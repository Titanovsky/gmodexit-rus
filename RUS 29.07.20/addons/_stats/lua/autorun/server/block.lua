-- Config

local blockGM = {}

local ply_struct = FindMetaTable( "Player" )

blockGM.user = "user"
blockGM.vip = "vip"
blockGM.superadmin = "superadmin"
blockGM.avk = "avk"

blockGM.propsList = {
  "models/props_phx/cannon.mdl",
"models/props_phx/construct/concrete_pipe01.mdl",
"models/props_phx/huge/road_long.mdl",
"models/props_phx/huge/road_medium.mdl",
"models/props_phx/misc/paddle_small.mdl",
"models/props_phx/misc/paddle_small2.mdl",
"models/props_rooftop/rooftopcluser06a.mdl",
"models/props_rooftop/rooftopcluser06a.mdl",
"models/props_combine/combine_citadel001b.mdl",
"models/props_combine/combine_citadel001b_open.mdl",
"models/props_combine/combine_teleport_2.mdl",
"models/props_combine/combineinnerwall001a.mdl",
"models/props_combine/combineinnerwallcluster1024_001a.mdl",
"models/props_combine/combineinnerwallcluster1024_002a.mdl",
"models/props_combine/combineinnerwallcluster1024_003a.mdl",
"models/props_combine/combinethumper001a.mdl",
"models/props_combine/introomarea.mdl",
"models/props_combine/portalskydome.mdl",
"models/props_combine/portalspire.mdl",
"models/props_combine/stasisfield.mdl",
"models/props_combine/stasisshield.mdl",
"models/props_combine/stasisvortex.mdl",
"models/props_combine/strut_array_01.mdl",
"models/props_combine/tpcontroller.mdl",
"models/props_combine/pipes01_cluster02a.mdl",
"models/props_combine/pipes01_cluster02b.mdl",
"models/props_combine/pipes01_cluster02c.mdl",
"models/props_combine/pipes01_single01a.mdl",
"models/props_combine/pipes01_single01b.mdl",
"models/props_combine/pipes01_single01c.mdl",
"models/props_combine/pipes01_single02a.mdl",
"models/props_combine/pipes01_single02b.mdl",
"models/props_combine/pipes01_single02c.mdl",
"models/props_combine/pipes02_single01a.mdl",
"models/props_combine/pipes02_single01b.mdl",
"models/props_combine/pipes02_single01c.mdl",
"models/props_combine/pipes03_single01a.mdl",
"models/props_combine/pipes03_single01b.mdl",
"models/props_combine/pipes03_single01c.mdl",
"models/props_combine/pipes03_single02a.mdl",
"models/props_combine/pipes03_single02b.mdl",
"models/props_combine/pipes03_single02c.mdl",
"models/props_combine/pipes03_single03a.mdl",
"models/props_combine/pipes03_single03b.mdl",
"models/props_combine/pipes03_single03c.mdl",
"models/effects/portalfunnel.mdl",
"models/effects/portalrift.mdl",
"models/props_combine/portalball.mdl",
"models/Cranes/crane_frame.mdl",
"models/props_c17/oildrum001_explosive.mdl",
}


