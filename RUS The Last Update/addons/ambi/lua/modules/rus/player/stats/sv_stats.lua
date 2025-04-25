local SQL, NW, C = Ambi.SQL, Ambi.NW, Ambi.General.Global.Colors
local PLAYER = FindMetaTable( 'Player' )
local DB = 'rus_players'

SQL.CreateTable( DB, 'SteamID, Name, Level, XP, Access, Money' )

-- -------------------------------------------------------------------------------------
function PLAYER:SetLevel( nLevel )
    if not self.ready then return end

    nLevel = nLevel or 1

    self.nw_Level = nLevel
    SQL.Update( DB, 'Level', nLevel, 'SteamID', self:SteamID() )

    self:SetXP( 0 )

    hook.Call( '[Ambi.Rus.SetLevel]', nil, self, nLevel )
end

function PLAYER:AddLevel( nLevel )
    nLevel = nLevel or 0

    self:SetLevel( self:GetLevel() + nLevel )
    self:NotifySend( Ambi.Rus.Config.notify_type, { time = 5, text = '+Level '..nLevel, color = C.AMBI_PURPLE } )
end

-- -------------------------------------------------------------------------------------
function PLAYER:SetXP( nXP )
    if not self.ready then return end

    nXP = nXP or 0
    if ( nXP < 0 ) then return end

    self.nw_XP = nXP
    SQL.Update( DB, 'XP', nXP, 'SteamID', self:SteamID() )

    if ( self:GetXP() >= self:GetNextXP() ) then
        local remains = self:GetXP() - self:GetNextXP()

        self:AddLevel( 1 )
        self:AddXP( remains )
    end
end

function PLAYER:AddXP( nXP )
    nXP = nXP or 0

    self:SetXP( self:GetXP() + nXP )
    self:NotifySend( Ambi.Rus.Config.notify_type, { time = 2, text = '+XP '..nXP, color = C.AMBI } )
end

-- -------------------------------------------------------------------------------------
function PLAYER:SetMoney( nMoney )
    if not self.ready then return end
    if ( nMoney < 0 ) then nMoney = 0 end

    self.nw_Money = nMoney
    SQL.Update( DB, 'Money', nMoney, 'SteamID', self:SteamID() )
end

function PLAYER:AddMoney( nMoney )
    nMoney = nMoney or 0

    self:SetMoney( self:GetMoney() + nMoney )
    self:NotifySend( Ambi.Rus.Config.notify_type, { time = 2, text = nMoney..'$', color = C.AMBI_GREEN } )
end

-- -------------------------------------------------------------------------------------
function PLAYER:SetAccess( nAccess )
    if not self.ready then return end

    self.nw_AccessCoding = nAccess

    SQL.Update( DB, 'Access', nAccess, 'SteamID', self:SteamID() )
end

-- -------------------------------------------------------------------------------------
function PLAYER:SetName( sName )
    if not self.ready then return end

    self.nw_Name = sName

    SQL.Update( DB, 'Name', sName, 'SteamID', self:SteamID() )

    self:ChatPrint( 'Теперь ваше имя: '..sName )
end

-- -------------------------------------------------------------------------------------
function PLAYER:SetStatus( sStatus )
    if not self.ready then return end

    self.nw_Status = tostring( sStatus )
end

function PLAYER:SetStatusColor( cColor )
    if not self.ready then return end

    self.nw_StatusRed = cColor.r
    self.nw_StatusGreen = cColor.g
    self.nw_StatusBlue = cColor.b
end

-- -------------------------------------------------------------------------------------
hook.Add( 'PlayerInitialSpawn', 'Ambi.Rus.SetStats', function( ePly )
    timer.Simple( 1, function()
        if ePly:IsBot() then 
            ePly.nw_Name = table.Random( Ambi.Rus.Config.bot_names[ 1 ] )..' '..table.Random( Ambi.Rus.Config.bot_names[ 2 ] ) 
            ePly:ChangeTeam( 'pvp' )    
            
            return 
        end

        local sid = ePly:SteamID()
        local bNewPlayer

        SQL.Get( DB, 'Name', 'SteamID', sid, function()
            local level = SQL.Select( DB, 'Level', 'SteamID', sid )
            local xp = SQL.Select( DB, 'XP', 'SteamID', sid )
            local access = SQL.Select( DB, 'Access', 'SteamID', sid )
            local money = SQL.Select( DB, 'Money', 'SteamID', sid )

            ePly.nw_Level = tonumber( level )
            ePly.nw_XP = tonumber( xp )
            ePly.nw_AccessCoding = tonumber( access )
            ePly.nw_Money = tonumber( money )
        end, function()
            ePly.nw_Level = 1
            ePly.nw_XP = 0
            ePly.nw_AccessCoding = 0
            ePly.nw_Money = 0

            SQL.Insert( DB, 'SteamID, Name, Level, XP, Access, Money', '%s, %s, %i, %i, %i, %i', sid, ePly:Nick(), 1, 0, 0, 0 )

            bNewPlayer = true
        end )

        ePly.nw_Name = SQL.Select( DB, 'Name', 'SteamID', sid )

        if bNewPlayer then 
            ePly:RunCommand( 'ambi_infohud 9' )

            ePly:ChatSend( C.ABS_WHITE, 'Рекомендую использовать ', C.FLAT_RED, '/kit bonus' )
        end

        ePly:ChangeTeam( RUS_TEAM_BUILD )
        ePly.ready = true
    end )
end )