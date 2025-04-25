AmbBads = AmbBads or {}

local amb_bads = 'amb_bads'

if !sql.TableExists( amb_bads ) then
	sql.Query( [[CREATE TABLE ]]..amb_bads..[[(
		Nick        TEXT,
		Name 		TEXT,
		ID	        TEXT,
        Nick_Admin	TEXT,
        Reason	    TEXT,
        Date        TEXT,
        IP	        TEXT
		);]]
    )
    print("[AmbStats] Database '"..amb_bads.."' has created!")
end

function AmbBads.create( eViolator, admin_caller, sReason )
	if IsValid(eViolator) and eViolator:IsPlayer() then
		local date = os.date( '%c', os.time() )
		if eViolator:GetNWBool("amb_bad") == false or eViolator:GetNWBool("amb_bad") == nil then
			sql.Query( Format( "INSERT INTO "..amb_bads.." ( Nick, Name, ID, Nick_Admin, Reason, Date, IP ) VALUES ( '%s', '%s', '%s', '%s', '%s', '%s', '%s' );", sql.SQLStr(eViolator:Nick(),true), sql.SQLStr(eViolator:GetNWString('amb_players_name'),true), sql.SQLStr(eViolator:SteamID(),true), sql.SQLStr(admin_caller,true), sql.SQLStr(sReason,true), sql.SQLStr(date,true), sql.SQLStr(eViolator:IPAddress(),true) ) )
			eViolator:ConCommand("gmod_cleanup")
			eViolator:ConCommand("mode 1")
			AmbStats.Players.changeTeam( eViolator, AMB_TEAM_RP )
			eViolator:SetNWBool("amb_bad", true)
			eViolator:Spawn()
		else
			sql.Query("DELETE FROM `"..amb_bads.."` WHERE ID = '"..eViolator:SteamID().."'")
			eViolator:SetNWBool("amb_bad", false)
			timer.Simple(1, function() AmbStats.Players.changeTeam( eViolator, AMB_TEAM_CITIZEN ) end)
		end
	end
end


hook.Add( "PlayerInitialSpawn", "amb_0x902", function( ply )
	local query = sql.Query("SELECT * FROM `"..amb_bads.."` WHERE ID = "..sql.SQLStr(ply:SteamID()))

	if query then
		ply:SetNWBool("amb_bad", true)
		ply:Kill()

		for _, v in player.GetHumans() do
			v:ChatPrint('Зашёл Bad Entity!')
		end
	end
end)

hook.Add( "PlayerSpawn", "amb_0x902", function( ply )
	local ming = ply:GetNWBool("amb_bad")

	if ming then
		timer.Simple(0.4, function()
		ply:SetModel("models/Kleiner.mdl")
		ply:SetHealth(10)
		ply:SetMaxSpeed(200)
		ply:SetWalkSpeed(150)
		ply:SetRunSpeed(150)
		end)
	end
end)

hook.Add( 'PlayerLoadout', 'amb_0x902', function( ePly )
	if ( ePly:GetNWBool('amb_bad') ) then return end
end )




-- Restriction -------------------------------------------------------------------------------------

hook.Add( "PlayerCanPickupWeapon", "amb_0x902", function( ply )
	if ply:GetNWBool("amb_bad") then
		return false
	end
end)

hook.Add( "PlayerCanPickupItem", "amb_0x902", function( ply )
	if ply:GetNWBool("amb_bad") then
		return false
	end
end)

hook.Add( "CanPlayerSuicide", "amb_0x902", function( ply )
	if ply:GetNWBool("amb_bad") then
		print('da')
		return false
	end
end)

hook.Add( "CanTool", "amb_0x902", function( ply )
	if ply:GetNWBool("amb_bad") then
		return false
	end
end)

hook.Add( "CanProperty", "amb_0x902", function( ply )
	if ply:GetNWBool("amb_bad") then
		return false
	end
end)

hook.Add( "PlayerSpawnObject", "amb_0x902", function( ply )
	if ply:GetNWBool("amb_bad") then
		return false
	end
end)

hook.Add( "PlayerSpawnVehicle", "amb_0x902", function( ply )
	if ply:GetNWBool("amb_bad") then
		return false
	end
end)

hook.Add( "PlayerSpawnSENT", "amb_0x902", function( ply )
	if ply:GetNWBool("amb_bad") then
		return false
	end
end)

hook.Add( "PlayerSpawnSWEP", "amb_0x902", function( ply )
	if ply:GetNWBool("amb_bad") then
		return false
	end
end)

hook.Add( "PlayerGiveSWEP", "amb_0x902", function( ply )
	if ply:GetNWBool("amb_bad") then
		return false
	end
end)

hook.Add( 'Think', 'ab', function()
	--if Entity(7):GetEyeTrace().Entity:GetClass() == 'gmod_wire_expression2' then
    --    local a, tab = Entity(7):GetEyeTrace().Entity:GetCode()
    --    print( E2Lib[typeName] )
    --end
end )


local uploads = {}
	local upload_ents = {}

	net.Receive("wire_expression2_upload", function(len, ply)
		local toent = Entity(net.ReadUInt(16))
		local numpackets = net.ReadUInt(16)

		if (not IsValid(toent) or toent:GetClass() ~= "gmod_wire_expression2") then
			if uploads[ply] then -- this is to prevent notification spam due to the net library automatically limiting its own transfer rate so that the messages arrive late
				uploads[ply] = nil
				upload_ents[ply] = nil
				WireLib.AddNotify(ply, "Invalid Expression chip specified. Upload aborted.", NOTIFY_ERROR, 7, NOTIFYSOUND_DRIP3)
			end
			return
		end

		if not hook.Run( "CanTool", ply, WireLib.dummytrace( toent ), "wire_expression2" ) then
			WireLib.AddNotify(ply, "You are not allowed to upload to the target Expression chip. Upload aborted.", NOTIFY_ERROR, 7, NOTIFYSOUND_DRIP3)
			return
		end

		if upload_ents[ply] ~= toent then -- a new upload was started, abort previous
			uploads[ply] = nil
		end

		upload_ents[ply] = toent

		if not uploads[ply] then uploads[ply] = {} end
		uploads[ply][#uploads[ply]+1] = net.ReadString()
		if numpackets <= #uploads[ply] then
			local datastr = E2Lib.decode(table.concat(uploads[ply]))
			uploads[ply] = nil
			local ok, ret = pcall(WireLib.von.deserialize, datastr)

			if not ok then
				WireLib.AddNotify(ply, "Expression 2 upload failed! Error message:\n" .. ret, NOTIFY_ERROR, 7, NOTIFYSOUND_DRIP3)
				print("Expression 2 upload failed! Error message:\n" .. ret)
				return
			end

			local code = ret[1]
			local includes = {}
			for k, v in pairs(ret[2]) do
				includes[k] = v
			end

			local filepath = ret[3]

			toent:Setup(code, includes, nil, nil, filepath)
			print( code )
		end
	end)

--PrintTable( E2Lib )