blockGM.costGun = 150
blockGM.costGunSpawn = 3213
blockGM.gunsList = {
  { "weapon_molotov_c", 15000 },
  { "weapon_rpg", 15000 },
  { "weapon_slam", 5500 },
  { "weapon_357", 2000 },
  { "weapon_pistol", 600 },
  { "weapon_crossbow", 1200 },
  { "weapon_ar2", 2500 },
  { "weapon_shotgun", 1500 },
  { "weapon_smg1", 1500 },
  { "weapon_frag", 900 },
  { "breadfish_weap", 59999 },
  { "cw_p99", 350 },
  { "cw_makarov", 350 },
  { "cw_m1911", 600 },
  { "cw_fiveseven", 600 },
  { "cw_deagle", 1200 },
  { "cw_mr96", 1200 },
  { "cw_shorty", 1200 },
  { "cw_m3super90", 2000 },
  { "cw_extrema_ratio_official", 4999 },
  { "cw_g36c", 3000 },
  { "cw_ump45", 3000 },
  { "cw_mac11", 3000 },
  { "cw_mp5", 4500 },
  { "cw_scarh", 5500 },
  { "cw_l85a2", 5500 },
  { "cw_m14", 6500 },
  { "cw_g3a3", 6500 },
  { "cw_ak74", 7500 },
  { "cw_ar15", 7500 },
  { "cw_vss", 12000 },
  { "cw_l115", 16000 },
  { "cw_m249_official", 22000 },
  { "cw_smoke_grenade", 12000 },
  { "cw_flash_grenade", 7000 },
  { "cw_frag_grenade", 6000 },
	{ "climb_swep2", 20000 },
	{ "weapon_camo", 150000 },


  { "weapon_ss2_cannon", 199999 },
  { "weapon_ss2_zapgun", 2000 },
  { "weapon_ss2_colt", 3000 },
  { "weapon_ss2_autoshotgun", 6000 },
  { "weapon_ss2_doubleshotgun", 12000 },
  { "weapon_ss2_uzi", 15000 },
  { "weapon_ss2_rocketlauncher", 60000 },
  { "weapon_ss2_sniper", 60000 },
  { "weapon_ss2_seriousbomb", 2 },
  { "weapon_ss2_klodovik", 59999 },
  { "weapon_ss2_plasmarifle", 59999 },
  { "weapon_ss2_grenadelauncher", 59999 },
  { "weapon_ss2_minigun", 80000 },

  { "fas2_m79", 228000 },

  { "amb_pickaxe", 900 },
  { "amb_advpickaxe", 8000 },

  { "weapon_cuff_standard", 90000 },
  { "weapon_cuff_rope", 128000 },
  { "weapon_cuff_elastic", 640000 },
  { "weapon_cuff_police", 164000 },
  { "weapon_cuff_plastic", 64000 },
  { "weapon_cuff_shackles", 199000 },
  { "weapon_cuff_tactical", 128000 },

  { "arccw_nade_claymore", 12000 },
  { "arccw_nade_flash", 12000 },
  { "arccw_nade_frag", 12000 },
  { "arccw_nade_impact", 12000 },
  { "arccw_nade_semtex", 12000 },
  { "arccw_nade_smoke", 24000 },
  { "arccw_db", 6000 },
  { "arccw_awm_obrez", 15000 },
  { "arccw_deagle50", 4000 },
  { "arccw_m107", 32000 },
  { "arccw_db_sawnoff", 6000 },
  { "arccw_m60", 42000 },
  { "arccw_minimi", 42000 },
  { "arccw_rpg7", 800999 },

  { "zwf_shoptablet", 8000 },
  { "zwf_wateringcan", 2400 },
}


blockGM.toolList = {
  { "precision", 4 },
  { "precision_align", 8 },
  { "axis", 3 },
  { "ballsocket", 3 },
  { "colour", 3 },
  { "creator", 3 },
  { "elastic", 3 },
  { "material", 3 },
  { "physprop", 3 },
  { "textscreen", 3 },
  { "wheel", 3 },
  { "winch", 4 },
  { "slider", 4 },
  { "weld", 4 },
  { "thruster", 4 },
  { "paint", 4 },
  { "rope", 4 },
  { "light", 4 },
  { "lamp", 4 },
  { "nocollide", 6 },
  { "motor", 6 },
  { "hydraulic", 6 },
  { "hoverball", 6 },
  { "emitter", 6 },
  { "trails", 4 },
  { "wire_turret", 10 },
  { "wire_egp", 10 },
  { "wire_detonator", 10 },
  { "wire_forcer", 4 },
  { "wire_gates", 4 },
  { "wire_holoemitter",8 },
  { "wire_hoverball", 4 },
  { "wire_igniter", 4 },
  { "wire_motor", 5 },
  { "wire_explosive", 10 },
  { "wire_soundemitter", 5 },
  { "wire_pod", 8 },
  { "wire_spawner", 8 },
  { "wire_teleporter", 6 },
  { "wire_trail", 8 },
  { "wire_wheel", 4 },
  { "masscenter", 5 },
  { "multi_parent", 5 },
  { "multi_unparent", 5 },
  { "smartweld", 3 },
  { "stacker_improved", 3 },
  { "elevator", 6 },
}
blockGM.toolSpec = {
  "dynamite",
  "mapret",
  "hoverboard"
}


blockGM.propertyList = {
  "bone_manipulate",
  "drive",
  "gravity",
  "ignite",
  "kinect_controller",
  "npc_scale"
}

blockGM.propsMax = 250
blockGM.ragdollsMax = 16
blockGM.sentsMax = 228
blockGM.vehicleMax = 2

