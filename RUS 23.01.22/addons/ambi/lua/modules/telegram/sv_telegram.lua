local C = AMB.Ambition.Global.Colors
local Fetch = http.Fetch
local URL = 'https://api.telegram.org/bot'
local STR = 'https://api.telegram.org/bot%s:%s/sendMessage?chat_id=%s&text=%s&parse_mode=html&reply_to_message_id'

local TITANOVSKY = '999998536'
local GR_CHAT, GR_LOGS_CONNECTS = '-1001596903444', '-1001559151116'
----------------------------------------------------------------------------------------------------------------

function AMB.Telegram.Send( sID, sToken, sChatID, sMessage )
    local id, token = sID or AMB.Telegram.Config.id, sToken or AMB.Telegram.Config.token
    sChatID, sMessage = sChatID or '999998536', sMessage or ''

    local str = Format( STR, id, token, sChatID, sMessage )
    Fetch( str )
end

function AMB.Telegram.GetLastMessage( sChatID, fAction )
    if timer.Exists( 'AmbTelegramDelayLastMessage' ) then return end
    local id, token = AMB.Telegram.Config.id, AMB.Telegram.Config.token
    local chat_id = sChatID and '?chat_id='..sChatID or ''

    Fetch( URL..id..':'..token..'/getUpdates'..chat_id, function( sBody )
        local tab = util.JSONToTable( sBody )
        
        local msg = {}
        if not msg then return end
        if not tab then return end
        if not tab.result then return end

        for i, v in ipairs( tab['result'] ) do
            if v.message and v.message.chat and ( v.message.chat.id == tonumber( sChatID ) ) then
                msg = v.message
            end
        end

        --print( '\n' )
        --PrintTable( msg )

        if fAction then fAction( msg ) end
    end )

    timer.Create( 'AmbTelegramDelayLastMessage', 0.05, 1, function() end )
end

function AMB.Telegram.GetCommands( sMsg )
 --todo
end

hook.Add( 'PlayerSay', 'AMB.Telegram.Log', function( ePly, sText )
    AMB.Telegram.Send( nil, nil, GR_CHAT, '<b>['..ePly:EntIndex()..'] ['..ePly:Gamename()..']</b> '..sText )
end )

local last_hash = ''
timer.Create( 'AmbTelegramReceiveChat', 0.05, 0, function()
    AMB.Telegram.GetLastMessage( GR_CHAT, function( tMsg )
        if not tMsg.text then return end

        if tMsg.text:StartWith( '/' ) then return end 
        local hash = util.CRC( tMsg.text )
        if hash == last_hash then return end

        last_hash = util.CRC( tMsg.text ) 
        
        local text = '[Telegram] ['..tMsg.from.first_name..'] '..tMsg.text
        print( text )

        for _, v in ipairs( player.GetAll() ) do
            v:ChatSend( C.FLAT_BLUE, '[Telegram] ', C.AMBITION, '['..tMsg.from.first_name..'] ', C.ABS_WHITE, tMsg.text )
        end
    end )
end )

hook.Add( 'PlayerInitialSpawn', 'AMB.Telegram.Log', function( ePly )
    local url = ePly:IsBot() and 'BOT' or '<a href="https://steamcommunity.com/profiles/'..ePly:SteamID64()..'/">'..ePly:SteamID()..'</a>'
    AMB.Telegram.Send( nil, nil, GR_LOGS_CONNECTS, '<b>['..ePly:EntIndex()..'] ['..ePly:Nick()..'] ('..url..', '..ePly:IPAddress()..') | Зашёл на сервер</b>' )
end )

hook.Add( 'PlayerDisconnected', 'AMB.Telegram.Log', function( ePly )
    local url = ePly:IsBot() and 'BOT' or '<a href="https://steamcommunity.com/profiles/'..ePly:SteamID64()..'/">'..ePly:SteamID()..'</a>'
    AMB.Telegram.Send( nil, nil, GR_LOGS_CONNECTS, '<b>[•] ['..ePly:Gamename()..'] ('..url..', '..ePly:IPAddress()..') | Вышел с сервера</b>' )
end )

hook.Add( 'CheckPassword', 'AMB.Telegram.Log', function( sSteamID64, sIP, _, _, sName )
    local url = '<a href="https://steamcommunity.com/profiles/'..sSteamID64..'/">'..util.SteamIDFrom64(sSteamID64)..'</a>'

    AMB.Telegram.Send( nil, nil, GR_LOGS_CONNECTS, '<b>[•] ['..sName..'] ('..url..', '..sIP..') | Подключается на сервер</b>' )
end )

