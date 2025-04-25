AmbEconomic = AmbEconomic or {}

AmbEconomic.WeaponsList = {
  --['name'] = lvl, cost
  ['weapon_ar2']		= { 20, 99 },
    ['Pulse-Rifle']		= { 20, 0 },
  ['weapon_slam']		= { 2, 4 },
    ['S.L.A.M']			= { 2, 4 }, 
  ['weapon_shotgun']	= { 1, 2 },
    ['Shotgun']			= { 1, 2 }, 
  ['weapon_smg1']		= { 1, 3 },
    ['SMG']				= { 1, 3 },
  ['weapon_frag'] 		= { 3, 4 },
	 ['Grenade'] 		= { 3, 4 },
	['weapon_357'] 		= { 1, 1 },
	 ['.357 Magnum'] 	= { 1, 1 }, 
	['weapon_rpg'] 		= { 4, 24 },
	 ['RPG Launcher'] 	= { 4, 24 }, 
	['weapon_crossbow'] = { 2, 6 },
	['Crossbow'] 		= { 2, 6 },
	['weapon_bugbait'] 	= { 2, 1 },
	['Bugbait'] 		= { 1, 1 }, 
	['weapon_medkit']	= { 3, 1 },
	['Medkit']			= { 1, 1 }, 


  ['arccw_makarov']   = { 1, 2 },
  ['arccw_fiveseven'] = { 1, 2 },
  ['arccw_g18']       = { 1, 3 },
  ['arccw_m9']        = { 1, 3 },
  ['arccw_p228']      = { 1, 3 },
  ['arccw_uspmatch']  = { 1, 3 },
  ['arccw_usp']       = { 2, 3 },
  ['arccw_ruger']     = { 2, 3 },
  ['arccw_welrod']    = { 4, 3 },
  ['arccw_ragingbull']  = { 4, 6 },
  ['arccw_deagle357']   = { 5, 6 },
  ['arccw_model627']    = { 5, 6 },
  ['arccw_deagle50']    = { 6, 8 },

  ['arccw_db']              = { 4, 3 },
  ['arccw_maresleg']        = { 4, 3 },
  ['arccw_winchester1873']  = { 4, 3 },
  ['arccw_db_sawnoff']      = { 4, 3 },
  ['arccw_shorty']          = { 4, 4 },
  ['arccw_m1014']           = { 4, 4 },
  ['arccw_pradit1911']      = { 5, 6 },

  ['arccw_fml_automag'] = { 4, 4 },
  ['arccw_fml_python'] = { 4, 6 },
  ['arccw_fml_tec9'] = { 4, 8 },
  ['arccw_fml_an94'] = { 4, 12 },


  ['arccw_famas']       = { 5, 4 },
  ['arccw_tmp']         = { 5, 4 },
  ['arccw_p90']         = { 5, 4 },
  ['arccw_mp7']         = { 5, 4 },
  ['arccw_galil762']    = { 5, 4 },
  ['arccw_ump9']        = { 5, 4 },
  ['arccw_mac11']       = { 5, 4 },
  ['arccw_g3a3']        = { 5, 4 },
  ['arccw_ump45']       = { 5, 5 },
  ['arccw_g36c']        = { 5, 5 },
  ['arccw_galil556']    = { 5, 5 },
  ['arccw_bizon']       = { 5, 6 },
  ['arccw_mp5']         = { 5, 6 },
  ['arccw_vector']      = { 6, 6 },

  ['arccw_augpara']   = { 6, 6 },
  ['arccw_tommygun']  = { 6, 6 },
  ['arccw_sg552']     = { 6, 6 },
  ['arccw_m14']       = { 6, 6 },
  ['arccw_m4a1']      = { 6, 7 },
  ['arccw_aug']       = { 6, 7 },
  ['arccw_ak47']      = { 6, 7 },
  ['arccw_sg550']     = { 6, 7 },

  ['weapon_dronerepair'] = { 6, 32 },

  ['arccw_saiga']         = { 7, 7 },
  ['arccw_contender']     = { 7, 7 },
  ['arccw_awm_obrez']     = { 7, 8 },
  ['arccw_awm']           = { 7, 9 },
  ['arccw_scout_obrez']   = { 7, 9 },
  ['arccw_scout']         = { 7, 10 },
  ['arccw_m107']          = { 8, 10 },


  ['arccw_minimi']  = { 8, 12 },
  ['arccw_rpg7']    = { 8, 12 },
  ['arccw_m60']     = { 8, 14 },
  ['arccw_minigun'] = { 12, 32 },
  
  ['arccw_mifl_k98_grenadier'] = { 12, 128 },

  ['arccw_melee_fists']     = { 4, 2 },
  ['arccw_melee_machete']   = { 6, 8 },
  ['arccw_melee_knife']     = { 6, 8 },
  ['arccw_nade_claymore']   = { 6, 12 },
  ['arccw_nade_flash']      = { 6, 12 },
  ['arccw_nade_frag']       = { 6, 12 },
  ['arccw_nade_semtex']     = { 7, 12 },
  ['arccw_nade_impact']     = { 7, 12 },
  ['arccw_nade_flare']      = { 8, 20 },
  ['arccw_nade_gas']        = { 8, 20 },
  ['arccw_nade_smoke']      = { 8, 20 },
  ['arccw_nade_incendiary'] = { 8, 20 },

}

