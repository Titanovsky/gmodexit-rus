local render = render
local surface = surface
local clamp = math.Clamp
local max = math.max
local cam = cam
local dgetmeta = debug.getmetatable
local checkluatype = SF.CheckLuaType
local haspermission = SF.Permissions.hasAccess
local registerprivilege = SF.Permissions.registerPrivilege
local COLOR_WHITE = Color(255, 255, 255)

registerprivilege("render.screen", "Render Screen", "Allows the user to render to a starfall screen", { client = {} })
registerprivilege("render.hud", "Render Hud", "Allows the user to render to your hud", { client = {} })
registerprivilege("render.offscreen", "Render Screen", "Allows the user to render without a screen", { client = {} })
registerprivilege("render.renderView", "Render View", "Allows the user to render the world again with custom perspective", { client = {} })
registerprivilege("render.renderscene", "Render Scene", "Allows the user to render a world again without a screen with custom perspective", { client = {} })
registerprivilege("render.effects", "Render Effects", "Allows the user to render special effects such as screen blur, color modification, and bloom", { client = {} })
registerprivilege("render.calcview", "Render CalcView", "Allows the use of the CalcView hook", { client = {} })
registerprivilege("render.fog", "Render Fog", "Allows the user to control fog", { client = {} })

local cv_max_fonts = CreateConVar("sf_render_maxfonts", "30", { FCVAR_ARCHIVE })
local cv_max_rendertargets = CreateConVar("sf_render_maxrendertargets", "20", { FCVAR_ARCHIVE })
local cv_max_maxrenderviewsperframe = CreateConVar("sf_render_maxrenderviewsperframe", "2", { FCVAR_ARCHIVE })


hook.Add("PreRender", "SF_PreRender_ResetRenderedViews", function()
	for instance, _ in pairs(SF.allInstances) do
		instance.data.render.renderedViews = 0
	end
end)

local RT_Material = CreateMaterial("SF_RT_Material", "UnlitGeneric", {
	["$nolod"] = 1,
	["$ignorez"] = 1,
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1
})
SF.RT_Material = RT_Material

local playerFonts = SF.EntityTable("playerFonts")

local defined_fonts = {
	DebugFixed = true,
	DebugFixedSmall = true,
	Default = true,
	Marlett = true,
	Trebuchet18 = true,
	Trebuchet24 = true,
	HudHintTextLarge = true,
	HudHintTextSmall = true,
	CenterPrintText = true,
	HudSelectionText = true,
	CloseCaption_Normal = true,
	CloseCaption_Bold = true,
	CloseCaption_BoldItalic = true,
	ChatFont = true,
	TargetID = true,
	TargetIDSmall = true,
	HL2MPTypeDeath = true,
	BudgetLabel = true,
	HudNumbers = true,
	DermaDefault = true,
	DermaDefaultBold = true,
	DermaLarge = true,
	GModNotify = true,
	ScoreboardDefault = true,
	ScoreboardDefaultTitle = true,
	GModToolName = true,
	GModToolSubtitle = true,
	GModToolHelp = true,
	GModToolScreen = true,
	ContentHeader = true,
	GModWorldtip = true,
}

local currentcolor
local defaultFont
local MATRIX_STACK_LIMIT = 8
local matrix_stack = {}
local view_matrix_stack = {}
local renderingView = false
local renderingViewRt
local drawViewerInView = false
local MAX_CLIPPING_PLANES = 4
local pushedClippingPlanes = 0
local pp = {
	add = Material("pp/add"),				-- basetexture
	sub = Material("pp/sub"),				-- basetexture
	bloom = Material("pp/bloom"),			-- basetexture, levelr, levelg, levelb, colormul
	colour = Material("pp/colour"),			-- fbtexture, pp_colour_*: addr, addg, addb, brightness, colour, contrast, mulr, mulg, mulb
	downsample = Material("pp/downsample")	-- fbtexture, darken, multiply

}
local tex_screenEffect = render.GetScreenEffectTexture(0)

local rt_bank = SF.ResourceHandler(cv_max_rendertargets:GetInt(),
	function(t, i)
		return GetRenderTarget("Starfall_CustomRT_" .. i, 1024, 1024)
	end,
	function(t, Rt)
		local oldRt = render.GetRenderTarget()
		render.SetRenderTarget( Rt )
		render.Clear(0, 0, 0, 255, true)
		render.SetRenderTarget( oldRt )
	end,
	function() return "RT" end
)

cvars.AddChangeCallback( "sf_render_maxrendertargets", function()
	rt_bank.max = cv_max_rendertargets:GetInt()
end )


local dummyrt = GetRenderTarget("starfall_dummyrt", 32, 32)

local function cleanupRender(instance)
	instance:cleanupRender()
end

local function canRenderHud(instance)
	return SF.IsHUDActive(instance.entity) and (haspermission(instance, nil, "render.hud") or instance.player == SF.Superuser)
end

local function hudPrepareSafeArgs(instance, ...)
	if SF.IsHUDActive(instance.entity) and (haspermission(instance, nil, "render.hud") or instance.player == SF.Superuser) then
		instance:prepareRender()
		return true, {...}
	end
	return false
end

--- Called when a frame is requested to be drawn. Doesn't require a screen or HUD but only works on rendertargets. (2D Context)
-- @name renderoffscreen
-- @class hook
-- @client
SF.hookAdd("PreRender", "renderoffscreen", function(instance)
	if haspermission(instance, nil, "render.offscreen") or instance.player == SF.Superuser then
		instance:prepareRenderOffscreen()
		return true, {}
	end
	return false
end, cleanupRender)

--- Called when a scene is requested to be drawn. This is used for the render.renderview function.
-- @name renderscene
-- @class hook
-- @client
-- @param Vector origin View origin
-- @param Angle angles View angles
-- @param number fov View FOV
SF.hookAdd("RenderScene", "renderscene", function(instance, origin, angles, fov)
	if haspermission(instance, nil, "render.renderscene") or instance.player == SF.Superuser then
		instance:prepareRender()
		instance.data.render.isScenic = true
		return true, {instance.Types.Vector.Wrap(origin), instance.Types.Angle.Wrap(angles), fov}
	end
	return false
end,
function(instance)
	instance:cleanupRender()
	instance.data.render.isScenic = false
end)

--- Called before entities are drawn. You can't render anything, but you can edit hologram matrices before they are drawn.
-- @name hologrammatrix
-- @class hook
-- @client
SF.hookAdd("PreDrawOpaqueRenderables", "hologrammatrix", function(instance, drawdepth, drawskybox)
	return drawskybox, {}
end)

--- Called when a frame is requested to be drawn on hud. (2D Context)
-- @name drawhud
-- @class hook
-- @client
SF.hookAdd("HUDPaint", "drawhud", hudPrepareSafeArgs, cleanupRender)

--- Called when a hud element is attempting to be drawn
-- @name hudshoulddraw
-- @class hook
-- @client
-- @param string str The name of the hud element trying to be drawn
-- @return boolean Return false to not draw the element
SF.hookAdd("HUDShouldDraw", nil, function(instance, ...)
	if canRenderHud(instance) then
		return true, {...}
	end
	return false
end, function(instance, args)
	if args[1] and args[2]==false then return false end
end)

--- Called before opaque entities are drawn. (Only works with HUD) (3D context)
-- @name predrawopaquerenderables
-- @class hook
-- @client
-- @param boolean depth Whether the current draw is writing depth
-- @param boolean skybox Whether the current draw is drawing the skybox
SF.hookAdd("PreDrawOpaqueRenderables", nil, hudPrepareSafeArgs, cleanupRender)

--- Called after opaque entities are drawn. (Only works with HUD) (3D context)
-- @name postdrawopaquerenderables
-- @class hook
-- @client
-- @param boolean depth Whether the current draw is writing depth
-- @param boolean skybox Whether the current draw is drawing the skybox
SF.hookAdd("PostDrawOpaqueRenderables", nil, hudPrepareSafeArgs, cleanupRender)

--- Called before translucent entities are drawn. (Only works with HUD) (3D context)
-- @name predrawtranslucentrenderables
-- @class hook
-- @client
-- @param boolean depth Whether the current draw is writing depth
-- @param boolean skybox Whether the current draw is drawing the skybox
SF.hookAdd("PreDrawTranslucentRenderables", nil, hudPrepareSafeArgs, cleanupRender)

--- Called after translucent entities are drawn. (Only works with HUD) (3D context)
-- @name postdrawtranslucentrenderables
-- @class hook
-- @client
-- @param boolean depth Whether the current draw is writing depth
-- @param boolean skybox Whether the current draw is drawing the skybox
SF.hookAdd("PostDrawTranslucentRenderables", nil, hudPrepareSafeArgs, cleanupRender)

--- Called before drawing HUD (2D Context)
-- @name predrawhud
-- @class hook
-- @client
SF.hookAdd("PreDrawHUD", nil, hudPrepareSafeArgs, cleanupRender)

--- Called after drawing HUD (2D Context)
-- @name postdrawhud
-- @class hook
-- @client
SF.hookAdd("PostDrawHUD", nil, function(instance)
	if canRenderHud(instance) and not IsValid(SF.permPanel) then
		instance:prepareRender()
		return true, {}
	end
end, cleanupRender)

--- Called when world fog is drawn.
-- @name setupworldfog
-- @class hook
-- @client
SF.hookAdd("SetupWorldFog", nil, function(instance)
	if canRenderHud(instance) then
		render.FogMode(MATERIAL_FOG_LINEAR)
		instance:prepareRender()
		return true, {}
	end
	return false
end, function(instance)
	instance:cleanupRender()
	return true
end)

--- Called when skybox fog is drawn.
-- @name setupskyboxfog
-- @class hook
-- @client
-- @param number scale Skybox scale
SF.hookAdd("SetupSkyboxFog", nil, function(instance, scale)
	if canRenderHud(instance) then
		render.FogMode(MATERIAL_FOG_LINEAR)
		instance:prepareRender()
		return true, {scale}
	end
	return false
end, function(instance)
	instance:cleanupRender()
	return true
end)

