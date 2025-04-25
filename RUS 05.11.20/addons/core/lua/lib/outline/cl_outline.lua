local List = {}
local RenderEnt = NULL

local CopyMat		= Material("pp/copy")
local OutlineMat	= CreateMaterial("OutlineMat","UnlitGeneric",{ ["$ignorez"] = 1,["$alphatest"] = 1})
local StoreTexture	= render.GetScreenEffectTexture(0)
local DrawTexture	= render.GetScreenEffectTexture(1)

CreateClientConVar( 'amb_outline', '1', true )

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



local COLOR_WEAPON 			= Color( 255, 255, 255 )
local COLOR_HEALTH_HIGH 	= Color( 0, 255, 0 )
local COLOR_HEALTH_MEDIUM 	= Color( 255, 255, 0 )
local COLOR_HEALTH_LOW 		= Color( 255, 0, 0 )

local classes = {
	['prop_physics'] = true,
	['prop_static'] = true,
	['prop_dynamic'] = true
}

hook.Add( 'Think', 'amb_0x2048', function()

	if ( GetConVar( 'amb_outline' ):GetBool() == false ) then return end


	local ent = LocalPlayer():GetEyeTrace().Entity

	if ( IsValid( ent ) and classes[ ent:GetClass() ] ) then

		AmbLib.Add( ent, AMB_COLOR_AMBITION, 2 )

	elseif ( ent:IsWeapon() ) then

		AmbLib.Add( ent, COLOR_WEAPON, 2 )

	elseif ( ent:IsPlayer() or ent:IsNPC() ) then

		if ( ent:Health() > 0 and ent:Health() < 40 ) then

			AmbLib.Add( ent, COLOR_HEALTH_LOW, 2 )

		elseif ( ent:Health() >= 40 and ent:Health() < 80 ) then

			AmbLib.Add( ent, COLOR_HEALTH_MEDIUM, 2 )

		elseif ( ent:Health() >= 80 ) then

			AmbLib.Add( ent, COLOR_HEALTH_HIGH, 2 )

		end
	end
end )
