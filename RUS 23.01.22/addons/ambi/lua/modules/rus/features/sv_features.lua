local C = Ambi.General.Global.Colors

local last_msg_string, last_msg_date = '', os.time()
hook.Add( 'CanTool', 'Ambi.Rus.LogTools', function( ePly, _, sTool )
    local message = '[Tools] '..ePly:Name()..'('..ePly:SteamID()..') use '..sTool
    if ( last_msg_string == message ) and ( os.time() >= last_msg_date ) then
        print( '[Tools] '..ePly:Name()..'('..ePly:SteamID()..') use '..sTool )
        last_msg_string, last_msg_date = message, os.time() + 60
    end
end )


/*
require 'chttp'
local API = 'https://discord.com/api'
local TOKEN = 'ODA1Mzc3NTYzMjYyMDU4NDk2.YBaATg.F7qdeCqnuPhwCYse0jqLRhjU5dI'

local function ReceiveLastMessage( nChannelID, fCallback )
    CHTTP( {
        url = 'https://discord.com/api/channels/'..nChannelID..'/messages?limit=1',
        method = 'GET',
        success = function( nCode, sBody, tHeaders )
            if not sBody then return end
            local msg = util.JSONToTable( sBody )[ 1 ]
            
            fCallback( msg )
        end,
        failed = function( sReason ) print( 'ERROR CHTTP: '..sReason ) end,
        headers = {
            [ 'Authorization' ] = 'Bot '..TOKEN,
            [ 'Content-Type' ] = 'application/json'
        },
    } )
end

local function SendMessage( nChannelID, sText )
    CHTTP( {
        url = 'https://discord.com/api/channels/'..nChannelID..'/messages',
        method = 'POST',
        success = function( nCode, sBody, tHeaders )
        end,
        failed = function( sReason ) print( 'ERROR CHTTP: '..sReason ) end,
        headers = {
            [ 'Authorization' ] = 'Bot '..TOKEN,
            [ 'Content-Type' ] = 'application/json'
        },
        body = util.TableToJSON( {
            content = sText
        }),
        type = 'application/json'
    } )
end

local CHANNEL = '839654371813097502'
local DISCORD_LAST_AUTHOR, DISCORD_LAST_TEXT = '', ''
timer.Create( 'AmbiRusCheckDiscord', 1, 0, function()
    ReceiveLastMessage( CHANNEL, function( tMsg )
        if not tMsg then return end
        local author_id, text = tMsg.author.id, tMsg.content 
        if ( author_id == DISCORD_LAST_AUTHOR ) and ( text == DISCORD_LAST_TEXT ) then return end
    
        if ( author_id == '475626347952209920' ) and ( text[ 1 ] == '/' ) then
            local cmd = string.sub( text, 2, #text )

            DISCORD_LAST_AUTHOR, DISCORD_LAST_TEXT = author_id, text
            
            return RunConsoleCommand( 'ulx', 'rcon', cmd )
        end

        if ( author_id == '805377563262058496' ) then return end -- Чтобы бот свои сообщения не читал, так как он двусторонний
    
        for _, ply in ipairs( player.GetAll() ) do
            ply:ChatSend( C.AMBI_PURPLE, '[Discord] ', C.ABS_WHITE, '['..tMsg.author.username..'] '..text )
        end

        print( '[Discord] ['..tMsg.author.username..'] '..text )
        DISCORD_LAST_AUTHOR, DISCORD_LAST_TEXT = author_id, text
    end )
end )

hook.Add( 'PlayerSay', 'Ambi.Rus.DiscordBot', function( ePly, sText ) 
    if timer.Exists( 'StopFloodInDiscord:'..ePly:SteamID() ) then return end
    timer.Create( 'StopFloodInDiscord:'..ePly:SteamID(), 0.36, 1, function() end )

    timer.Simple( 0.35, function() SendMessage( CHANNEL, '**['..ePly:Nick()..']** '..sText ) end )
end )

local LAST_CONNECTED = false
hook.Add( 'CheckPassword', 'Ambi.Rus.DiscordBot', function( sSteamID64, sIP, _, _, sName ) 
    if ( LAST_CONNECTED == sSteamID64 ) then return end
    LAST_CONNECTED = sSteamID64 

    local time = os.time()

    timer.Simple( 2, function()
        SendMessage( '891271855820910592', string.format( [[✅ Подключается ```lua
        SteamID: '%s'
        IP: '%s'
        Name: '%s'
        Time: '%s'```
        %s]], util.SteamIDFrom64( sSteamID64 ), sIP, sName, os.date( '%X  %d.%m.%Y', time ), 'https://steamcommunity.com/profiles/'..sSteamID64 ) )

        LAST_CONNECTED = false
    end )
end )

local LAST_DISCONNECTED = false
hook.Add( 'PlayerDisconnected', 'Ambi.Rus.DiscordBot', function( ePly ) 
    if ( LAST_DISCONNECTED == ePly:SteamID() ) then return end
    LAST_DISCONNECTED = ePly:SteamID()

    local time = os.time()
    local sid, ip, nick, sid64 = ePly:SteamID(), ePly:IPAddress(), ePly:Nick(), ePly:SteamID64()

    timer.Simple( 2, function()
        SendMessage( '891271855820910592', string.format( [[❌ Отключился ```lua
        SteamID: '%s'
        IP: '%s'
        Name: '%s'
        Time: '%s'```
        %s]], sid, ip, nick, os.date( '%X  %d.%m.%Y', time ), 'https://steamcommunity.com/profiles/'..sid64 ) )

        LAST_DISCONNECTED = false
    end )
end )

hook.Add( 'PlayerInitialSpawn', 'Ambi.Rus.DiscordBot', function( ePly ) 
    local time = os.time()

    timer.Simple( 2, function()
        if not IsValid( ePly ) then return end

        SendMessage( '891271855820910592', string.format( [[⭐ Инициализировался ```lua
        SteamID: '%s'
        IP: '%s'
        Name: '%s'
        Time: '%s'```
        %s]], ePly:SteamID(), ePly:IPAddress(), ePly:Nick(), os.date( '%X  %d.%m.%Y', time ), 'https://steamcommunity.com/profiles/'..ePly:SteamID64() ) )
    end )
end )

*/

