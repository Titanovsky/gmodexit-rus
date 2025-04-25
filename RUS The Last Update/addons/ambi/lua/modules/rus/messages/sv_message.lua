local C, SQL =  Ambi.General.Global.Colors, Ambi.SQL
local DB = SQL.CreateTable( 'world_messages', 'SteamID TEXT, Nick TEXT, Text TEXT, Pos TEXT, Map TEXT, Date NUMBER' )

world_messages = world_messages or {}

local function ToVec( vPos )
    local x, y, z = tostring( math.Round( vPos.x ) ), tostring( math.Round( vPos.y ) ), tostring( math.Round( vPos.z ) )

    return x..' '..y..' '..z
end

local function UnVec( sVec )
    local tab = string.Split( sVec, ' ' )

    return Vector( tonumber( tab[ 1 ] ), tonumber( tab[ 2 ] ), tonumber( tab[ 3 ] ) )
end

function Ambi.Rus.CreateWorldMessage( ePly, sText )
    local sid = ePly:SteamID()
    local pos = ePly:GetPos()

    local value = sql.QueryValue( 'SELECT Date FROM '..DB..' WHERE SteamID = "'..sid..'" AND Map = "'..game.GetMap()..'"' )
    if value then ePly:ChatPrint( 'На этой карте уже есть ваше сообщение!' ) return end
    if ( utf8.len( sText ) > 120 ) then ePly:ChatPrint( 'Больше 120 символов' ) return end

    SQL.Insert( DB, 'SteamID, Nick, Text, Pos, Map, Date', '%s, %s, %s, %s, %s, %i', sid, ePly:Nick(), sText, ToVec( pos ), game.GetMap(), os.time() )

    ePly:ChatPrint( 'Вы сделали надпись!' )

    world_messages[ #world_messages + 1 ] = {
        steamid = sid,
        nick = ePly:Nick(),
        map = game.GetMap(),
        text = sText,
        pos = pos,
        date = os.date( '%d.%m.%Y %H:%M', os.time() )
    }

    for _, ply in ipairs( player.GetAll() ) do
        Ambi.Rus.SendToPlayerWorldMessages( ply )
    end
end

function Ambi.Rus.RemoveWorldMessage( sSteamID, sMap )
    sql.QueryValue( 'DELETE FROM '..DB..' WHERE SteamID = "'..sSteamID..'" AND Map = "'..game.GetMap()..'"' )

    print( '[WorldMessages] Removed text on '..sSteamID..' on '..sMap )
end

function Ambi.Rus.CreateTableWorldMessages()
    local tab = Ambi.SQL.SelectAll( DB )
    if not tab then return end

    world_messages = {}

    for i, v in ipairs( tab ) do
        world_messages[ i ] = {
            steamid = v.SteamID,
            nick = v.Nick,
            map = v.Map,
            text = v.Text,
            pos = UnVec( v.Pos ),
            date = os.date( '%d.%m.%Y %H:%M', tonumber( v.Date ) )
        }
    end
end

net.AddString( 'ambi_world_messages_sync' )
function Ambi.Rus.SendToPlayerWorldMessages( ePly )
    local tab = {}

    for _, v in ipairs( world_messages ) do
        if ( v.map != game.GetMap() ) then continue end

        tab[ #tab + 1 ] = v
    end

    net.Start( 'ambi_world_messages_sync' )
        net.WriteTable( tab )
    net.Send( ePly )
end

hook.Add( 'PostGamemodeLoaded', 'Ambi.WorldMessages.CreateTable', Ambi.Rus.CreateTableWorldMessages )
hook.Add( 'PlayerInitialSpawn', 'Ambi.WorldMessages.Sync', Ambi.Rus.SendToPlayerWorldMessages )