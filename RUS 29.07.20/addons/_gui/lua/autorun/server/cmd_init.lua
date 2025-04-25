

local prefix = { "/", "!" }

--[[local cmds = {
	["stats"] = { "stats", "stat", "info" },
	["help"] = { "xui", "pizda" }
}]]-- Может дорасту =(

local cmds_stats = { "stats", "stat", "info" }
local cmds_help = { "help" }
local cmds_cmds = { "cmd", "cmds" }
local cmds_content = { "content", "contents" }
local cmds_rule = { "rule", "rules" }
local cmds_vk = { "vk", "vkontakte" }
local cmds_discord = { "discord", "dis" }
local cmds_steam = { "steam" }
local cmds_faq = { "faq", "вопрос" }
local cmds_hud = { "hud" }
local cmds_wallet = { "wallet" }
local cmds_logo = { "logo" }
local cmds_dev = { "dev" }
local cmds_panel = { "panel", "panels" }
local cmds_build = { "build", "buildmode", "pvp", "pvpmode", "buildpvp" }
local cmds_crosshire = { "cross", "crosshire" }
local cmds_motd = { "motd" }
local cmds_payday_time = { "pd", "payday" }

local bypass=false
hook.Add("PlayerSay", "ru_teamxchatavoider", function(ply, text,team)
	if team and not bypass then
		bypass=true
		ply:Say("[TEAM] "..text)
		bypass=false
		return ""
	end
end)

hook.Add("PlayerSay", "ru_cmds", function(ply, text)
	local text = string.lower( text )
	
	for _, v in pairs(prefix) do

		for _, cmd in pairs(cmds_stats) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(1)')
				return false
			end
		end

		for _, cmd in pairs(cmds_help) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(2)')
				return false
			end
		end

		for _, cmd in pairs(cmds_cmds) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(3)')
				return false
			end
		end

		for _, cmd in pairs(cmds_content) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(4)')
				return false
			end
		end

		for _, cmd in pairs(cmds_rule) do
			if text == v..cmd then
				ply:SendLua( 'rus_MOTD()')
				return false
			end
		end

		for _, cmd in pairs(cmds_discord) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(6)')
				return false
			end
		end

		for _, cmd in pairs(cmds_vk) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(7)')
				return false
			end
		end

		for _, cmd in pairs(cmds_steam) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(8)')
				return false
			end
		end

		for _, cmd in pairs(cmds_faq) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(9)')
				return false
			end
		end

		for _, cmd in pairs(cmds_hud) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(10)')
				return false
			end
		end

		for _, cmd in pairs(cmds_wallet) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(11)')
				return false
			end
		end

		for _, cmd in pairs(cmds_logo) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(12)')
				return false
			end
		end

		for _, cmd in pairs(cmds_dev) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(13)')
				return false
			end
		end

		for _, cmd in pairs(cmds_panel) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(14)')
				return false
			end
		end

		for _, cmd in pairs(cmds_build) do
			if text == v..cmd then
				ply:SetBuildMode()
				return false
			end
		end

		for _, cmd in pairs(cmds_crosshire) do
			if text == v..cmd then
				ply:SendLua( 'ru_showCmds(15)')
				return false
			end
		end

		for _, cmd in pairs(cmds_motd) do
			if text == v..cmd then
				ply:SendLua( 'rus_MOTD()')
				return false
			end
		end

		for _, cmd in pairs(cmds_payday_time) do
			if text == v..cmd then
				AmbPayday_showTime( ply )
			end
		end

	end
end)


--VOICE DATA--


concommand.Add("RPVOICE", function( ply, cmd, args )
	ply.RPVOICE = not ply:GetNWBool("RPVOICE")
	ply:SetNWBool("RPVOICE",ply.RPVOICE)
	return false
end)


hook.Add("PlayerCanHearPlayersVoice", "VOICERP", function(listener, talker)
	if talker.RPVOICE then return true,true end
	if listener.RPVOICE then return false end
	return true
end)