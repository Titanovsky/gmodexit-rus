local SQL, C = Ambi.SQL, Ambi.General.Global.Colors
local PLAYER = FindMetaTable( 'Player' )
local DB = 'rus_pvp'

SQL.CreateTable( DB, 'SteamID, Name, Deaths, Frags, Dominaties, Bots' )

hook.Add( 'PlayerDeath', 'Ambi.Rus.PVP', function( ePly, eInf, eAttacker ) 
    ePly.dominante = nil

    if IsValid( eAttacker ) and not eAttacker:IsPlayer() then return end
    if ( eAttacker == ePly ) then return end

    if ePly:IsBot() then
        local bots = eAttacker.nw_AllBots + 1
        eAttacker.nw_AllBots = bots
        SQL.Update( DB, 'Bots', bots, 'SteamID', eAttacker:SteamID() )

        eAttacker.dominate = nil

        return
    end

    local deaths = ePly.nw_AllDeaths + 1
    ePly.nw_AllDeaths = deaths
    SQL.Update( DB, 'Deaths', deaths, 'SteamID', ePly:SteamID() )
    
    local frags = eAttacker.nw_AllFrags + 1
    eAttacker.nw_AllFrags = frags
    SQL.Update( DB, 'Frags', frags, 'SteamID', eAttacker:SteamID() )

    if IsValid( eAttacker.dominate ) and ( eAttacker.dominate == ePly ) then
        local dominaties = eAttacker.nw_AllDominaties + 1
        eAttacker.nw_AllDominaties = dominaties
        SQL.Update( DB, 'Dominaties', dominaties, 'SteamID', eAttacker:SteamID() )

        eAttacker:EmitSound( 'ambi/csz/other/female_dominating.ogg' )

        for _, ply in ipairs( player.GetHumans() ) do
            ply:ChatSend( C.AMBI_RED, 'Игрок '..eAttacker:Name()..' доминирует над '..ePly:Name() )
        end
    end

    eAttacker.dominate = ePly
end )

hook.Add( 'PlayerInitialSpawn', 'Ambi.Rus.PVP', function( ePly )
    if ePly:IsBot() then return end

    ePly.nw_AllDeaths = 0
    ePly.nw_AllFrags = 0
    ePly.nw_AllDominaties = 0
    ePly.nw_AllBots = 0

    local sid = ePly:SteamID()
    SQL.Get( DB, 'Name', 'SteamID', sid, function()
        ePly.nw_AllDeaths = tonumber( SQL.Select( DB, 'Deaths', 'SteamID', sid ) )
        ePly.nw_AllFrags = tonumber( SQL.Select( DB, 'Frags', 'SteamID', sid ) )
        ePly.nw_AllDominaties = tonumber( SQL.Select( DB, 'Dominaties', 'SteamID', sid ) )
        ePly.nw_AllBots = tonumber( SQL.Select( DB, 'Bots', 'SteamID', sid ) )
    end, function()
        SQL.Insert( DB, 'SteamID, Name, Deaths, Frags, Dominaties, Bots', '%s, %s, %i, %i, %i, %i', sid, ePly:Nick(), 0, 0, 0, 0 )
    end )
end )

local weps_rust = {
    [ 'rust_ak47u' ] = true,
    [ 'rust_beancan' ] = true,
    [ 'rust_boltrifle' ] = true,
    [ 'rust_bone_club' ] = true,
    [ 'rust_bone_knife' ] = true,
    [ 'rust_bow' ] = true,
    [ 'rust_combat_knife' ] = true,
    [ 'rust_compoundbow' ] = true,
    [ 'rust_smg' ] = true,
    [ 'rust_doublebarrel' ] = true,
    [ 'rust_eoka' ] = true,
    [ 'rust_f1' ] = true,
    [ 'rust_l96' ] = true,
    [ 'rust_longsword' ] = true,
    [ 'rust_lr300' ] = true,
    [ 'rust_m249' ] = true,
    [ 'rust_m39emr' ] = true,
    [ 'rust_m92' ] = true,
    [ 'rust_mace' ] = true,
    [ 'rust_machete' ] = true,
    [ 'rust_mp5' ] = true,
    [ 'rust_grenadelauncher' ] = true,
    [ 'rust_nailgun' ] = true,
    [ 'rust_pitchfork' ] = true,
    [ 'rust_sawnoffshotgun' ] = true,
    [ 'rust_python' ] = true,
    [ 'rust_revolver' ] = true,
    [ 'rust_rock' ] = true,
    [ 'rust_rocketlauncher' ] = true,
    [ 'rust_salvaged_cleaver' ] = true,
    [ 'rust_salvaged_sword' ] = true,
    [ 'rust_satchel' ] = true,
    [ 'rust_sap' ] = true,
    [ 'rust_sar' ] = true,
    [ 'rust_spas12' ] = true,
    [ 'rust_stone_spear' ] = true,
    [ 'rust_thompson' ] = true,
    [ 'rust_c4' ] = true,
    [ 'rust_waterpipe' ] = true,
    [ 'rust_wooden_spear' ] = true,
}

