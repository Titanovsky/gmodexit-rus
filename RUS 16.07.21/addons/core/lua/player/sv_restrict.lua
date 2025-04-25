AmbRestrict = AmbRestrict or {}

local ALL_GROUPS = { 'user', 'helper', 'vip', 'officer', 'admin', 'ahc', 'superadmin', 'head_admin' }
local ADMINS = { 'admin', 'ahc', 'superadmin', 'head_admin' }
local VIP = { 'helper', 'vip', 'officer', 'admin', 'ahc', 'superadmin', 'head_admin' }
local ASDSD = { 'asdasdsd' }

AmbRestrict.Tools = {

	['duplicator'] 	= { 1, ADMINS },
	[ 'vjstool_npcspawner' ] = { 1, ADMINS },

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
	['light']  		= { 2, ALL_GROUPS },
	['nocollide']  	= { 4, ALL_GROUPS },
	['textscreen']  = { 2, ALL_GROUPS },

	['thruster']  	= { 5, ALL_GROUPS },
	['wheel']  		= { 5, ALL_GROUPS },
	['keypad_willox']  	= { 5, ALL_GROUPS },
	['nocollide']  	= { 5, ALL_GROUPS },

	['eyeposer']  	= { 5, VIP },
	['faceposer']  	= { 5, VIP },
	['finger']  	= { 5, VIP },
	['inflator']  	= { 5, VIP },

	[ 'trackassembly' ] = { 6, ALL_GROUPS },
	['multi_parent'] = { 6, ALL_GROUPS },
	['multi_unparent'] = { 6, ALL_GROUPS },
	
}

AmbRestrict.entities_blacklist = {

	'sent_ball', -- remove
	'grenade_helicopter', -- remove
	'prop_thumper', -- remove
	'npc_grenade_frag',
	'obj_vj_grenade',

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
	'ent_jack_gmod_ezatmine',
	'ent_jack_gmod_eztnt',
	'ent_jack_gmod_eztimebomb',
	'ent_jack_gmod_eznuke_big',
	'ent_jack_gmod_ezthermobaricbomb',
	'ent_jack_gmod_ezstickynade',
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

	'obj_zbs_revenant_burn',
	'obj_zbs_fireball',
	'obj_zbs_iceball',
	'obj_zbs_icenant_burn',
	'obj_zbs_oberonbomb',
	'obj_zbs_dione_poison',

}