blockGM.sentsList = {
	"sent_ball",
	"item_ammo_ar2_altfire",
  	"eml_redp",
 	"eml_meth",
  	"eml_ciodine",
 	"eml_buyer_text",
  	"amb_mine_rock",
  	"ent_jack_aidcomm",
    "amb_button_random",
    "amb_button_event",
}
blockGM.buysentList = {
  { "ent_jack_turretammobox_22", 2500 },
  { "ent_jack_turretammobox_338", 2500 },
  { "ent_jack_turretammobox_shot", 2500 },
  { "ent_jack_turretammobox_556", 2500 },
  { "ent_jack_turretammobox_762", 2500 },
  { "ent_jack_turretammobox_9mm", 2500 },
  { "ent_jack_generator", 6000 },
  { "ent_jack_sleepinbag", 6000 },
  { "ent_timebomb", 2000 },
  { "ent_jack_aidcomm", 5000 },
  { "ent_jack_ifftag", 500 },
  { "ent_jack_ballistic_shield", 2000 },
  { "ent_jack_claymore", 1000 },
  { "ent_jack_landmine_lrg", 8000 },
  { "ent_jack_landmine_med", 6000 },
  { "ent_jack_landmine_sml", 4000 },
  { "ent_jack_slam", 6000 },
  { "ent_jack_warmine", 50000 },
  { "ent_jack_seamine", 6000 },
  { "ent_jack_armorpanel_large", 5000 },
  { "ent_jack_armorpanel_medium", 3000 },
  { "ent_jack_armorpanel_small", 1500 },
  { "ent_jack_turretbattery", 1000 },
  { "ent_jack_terminal", 5000 },
  { "ent_jack_powernode", 1500 },
  { "ent_jack_turretrepairkit", 2200 },
  { "ent_jack_radiorepairkit", 800 },
  { "ent_jack_turret_grenade", 32000 },
  { "ent_jack_turret_mg", 15000 },
  { "ent_jack_turret_dmr", 15000 },
  { "ent_jack_turret_missile", 15000 },
  { "ent_jack_turret_pistol", 15000 },
  { "ent_jack_turret_plinker", 15000 },
  { "ent_jack_turret_rifle", 15000 },
  { "ent_jack_turret_shotty", 15000 },
  { "ent_jack_turret_sniper", 15000 },
  { "ent_jack_turret_smg", 15000 },
  { "ent_jack_turret_rocket", 48000 },
  { "ent_jack_turret_missile", 48000 },
  { "ent_jack_turretmissilepod", 15000 },
  { "ent_jack_turretrocketpod", 15000 },
  { "ent_jack_teslasentry", 18000 },
  { "ent_jack_bodyarmor_helm_im", 2000 },
  { "ent_jack_bodyarmor_helm_kr", 5000 },
  { "ent_jack_bodyarmor_helm_pe", 12000 },
  { "ent_jack_bodyarmor_helm_ri", 1000 },
  { "ent_jack_bodyarmor_helm_st", 15000 },
  { "ent_jack_suit_eod", 15000 },
  { "ent_jack_suit_hazmat", 3200 },
  { "ent_jack_suit_fire", 6000 },
  { "ent_jack_bodyarmor_vest_bn", 12000 },
  { "ent_jack_bodyarmor_vest_im", 32000 },
  { "ent_jack_bodyarmor_vest_ks", 25000 },
  { "ent_jack_bodyarmor_vest_sk", 12000 },
  { "ent_jack_bodyarmor_vest_sv", 4000 },
  { "npc_igs", 100000 },

  { "chair_titanovsky", 999000 },
  { "chair_aclapac", 999000 },
  { "chair_asher", 999000 },
  { "chair_extradip", 999000 },
  { "chair_frisk", 999000 },
  { "chair_ghost", 999000 },
  { "chair_spooky", 999000 },
  { "chair_wet", 999000 },
  { "chair_kona", 999000 },
  { "chair_unicode", 999000 },
  { "chair_scorpion", 999000 },
  { "chair_sad", 999000 },
  { "chair_combine", 999000 },

  { "eml_stove", 15000 },
  { "eml_jar", 4000 },
  { "eml_pot", 4000 },
  { "eml_spot", 4000 },
  { "eml_gas", 6000 },
  { "eml_water", 200 },
  { "eml_sulfur", 400 },
  { "eml_iodine", 400 },
  { "eml_macid", 600 },
  { "eml_buyer", 10000 },
  { "amb_box_buyer", 5000 },

  --{ "amb_fishing_bait1", 500 },

  { "amb_fishing_bait1", 500 },
  { "amb_fishing_bait2", 2000 },
  { "amb_fishing_bait3", 4000 },
  { "amb_fishing_rod1", 4000 },
  { "amb_fishing_rod2", 20000 },

  { "wac_hc_blackhawk_uh60", 8000 },
  { "wac_pl_c172", 25000 },
  { "wac_hc_mi28_havoc", 65000 },
  { "wac_hc_littlebird_ah6", 42000 },
  { "wac_hc_littlebird_mh6", 28000 },
  { "wac_hc_ah1z_viper", 89000 },

  { "wac_hc_ah1w", 128000 },
  { "wac_pl_f16", 199000 },
  { "wac_pl_f4", 244850 },
  { "wac_pl_fa18", 340000 },
  { "wac_pl_fw190", 28500 },
  { "wac_hc_mi17", 320400 },

  { "zwf_buyer_npc", 9999 },
  { "zwf_autopacker", 6000 },
  { "zwf_doobytable", 8000 },
  { "zwf_drystation", 4000 },
  { "zwf_joint_ent", 5000 },
  { "zwf_generator", 6000 },
  { "zwf_seed", 800 },
  { "zwf_lamp", 1500 },
}



blockGM.costSent = 124