-----------------------------------------------------------------------------------
local times = {
    [ 'day' ] = {
        pattern = 'l', 
        topcolor = '0.27 0.55 0.98', 
        bottomcolor = '0.67 0.75 0.97',
        duskcolor = '0.47 0.68 0.98',
        duskscale = '1.00',
        fadebias = '1.00',
        sunsize = '0.00',
        suncolor = '0.00 0.00 0.00',
        drawstars = '0',
        startexture = 'skybox/starfield',
        starslayers = '0',
        starscale = '0.00 0.00 0.00',
        starfade = '0.00 0.00 0.00',
        starspeed = '0.00 0.00 0.00'
    },

    [ 'night' ] = {
        pattern = 'a', 
        topcolor = '0.00 0.00 0.00', 
        bottomcolor = '0.01 0.01 0.01',
        duskcolor = '0.00 0.00 0.00',
        duskscale = '1.00',
        fadebias = '0.32',
        sunsize = '0.00',
        suncolor = '0.00 0.00 0.00',
        drawstars = '1',
        startexture = 'skybox/starfield',
        starslayers = '2',
        starscale = '0.90',
        starfade = '1.50',
        starspeed = '0.01'
    },

    [ 'sundown' ] = {
        pattern = 'f', 
        topcolor = '0.69 0.53 0.45', 
        bottomcolor = '0.26 0.13 0.05',
        duskcolor = '0.63 0.27 0.04',
        duskscale = '1.24',
        fadebias = '1.00',
        sunsize = '2.00',
        suncolor = '1.00 0.56 0.00',
        drawstars = '0',
        startexture = 'skybox/starfield',
        starslayers = '2',
        starscale = '0.90',
        starfade = '1.50',
        starspeed = '0.01'
    },

    [ 'christmas' ] = {
        pattern = 'b',
        topcolor = '0.00 0.00 0.00', 
        bottomcolor = '0.00 0.00 0.02',
        duskcolor = '0.00 0.00 0.02',
        duskscale = '1.00',
        duskintensity = '1.00',
        fadebias = '1.00',
        sunsize = '0.00',
        drawstars = '1',
        startexture = 'skybox/starfield',
        starslayers = '2',
        starscale = '1.45',
        starfade = '1.45',
        starspeed = '0.01'
    }

}
local time_s = 0
local time_m = 0
local time_h = 0
local time_d = 1

function Ambi.Rus.SetTimeEnvironment( sTime )
    sTime = string.lower( sTime )

    local tab = times[ sTime ]
    local light_env = Ambi.Rus.FindLightEnvironment()
    local skypaint = Ambi.Rus.FindEnvSkyPaint()

    if light_env then light_env:Fire( 'setpattern', tab.pattern ) end

    for k, v in pairs( tab ) do
        if ( k == 'pattern' ) then continue end

        skypaint:SetKeyValue( k, v )
    end
end

function Ambi.Rus.FindLightEnvironment()
    for _, ent in pairs( ents.FindByClass( 'light_environment' ) ) do
        return ent
    end

    return false
end

function Ambi.Rus.FindEnvSkyPaint()
    for _, ent in pairs( ents.FindByClass( 'env_skypaint' ) ) do
        return ent
    end

    local new_ent = ents.Create( 'env_skypaint' )
    new_ent:SetPos( Vector( 0, 0, 0 ) )
    new_ent:SetAngles( Angle( 0, 0, 0 ) )
    new_ent:Spawn()

    return new_ent
end

--hook.Add( 'InitPostEntity', 'Ambi.Rus.SetTime', function()
    --Ambi.Rus.SetTimeEnvironment( 'Day' )

    --Ambi.Rus.start_time = true
--end )

local delay = 0

--hook.Add( 'Think', 'Ambi.Rus.SetTime', function() 
    --[[
    if ( delay >= CurTime() ) then return end
    if not AmbTimeCycle.start_time then return end

    delay = CurTime() + 2 -- 48 минут = 1 игровые сутки

    AmbTimeCycle.time_m = AmbTimeCycle.time_m + 1

    if ( AmbTimeCycle.time_m >= 60 ) then

        AmbTimeCycle.time_m = 0
        AmbTimeCycle.time_h = AmbTimeCycle.time_h + 1

    end

    if ( AmbTimeCycle.time_h >= 24 ) then

        AmbTimeCycle.time_h = 0
        AmbTimeCycle.time_d = AmbTimeCycle.time_d + 1

    end
    
    if ( AmbTimeCycle.time_h == 20 ) then AmbTimeCycle.SetTimeEnvironment( 'night' ) -- до 8 минут
    elseif ( AmbTimeCycle.time_h == 18 ) then AmbTimeCycle.SetTimeEnvironment( 'sundown' ) -- до 4 минут
    elseif ( AmbTimeCycle.time_h == 2 ) then AmbTimeCycle.SetTimeEnvironment( 'day' ) -- до 32 минут
    elseif ( AmbTimeCycle.time_h == 0 ) then AmbTimeCycle.SetTimeEnvironment( 'sundown' ) -- до 4 минут
    end
    ]]--
--end )