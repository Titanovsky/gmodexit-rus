--[[
	Всё связанное с Дата Базой игрока (SQLite, MySQL, file ).
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[09.07.20]
		• Начало.
        • Вот есть функция s(), я понимаю, она уничтожает чуть ли не всю чистоту кода, но блин, она афигенная ;3 особенно при Format()
	.
]]

AmbDB = AmbDB or {}

local file  = file
local sql   = sql
local os    = os

local time = os.date( '%c', os.time() )
local amb_db_players = 'amb_db_players'








-- ## SQL SYSTEM #####################•
local function s( string, num )
    if not num then num = 0 end

    return sql.SQLStr( string, tobool( num ) )
end

function AmbDB.createDataBase( sName, vars )
    local name = s( sName, 1 )

    if ( sql.TableExists( name ) == false ) then
        sql.Query( [[ CREATE TABLE ]]..name..[[(]]..vars..[[);]] 
        )
       -- MsgN(' [AmbDB] Created '..name..'  '..time)
    else
        MsgN(' [AmbDB] Load '..name..'  '..time)
        -- sql.Query([[ CREATE TABLE IF NOT EXISTS amb_players( Name TEXT, ID TEXT, Money INTEGER, Level INTEGER, Exp INTEGER, Sex TEXT, Age INTEGER, Nation TEXT, Skin TEXT, Home TEXT )]])
    end
end

function AmbDB.dropTable( sName )
    local name = s( sName, 1 )

    if ( sql.TableExists( name ) ) then
        sql.Query( [[ DROP TABLE ]]..name..[[;]] )
        --MsgN(' [AmbDB] Drop Table '..name..'  '..time)
    else
        MsgN('  !  [AmbDB] Table '..name..' dont Drop, because not exists!')
    end
end

function AmbDB.wipeDate( sTable, spec_key, spec_value )
    sTable = s( sTable, 1 )
    spec_key = s( spec_key, 1 )
    spec_value = s( spec_value )

    if ( sql.TableExists( sTable ) ) then
        sql.Query('DELETE FROM '..sTable..' WHERE '..spec_key..'='..spec_value..';')
        --MsgN(' [AmbDB] Delete All From '..sTable..' where '..spec_key..'='..spec_value..' '..time)
    end
end

function AmbDB.insertDate( sTable, keys, values )
    sTable = s( sTable, 1 )

    if ( sql.TableExists( sTable ) ) then
        --MsgN(' [AmbDB] Insert Info '..sTable..' Keys: '..keys..' | Val: '..values..' '..time)
        sql.QueryValue("INSERT INTO "..sTable.."("..keys..") VALUES("..values..");")
    else
        MsgN('  !  [AmbDB] Table '..name..' dont insertDate, because not exists!')
    end
end

function AmbDB.updateDate( sTable, key, value, id_key, id_value )
    sTable = s( sTable, 1 )
    value = s( value )
    id_value = s( id_value )

    if ( sql.TableExists( sTable ) ) then
        --MsgN(' [AmbDB] Update '..sTable..' Keys: '..key..' | Val: '..value..' '..time)
        sql.Query( "UPDATE "..sTable.." SET "..key.."="..value.." WHERE "..id_key.."="..id_value )
    else
        MsgN('  !  [AmbDB] Table '..name..' dont insertDate, because not exists!')
    end
end

function AmbDB.selectDate( sTable, selected, id_key, id_value )
    sTable = s( sTable, 1 )
    id_value = s( id_value )

    if ( sql.TableExists( sTable ) ) then
            return sql.QueryValue( "SELECT "..selected.." FROM "..sTable.." WHERE "..id_key.."=" .. id_value ) 
    else
        MsgN('  !  [AmbDB] Table '..name..' dont insertDate, because not exists!')
        return false
    end
end

--AmbDB.wipeDate( amb_db_players, 'Nick', 'Alexey Titanovsky' )

-- ###################################•





-- ## PATH SYSTEM ####################•
function AmbDB.createPath( sName )
end
-- ###################################•

