if ( AMB.config.gamemode ~= "Sandbox" ) then return end -- only Sandbox

AmbRestrict = AmbRestrict or {}

local ALL_GROUPS = { 'user', 'helper', 'vip', 'officer', 'admin', 'ahc', 'superadmin', 'head_admin' }
local ADMINS = { 'admin', 'ahc', 'superadmin', 'head_admin' }
local VIP = { 'helper', 'vip', 'officer', 'admin', 'ahc', 'superadmin', 'head_admin' }

AmbRestrict.Tools = { -- todo: change table v[2] (ranks)
	-- ['name'] = { lvl, { ranks } }
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
	['blink'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' }, -- imago
	['npc_terraria_eye_of_cthulhu'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' },
	['npc_terraria_eye'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' },
	['ent_terraria_segment_fakemdl'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' },
	['ent_terraria_segment'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' },
	['ent_terraria_projectile'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' },
	['npc_terraria_skeletron'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' },
	['npc_terraria_dungeon_guardian'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' },
	['ent_terraria_projectile_cursed_skull'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' },
	['models/dk_cars/gtav/armed_vehicles/ruiner_2000/ruina.mdl'] = { 'STEAM_0:1:511604395', 'STEAM_0:1:95303327' },

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


	['weapon_fireballoon'] = { 'STEAM_0:0:431600296', 'STEAM_0:1:95303327' }, -- timur
	['coaster_supertool'] = { 'STEAM_0:0:431600296', 'STEAM_0:1:95303327' }, 
	
	['aw2_dropship'] = { 'STEAM_0:1:433532709', 'STEAM_0:1:95303327' },  -- dmitriy
	['aw2_dropship2'] = { 'STEAM_0:1:433532709', 'STEAM_0:1:95303327' },
	['aw2_gunship'] = { 'STEAM_0:1:433532709', 'STEAM_0:1:95303327' }, 
	['aw2_hunterchopper'] = { 'STEAM_0:1:433532709', 'STEAM_0:1:95303327' }, 
	['aw2_hunterchopper2'] = { 'STEAM_0:1:433532709', 'STEAM_0:1:95303327' }, 
	['aw2_hk'] = { 'STEAM_0:1:433532709', 'STEAM_0:1:95303327' }, 
	['aw2_manhack'] = { 'STEAM_0:1:433532709', 'STEAM_0:1:95303327' },

	['weapon_hpmstick'] = { 'STEAM_0:0:463056472', 'STEAM_0:1:95303327' },
	['weapon_elderwand'] = { 'STEAM_0:0:463056472', 'STEAM_0:1:95303327' },
	['weapon_mindstick'] = { 'STEAM_0:0:463056472', 'STEAM_0:1:95303327' },
	['weapon_magmawand'] = { 'STEAM_0:0:463056472', 'STEAM_0:1:95303327' },
	['weapon_intrinsicwand'] = { 'STEAM_0:0:463056472', 'STEAM_0:1:95303327' },
	['weapon_dstick'] = { 'STEAM_0:0:463056472', 'STEAM_0:1:95303327' },
	['weapon_darkwand'] = { 'STEAM_0:0:463056472', 'STEAM_0:1:95303327' },
	['weapon_advancedwand'] = { 'STEAM_0:0:463056472', 'STEAM_0:1:95303327' },

	['weapon_mor_base_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' }, -- Жождынский
	['weapon_mor_chitin_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_daedric_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_dwemer_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_ebony_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_imperial_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_iron_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_silver_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },
	['weapon_mor_steel_shortsword'] = { 'STEAM_0:1:459363124', 'STEAM_0:1:95303327' },

}

local function ambGiveWepSpec( ePly, sWeapon )
	for _, id in pairs( spec_weapons[sWeapon] ) do
		-- ePly:ChatPrint( rank ) -- debug
		if ( ePly:SteamID() == id ) then return true end
	end
	AmbLib.notifySend( ePly, 'Access Denied!', 1, 2, 'buttons/button10.wav' )
	return false
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

function AmbStats.Players.limitEntities( ePly, type_ent, sEnt )
    if ( type_ent == 1 ) or ( type_ent == 'props' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Props!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'props' ) >= tonumber( ePly:GetNWInt('amb_players_limit_props') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_props').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 2 ) or ( type_ent == 'sents' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Entities!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'sents' ) >= tonumber( ePly:GetNWInt('amb_players_limit_sents') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_entities').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 3 ) or ( type_ent == 'effects' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Effects!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'effects' ) >= tonumber( ePly:GetNWInt('amb_players_limit_effects') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_effects').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 4 ) or ( type_ent == 'ragdolls' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Ragdolls!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'ragdolls' ) >= tonumber( ePly:GetNWInt('amb_players_limit_ragdolls') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_ragdolls').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 5 ) or ( type_ent == 'vehicles' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Cars!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'vehicles' ) >= tonumber( ePly:GetNWInt('amb_players_limit_vehicles') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_vehicles').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 6 ) or ( type_ent == 'npcs' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn NPC!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'npcs' ) >= tonumber( ePly:GetNWInt('amb_players_limit_npcs') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_npc').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 7 ) or ( type_ent == 'balloons' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Ballons!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'balloons' ) >= tonumber( ePly:GetNWInt('amb_players_limit_balloons') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_balloons').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 8 ) or ( type_ent == 'buttons' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Buttons!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'buttons' ) >= tonumber( ePly:GetNWInt('amb_players_limit_buttons') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_buttons').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 9 ) or ( type_ent == 'emitters' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Emitters!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'emitters' ) >= tonumber( ePly:GetNWInt('amb_players_limit_emitters') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_emitters').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 10 ) or ( type_ent == 'dynamite' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Dynamites!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'dynamite' ) >= tonumber( ePly:GetNWInt('amb_players_limit_dynamite') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_dynamite').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 11 ) or ( type_ent == 'lights' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Lights!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'lights' ) >= tonumber( ePly:GetNWInt('amb_players_limit_lights') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_lights').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 12 ) or ( type_ent == 'lamps' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Lamps!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'lamps' ) >= tonumber( ePly:GetNWInt('amb_players_limit_lamps') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_lamps').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 13 ) or ( type_ent == 'wheels' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Wheels!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'wheels' ) >= tonumber( ePly:GetNWInt('amb_players_limit_wheels') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_wheels').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 14 ) or ( type_ent == 'thrusters' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Thrusters!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'thrusters' ) >= tonumber( ePly:GetNWInt('amb_players_limit_thrusters') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_thrusters').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 15 ) or ( type_ent == 'hoverballs' ) then
        if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Hoverballs!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'hoverballs' ) >= tonumber( ePly:GetNWInt('amb_players_limit_hoverballs') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_hoverballs').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    end
end

local props_tolik = {
	[ 'models/props/building_apartment_1.mdl' ] = true,
	[ 'models/props/building_apartment_3.mdl' ] = true,
	[ 'models/props/bus_prop.mdl' ] = true,
	[ 'models/props/d1_largebuilding_1.mdl' ] = true,
	[ 'models/props/d_attic_1.mdl' ] = true,
	[ 'models/props/d_bridge_1_small.mdl' ] = true,
	[ 'models/props/d_bridge_part_1.mdl' ] = true,
	[ 'models/props/d_bridge_part_2.mdl' ] = true,
	[ 'models/props/d_bridge_part_3.mdl' ] = true,
	[ 'models/props/d_bridge_part_4.mdl' ] = true,
	[ 'models/props/d_building_apartment_4.mdl' ] = true,
	[ 'models/props/d_building_apartment_6.mdl' ] = true,
	[ 'models/props/d_building_apartment_7.mdl' ] = true,
	[ 'models/props/d_building_apartment_8.mdl' ] = true,
	[ 'models/props/d_building_bar_1.mdl' ] = true,
	[ 'models/props/d_building_house_1.mdl' ] = true,
	[ 'models/props/d_building_house_2.mdl' ] = true,
	[ 'models/props/d_building_shop_1.mdl' ] = true,
	[ 'models/props/d_car_1.mdl' ] = true,
	[ 'models/props/d_construct_apartment.mdl' ] = true,
	[ 'models/props/d_construct_apartment_2.mdl' ] = true,
	[ 'models/props/d_construct_garage.mdl' ] = true,
	[ 'models/props/d_factory_1.mdl' ] = true,
	[ 'models/props/d_factory_2.mdl' ] = true,
	[ 'models/props/d_factory_3.mdl' ] = true,
	[ 'models/props/d_factory_4.mdl' ] = true,
	[ 'models/props/d_factory_5.mdl' ] = true,
	[ 'models/props/d_factory_6.mdl' ] = true,
	[ 'models/props/d_factory_7.mdl' ] = true,
	[ 'models/props/d_factory_8.mdl' ] = true,
	[ 'models/props/d_flatgrass_platform.mdl' ] = true,
	[ 'models/props/d_garage_1.mdl' ] = true,
	[ 'models/props/d_garage_2.mdl' ] = true,
	[ 'models/props/d_house_1.mdl' ] = true,
	[ 'models/props/d_largebuilding_2.mdl' ] = true,
	[ 'models/props/d_largebuilding_3.mdl' ] = true,
	[ 'models/props/d_largebuilding_4.mdl' ] = true,
	[ 'models/props/d_largebuilding_5.mdl' ] = true,
	[ 'models/props/d_largebuilding_8.mdl' ] = true,
	[ 'models/props/d_largetower_1.mdl' ] = true,
	[ 'models/props/d_office_building_1.mdl' ] = true,
	[ 'models/props/d_poster_1.mdl' ] = true,
	[ 'models/props/d_poster_2.mdl' ] = true,
	[ 'models/props/d_poster_3.mdl' ] = true,
	[ 'models/props/d_poster_4.mdl' ] = true,
	[ 'models/props/d_poster_5.mdl' ] = true,
	[ 'models/props/d_poster_6.mdl' ] = true,
	[ 'models/props/d_poster_7.mdl' ] = true,
	[ 'models/props/d_roadshort_1.mdl' ] = true,
	[ 'models/props/d_roadshort_2.mdl' ] = true,
	[ 'models/props/d_roadshort_3.mdl' ] = true,
	[ 'models/props/d_scaffolding_1.mdl' ] = true,
	[ 'models/props/d_scaffolding_2.mdl' ] = true,
	[ 'models/props/d_scaffolding_3.mdl' ] = true,
	[ 'models/props/d_shack_1.mdl' ] = true,
	[ 'models/props/d_shack_1_single.mdl' ] = true,
	[ 'models/props/d_shack_1_single_window.mdl' ] = true,
	[ 'models/props/d_shack_1_table.mdl' ] = true,
	[ 'models/props/d_smallhouse_1.mdl' ] = true,
	[ 'models/props/d_spike_1.mdl' ] = true,
	[ 'models/props/d_train_tunnel_1.mdl' ] = true,
	[ 'models/props/d_train_wagon_1.mdl' ] = true,
	[ 'models/props/d_train_wagon_2.mdl' ] = true,
	[ 'models/props/d_treeline_1.mdl' ] = true,
	[ 'models/props/d_trainbridge_part_1.mdl' ] = true,
	[ 'models/props/d_tunnel_1.mdl' ] = true,
	[ 'models/props/d_tunnel_1_large.mdl' ] = true,
	[ 'models/props/d_woodstand_1.mdl' ] = true,
	[ 'models/props/d_construct_garage_2.mdl' ] = true,
	[ 'models/props/dev_block_test.mdl' ] = true
}

hook.Add( 'PlayerSpawnProp', 'amb_0x228', function( ePly, sModel )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin

	if props_tolik[ sModel ] and ( ePly:SteamID() ~= 'STEAM_0:1:445577586' ) then AmbLib.notifySend( ePly, 'Это доступно только Толику!', 1, 6 ) return false end

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
	AmbLib.notifySend( ePly, 'Access Denied!', 1, 2, 'buttons/button10.wav' )
	return false
end

local block_e2 = {
	['STEAM_0:0:461664741'] = true,
}


hook.Add( 'CanTool', 'amb_0x228', function( ePly, tTrace, sTool )
	--if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
	if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "You a citizen, can't user ToolGun!", 1, 4, 'buttons/button10.wav' ) return false end

	for name, v in pairs( spec_weapons ) do
		if ( name == sTool ) then
			return ambGiveWepSpec( ePly, sTool )
		end
	end

	if sTool == 'wire_expression2' and block_e2[ePly:SteamID()] then
		ePly:ChatPrint('Тебе дураку ограничили E2 доступ!')
		return false
	end

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