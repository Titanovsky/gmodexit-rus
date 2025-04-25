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

Add( 'status', TYPE, 'Изменить статус', 1, function( ePly, tArgs ) 
    local arg = tArgs[ 2 ]
    if not arg then return end
    if ( utf8.len( arg ) > 24 ) then ePly:ChatPrint( 'Не больше 24 символов' ) return end

    ePly:SetStatus( arg )
    ePly:ChatSend( C.AMBI, '[•] ', C.ABS_WHITE, 'Вы поменяли статус >> '..arg )
end )

Add( 'statuscolor', TYPE, 'Изменить цвет статуса: RED GREEN BLUE', 1, function( ePly, tArgs ) 
    local r = tArgs[ 2 ]
    if not r then ePly:ChatPrint( 'По примеру: 255 255 255' ) return end
    r = tonumber( r )
    if ( r < 0 ) or ( r > 255 ) then ePly:ChatPrint( 'Не меньше 0 и не больше 255' ) return end

    local g = tArgs[ 3 ]
    if not g then ePly:ChatPrint( 'По примеру: 255 255 255' ) return end
    g = tonumber( g )
    if ( g < 0 ) or ( g > 255 ) then ePly:ChatPrint( 'Не меньше 0 и не больше 255' ) return end

    local b = tArgs[ 4 ]
    if not b then ePly:ChatPrint( 'По примеру: 255 255 255' ) return end
    b = tonumber( b )
    if ( b < 0 ) or ( b > 255 ) then ePly:ChatPrint( 'Не меньше 0 и не больше 255' ) return end

    local color = Color( r, g, b )

    ePly:SetStatusColor( color )
    ePly:ChatSend( C.AMBI, '[•] ', C.ABS_WHITE, 'Вы поменяли цвет статуса' )
end )

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
    ePly:ChatPrint( 'К Аксесе обратитесь к администраторам!' )
end )

Add( 'tts', TYPE, 'Использование ттс, ключ. слова: on, off, ignore, voice', 0.25, function( ePly, tArgs, bTeamChat ) 
    local word = tArgs[ 2 ]
    if not word then return end
    if bTeamChat then return end

    if ( word == 'on' ) then ePly.tts_on = true ePly:ChatPrint( 'Auto TTS Включен!' ) return
    elseif ( word == 'off' ) then ePly.tts_on = nil ePly:ChatPrint( 'Auto TTS Выключен!' ) return
    elseif ( word == 'voice' ) then
        local arg = tArgs[ 3 ]
        if not arg then ePly:ChatPrint( 'Все голоса: google, zahar, ermil, oksana, alyss, omazh, jane' ) return end 
        arg = string.lower( arg )

        ePly.nw_TTSVoice = arg

        ePly:ChatPrint( 'Вы сменили голос на '..arg )
    
        return
    elseif ( word == 'ignore' ) then 
        local arg = tArgs[ 3 ]
        if not arg then ePly:RunCommand( 'ambi_tts_ignore 1' ) return end

        ePly:RunCommand( 'ambi_tts_ignore '..arg )

        return
    end

    local text = ''
    for i, word in ipairs( tArgs ) do
        if ( i == 1 ) then continue end
        local sep = ( i == 2 ) and '' or ' '
        text = text..sep..word
    end

    if string.StartWith( text, '/' ) then return end
    if string.StartWith( text, 'http' ) then return end
    if string.StartWith( text, 'www' ) then return end
    
    net.Start( 'ambi_rus_tts_start' )
        net.WriteString( text )
        net.WriteEntity( ePly )
    net.Broadcast()

    return
end )

Add( 'weapons', TYPE, 'Система сохранённого оружия/патронов: on, off, save, remove', 0.25, function( ePly, tArgs ) 
    local word = tArgs[ 2 ]
    if not word then return end

    if ( word == 'on' ) then ePly.disable_auto_weapons_give = nil ePly:ChatPrint( 'Auto Weapons Включено!' ) return
    elseif ( word == 'off' ) then ePly.disable_auto_weapons_give = true ePly:ChatPrint( 'Auto Weapons Выключено!' ) return
    elseif ( word == 'save' ) then
        Ambi.Rus.SaveWeapons( ePly )
        ePly:ChatPrint( 'Вы сохранили Оружие и Патроны' )
    
        return
    elseif ( word == 'remove' ) then Ambi.Rus.RemoveSaveWeapons( ePly ) ePly:ChatPrint( 'Вы удалили Оружие и Патроны' ) return
    end
end )

