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
    [07.07.20]
        • Появилась непонятная дичь, которая вайпает lvl, exp и money у игроков, хз что такое(( Ошибок нет
    .
]]

AmbStats = AmbStats or {}
AmbStats.Players = AmbStats.Players or {}

local file  = file
local os    = os
local print = print

local amb_players = 'amb_players'
local amb_players_stats = 'amb_players_stats' -- specific for server
local amb_players_ranks = 'amb_players_ranks' -- for ULX

local start_money = 40

sql.Query("CREATE TABLE IF NOT EXISTS amb_players( ID TEXT, Nick TEXT, Reg_date TEXT, IP TEXT )")
sql.Query("CREATE TABLE IF NOT EXISTS amb_players( Name TEXT, ID TEXT, Money INTEGER, Level INTEGER, Exp INTEGER, Sex TEXT, Age INTEGER, Nation TEXT, Skin TEXT, Home TEXT )")


local function AmbStats_removeTab( name )
    sql.Query("DROP TABLE "..name..";")
end


function AmbStats.Players.initialPerson( ePly )
    print( '\n\n[AmbDebug] Start Process initialPerson('..ePly:Nick()..')')

    local id = sql.SQLStr( ePly:SteamID() )

    print( '\n\n[AmbDebug] InitPlayer [Nick:'..ePly:Nick()..']' )

    if ( sql.QueryValue( "SELECT * FROM amb_players_stats WHERE ID=" .. id ) ) then

        local name = sql.QueryValue( "SELECT Name FROM amb_players_stats WHERE ID="..id )
        local money = sql.QueryValue( "SELECT Money FROM amb_players_stats WHERE ID="..id )
    	local level = sql.QueryValue( "SELECT Level FROM amb_players_stats WHERE ID="..id )
    	local exp = sql.QueryValue( "SELECT Exp FROM amb_players_stats WHERE ID="..id )

        local sex = sql.QueryValue( "SELECT Sex FROM amb_players_stats WHERE ID="..id )
        local age = sql.QueryValue( "SELECT Age FROM amb_players_stats WHERE ID="..id )
        local nation = sql.QueryValue( "SELECT Nation FROM amb_players_stats WHERE ID="..id )
        local _skin = sql.QueryValue( "SELECT Skin FROM amb_players_stats WHERE ID="..id )
        local home = sql.QueryValue( "SELECT Home FROM amb_players_stats WHERE ID="..id )

        ePly:SetNWString( 'amb_players_name', name )
        ePly:SetNWFloat( 'amb_players_money', money )
        ePly:SetNWFloat( 'amb_players_level', level )
        ePly:SetNWFloat( 'amb_players_exp', exp )

        ePly:SetNWString( 'amb_players_sex', sex )
        ePly:SetNWFloat( 'amb_players_age', age )
        ePly:SetNWString( 'amb_players_nation', nation )
        ePly:SetNWString( 'amb_players_skin', _skin )
        ePly:SetNWString( 'amb_players_home', home )

        ePly:SetTeam( 1 )
        ePly:SetModel( ePly:GetNWString('amb_players_skin' ) )

        ePly:SetNWFloat( 'amb_players_max_exp', ePly:GetNWInt( 'amb_players_level' ) * 2 )

        print( '\n\n[AmbDebug] Money: '..money..' initialPerson('..ePly:Nick()..')')
        print( '\n\n[AmbDebug] Level: '..level..' initialPerson('..ePly:Nick()..')')
        print( '\n\n[AmbDebug] EXP: '..exp..' initialPerson('..ePly:Nick()..')')
    else
       print( '\n\n[AmbDebug] !!! VERY BAD initialPerson('..ePly:Nick()..')')
    end

    print( '[AmbDebug] End Process initialPerson('..ePly:Nick()..')')

    for k, v in pairs( player.GetAll() ) do
        if v:GetUserGroup() ~= 'user' or v:GetUserGroup() ~= 'vip' then
            v:ChatPrint( '[•] Player initial: '..ePly:GetNWString( 'amb_players_name' )..' ['..ePly:EntIndex()..']' )
        end
    end

    AmbStats.Players.limitCalc( ePly ) -- лимиты