hook.Add("PlayerGiveSWEP", "block_swep_give", function( ply, wep, tbl )
  --local wallet = tonumber( ply:GetNWInt("rub") )


--[[
  for k, v in pairs(blockGM.gunsList) do
    if wep == v[1] then
      if wallet >= v[2] then
        ply:SetNWInt("rub", wallet - v[2])
        ply:SendLua("notification.AddLegacy( 'Вы потратили "..v[2].." Рубаксов!', NOTIFY_GENERIC, 2 )")
        return true
       else
        ply:SendLua("notification.AddLegacy( 'Вам не хватает "..v[2].." Рубаксов!', NOTIFY_ERROR, 2 )")
        return false
      end
    end
  end


	if wallet >= blockGM.costGun then
		ply:SetNWInt("rub", wallet - blockGM.costGun)
		ply:SendLua("notification.AddLegacy( 'Вы потратили 150 Рубаксов!', NOTIFY_GENERIC, 2 )")
		return true
	else
		ply:SendLua("notification.AddLegacy( 'Не хватает 150 Рубаксов!', NOTIFY_ERROR, 2 )")
		return false
	end
--]]

	return true
end)

hook.Add("PlayerSpawnSWEP", "block_swep_spawn", function( ply, wep, tbl )
--[[
  local wallet = tonumber( ply:GetNWInt("rub") )

  for k, v in pairs(blockGM.gunsList) do
    if wep == v[1] then
      if wallet >= v[2] then
        ply:SetNWInt("rub", wallet - v[2])
        ply:SendLua("notification.AddLegacy( 'Вы потратили "..v[2].." Рубаксов!', NOTIFY_GENERIC, 2 )")
        return true
       else
        ply:SendLua("notification.AddLegacy( 'Вам не хватает "..v[2].." Рубаксов!', NOTIFY_ERROR, 2 )")
        return false
      end
    end
  end

  if wallet >= blockGM.costGun then
    ply:SetNWInt("rub", wallet - blockGM.costGun)
    ply:SendLua("notification.AddLegacy( 'Вы потратили 150 Рубаксов!', NOTIFY_GENERIC, 2 )")
    return true
  else
    ply:SendLua("notification.AddLegacy( 'Не хватает 150 Рубаксов!', NOTIFY_ERROR, 2 )")
    return false
  end
  --]]
  return true
end)

hook.Add("CanTool", "block_tools", function( ply, tr, tool )
	local lvl = tonumber(ply:GetNWInt("lvl"))

  for k, v in pairs(blockGM.toolList ) do
    if tool == v[1] then
      if lvl >= v[2]  then
      	if FPP.plyCanTouchEnt(ply, tr.Entity, "Toolgun") then
        	return true
        end
       else
        ply:SendLua("notification.AddLegacy( 'Вам не хватает "..v[2].." уровень!', NOTIFY_ERROR, 2 )")
        return false
      end
    end
  end

   if tool == "duplicator" then
      if ply:SteamID() == "STEAM_0:1:95303327" or ply:SteamID() == "STEAM_0:0:463056472" or ply:SteamID() == "STEAM_0:1:483604613" then
          return true
       else
        ply:SendLua("notification.AddLegacy( 'Незя!', NOTIFY_ERROR, 2 )")
        return false
      end
   end


   for k, v in pairs(blockGM.toolSpec) do
		if tool == v then
			if ply:GetUserGroup() == "user" then
				return false
			else
				return true
			end
   		end
   end

   if tool == "wire_expression2" then
      if ply:SteamID() == "STEAM_0:1:445528149" then
        return false
      end
   end
end)

hook.Add("CanProperty", "block_tools", function( ply, str)
  if ply:GetUserGroup() == "user" then
    for k, v in pairs( blockGM.propertyList ) do
      if str == v then
        return false
      end
    end
  end
end)

hook.Add("PlayerSpawnProp", "block_props", function( ply, mdl )

  --for _, v in pairs(blockGM.propsList) do
  --  if mdl == v then
  --    ply:SendLua("notification.AddLegacy( 'Запрещённый проп!', NOTIFY_ERROR, 2 )")
  --    return false
  --  end
  --end


	if ply:GetUserGroup() == blockGM.user then
		if ply:GetCount("props") == blockGM.propsMax then
      ply:SendLua("notification.AddLegacy( 'Вы достигли лимит пропов!', NOTIFY_ERROR, 2 )")
			return false
		else
			return true
		end
	else
		return true
	end
end)

hook.Add("PlayerSpawnedProp", "block_props", function( ply, mdl, ent)
  local ph = ent:GetPhysicsObject()

  if IsValid(ph) then
    ph:EnableMotion(false)
  end
end)

hook.Add("PlayerSpawnRagdoll", "block_rags", function( ply )

	if ply:GetUserGroup() == "user" then
		if ply:GetCount("ragdolls") == blockGM.ragdollsMax then
			ply:SendLua("notification.AddLegacy( 'Вы достигли лимит регдольчиков!', NOTIFY_ERROR, 2 )")
			return false
		 else
			return true
		end
	 else
		return true
	end
end)


