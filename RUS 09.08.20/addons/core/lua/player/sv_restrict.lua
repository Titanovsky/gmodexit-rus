AmbRestrict = AmbRestrict or {}

AmbRestrict.Tools = { -- todo: change table v[2] (ranks)
	-- ['name'] = { lvl, { ranks } }
	['duplicator'] 	= { 1, { 'admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },

	['weld'] 		= { 1, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['axis'] 		= { 1, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['ballsocket']  = { 1, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },

	['rope'] 		= { 2, { 'superadmin', 'helper', 'vip', 'officer', 'd_officer', 'd_admin', 'admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['advdupe2']	= { 2, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'd_admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['winch'] 		= { 2, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'd_admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['muscle'] 		= { 2, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'd_admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['slider'] 		= { 2, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'd_admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['hydraulic'] 	= { 2, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'd_admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['motor'] 		= { 2, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'd_admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['elastic'] 	= { 2, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'd_admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['balloons'] 	= { 2, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'd_admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
	['button'] 		= { 2, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'd_admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },

	['creator']  	= { 3, { 'user', 'helper', 'vip', 'officer', 'd_officer', 'admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },

	['dynamite'] 	= { 4, { 'helper', 'vip', 'officer', 'd_officer', 'admin', 'd_admin', 'ahc', 'sub_head_admin', 'superadmin', 'head_admin' } },
}

local weapons_builder = {
	'weapon_physcannon',
	'weapon_physgun',
	'weapon_physgun',
	'gmod_camera',
	'gmod_tool',
	'laserpointer',
	'remotecontroller',
	'weapon_simrepair',
	'weapon_simremote'
}

local spec_weapons = {
	['infinitygauntlet'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' },
	['infinitygauntlet_empty'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' }
}

for k, v in pairs( ents.GetAll() ) do
	if v:GetClass() == 'light_environment' then
		print( v:EntIndex() )
	end
end

local entities_blacklist = {
	'edit_fog',
	'edit_sky',
	'edit_sun',
	'sent_ball', -- remove
	'grenade_helicopter', -- remove
	'prop_thumper', -- remove
	'npc_grenade_frag',
	'amb_npc_job_employer'
}

hook.Add( 'PlayerSpawnProp', 'amb_0x228', function( ePly, sModel )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
	return true
end )

hook.Add( 'PlayerSpawnRagdoll', 'amb_0x228', function( ePly, sModel )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
	return AmbStats.Players.limitEntities( ePly, 'ragdolls' )
end )

hook.Add( 'PlayerSpawnEffect', 'amb_0x228', function( ePly, sModel )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
	return AmbStats.Players.limitEntities( ePly, 'effects' )
end )

hook.Add( 'PlayerSpawnSENT', 'amb_0x228', function( ePly, sEnt )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
	for _, ent in pairs( entities_blacklist ) do
		if ( sEnt == ent ) then
			if ePly:GetUserGroup() == 'sub_head_admin' or ePly:GetUserGroup() == 'superadmin' or ePly:GetUserGroup() == 'head_admin' then
				return true
			else
				AmbLib.notifySend( ePly, "Access Denied!", 1, 2, 'buttons/button10.wav' )
				return false
			end
		end
	end

	if AmbStats.Players.limitEntities( ePly, 'sents' ) then
		return AmbEconomic.buy( ePly, sEnt, 'ents' )
	else
		return false
	end
end )


hook.Add( 'PlayerSpawnSWEP', 'amb_0x228', function( ePly, sWeapon, tSWEP )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin

	for name, _ in pairs( spec_weapons ) do
		if sWeapon == name then return false end
	end

	if ( ePly:Team() == 3 ) then
		ePly:ChatPrint("net")
		for _, v in pairs( weapons_builder ) do
			if ( sWeapon == v ) then ePly:ChatPrint("da") return true end
			AmbLib.notifySend( ePly, "Your a builder, can't spawn Weapons!", 1, 4, 'buttons/button10.wav' )
			return false
		end
	end
	-- ePly:ChatPrint( sWeapon ) -- debug
	if AmbStats.Players.limitEntities( ePly, 'sents' ) then
		return AmbEconomic.buy( ePly, sWeapon, 'weapons' )
	else
		return false
	end
end )

local function ambGiveWepSpec( ePly, sWeapon )
	for name, v in pairs( spec_weapons ) do
		if ( name == sWeapon ) then
			for _, id in pairs( spec_weapons[sWeapon] ) do
				-- ePly:ChatPrint( rank ) -- debug
				if ( ePly:SteamID() == id ) then return true end
			end
		end
	end
	AmbLib.notifySend( ePly, 'Access Denied!', 1, 2, 'buttons/button10.wav' )
	return false
end

hook.Add( 'PlayerGiveSWEP', 'amb_0x228', function( ePly, sWeapon, tSWEP )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
	for name, v in pairs( spec_weapons ) do
		if ( name == sWeapon ) then
			return ambGiveWepSpec( ePly, sWeapon )
		end
	end

	if ( ePly:Team() == 3 ) then
		for k, v in pairs( weapons_builder ) do
			if ( sWeapon == v ) then
				return true
			else
				if ( k == #weapons_builder ) then
					AmbLib.notifySend( ePly, "Your a builder, can't spawn Weapons!", 1, 4, 'buttons/button10.wav' )
					return false
				end
			end
		end
	end
	-- ePly:ChatPrint( sWeapon ) -- debug
	if ePly:Team() == 1 then AmbLib.notifySend( ePly, "Your a just player, can't spawn Weapons", 1, 4, 'buttons/button10.wav' ) return false end -- потому что лимита на weapons нет!
		return AmbEconomic.buy( ePly, sWeapon, 'weapons' )
end )

hook.Add( 'PlayerSpawnVehicle', 'amb_0x228', function( ePly, sModel, sName, tTable )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
	if AmbStats.Players.limitEntities( ePly, 'vehicles' ) then
		return AmbEconomic.buy( ePly, sModel, 'vehicles' )
	else
		return false
	end
end )

hook.Add( 'PlayerSpawnNPC', 'amb_0x228', function( ePly, sNpc_Type, sWep )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
	return AmbStats.Players.limitEntities( ePly, 'npcs' )
end )

function AmbRestrict.calcRanks( ePly, sTool )
	for name, v in pairs( AmbRestrict.Tools ) do
		if ( name == sTool ) then
			for _, rank in pairs( AmbRestrict.Tools[sTool][2] ) do
				-- ePly:ChatPrint( rank ) -- debug
				if ( ePly:GetUserGroup() == rank ) then return true end
			end
		end
	end
	AmbLib.notifySend( ePly, 'Access Denied!', 1, 2, 'buttons/button10.wav' )
	return false
end


hook.Add( 'CanTool', 'amb_0x228', function( ePly, tTrace, sTool )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
	if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't user ToolGun!", 1, 4, 'buttons/button10.wav' ) return false end

	for name, v in pairs( AmbRestrict.Tools ) do
		if ( name == sTool ) then
			if tonumber( ePly:GetNWInt('amb_players_level') ) >= v[1] then return AmbRestrict.calcRanks( ePly, sTool ) end
			AmbLib.notifySend( ePly, "For this is tool need a level: "..v[1], 1, 3, 'buttons/button10.wav' )
			return false
		end
	end
end )

local properties_blacklist = {
	'ignite',
	'gravity',
	'collisions',
	'npc_scale',
	'kinect_controller',
	'editentity',
	'drive',
	'bone_manipulate',
	'persist'
}

hook.Add( 'CanProperty', 'amb_0x228', function( ePly, sProperty, ent )
	if ePly:GetUserGroup() == 'user' then
		for _, property in pairs( properties_blacklist ) do
			if sProperty == property then
				AmbLib.notifySend( ePly, "It property not available users!", 1, 3, 'buttons/button10.wav' )
				return false
			end
		end
	end
end)