end

local whitelist_e2 = {
    'STEAM_0:0:426598565'
}

function AmbStats.Players.giveAccessE2( ePly )
    ePly:SetNWFloat( 'amb_players_e2access', 1 )


    if ePly:GetUserGroup() == 'superadmin' then
        ePly:SetNWFloat( 'amb_players_e2access', 6 )
        return
    end

    if tonumber( ePly:GetNWFloat('amb_players_level') ) >= 3 then
        ePly:SetNWFloat( 'amb_players_e2access', 2 )
        if tonumber( ePly:GetNWFloat('amb_players_level') ) >= 5 then
            ePly:SetNWFloat( 'amb_players_e2access', 3 )
            if tonumber( ePly:GetNWFloat('amb_players_level') ) >= 8 then
                ePly:SetNWFloat( 'amb_players_e2access', 4 )
                if tonumber( ePly:GetNWFloat('amb_players_level') ) >= 12 then
                    ePly:SetNWFloat( 'amb_players_e2access', 5 )
                end
            end
        end
    end

    for _, id in pairs( whitelist_e2 ) do
        if ePly:SteamID() == id then ePly:SetNWFloat( 'amb_players_e2access', 6 ) return end
    end
end

function AmbStats.Players.createPerson( ePly )
	local id = sql.SQLStr( ePly:SteamID() )
    if ( sql.QueryValue( "SELECT * FROM amb_players WHERE ID=" .. id ) ) then
        AmbStats.Players.initialPerson( ePly )
    else
        print( '\n\n[AmbDebug] CreatePerson [ False ] [Nick:'..ePly:Nick()..']' )
        local id = sql.SQLStr( ePly:SteamID() )
        local nick = sql.SQLStr( ePly:Nick() )
        local reg_date = sql.SQLStr( os.date( "%c", os.time() ) )
        local ip = sql.SQLStr( ePly:IPAddress() )

        local name = sql.SQLStr( ePly:GetNWString("amb_players_name") )
        local lvl = 1
        local exp = 0
        local sex = sql.SQLStr( ePly:GetNWString('amb_players_sex') )
        local age = sql.SQLStr( ePly:GetNWFloat('amb_players_age') )
        local nation = sql.SQLStr( ePly:GetNWString('amb_players_nation') )
        local skin = sql.SQLStr( ePly:GetNWString( 'amb_players_skin' ) )
        local home = sql.SQLStr( ePly:GetNWString( 'amb_players_home' ) )

        sql.Query( "INSERT INTO `amb_players`(ID, Nick, Reg_date, IP) VALUES ("..id..", "..nick..", "..reg_date..", "..ip..")" )
        sql.Query( "INSERT INTO `amb_players_stats`(Name, ID, Money, Level, Exp, Sex, Age, Nation, Skin, Home) VALUES ("..name..", "..id..", "..start_money..", "..lvl..", "..exp..", "..sex..", "..age..", "..nation..", "..skin..", "..home..")" )

        AmbStats.Players.initialPerson( ePly )

        print( "[AmbStats] New player: "..ePly:Nick() ) -- log
        for k, v in pairs( player.GetAll() ) do
        	v:ChatPrint( '[•] New player registration: '..ePly:GetNWString('amb_players_name') )
        end
    end
end


-- ################# Controle Stats #################

