local C = Ambi.General.Global.Colors

require 'chttp'

-- local API = 'https://discord.com/api'
-- local TOKEN = 'ODA1Mzc3NTYzMjYyMDU4NDk2.YBaATg.F7qdeCqnuPhwCYse0jqLRhjU5dI'

-- local function ReceiveLastMessage( nChannelID, fCallback )
--     CHTTP( {
--         url = 'https://discord.com/api/channels/'..nChannelID..'/messages?limit=1',
--         method = 'GET',
--         success = function( nCode, sBody, tHeaders )
--             if not sBody then return end
--             local msg = util.JSONToTable( sBody )[ 1 ]
            
--             fCallback( msg )
--         end,
--         failed = function( sReason ) print( 'ERROR CHTTP: '..sReason ) end,
--         headers = {
--             [ 'Authorization' ] = 'Bot '..TOKEN,
--             [ 'Content-Type' ] = 'application/json'
--         },
--     } )
-- end

-- local function SendMessage( nChannelID, sText )
--     CHTTP( {
--         url = 'https://discord.com/api/channels/'..nChannelID..'/messages',
--         method = 'POST',
--         success = function( nCode, sBody, tHeaders )
--         end,
--         failed = function( sReason ) print( 'ERROR CHTTP: '..sReason ) end,
--         headers = {
--             [ 'Authorization' ] = 'Bot '..TOKEN,
--             [ 'Content-Type' ] = 'application/json'
--         },
--         body = util.TableToJSON( {
--             content = sText
--         }),
--         type = 'application/json'
--     } )
-- end

-- local CHANNEL = '839654371813097502'
-- local DISCORD_LAST_AUTHOR, DISCORD_LAST_TEXT = '', ''
-- timer.Create( 'AmbiRusCheckDiscord', 1, 0, function()
--     ReceiveLastMessage( CHANNEL, function( tMsg )
--         if not tMsg then return end
--         local author_id, text = tMsg.author.id, tMsg.content 
--         if ( author_id == DISCORD_LAST_AUTHOR ) and ( text == DISCORD_LAST_TEXT ) then return end
    
--         if ( author_id == '475626347952209920' ) and ( text[ 1 ] == '/' ) then
--             local cmd = string.sub( text, 2, #text )

--             DISCORD_LAST_AUTHOR, DISCORD_LAST_TEXT = author_id, text
            
--             return RunConsoleCommand( 'ulx', 'rcon', cmd )
--         end

--         if ( author_id == '805377563262058496' ) then return end -- Чтобы бот свои сообщения не читал, так как он двусторонний
    
--         for _, ply in ipairs( player.GetAll() ) do
--             ply:ChatSend( C.AMBI_PURPLE, '[Discord] ', C.ABS_WHITE, '['..tMsg.author.username..'] '..text )
--         end

--         print( '[Discord] ['..tMsg.author.username..'] '..text )
--         DISCORD_LAST_AUTHOR, DISCORD_LAST_TEXT = author_id, text
--     end )
-- end )

-- hook.Add( 'PlayerSay', 'Ambi.Rus.DiscordBot', function( ePly, sText ) 
--     if timer.Exists( 'StopFloodInDiscord:'..ePly:SteamID() ) then return end
--     timer.Create( 'StopFloodInDiscord:'..ePly:SteamID(), 0.36, 1, function() end )

--     timer.Simple( 0.35, function() SendMessage( CHANNEL, '**['..ePly:Nick()..']** '..sText ) end )
-- end )

-- local LAST_CONNECTED = false
-- hook.Add( 'CheckPassword', 'Ambi.Rus.DiscordBot', function( sSteamID64, sIP, _, _, sName ) 
--     if ( LAST_CONNECTED == sSteamID64 ) then return end
--     LAST_CONNECTED = sSteamID64 

--     local time = os.time()

--     timer.Simple( 2, function()
--         SendMessage( '891271855820910592', string.format( [[✅ Подключается ```lua
--         SteamID: '%s'
--         IP: '%s'
--         Name: '%s'
--         Time: '%s'```
--         %s]], --util.SteamIDFrom64( sSteamID64 ), sIP, sName, os.date( '%X  %d.%m.%Y', time ), 'https://steamcommunity.com/profiles/'..sSteamID64 ) )

--        LAST_CONNECTED = false
--     end )
-- end )

-- local LAST_DISCONNECTED = false
-- hook.Add( 'PlayerDisconnected', 'Ambi.Rus.DiscordBot', function( ePly ) 
--     if ( LAST_DISCONNECTED == ePly:SteamID() ) then return end
--     LAST_DISCONNECTED = ePly:SteamID()

--     local time = os.time()
--     local sid, ip, nick, sid64 = ePly:SteamID(), ePly:IPAddress(), ePly:Nick(), ePly:SteamID64()

--     timer.Simple( 2, function()
--         SendMessage( '891271855820910592', string.format( [[❌ Отключился ```lua
--         SteamID: '%s'
--         IP: '%s'
--         Name: '%s'
--         Time: '%s'```
--         %s]], --sid, ip, nick, os.date( '%X  %d.%m.%Y', time ), 'https://steamcommunity.com/profiles/'..sid64 ) )

--         LAST_DISCONNECTED = false
--     end )
-- end )

-- hook.Add( 'PlayerInitialSpawn', 'Ambi.Rus.DiscordBot', function( ePly ) 
--     local time = os.time()

--     timer.Simple( 2, function()
--         if not IsValid( ePly ) then return end

--         SendMessage( '891271855820910592', string.format( [[⭐ Инициализировался ```lua
--         SteamID: '%s'
--         IP: '%s'
--         Name: '%s'
--         Time: '%s'```
--        %s]], ePly:SteamID(), ePly:IPAddress(), ePly:Nick(), os.date( '%X  %d.%m.%Y', time ), 'https://steamcommunity.com/profiles/'..ePly:SteamID64() ) )
--     end )
-- end )