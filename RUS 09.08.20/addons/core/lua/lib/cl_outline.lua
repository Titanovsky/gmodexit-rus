local List = {}
local RenderEnt = NULL

local CopyMat		= Material("pp/copy")
local OutlineMat	= CreateMaterial("OutlineMat","UnlitGeneric",{["$ignorez"] = 1,["$alphatest"] = 1})
local StoreTexture	= render.GetScreenEffectTexture(0)
local DrawTexture	= render.GetScreenEffectTexture(1)

--[[-------------------------------
	Modes:
	0 - Always draw
	1 - Draw if not visible
	2 - Draw if visible
--]]-------------------------------

function AmbLib.Add(ents,color,mode)
	if !istable(ents) then ents = {ents} end	--Support for passing Entity as first argument
	if table.IsEmpty(ents) then return end		--Do not pass empty tables
    if #List>=255 then return end

	table.insert(List,{
        Ents = ents,
		Color = color,
		Mode = mode
	})
end

function AmbLib.RenderEnt()
	return RenderEnt
end

local function Render()
	local scene = render.GetRenderTarget()
	render.CopyRenderTargetToTexture(StoreTexture)

	render.Clear(0,0,0,0,true,true)

	render.SetStencilEnable(true)
		cam.IgnoreZ(true)
		render.SuppressEngineLighting(true)

		render.SetStencilWriteMask(255)
		render.SetStencilTestMask(255)

		render.SetStencilCompareFunction(STENCIL_ALWAYS)
		render.SetStencilFailOperation(STENCIL_KEEP)
		render.SetStencilZFailOperation(STENCIL_REPLACE)
		render.SetStencilPassOperation(STENCIL_REPLACE)

		cam.Start3D()
			for k,v in ipairs(List) do
            render.SetStencilReferenceValue(k)

				for k2,v2 in ipairs(v.Ents) do
					if !IsValid(v2) then continue end

					local visible = LocalPlayer():IsLineOfSightClear(v2)
                    if v.Mode==1 and visible or v.Mode==2 and !visible then continue end

					RenderEnt = v2
					v2:DrawModel()
					RenderEnt = NULL
				end
			end
		cam.End3D()

		render.SetStencilCompareFunction(STENCIL_EQUAL)

		cam.Start2D()
			for k,v in ipairs(List) do
				render.SetStencilReferenceValue(k)

				surface.SetDrawColor(v.Color)
				surface.DrawRect(0,0,ScrW(),ScrH())
			end
		cam.End2D()

		render.SuppressEngineLighting(false)
		cam.IgnoreZ(false)
	render.SetStencilEnable(false)

	render.CopyRenderTargetToTexture(DrawTexture)

	render.SetRenderTarget(scene)
	CopyMat:SetTexture("$basetexture",StoreTexture)
	render.SetMaterial(CopyMat)
	render.DrawScreenQuad()

	render.SetStencilEnable(true)
		render.SetStencilReferenceValue(0)
		render.SetStencilCompareFunction(STENCIL_EQUAL)

		OutlineMat:SetTexture("$basetexture",DrawTexture)
		render.SetMaterial(OutlineMat)

		for x=-1,1 do
			for y=-1,1 do
				if x==0 and x==0 then continue end

				render.DrawScreenQuadEx(x,y,ScrW(),ScrH())
			end
		end
	render.SetStencilEnable(false)
end

hook.Add("PostDrawEffects","RenderOutlines",function()
	hook.Run("PreDrawOutlines")

	if #List==0 then return end

	Render()

	List = {}
end)

local COLOR_ENT		= Color( 255, 255, 255, 255 )
local COLOR_PROP 	= Color( 193, 237, 173, 255 )
local COLOR_NPC 	= Color( 150, 150, 0, 255 )
local COLOR_VEHICLE = Color( 255, 100, 0, 255 )
local COLOR_RAG 	= Color( 153, 247, 244, 255 )
local COLOR_WEAPON 	= Color( 255, 0, 0, 255 )
local COLOR_PLY_1 	= Color( 0, 255, 0, 255 )
local COLOR_PLY_2 	= Color( 255, 255, 0, 255 )
local COLOR_PLY_3 	= Color( 255, 0, 0, 255 )

local classes = {
	'prop_physics',
	'prop_static',
	'prop_dynamic'
}

hook.Add("PostRender", "xa", function()
	--print( LocalPlayer():GetEyeTrace().Entity:GetClass() )
	if IsValid( LocalPlayer():GetEyeTrace().Entity ) and LocalPlayer():GetPos():Distance( LocalPlayer():GetEyeTrace().Entity:GetPos() ) < 800 then
		if ( LocalPlayer():GetEyeTrace().Entity:IsNPC() ) then
		    AmbLib.Add( LocalPlayer():GetEyeTrace().Entity, COLOR_NPC, 0 )
		   elseif ( LocalPlayer():GetEyeTrace().Entity:IsRagdoll() ) then
			AmbLib.Add( LocalPlayer():GetEyeTrace().Entity, COLOR_RAG, 0 )
		elseif ( LocalPlayer():GetEyeTrace().Entity:IsVehicle() ) then
			AmbLib.Add( LocalPlayer():GetEyeTrace().Entity, COLOR_VEHICLE, 0 )
		elseif ( LocalPlayer():GetEyeTrace().Entity:IsWeapon() ) then
			AmbLib.Add( LocalPlayer():GetEyeTrace().Entity, COLOR_WEAPON, 0 )
		elseif ( LocalPlayer():GetEyeTrace().Entity:IsPlayer() ) then
			if LocalPlayer():GetEyeTrace().Entity:Health() >= 1 then
				AmbLib.Add( LocalPlayer():GetEyeTrace().Entity, COLOR_PLY_3, 0 )
				if LocalPlayer():GetEyeTrace().Entity:Health() >= 20 then
					AmbLib.Add( LocalPlayer():GetEyeTrace().Entity, COLOR_PLY_2, 0 )
					if LocalPlayer():GetEyeTrace().Entity:Health() >= 70 then
						AmbLib.Add( LocalPlayer():GetEyeTrace().Entity, COLOR_PLY_1, 0 )
					end
				end
			end
		elseif ( LocalPlayer():GetEyeTrace().Entity ) and LocalPlayer():GetPos():Distance( LocalPlayer():GetEyeTrace().Entity:GetPos() ) < 400 then
			AmbLib.Add( LocalPlayer():GetEyeTrace().Entity, COLOR_ENT, 0 )
		end
	end

	for _, class in pairs( classes ) do
	   	if IsValid( LocalPlayer():GetEyeTrace().Entity ) and ( LocalPlayer():GetEyeTrace().Entity:GetClass() == class ) and LocalPlayer():GetPos():Distance( LocalPlayer():GetEyeTrace().Entity:GetPos() ) < 800 then
	        AmbLib.Add( LocalPlayer():GetEyeTrace().Entity, COLOR_PROP, 0 )
	    end
	end
end)