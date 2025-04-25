local C, SQL =  Ambi.General.Global.Colors, Ambi.SQL
local CFG = Ambi.Kit.Config
local db = SQL.CreateTable( 'kits', 'SteamID TEXT, Kit TEXT, Date NUMBER' )

local function ShowError( ePly, sError, bShowError )
    if not bShowError then return end

    ePly:ChatPrint( sError ) -- Временно
    --ePly:NotifySend( 4, { type = 1, color = C.AMBI_ERROR, sound = SND.ERROR, time = 8, text = sError or '' } )
end

local Player = FindMetaTable( 'Player' )

function Player:CheckKit( sName, bShowError )
    sName = sName or ''

    local kit = Ambi.Kit.Get( sName )
    if not kit then ShowError( self, 'Набора '..sName..' не существует!', bShowError ) return false end

    local date = sql.QueryValue( 'SELECT Date FROM '..db..' WHERE Kit = "'..sName..'" AND SteamID = "'..self:SteamID()..'"' )
    if not date then return true end
    date = tonumber( date )

    if kit.once then ShowError( self, 'Набор '..sName..' единоразовый!', bShowError ) return false end
    
    local delay = date + kit.delay
    if ( os.time() < delay ) then ShowError( self, 'Набор будет доступен '..os.date( '%x %X', delay ), bShowError ) return false end

    return true
end

function Player:GiveKit( sName, bNoCheck )
    sName = sName or ''

    local kit = Ambi.Kit.Get( sName )
    if not kit then self:ChatSend( C.FLAT_RED, '[Kits] ', C.ABS_WHITE, 'Набора ', C.FLAT_RED, sName, ' не существует!' ) return end
    if not bNoCheck and not self:CheckKit( sName, true ) then return end

    local result = kit.action( self )
    if ( result == false ) then return end

    self:ChatSend( C.FLAT_RED, '[Kits] ', C.ABS_WHITE, 'Вам выдан набор ', C.FLAT_RED, sName )

    local date = sql.QueryValue( 'SELECT Date FROM '..db..' WHERE Kit = "'..sName..'" AND SteamID = "'..self:SteamID()..'"' )
    if date then
        SQL.UpdateDouble( db, 'Date', os.time(), 'SteamID', self:SteamID(), 'Kit', sName )
    else
        SQL.Insert( db, 'SteamID, Kit, Date', '%s, %s, %i', self:SteamID(), sName, os.time() )
    end
end