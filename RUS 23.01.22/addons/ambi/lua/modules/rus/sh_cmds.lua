local C = Ambi.General.Global.Colors
local Add = Ambi.ChatCommands.AddCommand

-- ----------------------------------------------------------------------------------------------------
local URLS = {
    VK = 'https://vk.com/ambgmod',
    STEAM = 'https://steamcommunity.com/groups/ambiteam',
    DISCORD = 'https://discord.gg/G4vzxrq',
    CONTENT = 'https://steamcommunity.com/sharedfiles/filedetails/?id=2041976090',
}

-- ----------------------------------------------------------------------------------------------------
local TYPE = 'Main'

Add( 'limit', TYPE, 'Показать лимиты', 0.22, function( ePly, tArgs ) 
    ePly:RunCommand( 'ambi_rus_limits' )
end )

Add( 'roll', TYPE, 'Кинуть кубик [0;100]', 0.22, function( ePly, tArgs ) 
    ePly:Say( '/me бросил кубик и получил '..math.random( 0, 100 ) )
end )

Add( 'runspeed', TYPE, 'Подать скорости бега', 0.22, function( ePly, tArgs ) 
    if ePly:Team() ~= RUS_TEAM_BUILD then return end
    if not tArgs[ 2 ] then return end

    local speed = tonumber( tArgs[ 2 ] )
    if ( speed > 1600 ) then return end
    if ( speed < 0 ) then return end

    ePly:SetRunSpeed( speed )
end )

Add( 'суп', TYPE, 'Включить Анимацию', 0.01, function( ePly, tArgs ) 
    net.Start( 'ambi_rus_soup' )
        net.WriteUInt( tonumber( tArgs[ 2 ] ), 20 )
        net.WriteEntity( ePly )
    net.Broadcast()
end )

Add( 'access', TYPE, 'Получить Аксесу', 1, function( ePly, tArgs ) 
    ePly:ChatPrint( 'Из-за долбоёбов теперь не выдаю, отсосите моим замам - ExtraDip или Оксиду и получитет Аксесу' )
end )

Add( 'gifts', TYPE, 'Сколько подарков', 1, function( ePly, tArgs ) 
    local gifts = Ambi.SQL.Select( 'rus_gifts', 'Gifts', 'SteamID', ePly:SteamID() )
    if not gifts then return end
    
    ePly:ChatPrint( 'Вы собрали: '..gifts..' Подарок' )
end )

-- ----------------------------------------------------------------------------------------------------
local TYPE = 'Teams'

Add( 'build', TYPE, 'Стать Build', 2, function( ePly, tArgs ) 
    ePly:ChangeTeam( 'build' )
    ePly:Spawn()
end )

Add( 'pvp', TYPE, 'Стать PVP', 2, function( ePly, tArgs ) 
    ePly:ChangeTeam( 'pvp' )
    ePly:Spawn()
end )

Add( 'rp', TYPE, 'Стать RP', 2, function( ePly, tArgs ) 
    ePly:ChangeTeam( 'rp' )
    ePly:Spawn()
end )

-- ----------------------------------------------------------------------------------------------------
local TYPE = 'Time'

--[[
Add( 'timevotemap', TYPE, 'Показать лимиты', 0.22, function( ePly, tArgs )
    local time = math.floor( timer.TimeLeft( 'AmbTimer[AmbVoteMap]' ) / 60 )
    ePly:ChatSend( C.AMBITION, '[•] ', C.ABS_WHITE, 'Осталось ', C.AMBITION, tostring( time ), C.ABS_WHITE, ' минут(ы) до Голосования на Смену Карты' )
end )
]]--

-- ----------------------------------------------------------------------------------------------------
local TYPE = 'URLS'

Add( 'rule', TYPE, 'Правила сервера', 0.15, function( ePly, tArgs ) 
    ePly:ChatSend( C.AMBI, '[•] ', C.ABS_WHITE, 'Одно единственное правило — не мешать остальным игрокам!' ) 
end )

Add( 'vk', TYPE, 'ВК группа сервера', 0.15, function( ePly, tArgs ) 
    ePly:SendLua( 'gui.OpenURL("'..URLS.VK..'")' ) 
end )

Add( 'steam', TYPE, 'Steam группа сервера', 0.15, function( ePly, tArgs ) 
    ePly:SendLua( 'gui.OpenURL("'..URLS.STEAM..'")' ) 
end )

Add( 'discord', TYPE, 'Discord сервера', 0.15, function( ePly, tArgs ) 
    ePly:SendLua( 'gui.OpenURL("'..URLS.DISCORD..'")' ) 
end )

Add( 'content', TYPE, 'Основной контент сервера', 0.15, function( ePly, tArgs ) 
    ePly:SendLua( 'gui.OpenURL("'..URLS.CONTENT..'")' ) 
end )

Add( 'content2', TYPE, 'Побочный контент сервера', 0.15, function( ePly, tArgs ) 
    ePly:SendLua( 'gui.OpenURL("'..URLS.CONTENT2..'")' ) 
end )

-- ----------------------------------------------------------------------------------------------------

local ACCESS = { 
    [ 'STEAM_0:1:95303327' ] = true,
    [ 'STEAM_0:0:164590602' ] = true,
    [ 'STEAM_0:0:426598565' ] = true,
}

Add( 'sf', 'Starfall', 'Релоднуть старфальского', 0.25, function( ePly, tArgs ) 
	if ACCESS[ ePly:SteamID() ] then RunConsoleCommand( 'sf_reload_amb' ) end
end )

-- ----------------------------------------------------------------------------------------------------
local TYPE = 'Рандомайза'

Add( 'random', TYPE, 'Вызвать рандомный Event', 1, function( ePly, tArgs ) 
    Ambi.Rus.CallRandomizer( ePly, Ambi.Rus.GetRandomizer() )
end )