surface.CreateFont( "hud_text_lol", {
	font = "Tahoma",
	size = 28,
	antialias = true,
} )

surface.CreateFont( "hud_prop", {
	font = "Arial",
	size = 18,
	antialias = true,
} )

CreateClientConVar("ru_hud_enable", "1", true, false)
CreateClientConVar("ru_hud_wallet_enable", "1", true, false)
CreateClientConVar("ru_name_enable", "1", true, false)
CreateClientConVar("ru_prop_gui", "1", true, false)
CreateClientConVar("ru_admin_gui", "0", true, false)

local COLOR_MAIN = Color( 5, 5, 5, 220 )
local COLOR_LOGO = Color(255, 255, 100, 255)
local COLOR_RED = Color( 224, 32, 2, 230 )
local COLOR_BLUE = Color( 4, 98, 212, 230 )
local COLOR_GREEN = Color( 12, 138, 27, 230 )
local COLOR_PURPLE = Color( 90, 4, 201, 230 )
local COLOR_BLACK = Color( 0, 0, 0, 230 )
local COLOR_TEXT = Color( 240, 240, 240, 255 )
local COLOR_TEXT_LOW = Color( 255, 203, 196, 255 )
local COLOR_TEXT_BLOOD = Color( 227, 141, 129, 200 + math.sin( SysTime() * 20) * 100 )