--- Called when the engine wants to calculate the player's view. Only works if connected to Starfall HUD
-- @name calcview
-- @class hook
-- @client
-- @param Vector pos Current position of the camera
-- @param Angle ang Current angles of the camera
-- @param number fov Current fov of the camera
-- @param number znear Current near plane of the camera
-- @param number zfar Current far plane of the camera
-- @return table Table containing information for the camera. {origin=camera origin, angles=camera angles, fov=camera fov, znear=znear, zfar=zfar, drawviewer=drawviewer, ortho=ortho table}
SF.hookAdd("CalcView", nil, function(instance, ply, pos, ang, fov, znear, zfar)
	return SF.IsHUDActive(instance.entity) and (haspermission(instance, nil, "render.calcview") or instance.player == SF.Superuser),
		{instance.Types.Vector.Wrap(pos), instance.Types.Angle.Wrap(ang), fov, znear, zfar}
end, function(instance, tbl)
	local t = tbl[2]
	if tbl[1] and istable(t) then
		local ret = {}
		if t.origin then pcall(function() ret.origin = instance.Types.Vector.Unwrap(t.origin) end) end
		if t.angles then pcall(function() ret.angles = instance.Types.Angle.Unwrap(t.angles) end) end
		ret.fov = t.fov
		ret.znear = t.znear
		ret.zfar = t.zfar
		ret.drawviewer = t.drawviewer
		ret.ortho  = t.ortho
		return ret
	end
end)

hook.Add("ShouldDrawLocalPlayer", "SF_DrawLocalPlayerInRenderView", function()
	if renderingView and drawViewerInView then
		cam.Start3D()
		cam.End3D()
		return true
	end
end)
-- A fix for render view being rendered improperly when using a clipping plane.
-- PreDrawHalos is used, because PreDrawHUD isn't always called. This results in halos not being affected by clipping planes.
hook.Add("PreDrawHalos", "SF_DisableRenderViewClipping", function()
	if renderingView then
		render.EnableClipping(false)
	end
end)

--- Render library. Screens are 512x512 units. Most functions require
-- that you be in the rendering hook to call, otherwise an error is
-- thrown. +x is right, +y is down
-- @name render
-- @class library
-- @libtbl render_library
SF.RegisterLibrary("render")


--- The Markup type is used to easily format and draw text. Use render.parseMarkup(str, maxwidth) to create one.
-- @name Markup
-- @class type
-- @libtbl markup_methods
SF.RegisterType("Markup", true, false)


return function(instance)
local checkpermission = instance.player ~= SF.Superuser and SF.Permissions.check or function() end

local renderdata = {}
renderdata.renderedViews = 0
renderdata.rendertargets = {}
renderdata.validrendertargets = {}
instance.data.render = renderdata

local render_library = instance.Libraries.render
local ent_meta, ewrap, eunwrap = instance.Types.Entity, instance.Types.Entity.Wrap, instance.Types.Entity.Unwrap
local ang_meta, awrap, aunwrap = instance.Types.Angle, instance.Types.Angle.Wrap, instance.Types.Angle.Unwrap
local vec_meta, vwrap, vunwrap = instance.Types.Vector, instance.Types.Vector.Wrap, instance.Types.Vector.Unwrap
local col_meta, cwrap, cunwrap = instance.Types.Color, instance.Types.Color.Wrap, instance.Types.Color.Unwrap
local matrix_meta, mwrap, munwrap = instance.Types.VMatrix, instance.Types.VMatrix.Wrap, instance.Types.VMatrix.Unwrap
local markup_methods, markwrap, markunwrap = instance.Types.Markup.Methods, instance.Types.Markup.Wrap, instance.Types.Markup.Unwrap
local mtlunwrap = instance.Types.LockedMaterial.Unwrap


local getent
instance:AddHook("initialize", function()
	getent = instance.Types.Entity.GetEntity
end)

instance:AddHook("deinitialize", function ()
	for k, v in pairs(renderdata.rendertargets) do
		rt_bank:free(instance.player, v)
		renderdata.rendertargets[k] = nil
		renderdata.validrendertargets[v:GetName()] = nil
	end
end)


function instance:prepareRender()
	currentcolor = COLOR_WHITE
	render.SetColorMaterial()
	draw.NoTexture()
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DisableClipping( true )
	renderdata.isRendering = true
	renderdata.needRT = false
	renderdata.oldW = ScrW()
	renderdata.oldH = ScrH()
end