function AmbStats.Players.setStats( ePly, stats, value )
    local id = sql.SQLStr( ePly:SteamID() )
    if ( stats == "$" or stats == "M" or stats == "money" or stats == "Money" or stats == 1 ) then
        ePly:SetNWFloat( 'amb_players_money', value )
        sql.QueryValue( "UPDATE amb_players_stats SET Money="..value.." WHERE ID="..id )
    elseif ( stats == "!" or stats == "lvl" or stats == "Level" or stats == 2 ) then
        ePly:SetNWFloat( 'amb_players_level', value )
        sql.QueryValue( "UPDATE amb_players_stats SET Level="..value.." WHERE ID="..id )
    elseif ( stats == "/" or stats == "E" or stats == "exp" or stats == "Exp" or stats == 3 ) then
        ePly:SetNWFloat( 'amb_players_exp', value )
       sql.QueryValue( "UPDATE amb_players_stats SET Exp="..value.." WHERE ID="..id )
    elseif ( stats == "@" or stats == "name" or stats == "Name" or stats == 4 ) then
        ePly:SetNWString( 'amb_players_name', value )
        sql.QueryValue( "UPDATE amb_players_stats SET Name='"..sql.SQLStr( value ).."' WHERE ID="..id )
    elseif ( stats == "?" or stats == "skin" or stats == "Skin" or stats == 5 ) then
        ePly:SetNWString( 'amb_players_skin', value )
        ePly:SetModel( value )
        ePly:ChatPrint(" У вас новая моделькус :) ")
        sql.QueryValue( "UPDATE amb_players_stats SET Skin='"..sql.SQLStr( value ).."' WHERE ID="..id )
    elseif ( stats == "." or stats == "age" or stats == "Age" or stats == 6 ) then
        ePly:SetNWFloat( 'amb_players_age', value )
        ePly:ChatPrint(" Поздравляю, вам исполнилось "..value )
        sql.QueryValue( "UPDATE amb_players_stats SET Age='"..value.."' WHERE ID="..id )
    end
end

--AmbStats.Players.setStats( Entity(11), "!", 11 )
--AmbStats.Players.setStats( Entity(11), "$", 1800 )

function AmbStats.Players.addStats( ePly, stats, value )
    local id = sql.SQLStr( ePly:SteamID() )
    if ( stats == "$" or stats == "M" or stats == "money" or stats == "Money" or stats == 1 ) then
        value = tonumber( ePly:GetNWFloat('amb_players_money') ) + value
        ePly:SetNWFloat( 'amb_players_money', value )
        sql.QueryValue( "UPDATE amb_players_stats SET Money="..value.." WHERE ID="..id )

    elseif ( stats == "!" or stats == "lvl" or stats == "Level" or stats == 2 ) then
        value = tonumber( ePly:GetNWInt('amb_players_level') ) + value
        ePly:SetNWFloat( 'amb_players_level', value )
        sql.QueryValue( "UPDATE amb_players_stats SET Level="..value.." WHERE ID="..id )

    elseif ( stats == "/" or stats == "E" or stats == "exp" or stats == "Exp" or stats == 3 ) then
        value = tonumber( ePly:GetNWInt('amb_players_exp') ) + value
        ePly:SetNWFloat( 'amb_players_exp', value )
        sql.QueryValue( "UPDATE amb_players_stats SET Exp="..value.." WHERE ID="..id )
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
    if ( tonumber( ePly:GetNWFloat('amb_players_exp') ) >= tonumber( ePly:GetNWFloat('amb_players_max_exp') ) ) then
        AmbStats.Players.addStats( ePly, '!', 1 ) -- new level
        AmbStats.Players.setStats( ePly, '/', 0 ) -- обнуление exp
        ePly:SetNWFloat('amb_players_max_exp', AmbStats.Players.getStats( ePly, '!' ) * 2 )
        AmbLib.notifySend( ePly, 'Congratulations! +Level ', 4, 4, 'buttons/button10.wav' )
        AmbStats.Players.limitCalc( ePly )
    else
        AmbStats.Players.addStats( ePly, "/", 1 )
        AmbLib.notifySend( ePly, '+Exp', 2, 2, 'buttons/button14.wav' )
        if ( tonumber( ePly:GetNWFloat('amb_players_exp') ) >= tonumber( ePly:GetNWFloat('amb_players_max_exp') ) ) then
            AmbStats.Players.newLevel( ePly ) -- нужна рекурсия
        end
    end
end

