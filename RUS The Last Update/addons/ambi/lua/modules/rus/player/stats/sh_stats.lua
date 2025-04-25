local NW, C = Ambi.NW, Ambi.General.Global.Colors
local PLAYER = FindMetaTable( 'Player' )

-- -------------------------------------------------------------------------------------
function PLAYER:GetLevel()
    return self.nw_Level or 0
end

-- -------------------------------------------------------------------------------------
function PLAYER:GetMoney()
    return self.nw_Money or 0
end

-- -------------------------------------------------------------------------------------
function PLAYER:GetXP()
    return self.nw_XP or 0
end

function PLAYER:GetNextXP()
    return self:GetLevel() * 1000
end

-- -------------------------------------------------------------------------------------
function PLAYER:GetAccess()
    return self.nw_AccessCoding
end

function PLAYER:CheckAccess( nAccess, sMethod )
    if ( self:GetAccess() < nAccess ) then 
        self:NotifySend( Ambi.Rus.Config.notify_type, { time = 5, text = 'Для метода '..tostring( sMethod )..' нужна '..tostring( nAccess )..' Аксеса', color = C.AMBI_RED } ) 
        
        return false 
    end

    return true
end

------------------------------------------------------------------------------------
local oldName, oldNick = PLAYER.Name, PLAYER.Nick
function PLAYER:Name()
    return self.nw_Name and tostring( self.nw_Name ) or oldName( self )
end

function PLAYER:Nick()
    return self.nw_Name and tostring( self.nw_Name ) or oldNick( self )
end

-- -------------------------------------------------------------------------------------
function PLAYER:GetStatus()
    return self.nw_Status or ''
end

function PLAYER:GetStatusColor()
    if not self.nw_StatusRed then return C.ABS_WHITE end

    return Color( self.nw_StatusRed, self.nw_StatusGreen, self.nw_StatusBlue )
end