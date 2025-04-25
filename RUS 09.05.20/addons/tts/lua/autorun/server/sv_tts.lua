AddCSLuaFile("autorun/client/cl_tts.lua")
AddCSLuaFile("autorun/sh_tts_config.lua")

util.AddNetworkString("PlayTTS")

hook.Add("PlayerSay","TTSdetect",function(ply,txt,team)
	if string.sub(txt,1,4) == "!tts" or string.sub(txt,1,4) == "/tts" then
		if ply:GetUserGroup() ~= "user" then
			net.Start("PlayTTS")
				net.WriteString(txt)
				net.WriteEntity(ply)
			net.Broadcast()
		end
	end
end)