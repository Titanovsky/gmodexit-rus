AddCSLuaFile("sh_tts_config.lua")

/*
hook.Add("OnPlayerChat", "ru_voice_tts", function( ply, text )
	function urlencode( str )
		if (str) then
			str = string.gsub (str, "\n", "\r\n")
			str = string.gsub (str, "([^%w ])",
			function (c) return string.format ("%%%02X", string.byte(c)) end)
			str = string.gsub (str, " ", "+")
		end
 	return str 
end
end)
*/

net.Receive("PlayTTS",function()
	function urlencode( str )
		if (str) then
			str = string.gsub (str, "\n", "\r\n")
			str = string.gsub (str, "([^%w ])",
			function (c) return string.format ("%%%02X", string.byte(c)) end)
			str = string.gsub (str, " ", "+")
		end
 	 return str
 	end 
	local text = net.ReadString()
	local ply = net.ReadEntity() 
	local lang = TTS_CONFIG.Language
	text = urlencode(string.sub(text,5,100))

	sound.PlayURL("https://translate.google.com/translate_tts?ie=UTF-8&q="..text.."&tl=ru&client=tw-ob","3d",function(sound)
		if IsValid(sound) then
			sound:SetPos(ply:GetPos())
			sound:SetVolume(1)
			sound:Play()
			sound:Set3DFadeDistance(200,1000)
			ply.sound = sound
		end
	end)
end)

hook.Add("Think", "SoundOnPlayer",function()
	for _, ply in pairs(player.GetAll()) do
		if IsValid(ply.sound) then
			ply.sound:SetPos(ply:GetPos())
		end
	end
end)