local weps_ss2 = {
    [ 'weapon_ss2_autoshotgun' ] = true,
    [ 'weapon_ss2_colt' ] = true,
    [ 'weapon_ss2_doubleshotgun' ] = true,
    [ 'weapon_ss2_klodovik' ] = true,
    [ 'weapon_ss2_grenadelauncher' ] = true,
    [ 'weapon_ss2_circularsaw' ] = true,
    [ 'weapon_ss2_sniper' ] = true,
    [ 'weapon_ss2_cannon' ] = true,
    [ 'weapon_ss2_seriousbomb' ] = true,
    [ 'weapon_ss2_uzi' ] = true,
    [ 'weapon_ss2_plasmarifle' ] = true,
    [ 'weapon_ss2_minigun' ] = true,
    [ 'weapon_ss2_rocketlauncher' ] = true,
    [ 'weapon_ss2_zapgun' ] = true,
}

-- 0 - Free
-- 1 - HL2
-- 2 - Rust
-- 3 - SS2
local current_weps = 2

hook.Add( 'PlayerSpawnSWEP', 'Ambi.Rus.RestrictPVP', function( ePly, sClass )
    -- if not ePly:IsPVP() then return end

    -- if current_weps == 2 then
    --     if not weps_rust[ sClass ] then ePly:PlaySound( 'buttons/button8.wav' ) ePly:ChatSend( C.AMBI_RED, 'Сейчас действуют оружия из Rust!' ) return false end
    -- elseif ( current_weps == 3 ) then
    -- if not weps_ss2[ sClass ] then ePly:PlaySound( 'buttons/button8.wav' ) ePly:ChatSend( C.AMBI_RED, 'Сейчас действуют оружия из SS2!' ) return false end
    -- end
end )

hook.Add( 'PlayerGiveSWEP', 'Ambi.Rus.RestrictPVP', function( ePly, sClass )
    -- if not ePly:IsPVP() then return end

    -- if current_weps == 2 then
    --     if not weps_rust[ sClass ] then ePly:PlaySound( 'buttons/button8.wav' ) ePly:ChatSend( C.AMBI_RED, 'Сейчас действуют оружия из Rust!' ) return false end
    -- elseif ( current_weps == 3 ) then
    -- if not weps_ss2[ sClass ] then ePly:PlaySound( 'buttons/button8.wav' ) ePly:ChatSend( C.AMBI_RED, 'Сейчас действуют оружия из SS2!' ) return false end
    -- end
end )

-- hook.Add( 'PlayerSpawn', 'Ambi.Rus.RestrictPVP', function( ePly, sClass )
--     if not ePly:IsPVP() then return end

--     timer.Simple( 0, function()
--         if not IsValid( ePly ) then return end

--         local random_gun = current_weps == 2 and table.Random( table.GetKeys( weps_rust ) ) or table.Random( table.GetKeys( weps_ss2 ) )
--         ePly:Give( random_gun )
--     end )
-- end )

-- timer.Create( 'AmbiPVPSystem', 6 * 60, 0, function()
--     current_weps = ( current_weps == 2 ) and 3 or 2

--     for _, ply in ipairs( player.GetAll() ) do
--         if ply:IsPVP() then ply:ChatSend( C.AMBI_GREEN, 'Теперь доступны оружия из ', C.AMBI, current_weps == 2 and 'Rust' or 'Serious Sam 2' ) end
--     end
-- end )

-- TODO доделать эту систему полностью