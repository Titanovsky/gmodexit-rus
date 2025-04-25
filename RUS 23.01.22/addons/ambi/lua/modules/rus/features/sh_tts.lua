if SERVER then
    util.AddNetworkString( 'PlayTTS' )
    hook.Add("PlayerSay","TTSdetect",function( ply,txt,team )
        if txt=="/ttson" then
            ply.ALWAYSTTS=true
        elseif txt=="/ttsoff" then
            ply.ALWAYSTTS=nil
        end


        if ( ply.ALWAYSTTS ) then
            if string.GetChar(txt, 1) == '/' then return end
            txt = txt

            net.Start("PlayTTS")
                net.WriteString(txt)
                net.WriteEntity(ply)
            net.Broadcast()

        elseif string.sub(txt,1,4) == "/tts" then
        
            text = txt
            txt = string.Explode(" ", txt )
            text = string.Replace( text, txt[1], '')
            net.Start("PlayTTS")
                net.WriteString(text)
                net.WriteEntity(ply)
            net.Broadcast()
        end
    end)
else
    function urlencode( str )
        if (str) then
            str = string.gsub (str, "\n", "\r\n")
            str = string.gsub (str, "([^%w ])",
            function (c) return string.format ("%%%02X", string.byte(c)) end)
            str = string.gsub (str, " ", "+")
        end
        return str
    end

    local IGN = CreateClientConVar('ambi_tts_ignore', '0', true )

    net.Receive( "PlayTTS",function()
        if IGN:GetBool() then return end

        local text = net.ReadString()
        local ply = net.ReadEntity()

        text = urlencode( string.sub( text,1,240 ) )

        if ( ply:GetNWBool("ulx_muted") == false ) then
            sound.PlayURL( "https://translate.google.com/translate_tts?ie=UTF-8&q="..text.."&tl=ru&client=tw-ob", "mono", function(snd)
                if IsValid( snd ) then
                    snd:Set3DEnabled( true )
                    snd:SetVolume( 2 )
                    snd:Set3DFadeDistance( 40, 100 )
                    snd:SetPos( LocalPlayer():GetPos(), LocalPlayer():GetPos() )
                    snd:Play()
                    g_station = snd -- for gc
                end
            end )
        end
    end )
end