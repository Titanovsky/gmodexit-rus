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

    if self:InVehicle() then self:ExitVehicle() end

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
    end
end

-- --------------------------------------------------------------------------------------------------------- --
local weapon_assets = {}

function Ambi.Rus.SaveWeapons( ePly )
    ePly:ChatPrint( 'Временно не работает!' )
    -- weapon_assets[ ePly ] = { weps = {}, ammo = {} }

    -- for _, wep in ipairs( ePly:GetWeapons() ) do
    --     weapon_assets[ ePly ].weps[ #weapon_assets[ ePly ].weps + 1 ] = wep:GetClass()
    -- end

    -- for ammo_type, count in pairs( ePly:GetAmmo() ) do
    --     weapon_assets[ ePly ].ammo[ ammo_type ] = count
    -- end
end

function Ambi.Rus.RemoveSaveWeapons( ePly )
    weapon_assets[ ePly ] = nil 
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
            ePly:Give( 'gmod_tool' )
            ePly:SendLua( 'Ambi.Rus.ShowPVPImmortal()' )

            ePly.old_pvp_material = ePly:GetMaterial()
            ePly:GodEnable()
            ePly:SetMaterial( 'models/alyx/emptool_glow' )

            timer.Simple( 4, function()
                if IsValid( ePly ) then
                    ePly:GodDisable()

                    if not ePly:Alive() then return end

                    if ePly.old_pvp_material then ePly:SetMaterial( ePly.old_pvp_material ) end
                    ePly.old_pvp_material = nil

                    local assets = weapon_assets[ ePly ]
                    if ePly.disable_auto_weapons_give then return end
                    if not assets then return end

                    for _, class in ipairs( assets.weps ) do
                        ePly:Give( class )
                    end

                    for type, count in pairs( assets.ammo ) do
                        ePly:SetAmmo( count, type )
                    end
                end
            end )
        end

        local points = Ambi.Rus.teams_spawns[ game.GetMap() ]
        if Ambi.Rus.teams_spawns[ game.GetMap() ] then
            local points = points[ ePly:Team() ]
            if points then
                local point = table.Random( points )

                ePly:SetPos( point.pos )
                ePly:SetEyeAngles( point.ang )
            end
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
    if eAttacker:IsPlayer() and ( eAttacker:Team() == RUS_TEAM_PVP ) and eAttacker.old_pvp_material then return false end
end )

hook.Add( 'PlayerSpawnRagdoll', 'AMB.Rus.TeamBlock', function( ePly )
    if ( ePly:Team() == RUS_TEAM_PVP ) then return false end
end )

hook.Add( 'PlayerSpawnEffect', 'AMB.Rus.TeamBlock', function( ePly )
    if ( ePly:Team() == RUS_TEAM_PVP ) then return false end
end )

hook.Add( 'PlayerGiveSWEP', 'Ambi.Rus.GiveMoreAmmoForPVP', function( ePly, sClass )
    timer.Simple( 0.25, function()
        if not IsValid( ePly ) then return end
        if ( ePly:Team() != RUS_TEAM_PVP ) then return end

        local wep = ePly:GetWeapon( sClass )
        if not IsValid( wep ) then return end

        ePly:GiveAmmo( 9999, wep:GetPrimaryAmmoType(), true )
    end )
end )

------------------------------------------------------------------------------------------------------------------------------------

CreateConVar( 'ambi_rus_rp_voice', 0, FCVAR_REPLICATED + FCVAR_NOTIFY )

hook.Add( 'PlayerCanHearPlayersVoice', 'Ambi.Rus.RPVoice', function( eListener, eTalker )
    if GetConVar( 'ambi_rus_rp_voice' ):GetBool() then
        if ( eListener:GetPos():Distance( eTalker:GetPos() ) <= 1400 ) then
            return true, true
        else
            return false
        end
    end
end )