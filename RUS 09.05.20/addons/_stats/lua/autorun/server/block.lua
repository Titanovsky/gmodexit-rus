-- Config

local blockGM = {}

blockGM.user = "user"
blockGM.vip = "vip"
blockGM.superadmin = "superadmin"

blockGM.propsMax = 250
blockGM.propsList = {
  "models/props_c17/canister01a.mdl",
  "models/props_c17/canister02a.mdl"
}

blockGM.costGun = 150
blockGM.costGunSpawn = 3213
blockGM.gunsList = {
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
  { "cw_frag_grenade", 2000 }
}

blockGM.access = {
  "superadmin",
  "admin",
  "avk",
  "superadmin",
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
  { "smartweld", 4 },
  { "stacker_improved", 4 },
  { "elevator", 6 },
}

blockGM.toolSpec = {
  "dynamite",
  "mapret"
}


hook.Add("PlayerGiveSWEP", "block_swep_give", function( ply, wep, tbl )
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
end)

hook.Add("PlayerSpawnSWEP", "block_swep_give", function( ply, wep, tbl )
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

   if tool == "wire_expression2" then
      if ply:SteamID() == "STEAM_0:1:445528149" then
        return false
      end
   end

   if tool == "duplicator" then
      if ply:SteamID() == "STEAM_0:1:95303327" or ply:SteamID() == "STEAM_0:0:463056472" then
          return true
       else
        ply:SendLua("notification.AddLegacy( 'Незя!', NOTIFY_ERROR, 2 )")
        return false
      end
   end

   if tool == "hoverboard" then
   		if ply:GetUserGroup() == "vip" or ply:GetUserGroup() == "officer" or ply:GetUserGroup() == "admin" or ply:GetUserGroup() == "superadmin" then
        	return true
   		 else
    		ply:SendLua("notification.AddLegacy( 'Незя!', NOTIFY_ERROR, 2 )")
    		return false
   	 	end
   end

   for k, v in pairs(blockGM.toolSpec) do
      if tool == v then
      	if ply:GetUserGroup() == "superadmin" then
        	return true
    	else 
    		return false
    	end
      end
   end
end)

