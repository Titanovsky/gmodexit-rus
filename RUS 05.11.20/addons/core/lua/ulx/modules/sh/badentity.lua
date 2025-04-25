local CATEGORY_NAME = "[RUs]"

function ulx.bad( calling_ply, target_ply, reason )
	local ming = target_ply:GetNWBool("amb_bad")

	if target_ply:IsBot() then
		ULib.tsayError( calling_ply, "This player is immune to banning", true )
		return
	end

	if not calling_ply then
		calling_ply = "Server"
	end

	if ming == true then
		ulx.fancyLogAdmin( calling_ply, false, "#A remove from `Bad Entity` player #T", target_ply )
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A added in `Bad Entity` player #T. Reason: #s", target_ply, reason )
	end
	AmbBads.create( target_ply, calling_ply, reason )
end
local bad = ulx.command( CATEGORY_NAME, "ulx bad", ulx.bad, "/bad" )
bad:addParam{ type=ULib.cmds.PlayerArg }
bad:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional }
bad:defaultAccess( ULib.ACCESS_SUPERADMIN )
bad:help( "Add Bad Entity." )


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

	local date = os.date( '%c', os.time() )
	local query = sql.Query( "SELECT * FROM `amb_bads` WHERE ID = "..sql.SQLStr( steamid ) )

	if not query then
		if IsValid( calling_ply ) then
			sql.Query( "INSERT INTO amb_bads (  Nick, Name, ID, Nick_Admin, Reason, Date, IP ) VALUES ( 'offline', 'offline', '"..steamid.."', '"..calling_ply:Nick().."', '"..reason.."', '"..date.."', 'offline'  );" )
		else
			sql.Query( "INSERT INTO amb_bads (  Nick, Name, ID, Nick_Admin, Reason, Date, IP ) VALUES ( 'offline', 'offline', '"..steamid.."', '[CONSOLE]', '"..reason.."', '"..date.."', 'offline'  );" )
		end
		ulx.fancyLogAdmin( calling_ply, false, "#A added in `Bad Entity` ID #s. Reason: #s", steamid, reason )
		if IsValid(target_ply) then
			target_ply:SetNWBool("amb_bad", true)
			target_ply:Kill()
		end
	else
		ulx.fancyLogAdmin( calling_ply, false, "#A removed from Bad Entity ID #s", steamid )
		sql.Query("DELETE FROM amb_bads WHERE ID = '"..steamid.."'")
		if IsValid(target_ply) then
			target_ply:SetNWBool("amb_bad", false)
			target_ply:Kill()
		end
	end
end
local badid = ulx.command( CATEGORY_NAME, "ulx badid", ulx.badid )
badid:addParam{ type=ULib.cmds.StringArg, hint="steamid" }
badid:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional }
badid:defaultAccess( ULib.ACCESS_SUPERADMIN )
badid:help( "Превратить в Bad Entity." )
