AmbRestrict = AmbRestrict or {}

local ALL_GROUPS = { 'user', 'helper', 'vip', 'officer', 'admin', 'ahc', 'superadmin', 'head_admin' }
local ADMINS = { 'admin', 'ahc', 'superadmin', 'head_admin' }
local VIP = { 'helper', 'vip', 'officer', 'admin', 'ahc', 'superadmin', 'head_admin' }

AmbRestrict.Tools = { -- todo: change table v[2] (ranks)

	['duplicator'] 	= { 1, ADMINS },

	['axis'] 		= { 2, ALL_GROUPS },
	['ballsocket']  = { 2, ALL_GROUPS },

	['weld'] 		= { 3, ALL_GROUPS },
	['rope'] 		= { 3, ALL_GROUPS },
	['advdupe2']	= { 3, ALL_GROUPS },
	['winch'] 		= { 3, ALL_GROUPS },
	['muscle'] 		= { 3, ALL_GROUPS },
	['slider'] 		= { 3, ALL_GROUPS },
	['hydraulic'] 	= { 3, ALL_GROUPS },
	['motor'] 		= { 3, ALL_GROUPS },
	['elastic'] 	= { 3, ALL_GROUPS },
	['balloons'] 	= { 3, ALL_GROUPS },
	['button'] 		= { 3, ALL_GROUPS },
	['creator']  	= { 3, ALL_GROUPS },
	['stacker_improved']  = { 3, ALL_GROUPS },
	[ 'trackassembly' ] = { 6, ALL_GROUPS },

	['dynamite'] 	= { 4, VIP },
	['fin2']  		= { 4, ALL_GROUPS },
	['hoverball']  	= { 4, ALL_GROUPS },
	['lamp']  		= { 4, ALL_GROUPS },
	['light']  		= { 4, ALL_GROUPS },
	['nocollide']  	= { 4, ALL_GROUPS },
	['textscreen']  = { 4, ALL_GROUPS },

	['thruster']  	= { 5, ALL_GROUPS },
	['wheel']  		= { 5, ALL_GROUPS },
	['keypad_willox']  	= { 5, ALL_GROUPS },
	['nocollide']  	= { 5, ALL_GROUPS },

	['eyeposer']  	= { 5, VIP },
	['faceposer']  	= { 5, VIP },
	['finger']  	= { 5, VIP },
	['inflator']  	= { 5, VIP },
}

local weapons_builder = {
	'weapon_physcannon',
	'weapon_physgun',
	'weapon_physgun',
	'gmod_camera',
	'gmod_tool',
	'laserpointer',
	'weapon_simrepair',
	'weapon_remotedrone',
	'remotecontroller',
	'weapon_simrepair',
	'weapon_simremote',
	'weapon_empty_hands'
}