function custom_hud()

	local w = ScrW()
	local h = ScrH()
	local ply = LocalPlayer()
	local hp = ply:Health()
	local armor = ply:Armor()
	local money = ply:GetNWInt("rub")
	local lvl = ply:GetNWInt("lvl")
	local exp = ply:GetNWInt("exp")
	local next_exp = ply:GetNWInt("next_exp")
	local fc = ply:GetNWInt("friskCoins")
	local logo = "[RU] Reborn"

	if GetConVar("ru_hud_enable"):GetInt() == 1 then

		if ply:Alive() then
			draw.RoundedBox( 0, w * 0.006, h * 0.94, 50, 30, COLOR_MAIN ) -- HP
			draw.RoundedBox( 0, w * 0.006, h * 0.94, 5, 30, COLOR_RED )
			if hp > 50 then
				draw.SimpleText( hp, "hud_text_lol", w * 0.025, h * 0.94, COLOR_TEXT, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			elseif hp > 20 then
				draw.SimpleText( hp, "hud_text_lol", w * 0.025, h * 0.94, COLOR_TEXT_LOW, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			else 
				draw.SimpleText( hp, "hud_text_lol", w * 0.025, h * 0.94, COLOR_TEXT_BLOOD, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end

		if armor > 0 and ply:Alive() then
			draw.RoundedBox( 0, w * 0.05, h * 0.94, 50, 30, COLOR_MAIN )
			draw.RoundedBox( 0, w * 0.05, h * 0.94, 5, 30, COLOR_BLUE )
			draw.SimpleText( armor, "hud_text_lol", w * 0.07, h * 0.94, COLOR_TEXT, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end

		--[[
		local function HUDGETCLIP()		
			if ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():Clip1() then
				return ply:GetActiveWeapon():Clip1()
			else
				return 0	
			end
		end
				
		local function HUDGETAMMO()
			if ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetPrimaryAmmoType() then
				return ply:GetAmmoCount( ply:GetActiveWeapon():GetPrimaryAmmoType() ) or 0
			else
				return 0
			end	
		end

		local function HUDGETSECONDARYAMMO()
			if ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetSecondaryAmmoType() then
				return ply:GetAmmoCount( ply:GetActiveWeapon():GetSecondaryAmmoType() ) or 0
			else
				return 0
			end
		end

		function HUDAMMO()

			if not ply:Alive() or ply:InVehicle() then return end

			if HUDGETAMMO() and HUDGETCLIP() <= 0 then return end

			draw.RoundedBox( 4 , ScrW() - 220, ScrH() - 45, 150, 40, Color( 0, 0, 0, 150 ) )

			draw.RoundedBox( 4 , ScrW() - 220 + 151, ScrH() - 45, 50 , 40, Color( 0, 0, 0, 150 ) )


			draw.SimpleText(HUDGETCLIP()..'/'..HUDGETAMMO(), "DermaLarge",ScrW() - 220 + 140 + 2, ScrH() - 40 + 2, Color(0,0,0,255), 2)
			draw.SimpleText(HUDGETCLIP()..'/'..HUDGETAMMO(), "DermaLarge", ScrW() - 220 + 140, ScrH() - 40, COLOR_TEXT, 2)

			draw.SimpleText(HUDGETSECONDARYAMMO(), "DermaLarge", w - 25 + 2, h  - 40 + 2, Color(0,0,0,255), 2)
			draw.SimpleText(HUDGETSECONDARYAMMO(), "DermaLarge", w  - 25, h - 40, COLOR_TEXT, 2)
		end
		HUDAMMO()
		]]--
	end

	if GetConVar("ru_hud_wallet_enable"):GetInt() == 1 then
		if ply:Alive() then 
			draw.RoundedBox( 0, w * 0.006, h * 0.89, 108, 30, COLOR_MAIN )
			draw.RoundedBox( 0, w * 0.006, h * 0.89, 5, 30, COLOR_GREEN )
			draw.SimpleText( money, "hud_text_lol", w * 0.01, h * 0.89, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			draw.RoundedBox( 0, w * 0.006, h * 0.84, 108, 30, COLOR_MAIN )
			draw.RoundedBox( 0, w * 0.006, h * 0.84, 5, 30, COLOR_PURPLE )
			draw.SimpleText( fc, "hud_text_lol", w * 0.01, h * 0.84, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end
	end 

	if GetConVar("ru_name_enable"):GetInt() == 1 then
		draw.SimpleTextOutlined( logo, "hud_text_lol", w / 2 + 632, h * 0.001, COLOR_LOGO, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, COLOR_BLACK)
	end

	--local tr = util.TraceLine( util.GetPlayerTrace(ply) )
	local trace = LocalPlayer():GetEyeTrace()
	local ent = trace.Entity

	local weaponClassTouchTypes = {
    	["weapon_physgun"] = "Physgun",
    	["weapon_physcannon"] = "Gravgun",
    	["gmod_tool"] = "Toolgun",
	}

	local function FilterEntityTable(t)
    	local filtered = {}

    	for i, e in ipairs(t) do
       		if (not e:IsWeapon()) then table.insert(filtered, e) end
   		end

    	return filtered
	end


	if GetConVar("ru_prop_gui"):GetInt() == 1 then

		if ply:Alive() and IsValid( ent )  and (!ent:IsWeapon()) then

			--local LAEnt2 = ents.FindAlongRay(ply:EyePos(), ply:EyePos() + EyeAngles():Forward() * 2555384)
   			--local LAEnt = FilterEntityTable(ent)[1]

   			local weapon = ply:GetActiveWeapon()
   			local class = weapon:IsValid() and weapon:GetClass() or ""

    		local touchType = weaponClassTouchTypes[class] or "EntityDamage"

			local reason = FPP.entGetTouchReason(ent, touchType)
			--if trace.HitPos:DistToSqr(trace.StartPos) < LAEnt:NearestPoint(trace.StartPos):DistToSqr(trace.StartPos) then return end
			if not IsValid(ent) then return end
			if not reason then return end
			local originalOwner = ent:GetNW2String("FPP_OriginalOwner")
   			originalOwner = originalOwner ~= "" and (" (previous owner: %s)"):format(originalOwner) or ""
    		reason = reason .. originalOwner
   			local col = FPP.canTouchEnt(ent, touchType) and Color(0, 255, 0, 255) or Color(255, 0, 0, 255)

			local ent_class = ent:GetClass()
			local ent_model = ent:GetModel()
			local ent_id = ent:EntIndex()
			local ent_pos = tostring( ent:GetPos()  )
			local ent_ang = tostring(ent:GetAngles() )
			local ent_toscreen = tostring( math.Round( ply:GetPos():Distance(ent:GetPos()), 0) )

			draw.RoundedBox( 0, w / 2 + 338, h * 0.44, 298, 140, COLOR_MAIN )
				if ( !ent:IsPlayer() ) then
					draw.SimpleText( "1.  " .. reason, "hud_prop", w / 2 + 340, h * 0.44, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
					draw.SimpleText( "2.  " .. ent_class .. " ["..ent_id.."]", "hud_prop", w / 2 + 340, h * 0.47, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		 		 else 
	    			draw.SimpleText( "1.  " .. ent:Name() .. " ["..ent_id.."]", "hud_prop", w / 2 + 340, h * 0.44, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
					draw.SimpleText( "2.  " .. "LVL: " .. ent:GetNWInt("lvl") .. " | K: " .. ent:Frags() .. " | D: " .. ent:Deaths() .. " | Ping: " .. ent:Ping(), "hud_prop", w / 2 + 340, h * 0.47, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				end
			draw.SimpleText( "3.  " .. string.sub(ent_model, 8, 99), "hud_prop", w / 2 + 340, h * 0.50, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText( "4.  " .. ent_pos, "hud_prop", w / 2 + 340, h * 0.53, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText( "5.  " .. ent_ang, "hud_prop", w / 2 + 340, h * 0.56, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText( "6.  " .. ent_toscreen .. " unit", "hud_prop", w / 2 + 340, h * 0.59, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end

	elseif GetConVar("ru_prop_gui"):GetInt() == 0 then
		if ply:Alive() and IsValid( ent )  and (!ent:IsWeapon()) then

			--local LAEnt2 = ents.FindAlongRay(ply:EyePos(), ply:EyePos() + EyeAngles():Forward() * 2555384)
   			--local LAEnt = FilterEntityTable(ent)[1]

   			local weapon = ply:GetActiveWeapon()
   			local class = weapon:IsValid() and weapon:GetClass() or ""

    		local touchType = weaponClassTouchTypes[class] or "EntityDamage"

			local reason = FPP.entGetTouchReason(ent, touchType)
			--if trace.HitPos:DistToSqr(trace.StartPos) < LAEnt:NearestPoint(trace.StartPos):DistToSqr(trace.StartPos) then return end
			if not IsValid(ent) then return end
			if not reason then return end
			local originalOwner = ent:GetNW2String("FPP_OriginalOwner")
   			originalOwner = originalOwner ~= "" and (" (previous owner: %s)"):format(originalOwner) or ""
    		reason = reason .. originalOwner
   			local col = FPP.canTouchEnt(ent, touchType) and Color(0, 255, 0, 255) or Color(255, 0, 0, 255)

			local ent_class = ent:GetClass()
			local ent_model = ent:GetModel()
			local ent_id = ent:EntIndex()
			local ent_pos = tostring( ent:GetPos()  )
			local ent_ang = tostring(ent:GetAngles() )
			local ent_toscreen = tostring( math.Round( ply:GetPos():Distance(ent:GetPos()), 0) )
			draw.RoundedBox( 0, w / 2 + 508, h * 0.44, 130, 25, COLOR_MAIN )
			if (!ent:IsPlayer()) then 
				draw.SimpleText( reason, "hud_prop", w / 2 + 510, h * 0.443, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			else 
				draw.SimpleText( ent:Name(), "hud_prop", w / 2 + 510, h * 0.443, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end
		end
	end

	local COLOR_ADMIN_PANEL = Color(45, 45, 45, 240)

	if GetConVar("ru_admin_gui"):GetInt() == 1 then
		draw.RoundedBox( 4, w / 2 - 70, h * 0.8, 150, 140, COLOR_ADMIN_PANEL )
		draw.SimpleText( "HP: "..hp.."   R: "..money, "ChatFont", w / 2 - 68, h * 0.8, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( "AR: "..armor.."   FC: "..fc, "ChatFont", w / 2 - 68, h * 0.8 + 15, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( "PING: "..ply:Ping().."  LVL: "..lvl.."  "..exp.."/"..next_exp, "ChatFont", w / 2 - 68, h * 0.8 + 30, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( ent , "ChatFont", w / 2 - 68, h * 0.8 + 45, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
		draw.SimpleText( "RANK: " .. ply:GetUserGroup(), "ChatFont", w / 2 - 68, h * 0.8 + 60, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( "ACCESS: " .. ply:GetNWInt("e2ac") , "ChatFont", w / 2 - 68, h * 0.8 + 75, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( os.date( "%H:%M:%S" ), "ChatFont", w / 2 - 68, h * 0.8 + 110, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( os.date( "%d/%m/%Y", os.time() ), "ChatFont", w / 2 - 68, h * 0.8 + 125, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
end
hook.Add( "HUDPaint", "custom_hud", custom_hud )



local hideHUDElements = {
	["CHudAmmo"] = false,
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudSecondaryAmmo"] = false,
	["CHudCrosshair"] = false,
	["CHudCloseCaption"] = true,
	["CHudDeathNotice"] = false,
	["CHudDamageIndicator"] = true,
}
hook.Add( "HUDShouldDraw", "hide_hud", function( n )
   	if hideHUDElements[n] then return false end
   	--
end )


local function hudHead( ply )
	if ( !IsValid( ply ) ) then return end
	if ( ply == LocalPlayer() ) then return end 
	if ( !ply:Alive() ) then return end 

	local dis = LocalPlayer():GetPos():Distance( ply:GetPos() )

	if ( dis < 950 ) then 

		local offset = Vector( 0, 0, 70 )
		local ang = LocalPlayer():EyeAngles()
		local pos = ply:GetPos() + offset + ang:Up()

		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )

		cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.15 )
			draw.SimpleTextOutlined( ply:GetName(), "DermaLarge", 0, -15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			if ply:GetNWBool("IsBuild") then
				draw.SimpleTextOutlined( "Build", "DermaLarge", 0, 15, Color( 0, 200, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			end
		cam.End3D2D()	  
	end
end
hook.Add( "PostPlayerDraw", "hudHead", hudHead )
hook.Add( "HUDDrawTargetID", "amb_hook_DisableTargetID", function() return false end)