function AmbStats.Players.limitCalc( ePly ) -- todo: change for table !
    if ePly:GetUserGroup() == 'user' then
        ePly:SetNWInt( 'amb_players_limit_props', tonumber( ePly:GetNWInt('amb_players_level') ) * 50 ) -- [ PROPS ]
        ePly:SetNWInt( 'amb_players_limit_entities', tonumber( ePly:GetNWInt('amb_players_level') ) * 5 ) -- [ ENTITIES ]
        ePly:SetNWInt( 'amb_players_limit_effects', tonumber( ePly:GetNWInt('amb_players_level') ) * 1 ) -- [ EFFECTS ]
        ePly:SetNWInt( 'amb_players_limit_ragdolls', tonumber( ePly:GetNWInt('amb_players_level') ) * 1 ) -- [ RAGDOLLS ]
        ePly:SetNWInt( 'amb_players_limit_vehicles', tonumber( ePly:GetNWInt('amb_players_level') ) * 1 ) -- [ VEHICLES ]
        ePly:SetNWInt( 'amb_players_limit_npc', 0 ) -- [ NPC ]

        ePly:SetNWInt( 'amb_players_limit_balloons', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ BALLONS ]
        ePly:SetNWInt( 'amb_players_limit_buttons', tonumber( ePly:GetNWInt('amb_players_level') ) * 1 ) -- [ BUTTONS ]
        ePly:SetNWInt( 'amb_players_limit_emitters', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ EMITTERS ]
        ePly:SetNWInt( 'amb_players_limit_dynamites', tonumber( ePly:GetNWInt('amb_players_level') ) * 1 ) -- [ DYNAMITES ]
        ePly:SetNWInt( 'amb_players_limit_lights', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ LIGHTS ]
        ePly:SetNWInt( 'amb_players_limit_lamps', tonumber( ePly:GetNWInt('amb_players_level') ) * 1 ) -- [ LAMPS ]
        ePly:SetNWInt( 'amb_players_limit_wheels', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ HAPPY WHEELS ]
        ePly:SetNWInt( 'amb_players_limit_thrusters', tonumber( ePly:GetNWInt('amb_players_level') ) * 1 ) -- [ THRUSTERS ]
        ePly:SetNWInt( 'amb_players_limit_hoverballs', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ HOVERBALLS ]
    elseif ePly:GetUserGroup() == 'vip' then
        ePly:SetNWInt( 'amb_players_limit_props', tonumber( ePly:GetNWInt('amb_players_level') ) * 100 ) -- [ PROPS ]
        ePly:SetNWInt( 'amb_players_limit_entities', tonumber( ePly:GetNWInt('amb_players_level') ) * 10 ) -- [ ENTITIES ]
        ePly:SetNWInt( 'amb_players_limit_effects', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ EFFECTS ]
        ePly:SetNWInt( 'amb_players_limit_ragdolls', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ RAGDOLLS ]
        ePly:SetNWInt( 'amb_players_limit_vehicles', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ VEHICLES ]
        ePly:SetNWInt( 'amb_players_limit_npc', tonumber( ePly:GetNWInt('amb_players_level') ) * 1 ) -- [ NPC ]

        ePly:SetNWInt( 'amb_players_limit_balloons', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ BALLONS ]
        ePly:SetNWInt( 'amb_players_limit_buttons', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ BUTTONS ]
        ePly:SetNWInt( 'amb_players_limit_emitters', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ EMITTERS ]
        ePly:SetNWInt( 'amb_players_limit_dynamites', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ DYNAMITES ]
        ePly:SetNWInt( 'amb_players_limit_lights', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ LIGHTS ]
        ePly:SetNWInt( 'amb_players_limit_lamps', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ LAMPS ]
        ePly:SetNWInt( 'amb_players_limit_wheels', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ HAPPY WHEELS ]
        ePly:SetNWInt( 'amb_players_limit_thrusters', tonumber( ePly:GetNWInt('amb_players_level') ) * 2 ) -- [ THRUSTERS ]
        ePly:SetNWInt( 'amb_players_limit_hoverballs', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ HOVERBALLS ]
    else
        ePly:SetNWInt( 'amb_players_limit_props', tonumber( ePly:GetNWInt('amb_players_level') ) * 200 ) -- [ PROPS ]
        ePly:SetNWInt( 'amb_players_limit_entities', tonumber( ePly:GetNWInt('amb_players_level') ) * 25 ) -- [ ENTITIES ]
        ePly:SetNWInt( 'amb_players_limit_effects', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ EFFECTS ]
        ePly:SetNWInt( 'amb_players_limit_ragdolls', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ RAGDOLLS ]
        ePly:SetNWInt( 'amb_players_limit_vehicles', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ VEHICLES ]
        ePly:SetNWInt( 'amb_players_limit_npc', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ NPC ]

        ePly:SetNWInt( 'amb_players_limit_balloons', tonumber( ePly:GetNWInt('amb_players_level') ) * 6 ) -- [ BALLONS ]
        ePly:SetNWInt( 'amb_players_limit_buttons', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ BUTTONS ]
        ePly:SetNWInt( 'amb_players_limit_emitters', tonumber( ePly:GetNWInt('amb_players_level') ) * 6 ) -- [ EMITTERS ]
        ePly:SetNWInt( 'amb_players_limit_dynamites', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ DYNAMITES ]
        ePly:SetNWInt( 'amb_players_limit_lights', tonumber( ePly:GetNWInt('amb_players_level') ) * 6 ) -- [ LIGHTS ]
        ePly:SetNWInt( 'amb_players_limit_lamps', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ LAMPS ]
        ePly:SetNWInt( 'amb_players_limit_wheels', tonumber( ePly:GetNWInt('amb_players_level') ) * 6 ) -- [ HAPPY WHEELS ]
        ePly:SetNWInt( 'amb_players_limit_thrusters', tonumber( ePly:GetNWInt('amb_players_level') ) * 4 ) -- [ THRUSTERS ]
        ePly:SetNWInt( 'amb_players_limit_hoverballs', tonumber( ePly:GetNWInt('amb_players_level') ) * 6 ) -- [ HOVERBALLS ]
    end
