AddCSLuaFile("autorun/client/cl_tts.lua")

util.AddNetworkString("PlayTTS")
--local MAT = {"пи.+д","бля","хул","ебат","ебан","охуе","заеба","хуес","уеба","хуй","huy","pizd","ueba","ohue","blya","нихую","хуя","б.+лять","б.+лядь","pi.+da"}
hook.Add("PlayerSay","TTSdetect",function(ply,txt,team)
	if txt=="!ttson" then
		ply.ALWAYSTTS=true
	elseif txt=="!ttsoff" then
		ply.ALWAYSTTS=nil
	elseif ply.ALWAYSTTS or string.sub(txt,1,4) == "!tts" or string.sub(txt,1,4) == "/tts" then
		--local t2 = txt:Replace(" ",""):Replace("йо","е"):Replace("ё","е"):Replace("э","е")
		--for k,v in pairs(MAT) do
		--	if string.match(t2,MAT[k]) then return "На время теста мат в TTS запрещён." end
		--end
		txt = (ply.TTSNAME and ply.TTSNAME.." сказал "..txt:Replace("!tts ",""):Replace("/tts ","") or txt)
		if ply:GetUserGroup() ~= "user" then
			net.Start("PlayTTS")
				net.WriteString(ply.ALWAYSTTS and "!tts "..txt or txt)
				net.WriteEntity(ply)
			net.Broadcast()
		end
	end
end)