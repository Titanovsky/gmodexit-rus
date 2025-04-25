local ply_struct = FindMetaTable( "Player" )

function Rus_BadEntityCreate( eViolator, ePly, sReason )
	if IsValid(eViolator) and eViolator:IsPlayer() then
		if eViolator:GetNWBool("IsMing") == false or eViolator:GetNWBool("IsMing") == nil then
			sql.Query( "INSERT INTO rus_bad_entity ( nick, steamid, admin, reason ) VALUES ( '" .. eViolator:Nick() .. "', '" .. eViolator:SteamID() .. "', '" .. ePly:Nick() .. "', '" .. sReason .. "' )" )
			eViolator:ConCommand("gmod_cleanup")
			eViolator:SetNWBool("IsMing", true)
			timer.Simple(1, function() eViolator:Spawn() end)
		else
			sql.Query("DELETE FROM rus_bad_entity WHERE steamid = '"..eViolator:SteamID().."'")
			eViolator:SetNWBool("IsMing", false)
			timer.Simple(1, function() eViolator:Spawn() end)
		end
	end
end


hook.Add( "OnGamemodeLoaded", "asdasdasdsd", function()
	sql.Query("CREATE TABLE IF NOT EXISTS rus_bad_entity(nick varchar(255), steamid VARCHAR(255) PRIMARY KEY, admin varchar(255), reason varchar(255) )")
end)

--[[
hook.Add("PlayerDisconnected","MING_db_loaded",function ( ply )
	local ming = ply:GetNWBool("IsMing")

	if ming then
		sql.Query( "INSERT INTO rus_bad_entity ( steamid ) VALUES ( '" .. ply:SteamID() .. "' )" )
	end
end)
]]

hook.Add( "PlayerInitialSpawn", "MING_db_loaded", function( ply )
	local query = sql.Query("SELECT * FROM rus_bad_entity WHERE steamid = "..sql.SQLStr(ply:SteamID()))

	if query then
		ply:SetNWBool("IsMing", true)
		ply:Kill()

		for _, v in player.GetHumans() do
			v:SendLua("notification.AddLegacy( 'Зашёл Bad Entity!', NOTIFY_ERROR, 2 )")
		end
	end
end)

hook.Add( "PlayerSpawn", "MING_db_loaded", function( ply )
	local ming = ply:GetNWBool("IsMing")

	if ming then
		timer.Simple(.4, function()
		ply:SetModel("models/Kleiner.mdl")
		ply:StripWeapons()
		ply:SetHealth(10)
		ply:SetMaxSpeed(200)
		ply:SetWalkSpeed(150)
		ply:SetRunSpeed(150)
		end)
	end
end)




-- Restriction -------------------------------------------------------------------------------------

hook.Add( "PlayerCanPickupWeapon", "MING_restrict", function( ply )
	if ply:GetNWBool("IsMing") then
		return false
	end
end)

hook.Add( "PlayerCanPickupItem", "MING_restrict", function( ply )
	if ply:GetNWBool("IsMing") then
		return false
	end
end)

hook.Add( "CanPlayerSuicide", "MING_restrict", function( ply )
	if ply:GetNWBool("IsMing") then
		return false
	end
end)

hook.Add( "CanTool", "MING_restrict", function( ply )
	if ply:GetNWBool("IsMing") then
		return false
	end
end)

hook.Add( "CanProperty", "MING_restrict", function( ply )
	if ply:GetNWBool("IsMing") then
		return false
	end
end)

hook.Add( "PlayerSpawnObject", "MING_restrict", function( ply )
	if ply:GetNWBool("IsMing") then
		return false
	end
end)

hook.Add( "PlayerSpawnVehicle", "MING_restrict", function( ply )
	if ply:GetNWBool("IsMing") then
		return false
	end
end)

hook.Add( "PlayerSpawnSENT", "MING_restrict", function( ply )
	if ply:GetNWBool("IsMing") then
		return false
	end
end)

hook.Add( "PlayerSpawnSWEP", "MING_restrict", function( ply )
	if ply:GetNWBool("IsMing") then
		return false
	end
end)

hook.Add( "PlayerGiveSWEP", "MING_restrict", function( ply )
	if ply:GetNWBool("IsMing") then
		return false
	end
end)