end

function AmbStats.Players.limitEntities( ePly, type_ent, sEnt )
    if ( type_ent == 1 ) or ( type_ent == 'props' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Props!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'props' ) >= tonumber( ePly:GetNWInt('amb_players_limit_props') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_props').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 2 ) or ( type_ent == 'sents' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Entities!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'sents' ) >= tonumber( ePly:GetNWInt('amb_players_limit_entities') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_entities').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 3 ) or ( type_ent == 'effects' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Effects!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'effects' ) >= tonumber( ePly:GetNWInt('amb_players_limit_effects') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_effects').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 4 ) or ( type_ent == 'ragdolls' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Ragdolls!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'ragdolls' ) >= tonumber( ePly:GetNWInt('amb_players_limit_ragdolls') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_ragdolls').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 5 ) or ( type_ent == 'vehicles' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Cars!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'vehicles' ) >= tonumber( ePly:GetNWInt('amb_players_limit_vehicles') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_vehicles').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 6 ) or ( type_ent == 'npcs' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn NPC!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'npcs' ) >= tonumber( ePly:GetNWInt('amb_players_limit_npc') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_npc').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 7 ) or ( type_ent == 'balloons' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Ballons!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'balloons' ) >= tonumber( ePly:GetNWInt('amb_players_limit_balloons') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_balloons').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 8 ) or ( type_ent == 'buttons' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Buttons!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'buttons' ) >= tonumber( ePly:GetNWInt('amb_players_limit_buttons') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_buttons').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 9 ) or ( type_ent == 'emitters' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Emitters!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'emitters' ) >= tonumber( ePly:GetNWInt('amb_players_limit_emitters') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_emitters').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 10 ) or ( type_ent == 'dynamite' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Dynamites!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'dynamite' ) >= tonumber( ePly:GetNWInt('amb_players_limit_dynamite') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_dynamite').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 11 ) or ( type_ent == 'lights' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Lights!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'lights' ) >= tonumber( ePly:GetNWInt('amb_players_limit_lights') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_lights').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 12 ) or ( type_ent == 'lamps' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Lamps!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'lamps' ) >= tonumber( ePly:GetNWInt('amb_players_limit_lamps') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_lamps').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 13 ) or ( type_ent == 'wheels' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Wheels!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'wheels' ) >= tonumber( ePly:GetNWInt('amb_players_limit_wheels') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_wheels').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 14 ) or ( type_ent == 'thrusters' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Thrusters!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'thrusters' ) >= tonumber( ePly:GetNWInt('amb_players_limit_thrusters') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_thrusters').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    elseif ( type_ent == 15 ) or ( type_ent == 'hoverballs' ) then
        if ( ePly:Team() == 1 ) then AmbLib.notifySend( ePly, "Your a just player, can't spawn Hoverballs!", 1, 4, 'buttons/button10.wav' ) return false end
        if ePly:GetCount( 'hoverballs' ) >= tonumber( ePly:GetNWInt('amb_players_limit_hoverballs') ) then AmbLib.notifySend( ePly, "Your reached the limit ["..ePly:GetNWInt('amb_players_limit_hoverballs').."]", 1, 4, 'buttons/button10.wav' ) return false end
        return true
    end