hook.Add("PlayerSpawnSENT", "block_sents", function( ply, class )
  --local wallet = tonumber(ply:GetNWInt("rub"))


  --[[
  for k, v in pairs(blockGM.buysentList) do
    if class == v[1] then
      if wallet >= v[2] then
        ply:SetNWInt("rub", wallet - v[2])
        ply:SendLua("notification.AddLegacy( 'Вы потратили "..v[2].." Рубаксов!', NOTIFY_GENERIC, 2 )")
        return true
       else
        ply:SendLua("notification.AddLegacy( 'Вам не хватает "..v[2].." Рубаксов!', NOTIFY_ERROR, 2 )")
        return false
      end
    end
  end


  for k, v in pairs(blockGM.sentsList) do
  	if class == v then
  		if ply:GetUserGroup() == "superadmin" then
  			return true
  		else
  			ply:SendLua("notification.AddLegacy( 'Незя, ну!', NOTIFY_ERROR, 2 )")
  			return false
  		end
  	end
  end

  if ply:GetCount("sents") == blockGM.sentsMax then
  	return false
  end

  if wallet >= blockGM.costSent then
  	ply:RUB_minus( blockGM.costSent )
  	ply:SendLua("notification.AddLegacy( 'Вы потратили:"..blockGM.costSent.." Roblox', NOTIFY_GENERIC, 2 )")
  	return true
  else
  	ply:SendLua("notification.AddLegacy( 'Вам не хватает "..blockGM.costSent.." Roblox!', NOTIFY_ERROR, 2 )")
  	return false
  end
  ]]
  return true
end)