-- Add( 'gifts', TYPE, 'Сколько подарков', 1, function( ePly, tArgs ) 
--     local gifts = Ambi.SQL.Select( 'rus_gifts', 'Gifts', 'SteamID', ePly:SteamID() )
--     if not gifts then return end
    
--     ePly:ChatPrint( 'Вы собрали: '..gifts..' Подарок' )
-- end )

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

-- Тайный еврейский заговор

local CHAT = Ambi.UI.Chat.Send
Add( 'marry', 'Secret', 'Предложение руки и сердца', 55, function(ePly, tArgs)
    local another = ePly:GetEyeTrace().Entity

    if IsValid( another ) and another:IsPlayer() and ( another:GetPos():Distance( ePly:GetPos() ) < 150 ) then
        ePly:AddXP(350)
        another:AddXP(350)

        -- сообщение и выдача опыта "свидетелям"
        for k, v in ipairs( player.GetHumans() ) do
            if v == ePly and v == another then return end
            CHAT(v, C.ABS_PURPLE, ePly:Nick(), C.ABS_WHITE, ' сделал предложение руки и сердца игроку ', C.ABS_PURPLE, another:Nick(), C.ABS_WHITE, '! Мир да любовь!')
            if v:TestPVS(ePly) or v:TestPVS(another) then v:AddXP(50) end
        end

        -- еще одно сообщение
        CHAT(ePly, C.ABS_WHITE, 'Вы сделали предложение руки и сердца ', C.ABS_PURPLE, another:Nick() )
        CHAT(another, C.ABS_WHITE, 'Вы получили предложение руки и сердца от ', C.ABS_PURPLE, ePly:Nick() )
    else
        ePly:ChatPrint('Вы должны встать напротив другого игрока, чтобы сделать ему предложение!')
    end    
end, true)



-- ----------------------------------------------------------------------------------------------------
-- local TYPE = 'Рандомайза'

-- Add( 'random', TYPE, 'Вызвать рандомный Event', 1, function( ePly, tArgs ) 
--     Ambi.Rus.CallRandomizer( ePly, Ambi.Rus.GetRandomizer() )
-- end )

-- ----------------------------------------------------------------------------------------------------
local TYPE = 'Role Play'

Add( 'transfer', TYPE, 'Передать игроку напротив рубаксы', 0.55, function( ePly, tArgs ) 
    local another = ePly:GetEyeTrace().Entity
    
    if IsValid( another ) and another:IsPlayer() and ( another:GetPos():Distance( ePly:GetPos() ) < 84 ) then
        local amount = tArgs[ 2 ]
        if not amount then return end
        
        amount = tonumber( amount )
        if ( amount < 1 ) then ePly:ChatPrint( 'Нельзя передать отрицательную сумму' ) return end
        if ( ePly:GetMoney() < amount ) then ePly:ChatPrint( 'У вас недостаточно денег!' ) return end

        ePly:AddMoney( -amount )
        ePly:ChatPrint( 'Вы передали '..amount )

        another:AddMoney( amount )
        another:ChatPrint( 'Вы получили: '..amount )
    end
end )

-- ----------------------------------------------------------------------------------------------------
local TYPE = 'SimpleInventory'

Add( 'inv', TYPE, 'Открыть Инвентарь', 0.25, function( ePly, tArgs ) 
    ePly:RunCommand( 'ambi_sinv_open_inventory' )
end )

-- ----------------------------------------------------------------------------------------------------
local TYPE = 'WorldMessages'

Add( 'messages', TYPE, 'Включить/Выключить рендер World сообщений', 0.25, function( ePly, tArgs ) 
    local word = tArgs[ 2 ]
    if not word then word = 'on' end

    if ( word == 'on' ) then ePly:ChatPrint( 'Вы включили World Messages' ) ePly:RunCommand( 'ambi_rus_world_message_render 1' ) return
    elseif ( word == 'off' ) then ePly:ChatPrint( 'Вы выключили World Messages' ) ePly:RunCommand( 'ambi_rus_world_message_render 0' ) return
    end
end )

Add( 'write', TYPE, 'Написать сообщение', 1, function( ePly, tArgs ) 
    local text = ''
    for i, word in ipairs( tArgs ) do
        if ( i == 1 ) then continue end
        local sep = ( i == 2 ) and '' or ' '
        text = text..sep..word
    end

    Ambi.Rus.CreateWorldMessage( ePly, text )

    return true
end )