end



--print( AmbStats.Players.getStats( Entity(1), "@" ) )


-- ######## ULX #####################################
if !sql.TableExists( amb_players_ranks ) then
	sql.Query( [[CREATE TABLE ]]..amb_players_ranks..[[(
		ID        	TEXT,
		Nick	    TEXT,
		Nick_Admin	TEXT,
        Rank        TEXT,
		Date_Reg	TEXT,
        Diff_Time   INTEGER,
		Date_Last	TEXT
		);]]
    )
    print("[AmbStats] Database "..amb_players_ranks.." has created!")
end
--AmbStats_removeTab( amb_players_ranks )

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

    if sql.QueryValue( Format( "SELECT * FROM `"..amb_players_ranks.."` WHERE ID=%s;", sql.SQLStr( id ) ) ) then
        sql.QueryValue( Format( "UPDATE `"..amb_players_ranks.."` SET Rank=%s WHERE ID="..sql.SQLStr( id ), sql.SQLStr( sRank ) ) )
        sql.QueryValue( Format( "UPDATE `"..amb_players_ranks.."` SET Date_Last='%s' WHERE ID="..sql.SQLStr( id ), sql.SQLStr( date_last, true ) ) )
        sql.QueryValue( Format( "UPDATE `"..amb_players_ranks.."` SET Nick_Admin='%s' WHERE ID="..sql.SQLStr( id ), sql.SQLStr( admin_caller, true ) ) )
        sql.QueryValue( Format( "UPDATE `"..amb_players_ranks.."` SET Diff_Time=%i WHERE ID="..sql.SQLStr( id ), diff_time ) )
    else
        sql.Query( Format( "INSERT INTO "..amb_players_ranks.."(ID, Nick, Nick_Admin, Rank, Date_Reg, Diff_Time, Date_Last) VALUES (%s, '%s', '%s', %s, '%s', %i, '%s');", sql.SQLStr( id ), sql.SQLStr( nick, true ), sql.SQLStr( admin_caller, true ), sql.SQLStr( sRank ), sql.SQLStr( date_reg, true ), diff_time, sql.SQLStr( date_last, true ) ) )
    end
end

function AmbStats.Players.deleteRank( ePly )
    if IsEntity( ePly ) then
        ePly = ePly:SteamID()
    end
    RunConsoleCommand('ulx', 'removeuserid', ePly ) -- ulx
    sql.QueryValue( Format( "UPDATE `"..amb_players_ranks.."` SET Rank=%s WHERE ID="..sql.SQLStr( ePly ), sql.SQLStr( 'user' ) ) )
    sql.QueryValue( Format( "UPDATE `"..amb_players_ranks.."` SET Diff_Time=%i WHERE ID="..sql.SQLStr( ePly ), 0 ) )
    sql.QueryValue( Format( "UPDATE `"..amb_players_ranks.."` SET Date_Last=%s WHERE ID="..sql.SQLStr( ePly ), sql.SQLStr( '0' ) ) )
end

-- ##################################################