blockGM.costVeh = 10000
blockGM.VehList = {

  ["models/blu/avia/avia.mdl"] = 8062,
  ["models/blu/gaz52/gaz52.mdl"] = 9820,
  ["models/blu/hatchback/pw_hatchback.mdl"] = 12499,
  ["models/blu/skoda_liaz/skoda_liaz.mdl"] = 15024,
  ["models/blu/moskvich/moskvich.mdl"] = 18756,
  ["models/blu/trabant/trabant.mdl"] = 19887,
  ["models/blu/trabant/trabant02.mdl"] = 20111,
  ["models/blu/van/pw_van.mdl"] = 22522,
  ["models/blu/volga/volga.mdl"] = 24001,
  ["models/blu/zaz/zaz.mdl"] = 26450,

  ["models/airboat.mdl"] = 12499,
  ["models/buggy.mdl"] = 12499,

  ["models/blue/gtav/dukes/dukes.mdl"] = 22064,
  ["models/props_c17/furniturecouch002a.mdl"] = 6599,
  ["models/vehicles/buggy_elite.mdl"] = 26999,
  ["models/vehicles/7seatvan.mdl"] = 32500,

  ["models/chaos126p/chaos126p.mdl"] = 20400,
  ["models/hedgehog/hedgehog.mdl"] = 28320,
  ["models/ratmobile/ratmobile.mdl"] = 32409,
  ["models/blu/tanks/tiger.mdl"] = 240104,
  ["models/blu/conscript_apc.mdl"] = 44032,
  ["models/combine_apc.mdl"] = 48064,
  ["models/blu/tanks/t90ms.mdl"] = 264988,

  ["models/ats/vehicles/charger_generic_police.mdl"] = 100000,
	["models/ats/vehicles/crown_victoria_generic.mdl"] = 100000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 100000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 100000,
	["models/ats/vehicles/f350.mdl"] = 500000,
	["models/ats/vehicles/ford_taurus_generic.mdl"] = 100000,
	["models/ats/vehicles/arrow_xt.mdl"] = 600000,

  ["models/ats/vehicles/cat_422.mdl"] = 900600,
  ["models/ats/vehicles/mutt_578d.mdl"] = 4900600,
  ["models/ats/vehicles/cat_938g.mdl"] = 876000,
  ["models/ats/vehicles/city_express.mdl"] = 90228,
  ["models/ats/vehicles/chevy_lc_flatbed2.mdl"] = 54000,
  ["models/ats/vehicles/chevan.mdl"] = 54000,
  ["models/ats/vehicles/chevy_lc_dryvan.mdl"] = 64000,
  ["models/ats/vehicles/chevy_lc_dump.mdl"] = 64000,
  ["models/ats/vehicles/chevy_lc_flatbed.mdl"] = 68000,
	["models/ats/vehicles/dodge_ram.mdl"] = 45000,
	["models/ats/vehicles/f_150_escort.mdl"] = 75000,
	["models/ats/vehicles/f_150_hw.mdl"] = 75000,
	["models/ats/vehicles/f350_hd_tow_theme_firm.mdl"] = 75000,
	["models/ats/vehicles/f350_hd_tow_theme.mdl"] = 75000,
	["models/ats/vehicles/f350_hd_compressor.mdl"] = 80000,
	["models/ats/vehicles/limo_lincoln.mdl"] = 120000,
	["models/ats/vehicles/box_ladder.mdl"] = 125000,
	["models/ats/vehicles/ford_transit_tv.mdl"] = 95000,
	["models/ats/vehicles/ford_transit.mdl"] = 90000,
	["models/ats/vehicles/ford_transit_work_1.mdl"] = 95000,
	["models/ats/vehicles/ford_transit_hw.mdl"] = 100000,
	["models/ats/vehicles/solera.mdl"] = 145000,

	["models/ats/vehicles/wolverine.mdl"] = 30000,
	["models/ats/vehicles/bus_s.mdl"] = 100000,
	["models/ats/vehicles/greyhound.mdl"] = 900000,
	["models/ats/vehicles/bus.mdl"] = 90000,
	["models/ats/vehicles/pvan_icecream.mdl"] = 75000,

	["models/ats/vehicles/audi_a6.mdl"] = 145000,
	["models/ats/vehicles/verano.mdl"] = 150000,
	["models/ats/vehicles/ats.mdl"] = 150000,
	["models/ats/vehicles/deville.mdl"] = 100000,
	["models/ats/vehicles/camaro.mdl"] = 150000,
	["models/ats/vehicles/capr_civil.mdl"] = 100000,
	["models/ats/vehicles/volt.mdl"] = 175000,
	["models/ats/vehicles/chevy_imp.mdl"] = 228,
	["models/ats/vehicles/charger_12.mdl"] = 150000,
	["models/ats/vehicles/charger.mdl"] = 150000,
	["models/ats/vehicles/magnum.mdl"] = 125000,
	["models/ats/vehicles/crown_victoria_civil.mdl"] = 75000,
	["models/ats/vehicles/mustang.mdl"] = 125000,
	["models/ats/vehicles/mustang_2015.mdl"] = 125000,
	["models/ats/vehicles/ford_taurus_civil.mdl"] = 100000,
	["models/ats/vehicles/mustang_2015_hardtop.mdl"] = 125000,
	["models/ats/vehicles/lincoln_mkt.mdl"] = 100000,
	["models/ats/vehicles/accord.mdl"] = 750000,
	["models/ats/vehicles/mercury_co.mdl"] = 95000,
	["models/ats/vehicles/mercedes_ce.mdl"] = 90000,
	["models/ats/vehicles/oldsmobile.mdl"] = 150000,
	["models/ats/vehicles/impreza.mdl"] = 175000,
	["models/ats/vehicles/tesla.mdl"] = 250000,
	["models/ats/vehicles/prius.mdl"] = 75000,

	["models/ats/vehicles/crown_victoria_generic_old.mdl"] = 250000,
	["models/ats/vehicles/ford_explorer_police_old.mdl"] = 450000,
	["models/ats/vehicles/old_f_150.mdl"] = 125000,
	["models/ats/vehicles/ford_taurus_generic_old.mdl"] = 325000,
	["models/ats/vehicles/wrangler.mdl"] = 175000,
	["models/ats/vehicles/wrangler_canvas.mdl"] = 180000,
	["models/ats/vehicles/tractor.mdl"] = 200000,
	["models/ats/vehicles/xc90_old.mdl"] = 200000,
	["models/ats/vehicles/pvan_icecream.mdl"] = 150000,
	["models/ats/vehicles/crown_victoria_taxi.mdl"] = 150000,
	["models/ats/vehicles/enclave.mdl"] = 150000,
	["models/ats/vehicles/escalade.mdl"] = 150000,
	["models/ats/vehicles/3100p.mdl"] = 100000,
	["models/ats/vehicles/dodge_ram.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_civil.mdl"] = 150000,
	["models/ats/vehicles/f_150.mdl"] = 145000,
	["models/ats/vehicles/ford_smax.mdl"] = 135000,
	["models/ats/vehicles/sierra.mdl"] = 150000,
	["models/ats/vehicles/hummer_h2.mdl"] = 150000,
	["models/ats/vehicles/hummer_sut.mdl"] = 150000,
	["models/ats/vehicles/santafe.mdl"] = 145000,
	["models/ats/vehicles/wrangler.mdl"] = 125000,
	["models/ats/vehicles/cherokee.mdl"] = 140000,
	["models/ats/vehicles/wrangler_canvas.mdl"] = 150000,
	["models/ats/vehicles/lincoln_navigator.mdl"] = 175000,
	["models/ats/vehicles/rangerover.mdl"] = 150000,
	["models/ats/vehicles/xc90.mdl"] = 175000,

	["models/ats/vehicles/capr_arizona_hp.mdl"] = 120000,
	["models/ats/vehicles/capr_nevada_hp.mdl"] = 120000,
	["models/ats/vehicles/capr_nm_hp.mdl"] = 120000,
	["models/ats/vehicles/chevy_imp_police.mdl"] = 120000,
	["models/ats/vehicles/charger_albuquerque_pd.mdl"] = 120000,
	["models/ats/vehicles/charger_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police2.mdl"] = 120000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police_2.mdl"] = 150000,
	["models/ats/vehicles/f350.mdl"] = 250000,
	["models/ats/vehicles/ford_taurus_police.mdl"] = 120000,


  ["models/ats/vehicles/chevy_lc_reef.mdl"] = 54999,
  ["models/ats/vehicles/pvan.mdl"] = 54999,
  ["models/ats/vehicles/f350_hd_hull.mdl"] = 72000,
  ["models/ats/vehicles/box_plain.mdl"] = 72000,
  ["models/ats/vehicles/box_nhool.mdl"] = 72000,
  ["models/ats/vehicles/ford_transit.mdl"] = 72000,
  ["models/ats/vehicles/ford_transit_glass.mdl"] = 72000,
  ["models/ats/vehicles/ford_transit_work_2.mdl"] = 72000,
  ["models/ats/vehicles/ford_transit_work_3.mdl"] = 72000,
  ["models/ats/vehicles/harvester_u.mdl"] = 9000000,
  ["models/ats/vehicles/tractor.mdl"] = 184000,
  ["models/ats/vehicles/international_lonestar_ai_a.mdl"] = 184000,
  ["models/ats/vehicles/mack_anthem_ai_a.mdl"] = 184000,
  ["models/ats/vehicles/kenworth_t680_ai_a.mdl"] = 184000,
  ["models/ats/vehicles/kenworth_t680_ai_c.mdl"] = 184000,
  ["models/ats/vehicles/kenworth_t680_ai_b.mdl"] = 184000,
  ["models/ats/vehicles/kenworth_w900_ai_c.mdl"] = 184000,
  ["models/ats/vehicles/kenworth_w900_ai_a.mdl"] = 184000,
  ["models/ats/vehicles/kenworth_w900_ai_b.mdl"] = 184000,
  ["models/ats/vehicles/mack_anthem_ai_c.mdl"] = 184000,
  ["models/ats/vehicles/mack_anthem_ai_a.mdl"] = 184000,
  ["models/ats/vehicles/mack_mix.mdl"] = 999999,
  ["models/ats/vehicles/mack_dump.mdl"] = 999999,
  ["models/ats/vehicles/mack_garbage.mdl"] = 999999,
  ["models/ats/vehicles/mack_pump.mdl"] = 999999,
  ["models/blu/tanks/t90ms.mdl"] = 999999,
  ["models/ats/vehicles/yard_truck.mdl"] = 99200,

	 ["models/ats/vehicles/audi_a6.mdl"] = 600400,
	["models/ats/vehicles/verano.mdl"] = 150000,
	["models/ats/vehicles/ats.mdl"] = 150000,
	["models/ats/vehicles/deville.mdl"] = 100000,
	["models/ats/vehicles/camaro.mdl"] = 150000,
	["models/ats/vehicles/capr_civil.mdl"] = 100000,
	["models/ats/vehicles/volt.mdl"] = 175000,
	["models/ats/vehicles/chevy_imp.mdl"] = 228,
	["models/ats/vehicles/charger_12.mdl"] = 150000,
	["models/ats/vehicles/charger.mdl"] = 150000,
	["models/ats/vehicles/magnum.mdl"] = 125000,
	["models/ats/vehicles/crown_victoria_civil.mdl"] = 75000,
	["models/ats/vehicles/mustang.mdl"] = 125000,
	["models/ats/vehicles/mustang_2015.mdl"] = 125000,
	["models/ats/vehicles/ford_taurus_civil.mdl"] = 100000,
	["models/ats/vehicles/mustang_2015_hardtop.mdl"] = 125000,
	["models/ats/vehicles/lincoln_mkt.mdl"] = 100000,
	["models/ats/vehicles/accord.mdl"] = 750000,
	["models/ats/vehicles/mercury_co.mdl"] = 95000,
	["models/ats/vehicles/mercedes_ce.mdl"] = 90000,
	["models/ats/vehicles/oldsmobile.mdl"] = 150000,
	["models/ats/vehicles/impreza.mdl"] = 175000,
	["models/ats/vehicles/tesla.mdl"] = 250000,
	["models/ats/vehicles/prius.mdl"] = 75000,

		["models/ats/vehicles/capr_arizona_hp.mdl"] = 120000,
	["models/ats/vehicles/capr_nevada_hp.mdl"] = 120000,
	["models/ats/vehicles/capr_nm_hp.mdl"] = 120000,
	["models/ats/vehicles/chevy_imp_police.mdl"] = 120000,
	["models/ats/vehicles/charger_albuquerque_pd.mdl"] = 120000,
	["models/ats/vehicles/charger_police.mdl"] = 120000,
	["models/ats/vehicles/charger_police.mdl"] = 120000,
	["models/ats/vehicles/charger_police.mdl"] = 120000,
	["models/ats/vehicles/charger_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police2.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police2.mdl"] = 120000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police_2.mdl"] = 150000,
	["models/ats/vehicles/f350.mdl"] = 250000,
	["models/ats/vehicles/ford_taurus_police.mdl"] = 120000,
	["models/ats/vehicles/ford_taurus_police.mdl"] = 120000,
	["models/ats/vehicles/ford_taurus_police.mdl"] = 120000,
	["models/ats/vehicles/ford_taurus_police.mdl"] = 120000,
	["models/ats/vehicles/ford_taurus_police.mdl"] = 120000,

  ["models/ats/vehicles/capr_highway_patrol.mdl"] = 120000,
	["models/ats/vehicles/capr_or_hp.mdl"] = 120000,
	["models/ats/vehicles/capr_washington_hp.mdl"] = 120000,
	["models/ats/vehicles/charger_police.mdl"] = 120000,
	["models/ats/vehicles/charger_police.mdl"] = 120000,
	["models/ats/vehicles/charger_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police.mdl"] = 120000,
	["models/ats/vehicles/crown_victoria_police2.mdl"] = 120000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police_2.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police_2.mdl"] = 150000,
	["models/ats/vehicles/ford_explorer_police_2.mdl"] = 150000,
	["models/ats/vehicles/f350.mdl"] = 500000,
	["models/ats/vehicles/ford_taurus_police.mdl"] = 120000,
	["models/ats/vehicles/ford_taurus_police.mdl"] = 120000,

  ["models/ats/vehicles/peterbilt_389_ai_a.mdl"] = 280201,
  ["models/ats/vehicles/peterbilt_389_ai_b.mdl"] = 264988,
  ["models/ats/vehicles/peterbilt_389_ai_c.mdl"] = 280201,
  ["models/ats/vehicles/peterbilt_579_ai_a.mdl"] = 264988,
  ["models/ats/vehicles/peterbilt_579_ai_c.mdl"] = 280201,
  ["models/ats/vehicles/peterbilt_579_ai_b.mdl"] = 264988,
  ["models/ats/vehicles/sweeper.mdl"] = 280201,
  ["models/ats/vehicles/volvo_vnl_ai_a.mdl"] = 280201,
  ["models/ats/vehicles/volvo_vnl_ai_b.mdl"] = 264988,
  ["models/ats/vehicles/volvo_vnl_ai_c.mdl"] = 280201,
}