AmbEconomic.EntitiesList = {

  ['item_battery']		= { 2, 2 },
  ['item_healthvial']		= { 1, 3 },
  ['item_suit']			= { 4, 2 },
  ['item_healthkit']		= { 3, 3 },
  ['item_suitcharger']	= { 4, 4 },
  ['item_healthcharger']	= { 5, 6 },
  ['combine_mine']		= { 6, 4 },

  ['amb_alco_beer']		= { 2, 10 },

  ['item_ammo_smg1_grenade']	= { 3, 3 },
  ['item_ammo_ar2_altfire']	= { 20, 32 },
  ['AR2 Orb']	= { 20, 32 },

  ['arccw_ammo_smg1_grenade'] = { 5, 10 },
  ['arccw_ammo_smg1_grenade_large'] = { 7, 24 },

  [ 'gmt_instrument_piano' ] = { 2, 104 },

  [ 'ent_jack_gmod_ezweapon_mrl' ] = { 6, 454 },
  [ 'ent_jack_gmod_ezweapon_rocketlauncher' ] = { 6, 450 },
  [ 'ent_jack_gmod_ezweapon_mgl' ] = { 6, 450 },
  [ 'ent_jack_gmod_ezweapon_gl' ] = { 6, 450 },
  [ 'ent_jack_gmod_ezgasnade' ] = { 6, 1200 },
  [ 'ent_jack_gmod_ezflashbang' ] = { 6, 1200 },
  [ 'ent_jack_gmod_ezcsnade' ] = { 6, 1200 },
  [ 'ent_jack_gmod_ezsmokenade' ] = { 6, 1200 },

  [ 'ent_jack_gmod_ezammo' ] = { 2, 2 },
  [ 'ent_jack_gmod_ezmunitions' ] = { 2, 4 },
  [ 'ent_jack_gmod_ezparts' ] = { 3, 25 },
  [ 'ent_jack_gmod_ezadvparts' ] = { 4, 64 },
  [ 'ent_jack_gmod_ezadvtextiles' ] = { 4, 25 },
  [ 'ent_jack_gmod_ezbattery' ] = { 4, 8 },
  [ 'ent_jack_gmod_ezchemicals' ] = { 4, 80 },
  [ 'ent_jack_gmod_ezcoolant' ] = { 4, 40 },
  [ 'ent_jack_gmod_ezfissilematerial' ] = { 6, 800 },
  [ 'ent_jack_gmod_ezfuel' ] = { 6, 700 },
  [ 'ent_jack_gmod_ezgas' ] = { 6, 600 },
  [ 'ent_jack_gmod_ezmedsupplies' ] = { 4, 80 },
  [ 'ent_jack_gmod_eznutrients' ] = { 4, 45 },
  [ 'ent_jack_gmod_ezpropellant' ] = { 4, 45 },
  [ 'ent_jack_gmod_ezworkbench' ] = { 3, 64 },
  [ 'ent_jack_gmod_ezaidradio' ] = { 8, 84500 },
  [ 'ent_jack_gmod_ezbuildkit' ] = { 3, 2000 },

  [ 'ent_jack_gmod_ezarmor_nvgs' ] = { 5, 25000 },
  [ 'ent_jack_gmod_ezarmor_thermals' ] = { 5, 64000 },

  [ 'ent_jack_gmod_ezcrate' ] = { 3, 500 },
  [ 'ent_jack_gmod_ezcrate_uni' ] = { 5, 1200 },
  [ 'ent_jack_gmod_ezmedkit' ] = { 5, 800 },
  
}

AmbEconomic.Vehicles = {

  ['Airboat']             = { 2, 24 },
  ['models/airboat.mdl']  = { 2, 24 },
  ['models/blu/conscript_apc.mdl']  = { 5, 200 },
  ['models/combine_apc.mdl']  = { 5, 200 },
  ['models/buggy.mdl']  = { 5, 200 },
  ['models/vehicles/buggy_elite.mdl']  = { 5, 200 },
  ['models/blu/tanks/t90ms.mdl']  = { 5, 200 },
  ['models/blu/tanks/tiger.mdl']  = { 5, 200 },
  ['models/ratmobile/ratmobile.mdl']  = { 5, 200 },
  ['models/hedgehog/hedgehog.mdl']  = { 5, 200 },
  ['models/chaos126p/chaos126p.mdl']  = { 5, 200 },

}