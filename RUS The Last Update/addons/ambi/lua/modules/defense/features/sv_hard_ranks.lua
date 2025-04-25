local PLAYER = FindMetaTable( 'Player' )

local oldSetUserGroup = PLAYER.SetUserGroup
function PLAYER:SetUserGroup( sGroup )
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return oldSetUserGroup( self, sGroup ) end
    if ( Config.hard_ranks_enable == false ) then return oldSetUserGroup( self, sGroup ) end

    if Config.hard_ranks_list[ sGroup ] and not Config.hard_ranks_whitelist[ self:SteamID() ] then Ambi.Defense.Punish( self, Config.hard_ranks_punishment, 'Попытка стать рангом, к которому нет доступа!', 'Попытался стать '..sGroup ) return end

    return oldSetUserGroup( self, sGroup )
end