hook.Add("PlayerSpawnProp", "block_props", function( ply, mdl )

  for _, v in pairs(blockGM.propsList) do
    if mdl == v then
      ply:SendLua("notification.AddLegacy( 'Запрещённый проп!', NOTIFY_ERROR, 2 )")
      return false
    end
  end

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

hook.Add("PlayerSpawnRagdoll", "block_rags", function( ply ) 
	local max = 1

	if ply:GetUserGroup() == "user" then
		if ply:GetCount("props") ~= max then
			return true
		 else 
			return false
		end
	else 
		return true
	end
end)

hook.Add("PlayerSpawnSENT", "ru_block_sents", function( ply, class ) 
	local max = 10
  local countEnt = 120
  local wallet = tonumber(ply:GetNWInt("rub"))
  local user = ply:GetUserGroup()

  if user == "user" or user == "vip" then
    if class == "ent_jack_gmod_ezdynamite" then
      return false
     elseif class == "ent_jack_gmod_ezflashbang" then
      return false
     elseif class == "ent_jack_gmod_ezdetpack" then
      return false
     elseif class == "ent_jack_gmod_ezflashbang" then
      return false
     elseif class == "ent_jack_gmod_ezfougasse" then
      return false
      elseif class == "ent_jack_gmod_ezfragnade" then
      return false
     elseif class == "ent_jack_gmod_ezgasnade" then
      return false
     elseif class == "ent_jack_gmod_ezsticknadebundle" then
      return false
     elseif class == "ent_jack_gmod_ezimpactnade" then
      return false
      elseif class == "ent_jack_gmod_ezfirenade" then
      return false
     elseif class == "ent_jack_gmod_ezlandmine" then
      return false
     elseif class == "ent_jack_gmod_ezboundingmine" then
      return false
     elseif class == "ent_jack_gmod_ezminimore" then
      return false
      elseif class == "ent_jack_gmod_ezpowderkeg" then
      return false
     elseif class == "ent_jack_gmod_ezsatchelcharge" then
      return false
     elseif class == "ent_jack_gmod_ezsignalnade" then
      return false
     elseif class == "ent_jack_gmod_ezslam" then
      return false
     elseif class == "ent_jack_gmod_ezsmokenade" then
      return false
      elseif class == "ent_jack_gmod_ezsticknade" then
      return false
      elseif class == "ent_jack_gmod_ezstickynade" then
      return false
      elseif class == "ent_jack_gmod_eztimebomb" then
      return false
      elseif class == "ent_jack_gmod_eztnt" then
      return false
      elseif class == "ent_jack_gmod_eznade_impact" then
      return false
      elseif class == "ent_jack_gmod_eznade_proximity" then
      return false
      elseif class == "ent_jack_gmod_eznade_remote" then
      return false
      elseif class == "ent_jack_gmod_eznade_timed" then
      return false
      elseif class == "ent_jack_powderbottle" then
      return false
      elseif class == "ent_jack_powderkeg" then
      return false
      elseif class == "ent_jack_boundingmine" then
      return false
      elseif class == "ent_jack_claymore" then
      return false
      elseif class == "ent_jack_clusterbomb" then
      return false
      elseif class == "ent_jack_clusterminebomb" then
      return false
      elseif class == "ent_jack_c4block" then
      return false
      elseif class == "ent_jack_dynamite" then
      return false
      elseif class == "ent_jack_firework" then
      return false
      elseif class == "ent_jack_heatbomb" then
      return false
      elseif class == "ent_jack_hebomb" then
      return false
      elseif class == "ent_jack_firebomb" then
      return false
      elseif class == "ent_jack_landmine" then
      return false
      elseif class == "ent_jack_landmine_lrg" then
      return false
      elseif class == "ent_jack_fraggrenade" then
      return false
      elseif class == "ent_jack_landmine_med" then
      return false
      elseif class == "ent_jack_mark82" then
      return false
      elseif class == "ent_jack_seamine" then
      return false
      elseif class == "ent_jack_nitroglycerin" then
      return false
      elseif class == "ent_jack_slam" then
      return false
      elseif class == "ent_jack_apersbomb" then
      return false
      elseif class == "ent_jack_landmine_sml" then
      return false
      elseif class == "ent_jack_faebomb" then
      return false
      elseif class == "ent_jack_tntpack" then
      return false
      elseif class == "ent_jack_warmine" then
      return false
      elseif class == "ent_jack_gmod_antlions" then
      return false
      elseif class == "ent_jack_gmod_combine" then
      return false
      elseif class == "ent_jack_gmod_dropship" then
      return false
      elseif class == "ent_jack_gmod_combinestalkers" then
      return false
      elseif class == "ent_jack_gmod_elitecombine" then
      return false
      elseif class == "ent_jack_gmod_eliterebels" then
      return false
      elseif class == "ent_jack_gmod_headcrabs" then
      return false
      elseif class == "ent_jack_gmod_humans" then
      return false
      elseif class == "ent_jack_gmod_gunhack" then
      return false
      elseif class == "ent_jack_gmod_rollerbomb" then
      return false
      elseif class == "ent_jack_gmod_superhack" then
      return false
      elseif class == "ent_jack_gmod_soldiers" then
      return false
      elseif class == "ent_jack_gmod_npcspawner" then
      return false
      elseif class == "ent_jack_gmod_zombies" then
      return false
    end
  end

  if ply:GetCount("sents") == max then
    ply:SendLua("chat.AddText(Color(255,255,255), 'Лимит ентити!')")
    return false
   elseif ply:GetCount("sents") ~= max and wallet >= countEnt then
    ply:SendLua("notification.AddLegacy( 'Вы потратили 100 Рубаксов!', NOTIFY_GENERIC, 2 )")
    ply:RUB_minus( countEnt )
    return true
  end
end)

hook.Add("PlayerSpawnVehicle", "block_veh", function( ply ) 
	local max = 2

	if ply:GetCount("vehicles") == max then
		return false
	else 
		return true
	end
end)

hook.Add("PlayerSpawnEffect", "block_effects", function( ply ) 
	local max = 6

	if ply:GetCount("effects") == max then
		return false
	else 
		return true
	end
end)

hook.Add("PlayerSpawnNPC", "block_npcs", function( ply ) 
	--local max = 0

	if ply:GetUserGroup() == "user" then
		return false
	else
		return true
	end
end)