hook.Add( 'AmbitionAccountAuthorization', 'AMB.Telegram.Log', function( ePly, bNew )
    local url = '<a href="https://steamcommunity.com/profiles/'..ePly:SteamID64()..'/">'..ePly:SteamID()..'</a>'
    local new = bNew and '<i>впервые</i>' or ''
    AMB.Telegram.Send( nil, nil, GR_LOGS_CONNECTS, '<b>['..ePly:EntIndex()..'] ['..ePly:Nick()..'] ('..url..', '..ePly:IPAddress()..') | Авторизовался '..new..'</b>' )
end )

--------------------------------------------------------------------------------------------------------------------------------
--[[
local JSON = util.JSONToTable
local TRELLO_API, TRELLO_TOKEN = '1ca9a6167d50e5f6ce864f80d583d1aa', '0cc1889f0897afc1fe5707b9c7871ddf47d359c4a6dabb7d4d04cffbca295be9'
local TRELLO_URL = 'https://api.trello.com/1/members/me/boards?key='..TRELLO_API..'&token='..TRELLO_TOKEN
local TRELLO_ID = '5c6928e6d6e2703d9cbadf76' -- ID канала, 4 по номеру
local TRELLO_CARD_SEND, TRELLO_CARD_RECEIVE = '614ed6fb7b5e2741718834ee', '614ed6fc670ea66207b20254'
local URLStr = string.URLEncode

local function WriteCard( sID, sName, sDesc )
    local _url = Format( 'https://api.trello.com/1/cards/%s?key=%s&token=%s&name=%s&desc=%s', sID, TRELLO_API, TRELLO_TOKEN, URLStr( sName ), URLStr( sDesc ) )

    HTTP({
        method = 'PUT',
        url = _url,
    })
end

local function GetCard( sID, fAction )
    local _url = Format( 'https://api.trello.com/1/cards/%s?key=%s&token=%s', sID, TRELLO_API, TRELLO_TOKEN )

    http.Fetch( _url, function( sBody ) 
        local data = JSON( sBody or '[]' )
        if fAction then fAction( data ) end
    end )
end

hook.Add( 'PlayerSay', 'AMB.Trello.Log', function( ePly, sText )
    WriteCard( '614ed6fb7b5e2741718834ee', ePly:Gamename(), sText )
end )

local cache_author, cache_msg = ''
timer.Create( 'AmbTrelloCheckDiscord', 0.33, 0, function()
    GetCard( TRELLO_CARD_RECEIVE, function( tCard )
        local name, msg = tCard.name, tCard.desc
        if ( name == cache_author ) and ( msg == cache_msg ) then return end

        cache_author, cache_msg = name, msg
        if not msg then return end
        local text = '[Discord] ['..name..'] '..msg
        print( text )

        for _, v in ipairs( player.GetAll() ) do
            v:ChatSend( C.AMB_PURPLE, '[Discord] ', C.AMBITION, '['..name..'] ', C.ABS_WHITE, msg )
        end
    end )
end )

local TRELLO_CARD_LOGS_CHECK = '614efbd9f5ad57812c1a0288'
hook.Add( 'CheckPassword', 'AMB.Trello.Log', function( sSteamID64, sIP, _, _, sName )
    local url = '<a href="https://steamcommunity.com/profiles/'..sSteamID64..'/">'..util.SteamIDFrom64(sSteamID64)..'</a>'

    WriteCard( TRELLO_CARD_LOGS_CHECK, os.time(), ':white_check_mark: '..sName..' **подключается** к серверу ('..util.SteamIDFrom64(sSteamID64)..')\n\n'..os.date('**%X**', os.time() )..'\nhttps://steamcommunity.com/profiles/'..sSteamID64..'/' )
end )

local TRELLO_CARD_LOGS_DISCONNECT = '614f01e5cc865088f00729e7'
hook.Add( 'PlayerDisconnected', 'AMB.Trello.Log', function( ePly )
    WriteCard( TRELLO_CARD_LOGS_DISCONNECT, os.time(), ':no_entry: '..ePly:Gamename()..' **вышел** из сервера ('..ePly:SteamID()..')\n\n'..os.date('**%X**', os.time())..'\nhttps://steamcommunity.com/profiles/'..ePly:SteamID64()..'/' )
end )
]]--