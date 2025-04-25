--[[
	Основная информация про игрока.
	Сервер находится в полном подчинений проекта: [ Ambition ]

    -- Расчёт LVL

    • 1 payday = 10 min
    • После LVL теряется EXP

    LVL | MaxExp | Min(H) or Payday | All
    1 | LVL+2 | 20 min (0.4)    | 20 (0.4)
    2 | 4 | 40 min (0.8)        | 60 (1)
    3 | 6 | 60 min (1)          | 120 (2)
    4 | 8 | 80 min (1.4)        | 200 (3.4)
    5 | 10 | 100 min (1.8)      | 300 (5)
    6 | 12 | 120 min (2)        | 420 (7)
    7 | 14 | 140 min (2.4)      | 560 (9.4)
    8 | 16 | 160 min (2.8)      | 720 (12)
    9 | 18 | 180 min (3)        | 900 (15)
    10 | 20 | 200 min (3.4)     | 1100 (18.4)

	[24.07.20]
		• Первая версия основной инфы про игрока (регистрация персонажа).
        • За 2:13:05 сделал первую логику. Таблицы SQLlite, вывод/ввод, сохранение, изменение, проверки, создание.
	.
    [27.07.20]
		• Начал делать под ULX ранг с временем. Надо проверить, правильно ли os.difftime() сделал.
        • Нет, всё-таки неправильно, но изменил немного в ULX файле.
        • Сделал Teams, вроде закончил.
    .
    [31.07.20]
        • Пофиксил ремув юзера в ULX.
    .
    [07.08.20]
        • Появилась непонятная дичь, которая вайпает lvl, exp и money у игроков, хз что такое(( Ошибок нет
    .
    [09.08.20]
        • Не выдержал и решил всю ночь перепилить обработку данных.
    .
    [17.08.20]
        • Решил влить сюда DarkRP, надеюсь всё получится.        
    .
    [13.10.20]
        • Добавил, чтобы боты сразу переводились в РП режим.
        • Совсем чуть-чуть поправил стиль.
    .
]]

AmbStats = AmbStats or {}
AmbStats.Players = AmbStats.Players or {}

local file  = file
local os    = os
local print = print
local sql   = sql

local amb_db_players        = 'amb_db_players'
local amb_db_players_stats  = 'amb_db_players_stats'
local amb_db_players_ranks  = 'amb_db_players_ranks'
local amb_db_players_darkrp = 'amb_db_players_darkrp'

local start_money_sandbox = 600
local start_level = 1
local start_exp = 0

local function s( string, num )

    if not num then num = 0 end

    return sql.SQLStr( string, tobool( num ) )

end

AmbDB.createDataBase( amb_db_players, [[
    'ID' varchar(255) NOT NULL PRIMARY KEY,
    'Nick' varchar(255),
    'IP' varchar(255),
    'Reg_Date' varchar(255),
    'Reg_Last' varchar(255),
    'IP_Last' varchar(255)]]
)

AmbDB.createDataBase( amb_db_players_stats, [[
    'ID' varchar(255) NOT NULL PRIMARY KEY,
    'Name' varchar(255),

    'Bio_Essensia' bigint,
    'Level' smallint,
    'Exp' smallint,

    'Skin' varchar(255),
    'Tribe' varchar(255)]]
)

function AmbStats.Players.authorizationPlayer( ePly )
    MsgN('[AmbStats] Player: '..ePly:Nick()..' start initialization!')

    if ( ePly.authorized ) then
        return MsgN('[AmbStats] Player: '..AmbStats.Players.getStats( ePly, 'name' )..' end initialization!')
    end

    if ( AmbDB.selectDate( amb_db_players, 'ID', 'ID', ePly:SteamID() ) == ePly:SteamID() ) then
        AmbStats.Players.initialPlayer( ePly )
    else
        AmbStats.Players.registerPlayer( ePly )
    end

    MsgN('[AmbStats] Player: '..AmbStats.Players.getStats( ePly, 'name' )..' end initialization!')
end

function AmbStats.Players.registerPlayer( ePly )

    if ( AmbDB.selectDate( amb_db_players, 'ID', 'ID', ePly:SteamID() ) == ePly:SteamID() ) then
        MsgN( '  !  [AmbStats] Player has registration: '..ePly:Nick() )
        ePly:ChatPrint('You have account on server!')
    else
        local date = os.date( '%c', os.time() )
        local query = Format( "%s, %s, %s, %s, %s, %s", sql.SQLStr(ePly:SteamID()), sql.SQLStr(ePly:Nick()), sql.SQLStr(ePly:IPAddress()), sql.SQLStr(date), sql.SQLStr(date), sql.SQLStr(ePly:IPAddress()) )
        AmbDB.insertDate( amb_db_players, "ID, Nick, IP, Reg_Date, Reg_Last, IP_Last", query )

        local query_two = nil
        query_two = Format( "%s, %s, %f, %f, %f, %s, %s", s( ePly:SteamID() ), s( ePly:GetNWString('amb_players_name') ), start_money_sandbox, start_level, start_exp, s( ePly:GetNWString('amb_players_skin') ), s( ePly:GetNWString('amb_players_tribe') ) )
        AmbDB.insertDate( amb_db_players_stats, "ID, Name, Bio_Essensia, Level, Exp, Skin, Tribe", query_two )

        MsgN( '[AmbStats] New player registration: '..AmbStats.Players.getStats( ePly, 'name' ) )

        AmbStats.Players.initialPlayer( ePly )
    end
end

function AmbStats.Players.initialPlayer( ePly )

    if ( AMB.config.gamemode == "Sandbox" ) then

        if ( AmbDB.selectDate( amb_db_players_stats, 'ID', 'ID', ePly:SteamID() ) == ePly:SteamID() ) and not ePly.authorized then
            local name = AmbDB.selectDate( amb_db_players_stats, 'Name', 'ID', ePly:SteamID() )
            local money = AmbDB.selectDate( amb_db_players_stats, 'Bio_Essensia', 'ID', ePly:SteamID() )
            local level = AmbDB.selectDate( amb_db_players_stats, 'Level', 'ID', ePly:SteamID() )
            local exp = AmbDB.selectDate( amb_db_players_stats, 'Exp', 'ID', ePly:SteamID() )
            local skin = AmbDB.selectDate( amb_db_players_stats, 'Skin', 'ID', ePly:SteamID() )
            local tribe = AmbDB.selectDate( amb_db_players_stats, 'Tribe', 'ID', ePly:SteamID() )

            local nation = AmbDB.selectDate( amb_db_players_darkrp, 'Nation', 'ID', ePly:SteamID() ) -- rp
            local sex = AmbDB.selectDate( amb_db_players_darkrp, 'Sex', 'ID', ePly:SteamID() ) -- rp
            local age = AmbDB.selectDate( amb_db_players_darkrp, 'Age', 'ID', ePly:SteamID() ) -- rp


            ePly:SetNWFloat( 'amb_players_tribe', tribe )
            ePly:SetNWString( 'amb_players_name', name )
            ePly:SetNWFloat( 'amb_players_money', money )
            ePly:SetNWFloat( 'amb_players_level', level )
            ePly:SetNWFloat( 'amb_players_exp', exp )
            ePly:SetNWFloat( 'amb_players_max_exp', level * 2 )
            ePly:SetNWString( 'amb_players_skin', skin )

            ePly:SetNWString( 'amb_players_nation', nation )
            ePly:SetNWString( 'amb_players_sex', sex )
            ePly:SetNWFloat( 'amb_players_age', age )

            ePly:SetModel( ePly:GetNWString( 'amb_players_skin') )
            AmbStats.Players.limitCalc( ePly )


            AmbStats.Players.giveAccessE2( ePly )

            for k, v in pairs( player.GetAll() ) do

                AmbLib.chatSend( v, AMB_COLOR_NEWS, '[•] ', AMB_COLOR_WHITE, 'Player authorized: '..ePly:GetNWString('amb_players_name') )

            end

        else

            MsgN( '  !  [AmbStats] Player dont initial: '..ePly:Nick() )
            ePly:ChatPrint('You not have account on server!')

        end

    end

end

local whitelist_e2 = {

    [ 'STEAM_0:0:426598565' ] = true,

}

function AmbStats.Players.giveAccessE2( ePly )

    if whitelist_e2[ ePly:SteamID() ] then ePly:SetNWFloat( 'amb_players_e2', 6 ) return end
    if ePly:IsSuperAdmin() then ePly:SetNWFloat( 'amb_players_e2', 6 ) return end 

    if ( AmbStats.Players.getStats( ePly, '!' ) >= 16 ) then ePly:SetNWFloat( 'amb_players_e2', 5 )

    elseif ( AmbStats.Players.getStats( ePly, '!' ) >= 12 ) then ePly:SetNWFloat( 'amb_players_e2', 4 )

    elseif ( AmbStats.Players.getStats( ePly, '!' ) >= 8 ) then ePly:SetNWFloat( 'amb_players_e2', 3 )

    elseif ( AmbStats.Players.getStats( ePly, '!' ) >= 4 ) then ePly:SetNWFloat( 'amb_players_e2', 2 )

    else ePly:SetNWFloat( 'amb_players_e2', 1 )

    end    

end

-- ################# Controle Stats #################
function AmbStats.Players.setStats( ePly, stats, value )
    local id = ePly:SteamID()
    if ( stats == "$" or stats == "M" or stats == "money" or stats == "Money" or stats == 1 ) then
        value = tonumber( value )
        ePly:SetNWFloat( 'amb_players_money', value )
        if ( AMB.config.gamemode == "Sandbox" ) then
            AmbDB.updateDate( amb_db_players_stats, 'Bio_Essensia', value, 'ID', id )
            AmbDB.updateDate( amb_db_players_darkrp, 'Money', value, 'ID', id )
        elseif ( AMB.config.gamemode == "DarkRP" ) then
            AmbDB.updateDate( amb_db_players_darkrp, 'Money', value, 'ID', id )
        end

    elseif ( stats == "!" or stats == "lvl" or stats == "Level" or stats == 2 ) then
        value = tonumber( value )
        ePly:SetNWFloat( 'amb_players_level', value )
        if ( AMB.config.gamemode == "Sandbox" ) then
            AmbDB.updateDate( amb_db_players_stats, 'Level', value, 'ID', id )
            AmbDB.updateDate( amb_db_players_darkrp, 'Level', value, 'ID', id )
        elseif ( AMB.config.gamemode == "DarkRP" ) then
            AmbDB.updateDate( amb_db_players_darkrp, 'Level', value, 'ID', id )
        end

    elseif ( stats == "/" or stats == "E" or stats == "exp" or stats == "Exp" or stats == 3 ) then
        value = tonumber( value )
        ePly:SetNWFloat( 'amb_players_exp', value )
        if ( AMB.config.gamemode == "Sandbox" ) then
            AmbDB.updateDate( amb_db_players_stats, 'Exp', value, 'ID', id )
            AmbDB.updateDate( amb_db_players_darkrp, 'Exp', value, 'ID', id )
        elseif ( AMB.config.gamemode == "DarkRP" ) then
            AmbDB.updateDate( amb_db_players_darkrp, 'Exp', value, 'ID', id )
        end

    elseif ( stats == "@" or stats == "name" or stats == "Name" or stats == 4 ) then
        value = tostring( value )
        ePly:SetNWString( 'amb_players_name', value )
        if ( AMB.config.gamemode == "Sandbox" ) then
            AmbDB.updateDate( amb_db_players_stats, 'Name', value, 'ID', id )
            AmbDB.updateDate( amb_db_players_darkrp, 'Name', value, 'ID', id )
        elseif ( AMB.config.gamemode == "DarkRP" ) then
            AmbDB.updateDate( amb_db_players_darkrp, 'Name', value, 'ID', id )
        end

    elseif ( stats == "?" or stats == "skin" or stats == "Skin" or stats == 5 ) then
        value = tostring( value )
        ePly:SetNWString( 'amb_players_skin', value )
        ePly:SetModel( value )
        ePly:ChatPrint(" Congratulations, at your new skin!")
        if ( AMB.config.gamemode == "Sandbox" ) then
            AmbDB.updateDate( amb_db_players_stats, 'Skin', value, 'ID', id )
            AmbDB.updateDate( amb_db_players_darkrp, 'Skin', value, 'ID', id )
        elseif ( AMB.config.gamemode == "DarkRP" ) then
            AmbDB.updateDate( amb_db_players_darkrp, 'Skin', value, 'ID', id )
        end

    elseif ( stats == "." or stats == "age" or stats == "Age" or stats == 6 ) then -- DarkRP
        value = tonumber( value )
        ePly:SetNWFloat( 'amb_players_age', value )
        ePly:ChatPrint(" Congratulations , your age"..value )
        AmbDB.updateDate( amb_db_players_darkrp, 'Age', value, 'ID', id )

    elseif ( stats == "+" or stats == "e2" or stats == 7 ) then -- Sandbox
        if value < 6 then
            ePly:SetNWFloat( 'amb_players_e2', value )
        end
        ePly:ChatPrint(" Congratulations , your E2Access: "..value )

    elseif ( stats == "|" or stats == "tribe" or stats == "Tribe" or stats == 8 ) then -- Sandbox
        value = tostring( value )
        ePly:SetNWString( 'amb_players_tribe', value )
        AmbLib.notifySend( ePly, 'You joined in: '..value, 4, 6, 'buttons/button10.wav' )
        AmbDB.updateDate( amb_db_players_stats, 'Tribe', value, 'ID', id )
    end
end

function AmbStats.Players.addStats( ePly, stats, value )

    local id = ePly:SteamID()

    if ( stats == "$" or stats == "M" or stats == "money" or stats == "Money" or stats == 1 ) then
        local wallet = tonumber( ePly:GetNWFloat('amb_players_money') )
        AmbLib.notifySend( ePly, 'Bio. Essensia: '..value, 0, 3, 'buttons/button9.wav' )
        value = wallet + value

        ePly:SetNWFloat( 'amb_players_money', value )

        if ( AMB.config.gamemode == "Sandbox" ) then
            AmbDB.updateDate( amb_db_players_stats, 'Bio_Essensia', value, 'ID', id )
            AmbDB.updateDate( amb_db_players_darkrp, 'Money', value, 'ID', id )
            -- ePly:ChatPrint('[•] Your Bio.Essensia has saved!') -- debug
        elseif ( AMB.config.gamemode == "DarkRP" ) then
            AmbDB.updateDate( amb_db_players_darkrp, 'Money', value, 'ID', id )
            -- ePly:ChatPrint('[•] Your Money has saved!') -- debug
        end

    elseif ( stats == "!" or stats == "lvl" or stats == "Level" or stats == 2 ) then
        local level = tonumber( ePly:GetNWFloat('amb_players_level') )
        AmbLib.notifySend( ePly, 'Level: '..value, 0, 3, 'buttons/button9.wav' )
        value = level + value

        ePly:SetNWFloat( 'amb_players_level', value )

        if ( AMB.config.gamemode == "Sandbox" ) then
            AmbDB.updateDate( amb_db_players_stats, 'Level', value, 'ID', id )
            AmbDB.updateDate( amb_db_players_darkrp, 'Level', value, 'ID', id )
            -- ePly:ChatPrint('[•] Your Level has saved!') -- debug
        elseif ( AMB.config.gamemode == "DarkRP" ) then
            AmbDB.updateDate( amb_db_players_darkrp, 'Level', value, 'ID', id )
            -- ePly:ChatPrint('[•] Your Level has saved!') -- debug
        end

    elseif ( stats == "/" or stats == "E" or stats == "exp" or stats == "Exp" or stats == 3 ) then
        local exp = tonumber( ePly:GetNWFloat('amb_players_exp') )
        AmbLib.notifySend( ePly, 'Exp: '..value, 0, 3, 'buttons/button14.wav' )
        value = exp + value

        ePly:SetNWFloat( 'amb_players_exp', value )

        if ( AMB.config.gamemode == "Sandbox" ) then
            AmbDB.updateDate( amb_db_players_stats, 'Exp', value, 'ID', id )
            AmbDB.updateDate( amb_db_players_darkrp, 'Exp', value, 'ID', id )
            -- ePly:ChatPrint('[•] Your Level has saved!') -- debug
        elseif ( AMB.config.gamemode == "DarkRP" ) then
            AmbDB.updateDate( amb_db_players_darkrp, 'Exp', value, 'ID', id )
            -- ePly:ChatPrint('[•] Your EXP has saved!') -- debug
        end
    end

end

function AmbStats.Players.getStats( ePly, stats )
    if ( stats == "$" or stats == "M" or stats == "money" or stats == "Money" or stats == 1 ) then
        return tonumber( ePly:GetNWFloat( 'amb_players_money' ) )
    elseif ( stats == "!" or stats == "lvl" or stats == "Level" or stats == 2 ) then
        return tonumber( ePly:GetNWFloat( 'amb_players_level' ) )
    elseif ( stats == "/" or stats == "E" or stats == "exp" or stats == "Exp" or stats == 3 ) then
        return tonumber( ePly:GetNWFloat( 'amb_players_exp' ) )
    elseif ( stats == "@" or stats == "name" or stats == "Name" or stats == 4 ) then
        return ePly:GetNWString( 'amb_players_name' )
    end
end

function AmbStats.Players.newLevel( ePly )

    AmbStats.Players.addStats( ePly, "/", 1 )

    if ( AmbStats.Players.getStats( ePly, "/" ) >= ePly:GetNWFloat( 'amb_players_max_exp' ) ) then

        AmbStats.Players.addStats( ePly, '!', 1 )
        AmbStats.Players.setStats( ePly, '/', 0 )
        ePly:SetNWFloat('amb_players_max_exp', AmbStats.Players.getStats( ePly, '!' ) * 2 )
        AmbLib.notifySend( ePly, 'Новый Уровень!', 4, 6, 'ui/buttonclick.wav' )
        AmbStats.Players.limitCalc( ePly )

    end

end

AmbStats.limits = { 

    [ 'props' ] = 16,
    [ 'sents' ] = 4,
    [ 'effects' ] = 1,
    [ 'ragdolls' ] = 1,
    [ 'vehicles' ] = 1,
    [ 'npcs' ] = 1,
    [ 'balloons' ] = 2,
    [ 'buttons' ] = 2,
    [ 'emitters' ] = 1,
    [ 'dynamites' ] = 1,
    [ 'lights' ] = 2,
    [ 'lamps' ] = 1,
    [ 'wheels' ] = 2,
    [ 'thrusters' ] = 1,
    [ 'hoverballs' ] = 2

}

local limits_modify_ranks = {

    [ 'user' ] = 1,
    [ 'vip' ] = 2,
    [ 'helper' ] = 3,
    [ 'officer' ] = 4,
    [ 'admin' ] = 5,
    [ 'superadmin' ] = 6

}

function AmbStats.Players.limitCalc( ePly )

    for name, max in pairs( AmbStats.limits ) do ePly:SetNWInt( 'amb_players_limit_'..name, AmbStats.Players.getStats( ePly, '!' ) * max * limits_modify_ranks[ ePly:GetUserGroup() ] ) end

end

-- ######## Админка #####################################
function AmbStats.Players.setRank( ePly, admin_caller, sRank, date_reg, diff_time )

    local id = ''
    local nick = ''

    local date_last = os.date( '%c', diff_time )

    if IsValid( admin_caller ) then

        admin_caller = admin_caller:Nick()

    else

        admin_caller = '[CONSOLE]'

    end

    if IsEntity( ePly ) then

        id = ePly:SteamID()
        nick = ePly:Nick()

    else

        id = ePly
        nick = ePly

    end

    if ( AmbDB.selectDate( amb_db_players_ranks, 'ID', 'ID', id ) == id ) then

        AmbDB.updateDate( amb_db_players_ranks, 'Rank', sRank, 'ID', id )
        AmbDB.updateDate( amb_db_players_ranks, 'Date_Last', date_last, 'ID', id )
        AmbDB.updateDate( amb_db_players_ranks, 'Nick_Admin', admin_caller, 'ID', id )
        AmbDB.updateDate( amb_db_players_ranks, 'Diff_Time', diff_time, 'ID', id )

    else

        AmbDB.insertDate(
            amb_db_players_ranks,
            "ID, Nick, Nick_Admin, Rank, Date_Reg, Diff_Time, Date_Last",
            Format( "%s, %s, %s, %s, %s, %f, %s", s( id ), s( nick ), s( admin_caller ), s( sRank ), s( date_reg ), diff_time, s( date_last ) )
        )

    end

end

function AmbStats.Players.deleteRank( ePly )
    if IsEntity( ePly ) then
        ePly = ePly:SteamID()
    end
    RunConsoleCommand('ulx', 'removeuserid', ePly ) -- ulx
    AmbDB.updateDate( amb_db_players_ranks, 'Rank', 'user', 'ID', ePly )
    AmbDB.updateDate( amb_db_players_ranks, 'Date_Last', '0', 'ID', ePly )
    AmbDB.updateDate( amb_db_players_ranks, 'Diff_Time', diff_time, 0, ePly )
end

-- #################### Hooks #######################

hook.Add( 'PlayerInitialSpawn', 'AmbStatsInitialPlayers', function( ePly )

    ePly:Freeze( true )

    if sql.TableExists( amb_db_players_stats ) then

        if ( AmbDB.selectDate( amb_db_players_stats, 'ID', 'ID', ePly:SteamID() ) == ePly:SteamID() ) then

            AmbStats.Players.initialPlayer( ePly )

        end

    end

end )

hook.Add( 'PlayerSpawn', 'AmbStatsSpawnPlayers', function( ePly )

    AmbStats.Players.giveAccessE2( ePly )

    if ( tonumber( ePly:GetNWInt('amb_orgs') ) <= 0 ) then

        if ePly:GetNWString( 'amb_players_skin' ) then

            timer.Simple( 0, function() 

                ePly:SetModel( ePly:GetNWString( 'amb_players_skin' ) ) 

            end )

        end

    end

end )

hook.Add( 'PlayerSay', 'AmbStatsNotSay', function( ePly ) 

    if not ePly.authorized then return end

end )