function instance:prepareRenderOffscreen()
	self:prepareRender()
	renderdata.needRT = true
	render.PushRenderTarget(dummyrt, 0, 0, 1024, 1024)
	cam.Start2D()
	view_matrix_stack[#view_matrix_stack + 1] = "End2D"
	render.SetStencilEnable(false)
	renderdata.usingRT = true
end

function instance:cleanupRender()
	render.SetStencilEnable(false)
	render.OverrideBlend(false)
	render.OverrideDepthEnable(false, false)
	render.SetScissorRect(0, 0, 0, 0, false)
	render.CullMode(MATERIAL_CULLMODE_CCW)
	render.SetLightingMode(0)
	pp.colour:SetTexture("$fbtexture", tex_screenEffect)
	pp.downsample:SetTexture("$fbtexture", tex_screenEffect)
	for i = #matrix_stack, 1, -1 do
		cam.PopModelMatrix()
		matrix_stack[i] = nil
	end
	if renderdata.usingRT then
		if renderingView then
			render.SetRenderTarget(renderingViewRt)
		else
			render.PopRenderTarget()
		end
		renderdata.usingRT = false
	end
	for i = #view_matrix_stack, 1, -1 do
		cam[view_matrix_stack[i]]()
		view_matrix_stack[i] = nil
	end
	if renderdata.changedFilterMag then
		renderdata.changedFilterMag = false
		render.PopFilterMag()
	end
	if renderdata.changedFilterMin then
		renderdata.changedFilterMin = false
		render.PopFilterMin()
	end
	renderdata.isRendering = false
	renderdata.needRT = false

	for i = 1, pushedClippingPlanes do
		render.PopCustomClipPlane()
	end
	pushedClippingPlanes = 0

	if renderdata.prevClippingState ~= nil then
		render.EnableClipping(renderdata.prevClippingState)
		renderdata.prevClippingState = nil
	end
end


-- ------------------------------------------------------------------ --

--- Sets whether stencil tests are carried out for each rendered pixel. Only pixels passing the stencil test are written to the render target.
-- @param boolean enable True to enable, false to disable
function render_library.setStencilEnable(enable)
	enable = (enable == true) -- Make sure it's a boolean
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end
	render.SetStencilEnable(enable)
end

--- Resets all values in the stencil buffer to zero.
function render_library.clearStencil()
	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end
	render.ClearStencil()
end

--- Clears the current rendertarget for obeying the current stencil buffer conditions.
-- @param number r Value of the red channel to clear the current rt with.
-- @param number g Value of the green channel to clear the current rt with.
-- @param number b Value of the blue channel to clear the current rt with.
-- @param number a Value of the alpha channel to clear the current rt with.
-- @param boolean Clear the depth buffer.
function render_library.clearBuffersObeyStencil(r, g, b, a, depth)
	checkluatype (r, TYPE_NUMBER)
	checkluatype (g, TYPE_NUMBER)
	checkluatype (b, TYPE_NUMBER)
	checkluatype (a, TYPE_NUMBER)

	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end

	render.ClearBuffersObeyStencil(r, g, b, a, depth)
end

--- Sets the stencil value in a specified rect.
-- @param number originX X origin of the rectangle.
-- @param number originY Y origin of the rectangle.
-- @param number endX The end X coordinate of the rectangle.
-- @param number endY The end Y coordinate of the rectangle.
-- @param number stencilValue Value to set cleared stencil buffer to.
function render_library.clearStencilBufferRectangle(originX, originY, endX, endY, stencilValue)
	checkluatype (originX, TYPE_NUMBER)
	checkluatype (originY, TYPE_NUMBER)
	checkluatype (endX, TYPE_NUMBER)
	checkluatype (endY, TYPE_NUMBER)
	checkluatype (stencilValue, TYPE_NUMBER)

	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end

	render.ClearStencilBufferRectangle(originX, originY, endX, endY, stencilValue)
end

--- Sets the compare function of the stencil. More: https://wiki.facepunch.com/gmod/render.SetStencilCompareFunction
-- @param number compareFunction
function render_library.setStencilCompareFunction(compareFunction)
	checkluatype (compareFunction, TYPE_NUMBER)

	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end

	render.SetStencilCompareFunction(compareFunction )
end

--- Sets the operation to be performed on the stencil buffer values if the compare function was not successful. More: http://wiki.facepunch.com/gmod/render.SetStencilFailOperation
-- @param number operation
function render_library.setStencilFailOperation(operation)
	checkluatype (operation, TYPE_NUMBER)

	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end

	render.SetStencilFailOperation(operation)
end

--- Sets the operation to be performed on the stencil buffer values if the compare function was successful. More: http://wiki.facepunch.com/gmod/render.SetStencilPassOperation
-- @param number operation
function render_library.setStencilPassOperation(operation)
	checkluatype (operation, TYPE_NUMBER)

	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end

	render.SetStencilPassOperation(operation)
end

--- Sets the operation to be performed on the stencil buffer values if the stencil test is passed but the depth buffer test fails. More: http://wiki.facepunch.com/gmod/render.SetStencilZFailOperation
-- @param number operation
function render_library.setStencilZFailOperation(operation)
	checkluatype (operation, TYPE_NUMBER)

	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end

	render.SetStencilZFailOperation(operation)
end

--- Sets the reference value which will be used for all stencil operations. This is an unsigned integer.
-- @param number referenceValue Reference value.
function render_library.setStencilReferenceValue(referenceValue)
	checkluatype (referenceValue, TYPE_NUMBER)

	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end

	render.SetStencilReferenceValue(referenceValue)
end

--- Sets the unsigned 8-bit test bitflag mask to be used for any stencil testing.
-- @param number mask The mask bitflag.
function render_library.setStencilTestMask(mask)
	checkluatype (mask, TYPE_NUMBER)

	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end

	render.SetStencilTestMask(mask)
end

--- Sets the unsigned 8-bit write bitflag mask to be used for any writes to the stencil buffer.
-- @param number mask The mask bitflag.
function render_library.setStencilWriteMask(mask)
	checkluatype (mask, TYPE_NUMBER)

	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end

	render.SetStencilWriteMask(mask)
end

--- Resets stencil operations to their default behavior
function render_library.resetStencil()
	if renderdata.noStencil and not renderdata.usingRT then SF.Throw("Stencil operations must be used inside RenderTarget or HUD") end

	render.SetStencilWriteMask(0xFF)
	render.SetStencilTestMask(0xFF)
	render.SetStencilReferenceValue(0)
	render.SetStencilCompareFunction(STENCIL_ALWAYS)
	render.SetStencilPassOperation(STENCIL_KEEP)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.ClearStencil()
end

-- ------------------------------------------------------------------ --

--- Pushes a matrix onto the matrix stack.
-- @param VMatrix m The matrix
-- @param boolean? world Should the transformation be relative to the screen or world?
function render_library.pushMatrix(m, world)
	if world == nil then
		world = renderdata.usingRT
	end

	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	local id = #matrix_stack
	if id + 1 > MATRIX_STACK_LIMIT then SF.Throw("Pushed too many matrices", 2) end
	local newmatrix
	if matrix_stack[id] then
		newmatrix = matrix_stack[id] * munwrap(m)
	else
		newmatrix = munwrap(m)
		if not world and renderdata.renderEnt and renderdata.renderEnt.Transform then
			newmatrix = renderdata.renderEnt.Transform * newmatrix
		end
	end

	matrix_stack[id + 1] = newmatrix
	cam.PushModelMatrix(newmatrix)
end

--- Enables a scissoring rect which limits the drawing area. Only works 2D contexts such as HUD or render targets.
-- @param number startX X start coordinate of the scissor rect.
-- @param number startY Y start coordinate of the scissor rect.
-- @param number endX X end coordinate of the scissor rect.
-- @param number endY Y end coordinate of the scissor rect.
function render_library.enableScissorRect(startX, startY, endX, endY)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype (startX, TYPE_NUMBER)
	checkluatype (startY, TYPE_NUMBER)
	checkluatype (endX, TYPE_NUMBER)
	checkluatype (endY, TYPE_NUMBER)
	render.SetScissorRect(startX, startY, endX, endY, true)
end

--- Disables a scissoring rect which limits the drawing area.
function render_library.disableScissorRect()
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	render.SetScissorRect(0 , 0 , 0 , 0, false)
end

--- Pops a matrix from the matrix stack.
function render_library.popMatrix()
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if #matrix_stack <= 0 then SF.Throw("Popped too many matrices", 2) end
	matrix_stack[#matrix_stack] = nil
	cam.PopModelMatrix()
end


local viewmatrix_checktypes =
{
	x = TYPE_NUMBER, y = TYPE_NUMBER, w = TYPE_NUMBER, h = TYPE_NUMBER, type = TYPE_STRING,
	fov = TYPE_NUMBER, aspect = TYPE_NUMBER, zfar = TYPE_NUMBER, znear = TYPE_NUMBER, subrect = TYPE_BOOL,
	bloomtone = TYPE_BOOL, offcenter = TYPE_TABLE, ortho = TYPE_TABLE
}
local viewmatrix_checktypes_ignore = {origin = true, angles = true}

--- Pushes a perspective matrix onto the view matrix stack.
-- @param table tbl The view matrix data. See http://wiki.facepunch.com/gmod/Structures/RenderCamData
function render_library.pushViewMatrix(tbl)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if #view_matrix_stack == MATRIX_STACK_LIMIT then SF.Throw("Pushed too many matrices", 2) end
	checkluatype(tbl, TYPE_TABLE)

	local newtbl = {}
	if tbl.origin ~= nil then newtbl.origin = vunwrap(tbl.origin) end
	if tbl.angles ~= nil then newtbl.angles = aunwrap(tbl.angles) end

	for k, v in pairs(tbl) do
		local check = viewmatrix_checktypes[k]
		if check then
			checkluatype (v, check)
			newtbl[k] = v
		elseif not viewmatrix_checktypes_ignore[k] then
			SF.Throw("Invalid key found in view matrix: " .. k, 2)
		end
	end
	if newtbl.offcenter then
		checkluatype (tbl.offcenter.left, TYPE_NUMBER)
		checkluatype (tbl.offcenter.right, TYPE_NUMBER)
		checkluatype (tbl.offcenter.bottom, TYPE_NUMBER)
		checkluatype (tbl.offcenter.top, TYPE_NUMBER)
	end
	if newtbl.ortho then
		checkluatype (tbl.ortho.left, TYPE_NUMBER)
		checkluatype (tbl.ortho.right, TYPE_NUMBER)
		checkluatype (tbl.ortho.bottom, TYPE_NUMBER)
		checkluatype (tbl.ortho.top, TYPE_NUMBER)
	end

	local endfunc
	if newtbl.type == "2D" then
		endfunc = "End2D"
	elseif newtbl.type == "3D" then
		endfunc = "End3D"
	else
		SF.Throw("Camera type must be \"3D\" or \"2D\"", 2)
	end

	cam.Start(newtbl)
	view_matrix_stack[#view_matrix_stack + 1] = endfunc
end

--- Pops a view matrix from the matrix stack.
function render_library.popViewMatrix()
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	local i = #view_matrix_stack
	if i == 0 then SF.Throw("Popped too many matrices", 2) end

	cam[view_matrix_stack[i]]()
	view_matrix_stack[i] = nil
end

--- Sets background color of screen
-- @param Color col Color of background
-- @param Entity? screen (Optional) entity of screen
function render_library.setBackgroundColor(col, screen)
	if screen then
		screen = getent(screen)
		if screen.link ~= instance.entity then
			SF.Throw("Entity has to be linked!", 2)
		end
	else
		if renderdata.isRendering then
			screen = renderdata.renderEnt
		end
	end

	if not screen then
		SF.Throw("Invalid rendering entity.", 2)
	end

	if screen.SetBackgroundColor then --Fail silently on HUD etc
		screen:SetBackgroundColor(col.r, col.g, col.b, col.a)
	end
end

--- Sets the lighting mode
-- @param number mode The lighting mode. 0 - Default, 1 - Fullbright, 2 - Increased Fullbright
function render_library.setLightingMode(mode)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if mode ~= 0 and mode ~= 1 and mode ~= 2 then SF.Throw("Invalid mode.", 2) end
	render.SetLightingMode(mode)
end

--- Sets the draw color
-- @param Color clr Color type
function render_library.setColor(clr)
	currentcolor = clr
	surface.SetDrawColor(clr)
	surface.SetTextColor(clr)
end

--- Sets the draw color by RGBA values
-- @param number r Number, red value
-- @param number g Number, green value
-- @param number b Number, blue value
-- @param number a Number, alpha value
function render_library.setRGBA(r, g, b, a)
	checkluatype (r, TYPE_NUMBER) checkluatype (g, TYPE_NUMBER) checkluatype (b, TYPE_NUMBER) checkluatype (a, TYPE_NUMBER)
	currentcolor = Color(r, g, b, a)
	surface.SetDrawColor(r, g, b, a)
	surface.SetTextColor(r, g, b, a)
end

--- Looks up a texture by file name and creates an UnlitGeneric material with it.
--- Also supports image URLs or image data (These will create a rendertarget for the $basetexture): https://en.wikipedia.org/wiki/Data_URI_scheme
--- Make sure to store the material to use it rather than calling this slow function repeatedly.
--- NOTE: This no longer supports material names. Use texture names instead (Textures are .vtf, material are .vmt)
-- @param string tx Texture file path, a http url, or image data: https://en.wikipedia.org/wiki/Data_URI_scheme
-- @param function? cb An optional callback called when loading is done. Passes nil if it fails or Passes the material, url, width, height, and layout function which can be called with x, y, w, h to reposition the image in the texture.
-- @param function? done An optional callback called when the image is done loading. Passes the material, url
-- @return Material The material. Use with render.setMaterial to draw with it.
function render_library.createMaterial(tx, cb, done)
	checkluatype (tx, TYPE_STRING)

	local m = instance.env.material.create("UnlitGeneric")
	local _1, _2, prefix = tx:find("^(%w-):")
	if prefix=="http" or prefix=="https" or prefix == "data" then
		m:setTextureURL("$basetexture", tx, cb, done)
	else
		m:setTexture("$basetexture", tx)
	end
	return m
end

--- Releases the texture. Required if you reach the maximum url textures.
-- @param Material mat The material object
function render_library.destroyTexture(mat)
	mat:destroy()
end

--- Sets the current render material
-- @param Material mat The material object
function render_library.setMaterial(mat)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if mat then
		local m = mtlunwrap(mat)
		surface.SetMaterial(m)
		render.SetMaterial(m)
	else
		render.SetColorMaterial()
		draw.NoTexture()
	end
end


local function gettexture(mat)
	if isstring(mat) then
		local rt = renderdata.rendertargets[mat]
		if not rt then SF.Throw("Invalid Rendertarget", 3) end
		return rt
	else
		return mtlunwrap(mat):GetTexture("$basetexture")
	end
end

--- Sets the current render material to the given material or the rendertarget, applying an additive shader when drawn.
-- @param Material mat The material object to use the texture of, or the name of a rendertarget to use instead.
function render_library.setMaterialEffectAdd(mat)

	checkpermission(instance, nil, "render.effects")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	local tex = gettexture(mat)

	pp.add:SetTexture("$basetexture", tex)
	surface.SetMaterial(pp.add)
	render.SetMaterial(pp.add)

end

--- Sets the current render material to the given material or the rendertarget, applying a subtractive shader when drawn.
-- @param Material mat The material object to use the texture of, or the name of a rendertarget to use instead.
function render_library.setMaterialEffectSub(mat)

	checkpermission(instance, nil, "render.effects")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	local tex = gettexture(mat)

	pp.sub:SetTexture("$basetexture", tex)
	surface.SetMaterial(pp.sub)
	render.SetMaterial(pp.sub)

end

--- Sets the current render material to the given material or the rendertarget, applying a bloom shader to the texture.
-- @param Material mat The material object to use the texture of, or the name of a rendertarget to use instead.
-- @param number levelr Multiplier for all red pixels. 1 = unchanged
-- @param number levelg Multiplier for all green pixels. 1 = unchanged
-- @param number levelb Multiplier for all blue pixels. 1 = unchanged
-- @param number colormul Multiplier for all three colors. 1 = unchanged
function render_library.setMaterialEffectBloom(mat, levelr, levelg, levelb, colormul)

	checkpermission(instance, nil, "render.effects")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	local tex = gettexture(mat)
	checkluatype(levelr, TYPE_NUMBER)
	checkluatype(levelg, TYPE_NUMBER)
	checkluatype(levelb, TYPE_NUMBER)
	checkluatype(colormul, TYPE_NUMBER)
	levelr = math.Clamp(levelr, -1024, 1024)
	levelg = math.Clamp(levelg, -1024, 1024)
	levelb = math.Clamp(levelb, -1024, 1024)
	colormul = math.Clamp(colormul, -1024, 1024)

	pp.bloom:SetTexture("$basetexture", tex)
	pp.bloom:SetFloat("$levelr", levelr)
	pp.bloom:SetFloat("$levelg", levelg)
	pp.bloom:SetFloat("$levelb", levelb)
	pp.bloom:SetFloat("$colormul", colormul)
	surface.SetMaterial(pp.bloom)
	render.SetMaterial(pp.bloom)

end

--- Sets the current render material to the given material or the rendertarget, darkening the texture, and scaling up color values.
-- @param Material mat The material object to use the texture of, or the name of a rendertarget to use instead.
-- @param number darken The amount to darken the texture by. -1 to 1 inclusive.
-- @param number multiply The amount to multiply the pixel colors by. (0-1024)
function render_library.setMaterialEffectDownsample(mat, darken, multiply)

	checkpermission(instance, nil, "render.effects")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	local tex = gettexture(mat)
	checkluatype(darken, TYPE_NUMBER)
	checkluatype(multiply, TYPE_NUMBER)
	darken = math.Clamp(darken, -1, 1)
	multiply = math.Clamp(multiply, 0, 1024)

	pp.downsample:SetTexture("$fbtexture", tex)
	pp.downsample:SetFloat("$darken", darken)
	pp.downsample:SetFloat("$multiply", multiply)
	surface.SetMaterial(pp.downsample)
	render.SetMaterial(pp.downsample)

end


local defaultCM = {
	addr = 0,
	addg = 0,
	addb = 0,
	brightness = 0,
	colour = 1,
	contrast = 1,
	mulr = 1,
	mulg = 1,
	mulb = 1
}

--- Sets the current render material to the given material or the rendertarget, applying a color modification shader to the texture. Alias: render.setMaterialEffectColourModify
-- @param Material mat The material object to use the texture of, or the name of a rendertarget to use instead.
-- @param table cmStructure A table where each key must be of "addr", "addg", "addb", "brightness", "color" or "colour", "contrast", "mulr", "mulg", and "mulb". All keys are optional.
function render_library.setMaterialEffectColorModify(mat, cmStructure)

	checkpermission(instance, nil, "render.effects")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	local tex = gettexture(mat)
	checkluatype(cmStructure, TYPE_TABLE)

	for key, default in pairs(defaultCM) do
		local value = cmStructure[key]
		if TypeID(value) == TYPE_NIL then
			if key == "colour" then
				value = cmStructure["color"] or default
			else
				value = default
			end
		elseif TypeID(value) ~= TYPE_NUMBER then SF.Throw("Invalid type for key \"" .. key .. "\" (expected number, got " .. SF.GetType(value) .. ")", 2) end

		value = math.Clamp(value, -1024, 1024)
		pp.colour:SetFloat("$pp_colour_" .. key, value)
	end

	pp.colour:SetTexture("$fbtexture", tex)
	surface.SetMaterial(pp.colour)
	render.SetMaterial(pp.colour)

end

render_library.setMaterialEffectColourModify = render_library.setMaterialEffectColorModify


--- Applies a blur effect to the active rendertarget. This must be used with a rendertarget created beforehand.
-- @param number blurx The amount of horizontal blur to apply.
-- @param number blury The amount of vertical blur to apply.
-- @param number passes The number of times the blur effect is applied.
function render_library.drawBlurEffect(blurx, blury, passes)

	checkpermission(instance, nil, "render.effects")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if not renderdata.usingRT then SF.Throw("Cannot use this function outside of a rendertarget.", 2) end

	checkluatype(blurx, TYPE_NUMBER)
	checkluatype(blury, TYPE_NUMBER)
	checkluatype(passes, TYPE_NUMBER)
	blurx = math.Clamp(blurx, 0, 1024)
	blury = math.Clamp(blury, 0, 1024)
	passes = math.Clamp(blurx, 0, 100)

	local rt = render.GetRenderTarget()
	local w, h = renderdata.oldW, renderdata.oldH
	local aspectRatio = w / h

	render.BlurRenderTarget(rt, blurx*aspectRatio, blury, passes)

end

--- Check if the specified render target exists.
-- @param string name The name of the render target
function render_library.renderTargetExists(name)
	checkluatype (name, TYPE_STRING)
	return renderdata.rendertargets[name] ~= nil
end

--- Creates a new render target to draw onto.
-- The dimensions will always be 1024x1024
-- @param string name The name of the render target
function render_library.createRenderTarget(name)
	checkluatype (name, TYPE_STRING)

	if renderdata.rendertargets[name] then SF.Throw("A rendertarget with this name already exists!", 2) end

	local rt = rt_bank:use(instance.player, "RT")
	if not rt then SF.Throw("Rendertarget limit reached", 2) end

	render.ClearRenderTarget(rt, Color(0, 0, 0))
	renderdata.rendertargets[name] = rt
	renderdata.validrendertargets[rt:GetName()] = true
end

--- Releases the rendertarget. Required if you reach the maximum rendertargets.
-- @param string name Rendertarget name
function render_library.destroyRenderTarget(name)
	local rt = renderdata.rendertargets[name]
	if rt then
		rt_bank:free(instance.player, rt)
		renderdata.rendertargets[name] = nil
		renderdata.validrendertargets[rt:GetName()] = nil
	else
		SF.Throw("Cannot destroy an invalid rendertarget.", 2)
	end
end

--- Selects the render target to draw on.
-- Nil for the visible RT.
-- @param string? name Name of the render target to use
function render_library.selectRenderTarget(name)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if name then
		checkluatype (name, TYPE_STRING)

		local rt = renderdata.rendertargets[name]
		if not rt then SF.Throw("Invalid Rendertarget", 2) end

		if renderdata.usingRT then
			render.SetRenderTarget(rt)
		else
			render.PushRenderTarget(rt, 0, 0, 1024, 1024)
			cam.Start2D()
			view_matrix_stack[#view_matrix_stack + 1] = "End2D"
			render.SetStencilEnable(false)
			renderdata.usingRT = true
		end
	else
		if renderdata.usingRT and not renderdata.needRT then
			if renderingView then
				render.SetRenderTarget(renderingViewRt)
			else
				render.PopRenderTarget()
			end

			local i = #view_matrix_stack
			if i>0 then
				cam[view_matrix_stack[i]]()
				view_matrix_stack[i] = nil
			end
			renderdata.usingRT = false
			if renderdata.noStencil then -- Revert ALL stencil settings from screen
				render.SetStencilEnable(true)
				render.SetStencilFailOperation(STENCILOPERATION_KEEP)
				render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
				render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
				render.SetStencilWriteMask(1)
				render.SetStencilReferenceValue(1)
				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
				render.SetStencilTestMask(1)
			end
		end
	end
end

--- Sets the active texture to the render target with the specified name.
-- Nil to reset.
-- @param string? name Name of the render target to use
function render_library.setRenderTargetTexture(name)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if name == nil then
		render.SetColorMaterial()
		draw.NoTexture()
	else
		checkluatype (name, TYPE_STRING)

		local rt = renderdata.rendertargets[name]
		if rt then
			RT_Material:SetTexture("$basetexture", rt)
			surface.SetMaterial(RT_Material)
			render.SetMaterial(RT_Material)
		else
			render.SetColorMaterial()
			draw.NoTexture()
		end
	end
end

--- Sets the texture of a screen entity
-- @param Entity ent Screen entity
function render_library.setTextureFromScreen(ent)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end

	ent = getent(ent)
	if ent.GPU and ent.GPU.RT then
		RT_Material:SetTexture("$basetexture", ent.GPU.RT)
		surface.SetMaterial(RT_Material)
		render.SetMaterial(RT_Material)
	else
		render.SetColorMaterial()
		draw.NoTexture()
	end

end

--- Sets the texture filtering function when viewing a close texture
-- @param number val The filter function to use http://wiki.facepunch.com/gmod/Enums/TEXFILTER
function render_library.setFilterMag(val)
	checkluatype (val, TYPE_NUMBER)
	if renderdata.changedFilterMag then
		render.PopFilterMag()
	end
	renderdata.changedFilterMag = true
	render.PushFilterMag(val)
end

--- Sets the texture filtering function when viewing a far texture
-- @param number val The filter function to use http://wiki.facepunch.com/gmod/Enums/TEXFILTER
function render_library.setFilterMin(val)
	checkluatype (val, TYPE_NUMBER)
	if renderdata.changedFilterMin then
		render.PopFilterMin()
	end
	renderdata.changedFilterMin = true
	render.PushFilterMin(val)
end

--- Changes the cull mode
-- @param number mode Cull mode. 0 for counter clock wise, 1 for clock wise
function render_library.setCullMode(mode)
	if not renderdata.isRendering then SF.Throw("Not in a rendering hook.", 2) end

	render.CullMode(mode == 1 and 1 or 0)
end

--- Clears the active render target
-- @param Color? clr Color type to clear with
-- @param boolean? depth Boolean if should clear depth. Default false
function render_library.clear(clr, depth)
	if not renderdata.isRendering then SF.Throw("Not in a rendering hook.", 2) end
	if renderdata.usingRT then
		if clr == nil then
			render.Clear(0, 0, 0, 255, depth)
		else
			render.Clear(clr.r, clr.g, clr.b, clr.a, depth)
		end
	end
end

--- Draws a rounded rectangle using the current color
-- @param number r The corner radius
-- @param number x Top left corner x coordinate
-- @param number y Top left corner y coordinate
-- @param number w Width
-- @param number h Height
function render_library.drawRoundedBox(r, x, y, w, h)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	draw.RoundedBox(r, x, y, w, h, currentcolor)
end

--- Draws a rounded rectangle using the current color
-- @param number r The corner radius
-- @param number x Top left corner x coordinate
-- @param number y Top left corner y coordinate
-- @param number w Width
-- @param number h Height
-- @param boolean? tl Top left corner. Default false
-- @param boolean? tr Top right corner. Default false
-- @param boolean? bl Bottom left corner. Default false
-- @param boolean? br Bottom right corner. Default false
function render_library.drawRoundedBoxEx(r, x, y, w, h, tl, tr, bl, br)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	draw.RoundedBoxEx(r, x, y, w, h, currentcolor, tl, tr, bl, br)
end

local quad_v1, quad_v2, quad_v3, quad_v4 = Vector(0,0,0), Vector(0,0,0), Vector(0,0,0), Vector(0,0,0)
local function makeQuad(x, y, w, h)
	local right, bot = x + w, y + h
	quad_v1.x = x
	quad_v1.y = y
	quad_v2.x = right
	quad_v2.y = y
	quad_v3.x = right
	quad_v3.y = bot
	quad_v4.x = x
	quad_v4.y = bot
end
--- Draws a rectangle using the current color
--- Faster, but uses integer coordinates and will get clipped by user's screen resolution
-- @param number x Top left corner x
-- @param number y Top left corner y
-- @param number w Width
-- @param number h Height
function render_library.drawRectFast(x, y, w, h)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	surface.DrawRect(x, y, w, h)
end

--- Draws a rectangle using the current color
-- @param number x Top left corner x
-- @param number y Top left corner y
-- @param number w Width
-- @param number h Height
function render_library.drawRect(x, y, w, h)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	makeQuad(x, y, w, h)
	render.SetColorMaterial()
	render.DrawQuad(quad_v1, quad_v2, quad_v3, quad_v4, currentcolor)
end

--- Draws a rectangle outline using the current color.
-- @param number x Top left corner x integer coordinate
-- @param number y Top left corner y integer coordinate
-- @param number w Width
-- @param number h Height
-- @param number? thickness Optional inset border width
function render_library.drawRectOutline(x, y, w, h, thickness)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	surface.DrawOutlinedRect(x, y, w, h, thickness)
end

--- Draws a circle outline
-- @param number x Center x coordinate
-- @param number y Center y coordinate
-- @param number r Radius
function render_library.drawCircle(x, y, r)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	surface.DrawCircle(x, y, r, currentcolor)
end

--- Draws a textured rectangle
--- Faster, but uses integer coordinates and will get clipped by user's screen resolution
-- @param number x Top left corner x
-- @param number y Top left corner y
-- @param number w Width
-- @param number h Height
function render_library.drawTexturedRectFast(x, y, w, h)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	surface.DrawTexturedRect(x, y, w, h)
end

--- Draws a textured rectangle
-- @param number x Top left corner x
-- @param number y Top left corner y
-- @param number w Width
-- @param number h Height
function render_library.drawTexturedRect(x, y, w, h)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	makeQuad(x, y, w, h)
	render.DrawQuad(quad_v1, quad_v2, quad_v3, quad_v4, currentcolor)
end

--- Draws a textured rectangle with UV coordinates
--- Faster, but uses integer coordinates and will get clipped by user's screen resolution
-- @param number x Top left corner x
-- @param number y Top left corner y
-- @param number w Width
-- @param number h Height
-- @param number startU Texture mapping at rectangle's origin U
-- @param number startV Texture mapping at rectangle's origin V
-- @param number endU Texture mapping at rectangle's end U
-- @param number endV Texture mapping at rectangle's end V
-- @param boolean? UVHack If enabled, will scale the UVs to compensate for internal bug. Should be true for user created materials.
function render_library.drawTexturedRectUVFast(x, y, w, h, startU, startV, endU, endV, UVHack)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end

	if UVHack then
		startU = ( startU * 32 - 0.5 ) / 31
		startV = ( startV * 32 - 0.5 ) / 31
		endU = ( endU * 32 - 0.5 ) / 31
		endV = ( endV * 32 - 0.5 ) / 31
	end

	surface.DrawTexturedRectUV(x, y, w, h, startU, startV, endU, endV)
end

--- Draws a textured rectangle with UV coordinates
-- @param number x Top left corner x
-- @param number y Top left corner y
-- @param number w Width
-- @param number h Height
-- @param number startU Texture mapping at rectangle origin
-- @param number startV Texture mapping at rectangle origin
-- @param number endU Texture mapping at rectangle end
-- @param number endV Texture mapping at rectangle end
function render_library.drawTexturedRectUV(x, y, w, h, startU, startV, endU, endV)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype (x, TYPE_NUMBER)
	checkluatype (y, TYPE_NUMBER)
	checkluatype (w, TYPE_NUMBER)
	checkluatype (h, TYPE_NUMBER)
	checkluatype (startU, TYPE_NUMBER)
	checkluatype (startV, TYPE_NUMBER)
	checkluatype (endU, TYPE_NUMBER)
	checkluatype (endV, TYPE_NUMBER)

	local r,g,b,a = currentcolor.r, currentcolor.g, currentcolor.b, currentcolor.a

	makeQuad(x, y, w, h)
	mesh.Begin(MATERIAL_QUADS, 1)
		mesh.Position( quad_v1 )
		mesh.Color( r,g,b,a )
		mesh.TexCoord( 0, startU, startV )
		mesh.AdvanceVertex()
		mesh.Position( quad_v2 )
		mesh.Color( r,g,b,a )
		mesh.TexCoord( 0, endU, startV )
		mesh.AdvanceVertex()
		mesh.Position( quad_v3 )
		mesh.Color( r,g,b,a )
		mesh.TexCoord( 0, endU, endV )
		mesh.AdvanceVertex()
		mesh.Position( quad_v4 )
		mesh.Color( r,g,b,a )
		mesh.TexCoord( 0, startU, endV )
		mesh.AdvanceVertex()
	mesh.End()
end

--- Draws a rotated, textured rectangle.
--- Faster, but uses integer coordinates and will get clipped by user's screen resolution
-- @param number x X coordinate of center of rect
-- @param number y Y coordinate of center of rect
-- @param number w Width
-- @param number h Height
-- @param number rot Rotation in degrees
function render_library.drawTexturedRectRotatedFast(x, y, w, h, rot)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end

	surface.DrawTexturedRectRotated(x, y, w, h, rot)
end

--- Draws a rotated, textured rectangle.
-- @param number x X coordinate of center of rect
-- @param number y Y coordinate of center of rect
-- @param number w Width
-- @param number h Height
-- @param number rot Rotation in degrees
function render_library.drawTexturedRectRotated(x, y, w, h, rot)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end

	local rad = math.rad(rot)
	local cos, sin = math.cos(rad), math.sin(rad)
	makeQuad(-w/2, -h/2, w, h)
	local function rotateVector(vec)
		-- These locals are needed because the next line requires the vector to be unmodified
		local x = vec.x * cos - vec.y * sin + x
		local y = vec.x * sin + vec.y * cos + y
		vec.x = x
		vec.y = y
	end

	rotateVector(quad_v1)
	rotateVector(quad_v2)
	rotateVector(quad_v3)
	rotateVector(quad_v4)

	render.DrawQuad(quad_v1, quad_v2, quad_v3, quad_v4, currentcolor)
end

--- Draws RGB color channel tables to current render target.
-- @param number w Width of image to be drawn.
-- @param number h Height of image to be drawn.
-- @param table dataR Red channel data.
-- @param table dataG Green channel data.
-- @param table dataB Blue channel data.
function render_library.drawPixelsRGB(w, h, dataR, dataG, dataB)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if not renderdata.usingRT then SF.Throw("Cannot use this function outside of a rendertarget.", 2) end
	for i = 1, w*h do
		render.SetViewPort((i-1)%w,math.floor((i-1)/w),1,1)
		render.Clear(dataR[i], dataG[i], dataB[i], 255)
	end
	render.SetViewPort(0, 0, 1024, 1024)
end

--- Draws RGBA color channel tables to current render target.
-- @param number w Width of image to be drawn.
-- @param number h Height of image to be drawn.
-- @param table dataR Red channel data.
-- @param table dataG Green channel data.
-- @param table dataB Blue channel data.
-- @param table dataA Alpha channel data.
function render_library.drawPixelsRGBA(w, h, dataR, dataG, dataB, dataA)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if not renderdata.usingRT then SF.Throw("Cannot use this function outside of a rendertarget.", 2) end
	for i = 1, w*h do
		render.SetViewPort((i-1)%w,math.floor((i-1)/w),1,1)
		render.Clear(dataR[i], dataG[i], dataB[i], dataA[i])
	end
	render.SetViewPort(0, 0, 1024, 1024)
end
--- Draws region of RGB color channel tables to current render target.
-- @param number dstX Destination x coordinate
-- @param number dstY Destination y coordinate
-- @param number srcX Source x coordinate
-- @param number srcY Source y coordinate
-- @param number srcW Source original width
-- @param number srcH Source original height
-- @param number subrectW Width of subrect
-- @param number subrectH Height of subrect
-- @param table dataR Red channel data.
-- @param table dataG Green channel data.
-- @param table dataB Blue channel data.
function render_library.drawPixelsSubrectRGB(dstX, dstY, srcX, srcY, srcW, srcH, subrectW, subrectH, dataR, dataG, dataB)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if not renderdata.usingRT then SF.Throw("Cannot use this function outside of a rendertarget.", 2) end
	for i = 0, subrectW*subrectH-1 do
		local subX, subY = i%subrectW, math.floor(i/subrectW)
		local srcIndex = (srcY+subY)*srcW+srcX+subX+1
		render.SetViewPort(dstX+subX,dstY+subY,1,1)
		render.Clear(dataR[srcIndex], dataG[srcIndex], dataB[srcIndex], 255)
	end
	render.SetViewPort(0, 0, 1024, 1024)
end
--- Draws region of RGBA color channel tables to current render target.
-- @param number dstX Destination x coordinate
-- @param number dstY Destination y coordinate
-- @param number srcX Source x coordinate
-- @param number srcY Source y coordinate
-- @param number srcW Source original width
-- @param number srcH Source original height
-- @param number subrectW Width of subrect
-- @param number subrectH Height of subrect
-- @param table dataR Red channel data.
-- @param table dataG Green channel data.
-- @param table dataB Blue channel data.
-- @param table dataA Alpha channel data.
function render_library.drawPixelsSubrectRGBA(dstX, dstY, srcX, srcY, srcW, srcH, subrectW, subrectH, dataR, dataG, dataB, dataA)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if not renderdata.usingRT then SF.Throw("Cannot use this function outside of a rendertarget.", 2) end
	for i = 0, subrectW*subrectH-1 do
		local subX, subY = i%subrectW, math.floor(i/subrectW)
		local srcIndex = (srcY+subY)*srcW+srcX+subX+1
		render.SetViewPort(dstX+subX,dstY+subY,1,1)
		render.Clear(dataR[srcIndex], dataG[srcIndex], dataB[srcIndex], dataA[srcIndex])
	end
	render.SetViewPort(0, 0, 1024, 1024)
end

--- Draws a line. Use 3D functions for float coordinates
-- @param number x1 X start integer coordinate
-- @param number y1 Y start integer coordinate
-- @param number x2 X end integer coordinate
-- @param number y2 Y end integer coordinate
function render_library.drawLine(x1, y1, x2, y2)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	surface.DrawLine(x1, y1, x2, y2)
end

--- Creates a font. Does not require rendering hook
-- @param string font Base font to use
-- @param number? size Font size. Default 16
-- @param number? weight Font weight. Default 400
-- @param boolean? antialias Antialias font? Default false
-- @param boolean? additive If true, adds brightness to pixels behind it rather than drawing over them. Default false
-- @param boolean? shadow Enable drop shadow? Default false
-- @param boolean? outline Enable outline? Default false
-- @param boolean? blur Enable blur? Default false
-- @param boolean? extended Allows the font to display glyphs outside of Latin-1 range. Unicode code points above 0xFFFF are not supported. Required to use FontAwesome
-- @return string The font name that can be used with the rest of the font functions.
-- Base font can be one of (keep in mind that these may not exist on all clients if they are not shipped with starfall):
-- \- Akbar
-- \- Coolvetica
-- \- Roboto
-- \- Roboto Mono
-- \- FontAwesome
-- \- Courier New
-- \- Verdana
-- \- Arial
-- \- HalfLife2
-- \- hl2mp
-- \- csd
-- \- Tahoma
-- \- Trebuchet
-- \- Trebuchet MS
-- \- DejaVu Sans Mono
-- \- Lucida Console
-- \- Times New Roman

function render_library.createFont(font, size, weight, antialias, additive, shadow, outline, blur, extended)
	size = tonumber(size) or 16
	weight = tonumber(weight) or 400
	blur = tonumber(blur) or 0
	antialias = tobool(antialias)
	additive = tobool(additive)
	shadow = tobool(shadow)
	outline = tobool(outline)
	extended = tobool(extended)

	local name = string.format("sf_screen_font_%s_%d_%d_%d_%d%d%d%d%d",
		font, size, weight, blur,
		antialias and 1 or 0,
		additive and 1 or 0,
		shadow and 1 or 0,
		outline and 1 or 0,
		extended and 1 or 0)

	if not defined_fonts[name] then
		local fontCount = playerFonts[instance.player] or 0
		if fontCount == cv_max_fonts:GetInt() then SF.Throw("You have reached the max created fonts!", 2) end
		playerFonts[instance.player] = fontCount + 1

		surface.CreateFont(name, { size = size, weight = weight,
			antialias = antialias, additive = additive, font = font,
			shadow = shadow, outline = outline, blur = blur,
			extended = extended })

		defined_fonts[name] = true
	end
	return name
end
defaultFont = render_library.createFont("Default", 16, 400, false, false, false, false, 0)

--- Gets the size of the specified text. Don't forget to use setFont before calling this function
-- @param string text Text to get the size of
-- @return number width of the text
-- @return number height of the text
function render_library.getTextSize(text)
	checkluatype (text, TYPE_STRING)

	surface.SetFont(renderdata.font or defaultFont)
	return surface.GetTextSize(text)
end

--- Sets the font
-- @param string font The font to use
-- Use a font created by render.createFont or use one of these already defined fonts:
-- \- DebugFixed
-- \- DebugFixedSmall
-- \- Default
-- \- Marlett
-- \- Trebuchet18
-- \- Trebuchet24
-- \- HudHintTextLarge
-- \- HudHintTextSmall
-- \- CenterPrintText
-- \- HudSelectionText
-- \- CloseCaption_Normal
-- \- CloseCaption_Bold
-- \- CloseCaption_BoldItalic
-- \- ChatFont
-- \- TargetID
-- \- TargetIDSmall
-- \- HL2MPTypeDeath
-- \- BudgetLabel
-- \- HudNumbers
-- \- DermaDefault
-- \- DermaDefaultBold
-- \- DermaLarge
function render_library.setFont(font)
	if not defined_fonts[font] then SF.Throw("Font does not exist.", 2) end
	renderdata.font = font
	--surface.SetFont(font)
end

--- Gets the default font
-- @return string Default font
function render_library.getDefaultFont()
	return defaultFont
end

--- Draws text with newlines and tabs
-- @param number x X coordinate
-- @param number y Y coordinate
-- @param string text Text to draw
-- @param number alignment Text alignment
function render_library.drawText(x, y, text, alignment)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype (x, TYPE_NUMBER)
	checkluatype (y, TYPE_NUMBER)
	checkluatype (text, TYPE_STRING)
	if alignment then
		checkluatype (alignment, TYPE_NUMBER)
	end

	local font = renderdata.font or defaultFont

	draw.DrawText(text, font, x, y, currentcolor, alignment)
end

--- Draws text more easily and quickly but no new lines or tabs.
-- @param number x X coordinate
-- @param number y Y coordinate
-- @param string text Text to draw
-- @param number? xalign Text x alignment
-- @param number? yalign Text y alignment
-- @return number Width of the drawn text. Same as calling render.getTextSize
-- @return number Height of the drawn text. Same as calling render.getTextSize
function render_library.drawSimpleText(x, y, text, xalign, yalign)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype (x, TYPE_NUMBER)
	checkluatype (y, TYPE_NUMBER)
	checkluatype (text, TYPE_STRING)
	if xalign~=nil then checkluatype (xalign, TYPE_NUMBER) end
	if yalign~=nil then checkluatype (yalign, TYPE_NUMBER) end

	local font = renderdata.font or defaultFont

	return draw.SimpleText(text, font, x, y, currentcolor, xalign, yalign)
end

--- Constructs a markup object for quick styled text drawing.
-- @param string str The markup string to parse
-- @param number? maxsize The max width of the markup. Default nil
-- @return Markup The markup object. See https://wiki.facepunch.com/gmod/markup.Parse
function render_library.parseMarkup(str, maxsize)
	checkluatype (str, TYPE_STRING)
	if maxsize~=nil then checkluatype (maxsize, TYPE_NUMBER) end

	return markwrap(markup.Parse(str, maxsize))
end

--- Draw the markup object
-- @param number x number The x offset
-- @param number y number The x offset
-- @param number? xalign number The x TEXT_ALIGN. Default TEXT_ALIGN.LEFT
-- @param number? yalign number The y TEXT_ALIGN. Default TEXT_ALIGN.TOP
-- @param number? alpha The alpha to draw it with. Default 255
function markup_methods:draw(x, y, xalign, yalign, a)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype(x, TYPE_NUMBER)
	checkluatype(y, TYPE_NUMBER)
	if xalign~=nil then checkluatype(xalign, TYPE_NUMBER) end
	if yalign~=nil then checkluatype(yalign, TYPE_NUMBER) end
	if a~=nil then checkluatype(a, TYPE_NUMBER) end
	markunwrap(self):Draw(x, y, xalign, yalign, a)
end

--- Get the object width
-- @return number The width of the object
function markup_methods:getWidth()
	return markunwrap(self):GetWidth()
end

--- Get the object height
-- @return number The height of the object
function markup_methods:getHeight()
	return markunwrap(self):GetHeight()
end

--- Get the object size
-- @return number The width of the object
-- @return number The height of the object
function markup_methods:getSize()
	return markunwrap(self):Size()
end

--- Draws a polygon.
-- @param table poly Table of polygon vertices. Texture coordinates are optional. {{x=x1, y=y1, u=u1, v=v1}, ... }
function render_library.drawPoly(poly)
	checkluatype (poly, TYPE_TABLE)
	surface.DrawPoly(poly)
end

--- Enables or disables Depth Buffer
-- @param boolean enable True to enable
function render_library.enableDepth(enable)
	if not renderdata.isRendering then SF.Throw("Not in a rendering hook.", 2) end
	checkluatype (enable, TYPE_BOOL)
	render.OverrideDepthEnable(enable, enable)
end

--- Enables blend mode control. Read OpenGL or DirectX docs for more info
-- @param boolean on Whether to control the blend mode of upcoming rendering
-- @param number srcBlend http://wiki.facepunch.com/gmod/Enums/BLEND
-- @param number destBlend
-- @param number blendFunc http://wiki.facepunch.com/gmod/Enums/BLENDFUNC
-- @param number? srcBlendAlpha http://wiki.facepunch.com/gmod/Enums/BLEND
-- @param number? destBlendAlpha
-- @param number? blendFuncAlpha http://wiki.facepunch.com/gmod/Enums/BLENDFUNC
function render_library.overrideBlend(on, srcBlend, destBlend, blendFunc, srcBlendAlpha, destBlendAlpha, blendFuncAlpha)
	if not renderdata.isRendering then SF.Throw("Not in a rendering hook.", 2) end
	render.OverrideBlend(on, srcBlend, destBlend, blendFunc, srcBlendAlpha, destBlendAlpha, blendFuncAlpha)
end

--- Resets the depth buffer
function render_library.clearDepth()
	if not renderdata.isRendering then SF.Throw("Not in a rendering hook.", 2) end
	if renderdata.usingRT then
		render.ClearDepth()
	end
end

--- Draws a sprite in 3d space.
-- @param Vector pos Position of the sprite.
-- @param number width Width of the sprite.
-- @param number height Height of the sprite.
-- @param Color? Color tint to give the sprite. Default: white
function render_library.draw3DSprite(pos, width, height, color)
	pos = vunwrap(pos)
	render.DrawSprite(pos, width, height, color)
end

--- Draws a sphere
-- @param Vector pos Position of the sphere
-- @param number radius Radius of the sphere
-- @param number longitudeSteps The amount of longitude steps. The larger this number is, the smoother the sphere is
-- @param number latitudeSteps The amount of latitude steps. The larger this number is, the smoother the sphere is
function render_library.draw3DSphere(pos, radius, longitudeSteps, latitudeSteps)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype (radius, TYPE_NUMBER)
	checkluatype (longitudeSteps, TYPE_NUMBER)
	checkluatype (latitudeSteps, TYPE_NUMBER)
	pos = vunwrap(pos)
	longitudeSteps = math.Clamp(longitudeSteps, 3, 50)
	latitudeSteps = math.Clamp(latitudeSteps, 3, 50)
	render.DrawSphere(pos, radius, longitudeSteps, latitudeSteps, currentcolor, true)
end

--- Draws a wireframe sphere
-- @param Vector pos Position of the sphere
-- @param number radius Radius of the sphere
-- @param number longitudeSteps The amount of longitude steps. The larger this number is, the smoother the sphere is
-- @param number latitudeSteps The amount of latitude steps. The larger this number is, the smoother the sphere is
function render_library.draw3DWireframeSphere(pos, radius, longitudeSteps, latitudeSteps)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype (radius, TYPE_NUMBER)
	checkluatype (longitudeSteps, TYPE_NUMBER)
	checkluatype (latitudeSteps, TYPE_NUMBER)
	pos = vunwrap(pos)
	longitudeSteps = math.Clamp(longitudeSteps, 3, 50)
	latitudeSteps = math.Clamp(latitudeSteps, 3, 50)
	render.DrawWireframeSphere(pos, radius, longitudeSteps, latitudeSteps, currentcolor, true)
end

--- Draws a 3D Line
-- @param Vector startPos Starting position
-- @param Vector endPos Ending position
function render_library.draw3DLine(startPos, endPos)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	startPos = vunwrap(startPos)
	endPos = vunwrap(endPos)

	render.DrawLine(startPos, endPos, currentcolor, true)
end

--- Draws a box in 3D space
-- @param Vector origin Origin of the box.
-- @param Angle angle Orientation of the box
-- @param Vector mins Start position of the box, relative to origin.
-- @param Vector maxs End position of the box, relative to origin.
function render_library.draw3DBox(origin, angle, mins, maxs)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	origin = vunwrap(origin)
	mins = vunwrap(mins)
	maxs = vunwrap(maxs)
	angle = aunwrap(angle)

	render.DrawBox(origin, angle, mins, maxs, currentcolor, true)
end

--- Draws a wireframe box in 3D space
-- @param Vector origin Origin of the box.
-- @param Angle angle Orientation of the box
-- @param Vector mins Start position of the box, relative to origin.
-- @param Vector maxs End position of the box, relative to origin.
function render_library.draw3DWireframeBox(origin, angle, mins, maxs)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	origin = vunwrap(origin)
	mins = vunwrap(mins)
	maxs = vunwrap(maxs)
	angle = aunwrap(angle)

	render.DrawWireframeBox(origin, angle, mins, maxs, currentcolor, false)
end

--- Draws textured beam.
-- @param Vector startPos Beam start position.
-- @param Vector endPos Beam end position.
-- @param number width The width of the beam.
-- @param number textureStart The start coordinate of the texture used.
-- @param number textureEnd The end coordinate of the texture used.
function render_library.draw3DBeam(startPos, endPos, width, textureStart, textureEnd)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype (width, TYPE_NUMBER)
	checkluatype (textureStart, TYPE_NUMBER)
	checkluatype (textureEnd, TYPE_NUMBER)

	startPos = vunwrap(startPos)
	endPos = vunwrap(endPos)

	render.DrawBeam(startPos, endPos, width, textureStart, textureEnd, currentcolor)
end

--- Draws 2 connected triangles.
-- @param Vector vert1 First vertex.
-- @param Vector vert2 The second vertex.
-- @param Vector vert3 The third vertex.
-- @param Vector vert4 The fourth vertex.
function render_library.draw3DQuad(vert1, vert2, vert3, vert4)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end

	vert1 = vunwrap(vert1)
	vert2 = vunwrap(vert2)
	vert3 = vunwrap(vert3)
	vert4 = vunwrap(vert4)

	render.DrawQuad(vert1, vert2, vert3, vert4, currentcolor)
end

--- Draws 2 connected triangles with custom UVs.
-- @param Vector vert1 First vertex. {x, y, z, u, v}
-- @param Vector vert2 The second vertex.
-- @param Vector vert3 The third vertex.
-- @param Vector vert4 The fourth vertex.
function render_library.draw3DQuadUV(vert1, vert2, vert3, vert4)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	mesh.Begin(MATERIAL_QUADS, 1)
	local ok, err = pcall(function()
		mesh.Position( Vector(vert1[1], vert1[2], vert1[3]) )
		mesh.Color( currentcolor.r, currentcolor.g, currentcolor.b, currentcolor.a )
		mesh.TexCoord( 0, vert1[4], vert1[5] )
		mesh.AdvanceVertex()
		mesh.Position( Vector(vert2[1], vert2[2], vert2[3]) )
		mesh.Color( currentcolor.r, currentcolor.g, currentcolor.b, currentcolor.a )
		mesh.TexCoord( 0, vert2[4], vert2[5] )
		mesh.AdvanceVertex()
		mesh.Position( Vector(vert3[1], vert3[2], vert3[3]) )
		mesh.Color( currentcolor.r, currentcolor.g, currentcolor.b, currentcolor.a )
		mesh.TexCoord( 0, vert3[4], vert3[5] )
		mesh.AdvanceVertex()
		mesh.Position( Vector(vert4[1], vert4[2], vert4[3]) )
		mesh.Color( currentcolor.r, currentcolor.g, currentcolor.b, currentcolor.a )
		mesh.TexCoord( 0, vert4[4], vert4[5] )
		mesh.AdvanceVertex()
	end)
	mesh.End()
	if not ok then SF.Throw(err, 2) end
end

--- Gets a 2D cursor position where ply is aiming at the current rendered screen or nil if they aren't aiming at it.
-- @param Player? ply player to get cursor position from. Default player()
-- @param Entity? screen An explicit screen to get the cursor pos of (default: The current rendering screen using 'render' hook)
-- @return number X position
-- @return number Y position
function render_library.cursorPos(ply, screen)
	if ply~=nil then
		ply = getent(ply)
		if not ply:IsPlayer() then SF.Throw("Entity isn't a player", 2) end
	else
		ply = LocalPlayer()
	end

	if screen~=nil then screen = getent(screen) else screen = renderdata.renderEnt end
	if not (screen and screen.Transform) then SF.Throw("Invalid screen", 2) end

	local Normal, Pos
	-- Get monitor screen pos & size

	Pos = screen:LocalToWorld(screen.Origin)

	Normal = -screen.Transform:GetUp():GetNormalized()

	local Start = ply:GetShootPos()
	local Dir = ply:GetAimVector()

	local A = Normal:Dot(Dir)

	-- If ray is parallel or behind the screen
	if A == 0 or A > 0 then return nil end

	local B = Normal:Dot(Pos-Start) / A
	if (B >= 0) then
		local w = 512 / screen.Aspect
		local HitPos = screen.Transform:GetInverseTR() * (Start + Dir * B)
		local x = HitPos.x / screen.Scale^2
		local y = HitPos.y / screen.Scale^2
		if x < 0 or x > w or y < 0 or y > 512 then return nil end -- Aiming off the screen
		return x, y
	end

	return nil
end

--- Returns information about the screen, such as world offsets, dimensions, and rotation.
-- Note: this does a table copy so move it out of your draw hook
-- @param Entity e The screen to get info from.
-- @return table A table describing the screen.
function render_library.getScreenInfo(e)
	local screen = getent(e)
	if not screen.ScreenInfo then SF.Throw("Invalid screen", 2) end
	return instance.Sanitize(screen.ScreenInfo)
end

--- Returns the entity currently being rendered to
-- @return Entity Entity of the screen or hud being rendered
function render_library.getScreenEntity()
	return ewrap(renderdata.renderEnt)
end

--- Dumps the current render target and allows the pixels to be accessed by render.readPixel.
function render_library.capturePixels()
	if not renderdata.isRendering then
		SF.Throw("Not in rendering hook.", 2)
	end
	if renderdata.usingRT then
		render.CapturePixels()
	end
end

--- Reads the color of the specified pixel.
-- @param number x Pixel x-coordinate.
-- @param number y Pixel y-coordinate.
-- @return Color Color object with ( r, g, b, a ) from the specified pixel.
function render_library.readPixel(x, y)
	if not renderdata.isRendering then
		SF.Throw("Not in rendering hook.", 2)
	end
	return cwrap(Color(render.ReadPixel(x, y)))
end

--- Returns the render context's width and height. If a rendertarget is selected, will return 1024, 1024
-- @class function
-- @return number the X size of the current render context
-- @return number the Y size of the current render context
function render_library.getResolution()
	if renderdata.renderEnt and renderdata.renderEnt.GetResolution then
		return renderdata.renderEnt:GetResolution()
	end
	return ScrW(), ScrH()
end

--- Returns width and height of the game window
-- @class function
-- @return number the X size of the game window
-- @return number the Y size of the game window
function render_library.getGameResolution()
	return renderdata.oldW, renderdata.oldH
end

--- Does a trace and returns the color of the textel the trace hits.
-- @param Vector vec1 The starting vector
-- @param Vector vec2 The ending vector
-- @return Color The color
function render_library.traceSurfaceColor(vec1, vec2)
	return cwrap(render.GetSurfaceColor(vunwrap(vec1), vunwrap(vec2)):ToColor())
end

--- Checks if a hud component is connected to the Starfall Chip
-- @return boolean Whether a hud component is connected to the SF Chip and active
function render_library.isHUDActive()
	return SF.IsHUDActive(instance.entity)
end

--- Renders the scene with the specified viewData to the current active render target.
-- @param table tbl view The view data to be used in the rendering. See http://wiki.facepunch.com/gmod/Structures/ViewData. There's an additional key drawviewer used to tell the engine whether the local player model should be rendered.
function render_library.renderView(tbl)
	checkluatype(tbl, TYPE_TABLE)

	local origin, angles, w, h, ortho, offcenter
	if tbl.origin~=nil then origin = vunwrap(tbl.origin) end
	if tbl.angles~=nil then angles = aunwrap(tbl.angles) end
	if tbl.aspectratio~=nil then checkluatype(tbl.aspectratio, TYPE_NUMBER) end
	if tbl.x~=nil then checkluatype(tbl.x, TYPE_NUMBER) end
	if tbl.y~=nil then checkluatype(tbl.y, TYPE_NUMBER) end
	if tbl.w~=nil then checkluatype(tbl.w, TYPE_NUMBER) w = math.Clamp(tbl.w, 1, 1024) end
	if tbl.h~=nil then checkluatype(tbl.h, TYPE_NUMBER) h = math.Clamp(tbl.h, 1, 1024) end
	if tbl.fov~=nil then checkluatype(tbl.fov, TYPE_NUMBER) end
	if tbl.zfar~=nil then checkluatype(tbl.zfar, TYPE_NUMBER) end
	if tbl.znear~=nil then checkluatype(tbl.znear, TYPE_NUMBER) end
	if tbl.drawmonitors~=nil then checkluatype(tbl.drawmonitors, TYPE_BOOL) end
	if tbl.drawviewmodel~=nil then checkluatype(tbl.drawviewmodel, TYPE_BOOL) end
	if tbl.ortho~=nil then
		checkluatype(tbl.ortho, TYPE_TABLE)
		checkluatype(tbl.ortho.left, TYPE_NUMBER)
		checkluatype(tbl.ortho.right, TYPE_NUMBER)
		checkluatype(tbl.ortho.top, TYPE_NUMBER)
		checkluatype(tbl.ortho.bottom, TYPE_NUMBER)
		ortho = {
			left = tbl.ortho.left,
			right = tbl.ortho.right,
			top = tbl.ortho.top,
			bottom = tbl.ortho.bottom,
		}
	end
	if tbl.dopostprocess~=nil then checkluatype(tbl.dopostprocess, TYPE_BOOL) end
	if tbl.bloomtone~=nil then checkluatype(tbl.bloomtone, TYPE_BOOL) end
	if tbl.znearviewmodel~=nil then checkluatype(tbl.znearviewmodel, TYPE_NUMBER) end
	if tbl.zfarviewmodel~=nil then checkluatype(tbl.zfarviewmodel, TYPE_NUMBER) end
	if tbl.offcenter~=nil then
		checkluatype(tbl.offcenter, TYPE_TABLE)
		checkluatype(tbl.offcenter.left, TYPE_NUMBER)
		checkluatype(tbl.offcenter.right, TYPE_NUMBER)
		checkluatype(tbl.offcenter.top, TYPE_NUMBER)
		checkluatype(tbl.offcenter.bottom, TYPE_NUMBER)
		offcenter = {
			left = tbl.offcenter.left,
			right = tbl.offcenter.right,
			top = tbl.offcenter.top,
			bottom = tbl.offcenter.bottom,
		}
	end

	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if !renderdata.isScenic then SF.Throw("Can't use render.renderView outside of renderscene hook.", 2) end

	if renderdata.renderingView then
		SF.Throw("Already rendering a view.", 2)
	end

	if renderingView then
		return
	end

	checkpermission(instance, nil, "render.renderView")

	if renderdata.renderedViews >= cv_max_maxrenderviewsperframe:GetInt() then
		SF.Throw("Max rendered views per frame exceeded!.", 2)
	end

	renderdata.renderedViews = renderdata.renderedViews + 1

	local prevData = {
		matrix_stack = matrix_stack,
		view_matrix_stack = view_matrix_stack,
		changedFilterMag = renderdata.changedFilterMag,
		changedFilterMin = renderdata.changedFilterMin,
		prevClippingState = renderdata.prevClippingState,
		noStencil = renderdata.noStencil,
		usingRT = renderdata.usingRT,
		pushedClippingPlanes = pushedClippingPlanes
	}

	matrix_stack = { }
	view_matrix_stack = { }
	renderdata.changedFilterMag = false
	renderdata.changedFilterMin = false
	renderdata.prevClippingState = nil
	pushedClippingPlanes = 0

	renderingView = true
	renderdata.renderingView = true

	drawViewerInView = tbl.drawviewer == true

	local oldRt = render.GetRenderTarget()
	renderingViewRt = oldRt

	render.PushRenderTarget(oldRt)
	cam.Start3D() -- Seems to fix some of the issues with render operations leaking into default RT

	render.RenderView({
		origin = origin,
		angles = angles,
		aspectratio = tbl.aspectratio,
		x = tbl.x,
		y = tbl.y,
		w = w,
		h = h,
		fov = tbl.fov,
		zfar = tbl.zfar,
		znear = tbl.znear,
		drawhud = false,
		drawmonitors = tbl.drawmonitors,
		drawviewmodel = tbl.drawviewmodel,
		ortho = ortho,
		dopostprocess = tbl.dopostprocess,
		bloomtone = tbl.bloomtone,
		znearviewmodel = tbl.znearviewmodel,
		zfarviewmodel = tbl.zfarviewmodel,
		offcenter = offcenter,
	})

	cam.End3D()
	render.PopRenderTarget()

	matrix_stack = prevData.matrix_stack
	view_matrix_stack = prevData.view_matrix_stack
	renderdata.changedFilterMag = prevData.changedFilterMag
	renderdata.changedFilterMin = prevData.changedFilterMin
	renderdata.prevClippingState = prevData.prevClippingState
	renderdata.noStencil = prevData.noStencil
	renderdata.usingRT = prevData.usingRT
	pushedClippingPlanes = prevData.pushedClippingPlanes

	renderingView = false
	renderdata.renderingView = false
	renderdata.isRendering = true
end

--- Returns whether render.renderView is being executed.
-- @return boolean Whether render.renderView is being executed
function render_library.isInRenderView()
	return renderingView
end

--- Returns how many render.renderView calls can be done in the current frame.
-- @return number How many render.renderView calls are left
function render_library.renderViewsLeft()
	return cv_max_maxrenderviewsperframe:GetInt() - renderdata.renderedViews
end

--- Sets the status of the clip renderer, returning previous state.
-- @param boolean state New clipping state.
-- @return boolean Previous clipping state.
function render_library.enableClipping(state)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype(state, TYPE_BOOL)

	local prevState = render.EnableClipping(state)

	if renderdata.prevClippingState == nil then
		renderdata.prevClippingState = prevState
	end

	return prevState
end

--- Pushes a new clipping plane of the clip plane stack.
-- @param Vector normal The normal of the clipping plane.
-- @param number distance The normal of the clipping plane.
function render_library.pushCustomClipPlane(normal, distance)
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end

	if pushedClippingPlanes >= MAX_CLIPPING_PLANES then
		SF.Throw("Pushed too many clipping planes.", 2)
	end

	checkluatype(distance, TYPE_NUMBER)

	render.PushCustomClipPlane(vunwrap(normal), distance)

	pushedClippingPlanes = pushedClippingPlanes + 1
end

--- Removes the current active clipping plane from the clip plane stack.
function render_library.popCustomClipPlane()
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	if pushedClippingPlanes == 0 then SF.Throw("Popped too many clipping planes.", 2) end

	render.PopCustomClipPlane()

	pushedClippingPlanes = pushedClippingPlanes - 1
end

--- Calculates the light color of a certain surface
-- @param Vector pos Vector position to sample from
-- @param Vector normal Normal vector of the surface
-- @return Vector Vector representing color of the light
function render_library.computeLighting(pos, normal)
	return vwrap(render.ComputeLighting(vunwrap(pos), vunwrap(normal)))
end

--- Calculates the lighting caused by dynamic lights for the specified surface
-- @param Vector pos Vector position to sample from
-- @param Vector normal Normal vector of the surface
-- @return Vector Vector representing color of the light
function render_library.computeDynamicLighting(pos, normal)
	return vwrap(render.ComputeDynamicLighting(vunwrap(pos), vunwrap(normal)))
end

--- Gets the light exposure on the specified position
-- @param Vector pos Vector position to sample from
-- @return Vector Vector representing color of the light
function render_library.getLightColor(pos)
	return vwrap(render.GetLightColor(vunwrap(pos)))
end

--- Returns the ambient color of the map
-- @return Vector Vector representing color of the light
function render_library.getAmbientLightColor()
	return vwrap(render.GetAmbientLightColor())
end

--- Sets the fog mode. See: https://wiki.facepunch.com/gmod/Enums/MATERIAL_FOG
-- @param number mode Fog mode
function render_library.setFogMode(mode)
	checkpermission(instance, nil, "render.fog")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype(mode, TYPE_NUMBER)

	render.FogMode(mode)
end

--- Changes color of the fog
-- @param Color col Color (alpha won't have any effect)
function render_library.setFogColor(color)
	checkpermission(instance, nil, "render.fog")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end

	local col = cunwrap(color)
	render.FogColor(col.r, col.g, col.b)
end

--- Changes density of the fog
-- @param number density Density between 0 and 1
function render_library.setFogDensity(density)
	checkpermission(instance, nil, "render.fog")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype(density, TYPE_NUMBER)

	render.FogMaxDensity(density)
end

--- Sets distance at which the fog will start appearing
-- @param number distance Start distance
function render_library.setFogStart(distance)
	checkpermission(instance, nil, "render.fog")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype(distance, TYPE_NUMBER)

	render.FogStart(distance)
end

--- Sets distance at which the fog will reach it's target density
-- @param number distance End distance
function render_library.setFogEnd(distance)
	checkpermission(instance, nil, "render.fog")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype(distance, TYPE_NUMBER)

	render.FogEnd(distance)
end

--- Sets the height below which fog will be rendered. Only works with fog mode 2, MATERIAL_FOG.LINEAR_BELOW_FOG_Z
-- @param number height The fog height
function render_library.setFogHeight(height)
	checkpermission(instance, nil, "render.fog")
	if not renderdata.isRendering then SF.Throw("Not in rendering hook.", 2) end
	checkluatype(height, TYPE_NUMBER)

	render.SetFogZ(height)
end


--- Checks whether the hardware supports HDR
-- @return boolean True if supported
render_library.supportsHDR = render.SupportsHDR

--- Checks whether HDR is enabled. Hardware support, map and client settings are all taken into account
-- @return boolean True if available
render_library.getHDREnabled = render.GetHDREnabled

--- Sets the overlay of the chip to a user's rendertarget
-- @param string? name The name of the RT to use or nil to set it back to normal
function render_library.setChipOverlay(name)
	local rt
	if name~=nil then
		checkluatype(name, TYPE_STRING)
		rt = renderdata.rendertargets[name]
		if not rt then SF.Throw("Invalid Rendertarget", 2) end
	end
	instance.entity:SetCustomOverlay(rt)
end

--- Using the custom screen model, sets the screen offset and size as long as its within bounds of -1024 to 1024 units
-- @param Entity screen The custom screen to be resized
-- @param number x The x offset of the screen
-- @param number y The y offset of the screen
-- @param number w The width of the screen
-- @param number h The height of the screen
function render_library.setScreenDimensions(screen, x, y, w, h)
	checkluatype(x, TYPE_NUMBER)
	checkluatype(y, TYPE_NUMBER)
	checkluatype(w, TYPE_NUMBER)
	checkluatype(h, TYPE_NUMBER)
	local halfw, halfh = w/2, h/2
	if x-halfw<-1024 or y-halfh<-1024 or w<1 or h<1 or x+halfw>1024 or y+halfh>1024 then SF.Throw("The specified dimensions exceeds the bounds!", 2) end
	screen = getent(screen)
	local custominfo = SF.CustomScreenInfo
	if screen.ScreenInfo.Name ~= custominfo.Name then SF.Throw("Expected a custom screen. Make sure the selected screen is the 'custom screen' model!", 2) end

	screen:SetScreenMatrix{
		RS = w/1024,
		RatioX = h/w,
		offset = custominfo.offset + Vector(y, x, 0),
		rot = custominfo.rot,
	}
	screen:SetRenderBounds(Vector(-1024, -1024, -10), Vector(1024, 1024, 10))
end

--- Makes the screen shake, client must be connected to a HUD.
-- @param number amplitude The strength of the effect
-- @param number frequency The frequency of the effect in hertz
-- @param number duration The duration of the effect in seconds, max 10.
function render_library.screenShake(amplitude, frequency, duration)
	checkluatype (amplitude, TYPE_NUMBER)
	checkluatype (frequency, TYPE_NUMBER)
	checkluatype (duration, TYPE_NUMBER)
	if not SF.IsHUDActive(instance.entity) then SF.Throw("Player isn't connected to HUD!", 2) end
	util.ScreenShake(Vector(0, 0, 0), amplitude, frequency, math.Clamp(duration, 0, 10), 0)
end

end

---
-- @name render_library.Screen information table
-- @class table
-- @field Name Pretty name of model
-- @field offset Offset of screen from prop
-- @field RS Resolution/scale
-- @field RatioX Inverted Aspect ratio (height divided by width)
-- @field x1 Corner of screen in local coordinates (relative to offset?)
-- @field x2 Corner of screen in local coordinates (relative to offset?)
-- @field y1 Corner of screen in local coordinates (relative to offset?)
-- @field y2 Corner of screen in local coordinates (relative to offset?)
-- @field z Screen plane offset in local coordinates (relative to offset?)
-- @field rot Screen rotation

--- Vertex format
-- @name render_library.Vertex Format
-- @class table
-- @field x X coordinate
-- @field y Y coordinate
-- @field u U coordinate (optional, default is 0)
-- @field v V coordinate (optional, default is 0)
