function urlencode( str )
	if (str) then
		str = string.gsub (str, "\n", "\r\n")
		str = string.gsub (str, "([^%w ])",
		function (c) return string.format ("%%%02X", string.byte(c)) end)
		str = string.gsub (str, " ", "+")
	end
 	return str
end

local IGN = CreateClientConVar('amb_tts_ignore', '0', true )

net.Receive( "PlayTTS",function()

	if IGN:GetBool() then return end

	local text = net.ReadString()
	local ply = net.ReadEntity()

	text = urlencode( string.sub( text,1,240 ) )

	if ( ply:GetNWBool("ulx_muted") == false ) then
		sound.PlayURL( "https://translate.google.com/translate_tts?ie=UTF-8&q="..text.."&tl=ru&client=tw-ob", "mono", function(sound)
			if IsValid( snd ) then
				snd:Play()
				g_station = snd -- for gc
			end
		end )
	end
end )