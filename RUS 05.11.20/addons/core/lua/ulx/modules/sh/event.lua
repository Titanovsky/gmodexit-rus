local categ_event = '[RUs] Event'

-- WARP ------------------------------------
local warpOn = false
local warpPos = Vector(0,0,0)

function ulx.warp( calling_ply )
	if warpOn then
		calling_ply:SetPos( warpPos )
		ulx.fancyLogAdmin( calling_ply, false, "#A Send in warp" )
	else
		ULib.tsayError( calling_ply, "Warp has locked!", true )
	end
end
local warp = ulx.command( categ_event, "ulx warp", ulx.warp, "/warp" )
warp:defaultAccess( ULib.ACCESS_ALL )
warp:help( "Teleport in Warp" )

function ulx.setwarp( calling_ply )
	if warpOn then
		warpOn = false
		ulx.fancyLogAdmin( calling_ply, false, "#A Closed warp" )
	else
		warpOn = true
		warpPos = calling_ply:GetPos() + Vector( 0, 0, 16 )
		ulx.fancyLogAdmin( calling_ply, false, "#A Open warp" )
	end
end
local setwarp = ulx.command( categ_event, "ulx setwarp", ulx.setwarp, "/setwarp" )
setwarp:defaultAccess( ULib.ACCESS_ADMIN )
setwarp:help( "Create/Unlocked warp or Remove/Locked warp." )

------------------------------------

function ulx.stripsweaponsevent( calling_ply )

	for k, v in pairs(player.GetHumans()) do
		if ( v ~= calling_ply ) and ( ( calling_ply:GetPos():Distance( v:GetPos() ) ) <= 1200 )then
			v:StripWeapons()
		end
	end
    ulx.fancyLogAdmin( calling_ply, false, "#A strip weapon around radius 1200 units"  )
end
local stripsweaponsevent = ulx.command( categ_event, "ulx swe", ulx.stripsweaponsevent, "/swe" )
stripsweaponsevent:defaultAccess( ULib.ACCESS_ADMIN )
stripsweaponsevent:help( "Strip weapons around player on 1200 units." )

function ulx.hpevent( calling_ply, number )

	for k, v in pairs(player.GetHumans()) do
		if ( v ~= calling_ply ) and ( ( calling_ply:GetPos():Distance( v:GetPos() ) ) <= 1200 ) then
			v:SetHealth( number )
		end
	end

	ulx.fancyLogAdmin( calling_ply, false, "#A add Health players around radius 1200 units"  )
end
local hpevent = ulx.command( categ_event, "ulx he", ulx.hpevent, "/he" )
hpevent:addParam{ type=ULib.cmds.NumArg, hint="HP" }
hpevent:defaultAccess( ULib.ACCESS_ADMIN )
hpevent:help( "Add HP for radius 1200 units." )

local function playSoundCount( count )
	for k, v in pairs( player.GetHumans() ) do
		v:SendLua('surface.PlaySound( "ambition/amb_zombie_mode_sounds_pack/countdown/'..tostring(count)..'.wav" )')
	end
end

function ulx.countdown( calling_ply, max )

	for i = 1, max do
		timer.Simple( i-0.75, function() playSoundCount( i ) end )
	end

	ulx.fancyLogAdmin( calling_ply, false, "#A start `CountDown` to #i", max  )
end
local countdown = ulx.command( categ_event, "ulx countdown", ulx.countdown, "/countdown" )
countdown:addParam{ type=ULib.cmds.NumArg, min=1, max=10, hint="Count", ULib.cmds.round }
countdown:defaultAccess( ULib.ACCESS_ADMIN )
countdown:help( "Countdowns." )