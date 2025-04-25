
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
local COLOR_BLUE_SOFT = Color( 0, 217, 255 )
local COLOR_GREEN = Color( 12, 138, 27, 230 )
local COLOR_PURPLE = Color( 90, 4, 201, 230 )
local COLOR_BLACK = Color( 0, 0, 0, 230 )
local COLOR_TEXT = Color( 240, 240, 240, 255 )
local COLOR_TEXT_LOW = Color( 255, 203, 196, 255 )
local COLOR_TEXT_BLOOD = Color( 227, 141, 129, 200 + math.sin( SysTime() * 20) * 100 )
local COLOR_BUILDTEXT = Color( 255, 255, 255 )
local COLOR_BUILDTEXT_OUTLINE = Color( 57, 181, 4 )
local COLOR_SAFE = Color(0, 138, 212, 150)
local COLOR_ADMIN_PANEL = Color(45, 45, 45, 240)


local w = ScrW()
local h = ScrH()

local main_w, main_h = w / 1.32, h * 0.442
local main_hud_w, main_hud_h = w * 0.003, h * 0.954
local main_logo_w, main_logo_h = w * 0.996, h * 0.002

local logo = "[RU's]"



function custom_hud()

	local ply = LocalPlayer()
	local hp = ply:Health()
	local armor = ply:Armor()
	local money = ply:GetNWInt("rub")
	local lvl = ply:GetNWInt("lvl")
	local exp = ply:GetNWInt("exp")
	local next_exp = ply:GetNWInt("next_exp")
	local fc = ply:GetNWInt("friskCoins")
	local buildmode = ply:GetNWBool("IsBuild")

	if GetConVar("ru_hud_enable"):GetInt() == 1 then

		if ply:Alive() then

			if ( zone.DrawHUDSafe ) and buildmode == false and ply.jailed == false then
				draw.SimpleTextOutlined( "Зона Спавна", "ZN", main_hud_w + 112, main_hud_h + 8, COLOR_BUILDTEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, COLOR_SAFE )
			end

			if buildmode == true then
				draw.SimpleTextOutlined( "Build", "ZN", main_hud_w + 112, main_hud_h + 8, COLOR_BUILDTEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, COLOR_BUILDTEXT_OUTLINE)
			end
			draw.RoundedBox( 0, main_hud_w, main_hud_h, 50, 30, COLOR_MAIN ) -- HP
			draw.RoundedBox( 0, main_hud_w, main_hud_h, 5, 30, COLOR_RED )
			if hp > 50 then
				draw.SimpleText( hp, "hud_text_lol", main_hud_w + 4, main_hud_h, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			elseif hp > 20 then
				draw.SimpleText( hp, "hud_text_lol", main_hud_w + 4, main_hud_h, COLOR_TEXT_LOW, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			else
				draw.SimpleText( hp, "hud_text_lol", main_hud_w + 4, main_hud_h, COLOR_TEXT_BLOOD, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end
		end

		if armor > 0 and ply:Alive() then
			draw.RoundedBox( 0, main_hud_w + 58, main_hud_h, 50, 30, COLOR_MAIN )
			draw.RoundedBox( 0, main_hud_w + 58, main_hud_h, 5, 30, COLOR_BLUE )
			draw.SimpleText( armor, "hud_text_lol", main_hud_w + 62, main_hud_h, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end
	end

	if GetConVar("ru_hud_wallet_enable"):GetInt() == 1 then
		if ply:Alive() then
			draw.RoundedBox( 0, main_hud_w, main_hud_h - 32, 108, 30, COLOR_MAIN )
			draw.RoundedBox( 0, main_hud_w, main_hud_h - 32, 5, 30, COLOR_GREEN )
			draw.SimpleText( money, "hud_text_lol", main_hud_w + 6, main_hud_h - 32, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end
	end

	if GetConVar("ru_name_enable"):GetInt() == 1 then
		draw.SimpleTextOutlined( logo, "hud_text_lol", main_logo_w, main_logo_h, COLOR_BLUE_SOFT, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, COLOR_BLACK)
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

			draw.RoundedBox( 0, main_w, main_h, 304, 120, COLOR_MAIN )
				if ( !ent:IsPlayer() ) then
					draw.SimpleText( "1.  " .. reason, "hud_prop", main_w, main_h, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
					draw.SimpleText( "2.  " .. ent_class .. " ["..ent_id.."]", "hud_prop", main_w, main_h + 20, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		 		 else
	    			draw.SimpleText( "1.  " .. ent:Name() .. " ["..ent_id.."]", "hud_prop", main_w, main_h, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
					draw.SimpleText( "2.  " .. "LVL: " .. ent:GetNWInt("lvl") .. " | K: " .. ent:Frags() .. " | D: " .. ent:Deaths() .. " | Ping: " .. ent:Ping(), "hud_prop", main_w, main_h + 20, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				end
			draw.SimpleText( "3.  " .. string.sub(ent_model, 8, 99), "hud_prop", main_w, main_h + 40, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText( "4.  " .. ent_pos, "hud_prop", main_w, main_h + 60, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText( "5.  " .. ent_ang, "hud_prop", main_w, main_h + 80, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText( "6.  " .. ent_toscreen .. " unit", "hud_prop",main_w, main_h + 100, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
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
			draw.RoundedBox( 0, main_w * 1.175, main_h, 130, 25, COLOR_MAIN )
			if (!ent:IsPlayer()) then
				draw.SimpleText( reason, "hud_prop", main_w * 1.175 , main_h, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			else
				draw.SimpleText( ent:Name(), "hud_prop", main_w * 1.175 , main_h, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end
		end
	end

	if GetConVar("ru_admin_gui"):GetInt() == 1 then
		draw.RoundedBox( 4, main_w / 2 + 40, main_h * 1.82, 150, 140, COLOR_ADMIN_PANEL )
		draw.SimpleText( "HP: "..hp.."   R: "..money, "ChatFont", main_w / 2 + 40, main_h * 1.82, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( "AR: "..armor.."   FC: "..fc, "ChatFont", main_w / 2 + 40, main_h * 1.82 + 15, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( "PING: "..ply:Ping(), "ChatFont", main_w / 2 + 40, main_h * 1.82 + 30, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( "LVL: "..lvl.."  "..exp.."/"..next_exp, "ChatFont", main_w / 2 + 40, main_h * 1.82 + 45, COLOR_GREEN, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( "RANK: " .. ply:GetUserGroup(), "ChatFont", main_w / 2 + 40, main_h * 1.82 + 60, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( "ACCESS: " .. ply:GetNWInt("e2ac") , "ChatFont", main_w / 2 + 40, main_h * 1.82 + 75, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( os.date( "%H:%M:%S" ), "ChatFont", main_w / 2 + 40, main_h * 1.82 + 110, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText( os.date( "%d/%m/%Y", os.time() ), "ChatFont", main_w / 2 + 40, main_h * 1.82 + 125, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	if ply:GetNWBool("IsMing") then
		draw.SimpleTextOutlined( "Bad Entity!", "hud_text_lol", main_w / 2 + 46, main_h * 0.1, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, COLOR_RED)
		draw.SimpleTextOutlined( "Ты читер/минга/крашер/e2минга", "ZN", main_w / 2 - 30, main_h * 0.1 + 30, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 0.6, COLOR_BLACK)
		draw.SimpleTextOutlined( "Тебе нельзя ничего спавнить/создавать/делать", "ZN", main_w / 2 - 60, main_h * 0.1 + 60, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 0.6, COLOR_BLACK)
		draw.SimpleTextOutlined( "Ты ничтожество, которое мешало другим играть", "ZN", main_w / 2 - 80, main_h * 0.1 + 90, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 0.6, COLOR_BLACK)
		draw.SimpleTextOutlined( "Отныне ты никто!", "ZN", main_w / 2 + 20, main_h * 0.1 + 120, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 0.6, COLOR_BLACK)
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

	if ( dis < 650 ) then

		local offset = Vector( 0, 0, 70 )
		local ang = LocalPlayer():EyeAngles()
		local pos = ply:GetPos() + offset + ang:Up()

		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )

		cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.15 )
			draw.SimpleTextOutlined( ply:GetName(), "DermaLarge", 0, -15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )

			if ply:SteamID() == 'STEAM_0:1:95303327' then
				draw.SimpleTextOutlined( 'Шериф', "DermaLarge", 0, -64, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 255 ) )
			end

			if ply:GetNWBool("IsBuild") then
				draw.SimpleTextOutlined( "Build", "DermaLarge", 0, 15, Color( 0, 200, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			else
				draw.SimpleText( "["..ply:Health().."]", "TargetID", surface.GetTextSize(ply:GetName())/2, 12, COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				if ply:Armor() > 0 then
					draw.SimpleText( "["..ply:Armor().."]", "TargetID", surface.GetTextSize(ply:GetName())/2, 32, COLOR_BLUE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				end
			end
			if ply:GetNWBool("IsMing") == true then
				draw.SimpleTextOutlined( "Bad Entity", "DermaLarge", 0, -45, Color( 200, 0, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			end
		cam.End3D2D()
	end
end
hook.Add( "PostPlayerDraw", "hudHead", hudHead )
hook.Add( "HUDDrawTargetID", "amb_hook_DisableTargetID", function() return false end)