-- #################### Hooks #######################

hook.Add( "PlayerInitialSpawn", "amb_0x2024", function( ePly )
    ePly:SetTeam( 1 ) -- just player
    ePly:Freeze( true )
    timer.Simple( 0, function() ePly:StripWeapons() end ) -- ПОТОМУ ЧТО ПОТОМУ
    --AmbStats.Players.createPerson( ply )

    if sql.QueryValue( Format( "SELECT * FROM `"..amb_players_ranks.."` WHERE ID=%s;", sql.SQLStr( ePly:SteamID() ) ) ) and ePly:GetUserGroup() ~= 'user' then
        local diff_time = sql.QueryValue( Format( "SELECT Diff_Time FROM `"..amb_players_ranks.."` WHERE ID=%s;", sql.SQLStr( ePly:SteamID() ) ) )
        local today = os.time()
        if tonumber( today ) >= tonumber( diff_time ) then
            AmbStats.Players.deleteRank( ePly )
        end
    end

    --[[
    if sql.QueryValue( Format( "SELECT * FROM `"..amb_players_ranks.."` WHERE ID=%s;", sql.SQLStr( ply:SteamID() ) ) ) and ply:GetUserGroup() ~= 'user' then
        local userInfo = ULib.ucl.authed[ ply:UniqueID() ] -- ulx
        local rank = sql.QueryValue( Format( "SELECT Rank FROM `"..amb_players_ranks.."` WHERE ID=%s;", sql.SQLStr( ply:SteamID() ) ) )
        local diff_time = sql.QueryValue( Format( "SELECT Diff_Time FROM `"..amb_players_ranks.."` WHERE ID=%s;", sql.SQLStr( ply:SteamID() ) ) )
        local today = os.time()
        print( rank )

        local id = ULib.ucl.getUserRegisteredID( ply ) -- ulx
        if not id then id = ply:SteamID() end -- ulx

        if tonumber( today ) >= tonumber( diff_time ) then
            ULib.ucl.removeUser( ply:UniqueID() ) -- ulx
        else
            ULib.ucl.addUser( id, userInfo.allow, userInfo.deny, rank ) -- ulx
        end
    end
    ]]
end )

hook.Add( 'PlayerSpawn', 'amb_0x2026', function( ePly )
    AmbStats.Players.giveAccessE2( ePly )
    if ( ePly:GetNWInt('amb_orgs') <= 0 ) then
        if ( ePly:GetNWString('amb_players_skin') ) then
            timer.Simple( 0, function() ePly:SetModel( ePly:GetNWString('amb_players_skin') ) end )
        end
    end
end )

hook.Add( 'PlayerDisconnected', 'amb_0x2026', function( ePly )
    if #ePly:GetNWString('amb_players_name') > 0 then
        local nw_money = tonumber( ePly:GetNWFloat('amb_players_money') )
        local nw_level = ePly:GetNWFloat('amb_players_level')
        local nw_exp = tonumber( ePly:GetNWFloat('amb_players_exp') )
        local money = sql.QueryValue( "SELECT Money FROM amb_players_stats WHERE Name="..sql.SQLStr( ePly:GetNWString('amb_players_name') ) )
        local level = sql.QueryValue( "SELECT Level FROM amb_players_stats WHERE Name="..sql.SQLStr( ePly:GetNWString('amb_players_name') ) )
        local exp = sql.QueryValue( "SELECT Exp FROM amb_players_stats WHERE Name="..sql.SQLStr( ePly:GetNWString('amb_players_name') ) )
            print( '\n[AmbDebug] '..ePly:GetNWString('amb_players_name') )
            print( '[AmbDebug] Level: '..level )
            print( '[AmbDebug] Level_NW: '..nw_level )
            print( '[AmbDebug] Exp: '..exp )
            print( '[AmbDebug] Exp_NW: '..nw_exp )
            print( '[AmbDebug] Money: '..money )
            print( '[AmbDebug] Money_NW: '..nw_money..'\n\n' )
    end
end )



-- ##################################################

-- Данное творение принадлежит проекту [ Ambition ]