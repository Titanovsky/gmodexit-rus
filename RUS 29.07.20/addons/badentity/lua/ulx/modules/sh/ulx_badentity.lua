local CATEGORY_NAME = "[RU] Dev"
local warpCat = "[RU] Events"

function ulx.bad( calling_ply, target_ply, reason )
	local ming = target_ply:GetNWBool("IsMing")

	if target_ply:IsBot() then
		ULib.tsayError( calling_ply, "This player is immune to banning", true )
		return
	end

	if not calling_ply then
		calling_ply = "Server"
	end

	if ming == true then
		ulx.fancyLogAdmin( calling_ply, false, "#A убрал из Bad Entity челика #T", target_ply )
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A превратил в Bad Entity челика #T. По причине: #s", target_ply, reason )
	end
	Rus_BadEntityCreate( target_ply, calling_ply, reason )
end
local bad = ulx.command( CATEGORY_NAME, "ulx bad", ulx.bad, "!bad" )
bad:addParam{ type=ULib.cmds.PlayerArg }
bad:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional }
bad:defaultAccess( ULib.ACCESS_SUPERADMIN )
bad:help( "Превратить в Bad Entity." )


function ulx.badid( calling_ply, steamid, reason )
	steamid = steamid:upper()
	if not ULib.isValidSteamID( steamid ) then
		ULib.tsayError( calling_ply, "Неверный SteamID." )
		return
	end

	local name, target_ply
	local plys = player.GetAll()
	for i=1, #plys do
		if plys[ i ]:SteamID() == steamid then
			target_ply = plys[ i ]
			name = target_ply:Nick()
			break
		end
	end

	local query = sql.Query( "SELECT * FROM rus_bad_entity WHERE steamid = "..sql.SQLStr( steamid ) )

	if not query then
		if IsValid( calling_ply ) then
			sql.Query( "INSERT INTO rus_bad_entity ( nick, steamid, admin, reason ) VALUES ( ' offline ', '" .. steamid .. "', '" .. calling_ply:Nick() .. "', '" .. reason .. "' )" )
		else
			print( calling_ply )
			sql.Query( "INSERT INTO rus_bad_entity ( nick, steamid, admin, reason ) VALUES ( ' offline ', '" .. steamid .. "', '" .. "[SERVER]".. "', '" .. reason .. "' )" )
		end
		ulx.fancyLogAdmin( calling_ply, false, "#A превратил в Bad Entity #s. По причине: #s", steamid, reason )
		if IsValid(target_ply) then
			target_ply:SetNWBool("IsMing", true)
			target_ply:Kill()
		end
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A убрал из Bad Entity #s", reason )
		sql.Query("DELETE FROM rus_bad_entity WHERE steamid = '"..steamid.."'")
		if IsValid(target_ply) then
			target_ply:SetNWBool("IsMing", false)
			target_ply:Kill()
		end
	end
end
local badid = ulx.command( CATEGORY_NAME, "ulx badid", ulx.badid )
badid:addParam{ type=ULib.cmds.StringArg, hint="steamid" }
badid:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional }
badid:defaultAccess( ULib.ACCESS_SUPERADMIN )
badid:help( "Превратить в Bad Entity." )