local spec_weapons = {

	['drone_aentity'] = { 'STEAM_0:0:426598565' },
	['drone_dentity'] = { 'STEAM_0:0:426598565' },
	['drone_entity'] = { 'STEAM_0:0:426598565' },
	['drone_wentity'] = { 'STEAM_0:0:426598565' },
	['drone_lentity'] = { 'STEAM_0:0:426598565' },
	['drone_centity'] = { 'STEAM_0:0:426598565' },
	['drone_nentity'] = { 'STEAM_0:0:426598565' },
	['drone_rentity'] = { 'STEAM_0:0:426598565' },
	['drone_bentity'] = { 'STEAM_0:0:426598565' },
	['drone_nanodrone'] = { 'STEAM_0:0:426598565' },
	['drone_nanodronemarkii'] = { 'STEAM_0:0:426598565' },
	['drone_spy'] = { 'STEAM_0:0:426598565' },
	['drone_wheelbasic'] = { 'STEAM_0:0:426598565' },
	['drone_groundgunner'] = { 'STEAM_0:0:426598565' },
	['drone_groundlaser'] = { 'STEAM_0:0:426598565' },
	['drone_groundmissile'] = { 'STEAM_0:0:426598565' },
	['drone_groundsniper'] = { 'STEAM_0:0:426598565' },
	['drone_flamethrower'] = { 'STEAM_0:0:426598565' },
	['drone_grenadier'] = { 'STEAM_0:0:426598565' },
	['drone_heavy'] = { 'STEAM_0:0:426598565' },
	['drone_heavymarkii'] = { 'STEAM_0:0:426598565' },
	['drone_missile'] = { 'STEAM_0:0:426598565' },
	['drone_missilemarkii'] = { 'STEAM_0:0:426598565' },
	['drone_racer'] = { 'STEAM_0:0:426598565' },
	['drone_steel'] = { 'STEAM_0:0:426598565' },
	['drone_tartillery'] = { 'STEAM_0:0:426598565' },
	['drone_bomb'] = { 'STEAM_0:0:426598565' },
	['drone_two_entity'] = { 'STEAM_0:0:426598565' },
	['drone_laser'] = { 'STEAM_0:0:426598565' },
	['drone_lasermarkii'] = { 'STEAM_0:0:426598565' },
	['drone_microwave'] = { 'STEAM_0:0:426598565' },
	['drone_pbomb'] = { 'STEAM_0:0:426598565' },
	['drone_scout'] = { 'STEAM_0:0:426598565' },
	['drone_shotgun'] = { 'STEAM_0:0:426598565' },
	['drone_sniper'] = { 'STEAM_0:0:426598565' },
	['drone_warrior'] = { 'STEAM_0:0:426598565' },
	['drone_warriormarkii'] = { 'STEAM_0:0:426598565' },
	['drone_ball'] = { 'STEAM_0:0:426598565' },
	['drone_civilian'] = { 'STEAM_0:0:426598565' },
	['drone_box'] = { 'STEAM_0:0:426598565' },
	['drone_skull'] = { 'STEAM_0:0:426598565' },
	['hacktool_drone'] = { 'STEAM_0:0:426598565' },

	['climb_swep2'] = { 'STEAM_0:0:435148107' },

	['weapon_fireballoon'] = { 'STEAM_0:0:431600296', 'STEAM_0:1:95303327' }, -- timur
	['coaster_supertool'] = { 'STEAM_0:0:431600296', 'STEAM_0:1:95303327' }, 

	['weapon_mor_base_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' }, -- Жождынский
	['weapon_mor_chitin_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_daedric_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_dwemer_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_ebony_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_imperial_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_iron_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_silver_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_steel_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },

	[ 'weapon_bp_alyxgun' ] = { 'STEAM_0:0:426598565' }, -- Оксайдуса
	[ 'weapon_bp_annabelle' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_shotgun' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_binoculars' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_bbcrem' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_flaregun' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_guardgun' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_hopwire' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_immolator' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_flamethrower' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_irifle' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_manhack' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_launcher' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_cocktail' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_radio' ] =  { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_stickylauncher' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_taucannon' ] = { 'STEAM_0:0:426598565' },
	[ 'weapon_bp_rlauncher' ] = { 'STEAM_0:0:426598565' },

}

local function ambGiveWepSpec( ePly, sWeapon )

	if ( ePly:SteamID() == 'STEAM_0:1:95303327' ) then return true end

	for _, id in pairs( spec_weapons[sWeapon] ) do
		-- ePly:ChatPrint( rank ) -- debug
		if ( ePly:SteamID() == id ) then return true end
	end

	AmbLib.notifySend( ePly, 'На данную Ентити задонатили!', 1, 2, 'buttons/button10.wav' )

	return false

end

AmbRestrict.entities_blacklist = {

	'edit_fog',
	'edit_sky',
	'edit_sun',
	'sent_ball', -- remove
	'grenade_helicopter', -- remove
	'prop_thumper', -- remove
	'npc_grenade_frag',
	'amb_npc_job_employer',
	'obj_vj_grenade',
	--'amb_factory2_workbench_rifle',
	--'amb_factory2_workbench_machinegun',
	--'amb_factory2_warehouse_workpieces',
	--'amb_factory2_warehouse_metal',
	--'amb_factory2_lathe_machine',
	--'amb_factory2_miling_machine',
	--'amb_factory2_tool_box',

	'ent_jack_gmod_ezbigbomb',
	'ent_jack_gmod_ezbomb',
	'ent_jack_gmod_ezclusterbomb',
	'ent_jack_gmod_ezdetpack',
	'ent_jack_gmod_ezdynamite',
	'ent_jack_gmod_ezfougasse',
	'ent_jack_gmod_ezfragnade',
	'ent_jack_gmod_ezsticknadebundle',
	'ent_jack_gmod_ezherocket',
	'ent_jack_gmod_ezheatrocket',
	'ent_jack_gmod_ezimpactnade',
	'ent_jack_gmod_ezincendiarybomb',
	'ent_jack_gmod_ezfirenade',
	'ent_jack_gmod_ezlandmine',
	'ent_jack_gmod_ezmoab',
	'ent_jack_gmod_eznuke',
	'ent_jack_gmod_eznade_timed',
	'ent_jack_gmod_eznade_remote',
	'ent_jack_gmod_eznade_proximity',
	'ent_jack_gmod_eznade_impact',
	'ent_jack_gmod_ezatmine',
	'ent_jack_gmod_eztnt',
	'ent_jack_gmod_eztimebomb',
	'ent_jack_gmod_eznuke_big',
	'ent_jack_gmod_ezthermobaricbomb',
	'ent_jack_gmod_ezstickynade',
	'ent_jack_gmod_ezsticknade',
	'ent_jack_gmod_ezsmallbomb',
	'ent_jack_gmod_ezslam',
	'ent_jack_gmod_ezsatchelcharge',
	'ent_jack_gmod_ezpowderkeg',
	'ent_jack_gmod_eznuke_small',
	'ent_jack_gmod_eznavalmine',
	'ent_jack_gmod_ezminimore',
	'ent_jack_gmod_ezboundingmine',

	'ent_jack_gmod_ezmbhg',
	'ent_jack_gmod_ezarmor_headset',

	'ent_jack_gmod_ezantimatter',

}

function AmbStats.Players.limitEntities( ePly, sType, sEnt )

	if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, 'Вам ничего не доступно!', 1, 6, 'buttons/button10.wav' ) return false end

	if AmbStats.limits[ sType ] then

		if ( ePly:GetCount( sType ) >= ePly:GetNWInt( 'amb_players_limit_'..sType ) ) then AmbLib.notifySend( ePly, 'Вы достигли лимита '..sType..' ['..ePly:GetNWInt( 'amb_players_limit_'..sType )..']', 1, 6, 'buttons/button10.wav' ) return false end

		return true

	end

	return false

end

local function SendAdmins( sMessage )

	for _, adm in pairs( player.GetHumans() ) do

		if not adm:IsUserGroup( 'user' ) then

			adm:SendLua( sMessage )

		end

	end

end

hook.Add( 'PlayerSpawnProp', 'amb_0x228', function( ePly, sModel )

	return AmbStats.Players.limitEntities( ePly, 'props' )

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
	for _, ent in pairs( AmbRestrict.entities_blacklist ) do
		if ( sEnt == ent ) then
			if ePly:GetUserGroup() == 'sub_head_admin' or ePly:GetUserGroup() == 'superadmin' or ePly:GetUserGroup() == 'head_admin' then
				return true
			else
				AmbLib.notifySend( ePly, "Access Denied!", 1, 2, 'buttons/button10.wav' )
				return false
			end
		end
	end

	for name, v in pairs( spec_weapons ) do

		if ( name == sEnt ) then
			return ambGiveWepSpec( ePly, sEnt )
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

	if ePly.ragdoll then return false end

	for name, _ in pairs( spec_weapons ) do
		if sWeapon == name then return false end
	end

	if ( ePly:Team() == AMB_TEAM_BUILD ) then
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

hook.Add( 'PlayerGiveSWEP', 'amb_0x228', function( ePly, sWeapon, tSWEP )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin

	if ePly.ragdoll then return false end

	for name, v in pairs( spec_weapons ) do
		if ( name == sWeapon ) then
			return ambGiveWepSpec( ePly, sWeapon )
		end
	end

	if ( ePly:Team() == AMB_TEAM_BUILD ) then
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
	if ePly:Team() == AMB_TEAM_CITIZEN then AmbLib.notifySend( ePly, "Your a just player, can't spawn Weapons", 1, 4, 'buttons/button10.wav' ) return false end -- потому что лимита на weapons нет!
		return AmbEconomic.buy( ePly, sWeapon, 'weapons' )
end )

hook.Add( 'PlayerSpawnVehicle', 'amb_0x228', function( ePly, sModel, sName, tTable )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin

	for name, v in pairs( spec_weapons ) do
		if ( name == sModel ) then
			return ambGiveWepSpec( ePly, sModel )
		end
	end

	if AmbStats.Players.limitEntities( ePly, 'vehicles' ) then
		return AmbEconomic.buy( ePly, sModel, 'vehicles' )
	else
		return false
	end
end )

hook.Add( 'PlayerSpawnNPC', 'amb_0x228', function( ePly, sNpc_Type, sWep )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin

	for name, v in pairs( spec_weapons ) do
		if ( name == sNpc_Type ) then
			return ambGiveWepSpec( ePly, sNpc_Type )
		end
	end


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
	AmbLib.notifySend( ePly, 'Ранг не подходит!', 1, 2, 'buttons/button10.wav' )
	return false
end

local block_e2 = {
	['STEAM_0:0:461664741'] = true,
	['STEAM_0:0:508457595'] = true,
	['STEAM_0:1:69685915'] = false,
	['STEAM_0:0:155816401'] = true,
}

local function SendChatAll( ... )

    local tab = { ... }

    for _, v in pairs( player.GetAll() ) do

        AmbLib.chatSend( v, unpack( tab ) )

    end

end

local pidor_tools = {

	[ 'weld' ] = true,
	[ 'smartweld' ] = true,
	[ 'rope' ] = true,
	[ 'slider' ] = true,
	[ 'elastic' ] = true,
	[ 'axis' ] = true,
	[ 'winch' ] = true,
	[ 'ballsocket' ] = true,
	[ 'pulley' ] = true,
	[ 'hydraulic' ] = true,
	[ 'motor' ] = true,
	[ 'muscle' ] = true

}

hook.Add( 'CanTool', 'amb_0x228', function( ePly, tTrace, sTool )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
	if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Вы не можете юзать тулган!", 1, 4, 'buttons/button10.wav' ) return false end
	if spec_weapons[ sTool ] then

		if not ambGiveWepSpec( ePly, sTool ) then return false end

	end
	if ( sTool == 'wire_expression2' ) or ( sTool == 'advdupe2' ) then

		if block_e2[ ePly:SteamID() ] then ePly:ChatPrint('Тебе дураку ограничили E2 и Adv.Dupe2 доступ!') return false end

	end
	
	if pidor_tools[ sTool ] and ( AmbStats.Players.getStats( ePly, '!' ) <= 6 ) then

		for i = 1, math.random( 2, 3 ) do

			AmbLib.notifySend( ePly, 'НЕ НАДО ЮЗАТЬ НА ОБЫЧНУЮ ПОСТРОЙКУ!', 1, 10, '' )

		end

	end

	for name, v in pairs( AmbRestrict.Tools ) do

		if ( name == sTool ) then

			if tonumber( ePly:GetNWInt('amb_players_level') ) >= v[1] then 
			
				if AmbRestrict.calcRanks( ePly, sTool ) then

					print( '### [AmbLogs] Player '..AmbStats.Players.getStats( ePly, 'name' )..' ('..ePly:SteamID()..') use tool '..sTool..os.date( ' [%X] ###', os.time() ) )
					SendAdmins( "print( '### [AmbLogs] Player "..AmbStats.Players.getStats( ePly, 'name' ).." ("..ePly:SteamID()..") use tool "..sTool..os.date( ' [%X] ###', os.time() ).."' )")

					return true

				else

					AmbLib.notifySend( ePly, 'Вы не того ранга!', 1, 3, 'buttons/button10.wav' )

					return false

				end
				
			end

			AmbLib.notifySend( ePly, "Нужен уровень: "..v[1], 1, 3, 'buttons/button10.wav' )

			return false

		end

	end

	print( '### [AmbLogs] Player '..AmbStats.Players.getStats( ePly, 'name' )..' ('..ePly:SteamID()..') use tool '..sTool..os.date( ' [%X] ###', os.time() ) )
	SendAdmins( "print( '### [AmbLogs] Player "..AmbStats.Players.getStats( ePly, 'name' ).." ("..ePly:SteamID()..") use tool "..sTool..os.date( ' [%X] ###', os.time() ).."' )")

	return true 
	
end )

local properties_list = {

	[ 'drive' ] = false,
	[ 'ignite' ] = true,
	[ 'gravity' ] = true,
	[ 'collisions' ] = true,
	[ 'npc_scale' ] = true,
	[ 'kinect_controller' ] = false,
	[ 'editentity' ] = true,
	[ 'bone_manipulate' ] = false,
	[ 'persist' ] = false

}

hook.Add( 'CanProperty', 'amb_0x228', function( ePly, sProperty, ent )

	if ePly:IsUserGroup( 'superadmin' ) then return true end

	return properties_list[ sProperty ] or true

end)

local function SendChatAll( ... )

    local tab = { ... }

    for _, v in pairs( player.GetAll() ) do

        AmbLib.chatSend( v, unpack( tab ) )

    end

end

CreateConVar( 'amb_rp_voice', '0', FCVAR_REPLICATED )

hook.Add( 'PlayerCanHearPlayersVoice', 'AmbRestrictRPVoice', function( eListener, eTalker )

	if GetConVar( 'amb_rp_voice' ):GetBool() then

    	if ( eListener:GetPos():Distance( eTalker:GetPos() ) > 1600 ) then

			return false

		else

			return true, true

		end

	end

end )

cvars.AddChangeCallback( 'amb_rp_voice', function( convar_name, value_old, value_new )

    if tobool( value_new ) then 

		SendChatAll( AMB_COLOR_AMBITION, '[•] ', AMB_COLOR_WHITE, 'Внимание! Включён RP Войс. Теперь голоса локальные!' )

	else

		SendChatAll( AMB_COLOR_AMBITION, '[•] ', AMB_COLOR_WHITE, 'Внимание! RP Войс выключен!' )

	end

end)

