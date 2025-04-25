VJBASE_VERSION = "2.12.5"
VJBASE_GETNAME = "VJ Base"

-- Shared --
include("autorun/vj_menu_spawn.lua")
AddCSLuaFile("autorun/vj_base_autorun.lua")
AddCSLuaFile("autorun/vj_controls.lua")
AddCSLuaFile("autorun/vj_entities.lua")
AddCSLuaFile("autorun/vj_entities_cmds.lua")
AddCSLuaFile("autorun/vj_files.lua")
AddCSLuaFile("autorun/vj_files_language.lua")
AddCSLuaFile("autorun/vj_files_particles.lua")
AddCSLuaFile("autorun/vj_menu_main.lua")
AddCSLuaFile("autorun/vj_menu_properties.lua")
AddCSLuaFile("autorun/vj_util.lua")
AddCSLuaFile("autorun/vj_weapons.lua")

-- Client --
AddCSLuaFile("autorun/client/vj_menu_main_client.lua")
AddCSLuaFile("autorun/client/vj_menu_plugins.lua")
AddCSLuaFile("autorun/client/vj_menu_snpc.lua")
AddCSLuaFile("autorun/client/vj_menu_weapon.lua")

-- Modules --
AddCSLuaFile("includes/modules/ai_vj_schedule.lua")
AddCSLuaFile("includes/modules/ai_vj_task.lua")
//AddCSLuaFile("includes/modules/sound_vj_track.lua")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Main Hooks / Functions ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
	hook.Add("AddToolMenuTabs", "VJ_CREATETOOLTAB", function()
		spawnmenu.AddToolTab("DrVrej", "DrVrej", "vj_base/icons/vrejgaming.png") // "icon16/plugin.png"
		spawnmenu.AddToolCategory("DrVrej", "Main Menu", "#vjbase.menu.tabs.mainmenu")
		spawnmenu.AddToolCategory("DrVrej", "SNPCs", "#vjbase.menu.tabs.settings.snpc")
		spawnmenu.AddToolCategory("DrVrej", "Weapons", "#vjbase.menu.tabs.settings.weapon")
		spawnmenu.AddToolCategory("DrVrej", "HUDs", "#vjbase.menu.tabs.settings.hud")
		spawnmenu.AddToolCategory("DrVrej", "Tools", "#vjbase.menu.tabs.tools")
		spawnmenu.AddToolCategory("DrVrej", "SNPC Configures", "#vjbase.menu.tabs.configures.snpc")
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Outdated GMod Version Check ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if SERVER && !isfunction(FindMetaTable("NPC").SetIdealYawAndUpdate) then
	timer.Simple(1, function()
		if !VJ_WARN_GModOutdated then
			VJ_WARN_GModOutdated = true
			timer.Create("VJ_WARN_GModOutdated", 2, 0, function()
				PrintMessage(HUD_PRINTTALK, "--- Outdated version of Garry's Mod detected! ---")
				PrintMessage(HUD_PRINTTALK, "Opt out of the Chromium branch!")
			end)
		end
	end)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ SLV Base Check ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (SLVBase) then
	timer.Simple(1, function()
		if !VJ_WARN_SLVBase then
			if (SERVER) then
				timer.Create("VJ_WARN_SLVBase", 5, 0, function()
					print("VJ Base is being overridden by another addon! Incompatible Addons: http://steamcommunity.com/sharedfiles/filedetails/?id=1129493108")
				end)
			end
		end
	end)
end