hook.Add("PlayerSpawnVehicle", "block_veh", function( ply, mdl )
	--[[
	local wallet = tonumber(ply:GetNWInt("rub"))

	if ply:GetCount("vehicles") == blockGM.vehicleMax then
		return false
	end

  for name, v in pairs(blockGM.VehList) do
      local price = blockGM.VehList[name]
		if mdl == name then
			if wallet >= price then
				ply:RUB_minus(price)
				ply:SendLua("notification.AddLegacy( 'Вы потратили "..price.." Рубаксов!', NOTIFY_GENERIC, 2 )")
				return true
			else
				ply:SendLua("notification.AddLegacy( 'Вам не хватает "..price.." Рубаксов!', NOTIFY_ERROR, 2 )")
				return false
			end
		end
  end
  ]]--
  return true
end)


hook.Add("PlayerSpawnEffect", "block_effects", function( ply )
	local max = 3

	if ply:GetCount("effects") == max then
		return false
	else
		return true
	end
end)

hook.Add("PlayerSpawnNPC", "block_npcs", function( ply )
	--local max = 0

	if ply:GetUserGroup() == "user" or ply:GetUserGroup() == "vip" then
		return false
	else
		return true
	end
end)


hook.Add("PlayerCanHearPlayersVoice", "Maximum Range", function(listener, talker)
    --if talker:SteamID() ~= "STEAM_0:1:95303327" then
    --	if listener:GetPos():Distance(talker:GetPos()) > 2000 then
   	--return false
    --	end
    --end
end)

function ply_struct:SetReloadPhys( bAccess )
  self.reloadPhys = bAccess
end

local delay_phys_reload = 5

hook.Add( "PlayerInitialSpawn", "rus_antilag_hook", function( ply )
  ply:SetReloadPhys( true )
end )


hook.Add( "OnPhysgunReload", "rus_antilag_hook", function( _, ply)
  if ( tonumber( ply:GetNWInt("lvl") ) <= 4 ) then
    ply:ChatPrint("Извините, но такая разморозка доступна с 4+ уровня")
    return false
  end

  if ( ply.reloadPhys == false ) then
    if timer.Exists( "amb_reloadtime"..tostring( ply:SteamID() ) ) then
      ply:ChatPrint("Перезарядка: "..math.Round( timer.TimeLeft( "amb_reloadtime"..tostring( ply:SteamID() ) ), 2 ).." сек!")
      return false
    end
  end

  ply:SetReloadPhys( false )
  timer.Create( "amb_reloadtime"..tostring( ply:SteamID() ), 5, 0, function()
    if IsValid( ply ) then
      ply:SetReloadPhys( true )
    end
  end)
end )