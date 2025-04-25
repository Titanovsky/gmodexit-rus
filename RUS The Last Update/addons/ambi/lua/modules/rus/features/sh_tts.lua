if SERVER then
    util.AddNetworkString( 'ambi_rus_tts_start' )

    hook.Add( 'PlayerSay', 'Ambi.Rus.TTSOn',function( ePly, sText, bTeamChat )
        if not ePly.tts_on then return end
        
        if bTeamChat then return end

        if ( string.GetChar( sText, 1 ) == '/' ) then return end
        if string.StartWith( sText, 'http' ) then return end
        if string.StartWith( sText, 'www' ) then return end

        net.Start( 'ambi_rus_tts_start' )
            net.WriteString( sText )
            net.WriteEntity( ePly )
        net.Broadcast()
    end )

    return
end 

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

net.Receive( 'ambi_rus_tts_start', function()
    if IGN:GetBool() then return end

    local text = net.ReadString()
    if not text then return end

    local ply = net.ReadEntity()
    if not ply then return end
    if ply:GetNWBool( 'ulx_muted' ) then return end

    --text = urlencode( string.sub( text,1,240 ) )
    text = urlencode( text )

    local url
    local voice = ply.nw_TTSVoice
    
    if not voice or ( voice == 'google' ) or ( voice == '0' ) or ( voice == 0 ) then
        url = 'https://translate.google.com/translate_tts?ie=UTF-8&q='..text..'&tl=ru&client=tw-ob'
    else
        url = 'http://tts.voicetech.yandex.net/tts?speaker='..voice..'&text='..text
    end

    sound.PlayURL( url, 'mono', function(snd)
        if not IsValid( snd ) then return end

        snd:Set3DEnabled( true )
        snd:SetVolume( 2 )
        snd:Set3DFadeDistance( 40, 100 )
        snd:SetPos( LocalPlayer():GetPos(), LocalPlayer():GetPos() )
        snd:Play()
        g_station = snd -- for gc
    end )
end )