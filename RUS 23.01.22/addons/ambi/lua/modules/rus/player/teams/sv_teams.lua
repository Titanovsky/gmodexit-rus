local C = Ambi.General.Global.Colors
local PLAYER = FindMetaTable( 'Player' )
local TEAMS = {
    [ 'build' ] = RUS_TEAM_BUILD,
    [ 'pvp' ] = RUS_TEAM_PVP,
    [ 'rp' ] = RUS_TEAM_RP,
    
    [ RUS_TEAM_BUILD ] = RUS_TEAM_BUILD,
    [ RUS_TEAM_PVP ] = RUS_TEAM_PVP,
    [ RUS_TEAM_RP ] = RUS_TEAM_RP,
}

-- --------------------------------------------------------------------------------------------------------- --
function PLAYER:ChangeTeam( sTeam )
    local id = TEAMS[ sTeam ]
    if not id then return end

    self:SetTeam( id )
    self:ChatSend( C.AMBI_GREEN, '[Team] ', C.ABS_WHITE, 'Вы стали ', self:TeamColor(), self:TeamName() )
    self:StripAmmo()
    self:StripWeapons()

    if ( id == RUS_TEAM_BUILD ) then
        self:Give( 'weapon_physgun' )
        self:Give( 'weapon_physcannon' )
        self:Give( 'gmod_tool' )
        self:Give( 'gmod_camera' )
    elseif ( id == RUS_TEAM_PVP ) then
        self:Give( 'weapon_crowbar' )
    end
end

-- --------------------------------------------------------------------------------------------------------- --
hook.Add( 'PlayerSpawn', 'Ambi.Rus.TeamSpawn', function( ePly )
    timer.Simple( 0.01, function()
        if ( ePly:Team() == RUS_TEAM_BUILD ) then
            ePly:Give( 'weapon_physgun' )
            ePly:Give( 'weapon_physcannon' )
            ePly:Give( 'gmod_tool' )
            ePly:Give( 'gmod_camera' )
        elseif ( ePly:Team() == RUS_TEAM_PVP ) then
            ePly:Give( 'weapon_crowbar' )
        end
    end )
end )

hook.Add( 'PlayerNoClip', 'AMB.Rus.TeamBlock', function( ePly ) 
    if ( ePly:Team() == RUS_TEAM_RP ) or ( ePly:Team() == RUS_TEAM_PVP ) then return false end
end )

hook.Add( 'PlayerShouldTakeDamage', 'AMB.Rus.TeamBlock', function( ePly, eAttacker )
    if ( ePly:Team() == RUS_TEAM_BUILD ) then return false end
    if eAttacker:IsPlayer() and ( eAttacker:Team() == RUS_TEAM_BUILD ) then return false end
    if eAttacker:IsPlayer() and ( eAttacker:Team() == RUS_TEAM_RP ) and ( ePly:Team() == RUS_TEAM_PVP ) then return false end
    if eAttacker:IsPlayer() and ( eAttacker:Team() == RUS_TEAM_PVP ) and ( ePly:Team() == RUS_TEAM_RP ) then return false end
end )

hook.Add( 'PlayerSpawnRagdoll', 'AMB.Rus.TeamBlock', function( ePly )
    if ( ePly:Team() == RUS_TEAM_PVP ) then return false end
end )

hook.Add( 'PlayerSpawnEffect', 'AMB.Rus.TeamBlock', function( ePly )
    if ( ePly:Team() == RUS_TEAM_PVP ) then return false end
end )