AmbRestrict.for_donaters = {
	[ 'weapon_ninjaskunai' ] = { [ 'STEAM_0:1:563284492' ] = true }, -- ДЭСЭПТИК
	[ 'gaymg' ] = { [ 'STEAM_0:1:563284492' ] = true },
	[ 'finger' ] = { [ 'STEAM_0:1:563284492' ] = true },
	[ 'weapon_unoreverse' ] = { [ 'STEAM_0:1:563284492' ] = true },

	[ 'npctool_controller' ] = { [ 'STEAM_0:1:445577586' ] = true }, -- Tolik
	[ 'npctool_follower' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'npctool_health' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'npctool_newroute' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'npctool_newspawner' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'npctool_notarget' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'npctool_proficiency' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'npctool_relationships' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'npctool_spawner' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'npctool_viewcam' ] = { [ 'STEAM_0:1:445577586' ] = true },
	[ 'obj_npcroute' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'obj_viewcam' ] = { [ 'STEAM_0:1:445577586' ] = true },
	[ 'obj_patrolpoint' ] = { [ 'STEAM_0:1:445577586' ] = true },
	[ 'obj_npcspawner' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'sent_skybox_editor' ] = { [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:1:428237499' ] = true },
	[ 'sent_skycamera_editor' ] = { [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:1:428237499' ] = true },
	[ 'weapon_vfirethrower' ] = { [ 'STEAM_0:1:445577586' ] = true }, 
	[ 'mr' ] = { [ 'STEAM_0:1:445577586' ] = true }, 

	[ 'weapon_fireballoon' ] = { [ 'STEAM_0:0:431600296' ] = true }, -- Timur

	[ 'npc_shaklin_scp096' ] = { [ 'STEAM_0:1:187917947' ] = true }, -- Ramirez
	[ 'scp173' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_scp173' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'scp173_knife' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_csozbs_boss_alienboss' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_csozbs_boss_dione' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_csozbs_boss_icenant' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_csozbs_boss_juggernaught' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_csozbs_boss_oberon' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_csozbs_boss_phobos' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_csozbs_boss_revenant' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'mexican_chaingun' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_fo3ene_libertyprime' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_fo3bhs_libertyprime' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'obj_fo3_libertymininuke' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'railgun_l5' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_arctic' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_gasmask' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_guerilla' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_hostage1' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_hostage2' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_hostage3' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_hostage4' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_leet' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_phoenix' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_riot' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_swat' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_css_urban' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'weapon_firem' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'replicator_queen' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'replicator_queen_hive' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'replicator_segment' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'replicator_worker' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'npc_vj_elite_synth' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'weapon_beam' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'ent_rtcw_dynamite' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'ent_rtcw_grenade' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'ent_rtcw_grenades' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'rtcw_rocket' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'rtcw_grenade' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'rtcw_grenades' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'rtcw_panzerfaust' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'rtcw_dynamite' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'rtcw_fg42' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'rtcw_snooper' ] = { [ 'STEAM_0:1:187917947' ] = true },
	[ 'rtcw_venom' ] = { [ 'STEAM_0:1:187917947' ] = true },
	
	[ 'weapon_mad_2b' ] = { [ 'STEAM_0:0:435148107' ] = true }, -- Sandro
	[ 'ent_pod' ] = { [ 'STEAM_0:0:435148107' ] = true },
	[ 'ent_pod_shot' ] = { [ 'STEAM_0:0:435148107' ] = true },
	[ 'weapon_ak47_beast' ] = { [ 'STEAM_0:0:435148107' ] = true },
	[ 'weapon_m4a1_beast' ] = { [ 'STEAM_0:0:435148107' ] = true },
	[ 'weapon_deagle_bornbeast' ] = { [ 'STEAM_0:0:435148107' ] = true },

	-- Danillochka
	[ 'seal6-c4' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_bfg' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_chaingun' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_chainsaw' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_fists' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_flashlight' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_grenade' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_machinegun' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_pistol' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_plasmagun' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_rocketlauncher' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_shotgun' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'weapon_doom3_doublebarrel' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },
	[ 'sent_grapplehook_bpack' ] = { [ 'STEAM_0:0:460772674' ] = true, [ 'STEAM_0:0:164590602' ] = true, [ 'STEAM_0:0:426598565' ] = true, [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:0:503923263' ] = true },

	-- Жожда
	[ 'weapon_hl_9mmar' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_9mmhandgun' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_357' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_crossbow' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_crowbar' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_egon' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_gauss' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_handgrenade' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_hornetgun' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_rpg' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_satchel' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'weapon_hl_shotgun' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_argrenade_ammo' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_argrenade' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_gauss_ammo' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_handgrenade' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_hornet' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_hornet_alt' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_rpg_ammo' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_rpgrocket' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_357_ammo' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_satchel' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_9mmhandgun_ammo' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },
	[ 'ent_hl_shotgun_ammo' ] = { [ 'STEAM_0:1:459363124' ] = true, [ 'STEAM_0:1:445577586' ] = true, [ 'STEAM_0:0:460772674' ] = true },


}

local weapons_builder = {

	[ 'weapon_physcannon' ] = true,
	[ 'weapon_physgun' ] = true,
	[ 'weapon_physgun' ] = true,
	[ 'gmod_camera' ] = true,
	[ 'gmod_tool' ] = true,
	[ 'laserpointer' ] = true,
	[ 'weapon_simrepair' ] = true,
	[ 'weapon_remotedrone' ] = true,
	[ 'remotecontroller' ] = true,
	[ 'weapon_simrepair' ] = true,
	[ 'weapon_simremote' ] = true,
	[ 'wep_jack_gmod_hands' ] = true,
	[ 'weapon_empty_hands' ] = true

}

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

AmbRestrict.block_e2 = {

	[ 'STEAM_0:0:461664741' ] = true,
	[ 'STEAM_0:0:508457595' ] = true,
	[ 'STEAM_0:1:69685915' ] = false,
	[ 'STEAM_0:0:155816401' ] = true,
	[ 'STEAM_0:0:431600296' ] = false,

}

local block_properties_list = {

	[ 'drive' ] = true,
	[ 'collisions' ] = true,
	[ 'npc_scale' ] = true,
	[ 'editentity' ] = true,
	[ 'bone_manipulate' ] = true,
	[ 'persist' ] = true

}

function AmbRestrict.GetDonatObject( ePly, sObj )

	if ( ePly:SteamID() == 'STEAM_0:1:95303327' ) then return true end
	if not AmbRestrict.for_donaters[ sObj ] then return true end
	if AmbRestrict.for_donaters[ sObj ][ ePly:SteamID() ] then return true end

	AmbLib.notifySend( ePly, 'Доступно Донатеру! [Нажми F4]', 1, 8, 'buttons/button10.wav' )

	return false

end

function AmbRestrict.calcRanks( ePly, sTool )

	for name, v in pairs( AmbRestrict.Tools ) do

		if ( name == sTool ) then

			for _, rank in pairs( AmbRestrict.Tools[sTool][2] ) do

				if ( ePly:GetUserGroup() == rank ) then return true end

			end

		end

	end

	AmbLib.notifySend( ePly, 'Ранг не подходит!', 1, 2, 'buttons/button10.wav' )

	return false

end

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

local function SendChatAll( ... )

    local tab = { ... }

    for _, v in pairs( player.GetAll() ) do

        AmbLib.chatSend( v, unpack( tab ) )

    end

end

hook.Add( 'PlayerSpawnProp', 'AmbRestrictSpawnProps', function( ePly, sModel )

	return AmbStats.Players.limitEntities( ePly, 'props' )

end )

hook.Add( 'PlayerSpawnRagdoll', 'AmbRestrictRagdolls', function( ePly, sModel )

	return AmbStats.Players.limitEntities( ePly, 'ragdolls' )

end )

hook.Add( 'PlayerSpawnEffect', 'AmbRestrictEffects', function( ePly, sModel )

	return AmbStats.Players.limitEntities( ePly, 'effects' )

end )

hook.Add( 'PlayerSpawnSENT', 'AmbRestrictSpawnSENT', function( ePly, sEnt )

	if not AmbRestrict.GetDonatObject( ePly, sEnt ) then return false end

	for _, ent in pairs( AmbRestrict.entities_blacklist ) do
		if ( sEnt == ent ) then
			if ePly:GetUserGroup() == 'sub_head_admin' or ePly:GetUserGroup() == 'superadmin' or ePly:GetUserGroup() == 'head_admin' then
				return true
			else
				AmbLib.notifySend( ePly, 'Нельзя заспавнить эту Ентитю', 1, 6, 'buttons/button10.wav' )
				return false
			end
		end
	end

	if AmbStats.Players.limitEntities( ePly, 'sents' ) then return AmbEconomic.buy( ePly, sEnt, 'ents' ) end

	return false

end )

hook.Add( 'PlayerSpawnSWEP', 'AmbRestrictSpawnSWEP', function( ePly, sWeapon, tSWEP )

	if not AmbRestrict.GetDonatObject( ePly, sWeapon ) then return false end

	if ePly.ragdoll then return false end

	if AmbStats.Players.limitEntities( ePly, 'sents' ) then return AmbEconomic.buy( ePly, sWeapon, 'weapons' ) end
	
	return false

end )

hook.Add( 'PlayerGiveSWEP', 'AmbRestrictGiveSWEP', function( ePly, sWeapon, tSWEP )

	if ePly.ragdoll then return false end

	if ePly:HasWeapon( sWeapon ) then return true end

	if not AmbRestrict.GetDonatObject( ePly, sWeapon ) then return false end

	if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, 'Войдите в /pvp', 1, 6, 'buttons/button10.wav' ) return false end

	return AmbEconomic.buy( ePly, sWeapon, 'weapons' )

end )

hook.Add( 'PlayerSpawnVehicle', 'AmbRestrictVehicles', function( ePly, sModel, sName, tTable )

	if not AmbRestrict.GetDonatObject( ePly, sModel ) then return false end

	if AmbStats.Players.limitEntities( ePly, 'vehicles' ) then return AmbEconomic.buy( ePly, sModel, 'vehicles' ) end

	return false
		
end )

hook.Add( 'PlayerSpawnNPC', 'AmbRestrictNPCs', function( ePly, sNpc_Type, sWep )

	if not ePly:IsUserGroup( 'superadmin' ) then

		local count = 0

		for k, v in pairs( ents.GetAll() ) do

			if v:IsNPC() then count = count + 1 end

		end

		if ( count >= 45 ) then AmbLib.notifySend( ePly, 'Лимит НПСей: 45 штук по всей карте', 1, 8, 'buttons/button10.wav' ) return false end

	end

	if not AmbRestrict.GetDonatObject( ePly, sNpc_Type ) then return false end

	if ePly:IsUserGroup( 'user' ) or ePly:IsUserGroup( 'vip' ) and not AmbRestrict.for_donaters[ sNpc_Type ] then AmbLib.notifySend( ePly, 'Юзерам и VIP недоступно! [F4]', 1, 6, 'buttons/button10.wav' ) return false end

	return AmbStats.Players.limitEntities( ePly, 'npcs' )

end )

AmbDB.createDataBase( 'amb_e2limit', [[
    'SteamID' TEXT,
    'Count' NUMERIC,
    'Date' NUMERIC]]
)

local function GetE2Limit( ePly )

	local count = sql.QueryValue( 'SELECT Count FROM amb_e2limit WHERE SteamID = "'..ePly:SteamID()..'"' ) 
	if not count then return 0 end

	return tonumber( count )

end

local function GetE2LimitDate( ePly )

	local date = sql.QueryValue( 'SELECT Date FROM amb_e2limit WHERE SteamID = "'..ePly:SteamID()..'"' ) 
	if not date then return os.time() end

	return tonumber( date )

end

local function AddE2Limit( ePly )

	local count = sql.QueryValue( 'SELECT Count FROM amb_e2limit WHERE SteamID = "'..ePly:SteamID()..'"' )

	if count then

		local count, date = tonumber( count ) + 1, os.time() + 60 * 60 * 6
		sql.Query( 'UPDATE amb_e2limit SET Count = '..count..' WHERE SteamID = "'..ePly:SteamID()..'"' )
		sql.Query( 'UPDATE amb_e2limit SET Date = '..date..' WHERE SteamID = "'..ePly:SteamID()..'"' )

	else

		sql.QueryValue( 'INSERT INTO amb_e2limit( SteamID, Count, Date ) VALUES( "'..ePly:SteamID()..'", 0, '..os.time()..' )')

	end

end

hook.Add( 'PlayerInitialSpawn', 'E2LimitSetup', function( ePly )

	timer.Simple( 1, function()

		if not IsValid( ePly ) then return end
	
		local date = sql.QueryValue( 'SELECT Date FROM amb_e2limit WHERE SteamID = "'..ePly:SteamID()..'"' ) 
		if not date then return end

		if ( os.time() >= tonumber( date ) ) then sql.Query( 'DELETE FROM amb_e2limit WHERE SteamID = "'..ePly:SteamID()..'"' ) end

	end )

end )

hook.Add( 'CanTool', 'AmbRestrictCanTool', function( ePly, tTrace, sTool )

	if ( ePly:Team() == AMB_TEAM_CITIZEN ) then AmbLib.notifySend( ePly, "Вы не можете юзать тулган!", 1, 4, 'buttons/button10.wav' ) return false end

	if not AmbRestrict.GetDonatObject( ePly, sTool ) then return false end
	
	if pidor_tools[ sTool ] then AmbLib.notifySend( ePly, 'НЕ НАДО ЮЗАТЬ НА НЕПОДВИЖНУЮ ПОСТРОЙКУ!', 1, 6, '' ) end

	if AmbRestrict.Tools[ sTool ] then

		if ( AmbStats.Players.getStats( ePly, '!' ) >= AmbRestrict.Tools[ sTool ][1] ) then

			if not AmbRestrict.calcRanks( ePly, sTool ) then

				AmbLib.notifySend( ePly, 'Вы не того ранга!', 1, 3, 'buttons/button10.wav' )

				return false

			end

		else

			AmbLib.notifySend( ePly, "Нужен уровень: "..AmbRestrict.Tools[ sTool ][1], 1, 3, 'buttons/button10.wav' )

			return false

		end

	end

	print( '### [AmbLogs] Player '..AmbStats.Players.getStats( ePly, 'name' )..' ('..ePly:SteamID()..') use tool '..sTool..os.date( ' [%X] ###', os.time() ) )
	SendAdmins( "print( '### [AmbLogs] Player "..AmbStats.Players.getStats( ePly, 'name' ).." ("..ePly:SteamID()..") use tool "..sTool..os.date( ' [%X] ###', os.time() ).."' )")

	return true 
	
end )

hook.Add( 'CanProperty', 'AmbRestrictProperty', function( ePly, sProperty, eEnt )

	if ePly:IsUserGroup( 'superadmin' ) then return true end
	if ( eEnt:CPPIGetOwner() ~= ePly ) then return false end

	if block_properties_list[ sProperty ] then return false end

end)

hook.Add( 'OnPhysgunReload', 'AmbRestrictNotUnfreezeAll', function( sWep, ePly )

	if ePly:IsUserGroup( 'user' ) or ePly:IsUserGroup( 'vip' ) then ePly:ChatPrint('[F4] нажми') return false end

	return 

end )

CreateConVar( 'amb_rp_voice', '0', FCVAR_REPLICATED )

hook.Add( 'PlayerCanHearPlayersVoice', 'AmbRestrictRPVoice', function( eListener, eTalker )

	--[[
	if GetConVar( 'amb_rp_voice' ):GetBool() then

    	if ( eListener:GetPos():Distance( eTalker:GetPos() ) > 1600 ) then

			return false

		else

			return true, true

		end

	end
	]]

end )

cvars.AddChangeCallback( 'amb_rp_voice', function( convar_name, value_old, value_new )

    if tobool( value_new ) then 

		SendChatAll( AMB_COLOR_AMBITION, '[•] ', AMB_COLOR_WHITE, 'Внимание! Включён RP Войс. Теперь голоса локальные!' )

	else

		SendChatAll( AMB_COLOR_AMBITION, '[•] ', AMB_COLOR_WHITE, 'Внимание! RP Войс выключен!' )

	end

end)