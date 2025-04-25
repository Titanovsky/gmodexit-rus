AmbDuel = AmbDuel or {}

local duelist1 = Entity( 0 )
local duelist2 = Entity( 0 )
local award = 0
local health = 0
local armor = 0
local gun = 'gmod_tool'
local winner = Entity( 0 )
local loser = Entity( 0 )

function AmbDuel.PreparingStart( eDuelist1, eDuelist2, nAward, nHealth, nArmor, sGun )

    if timer.Exists( 'AmbDuelTime' ) then eDuelist1:ChatPrint('ERROR: #1') return end
    if timer.Exists( 'AmbDuelDelay' ) then AmbLib.notifySend( eDuelist1, 'Подождите: '..math.Round( timer.TimeLeft( 'AmbDuelDelay' ) )..' секунд', 1, 6, 'buttons/button10.wav' ) return end
    if timer.Exists( 'AmbDuelAccept' ) then eDuelist1:ChatPrint('ERROR: #3') return end

    nAward = math.Round( nAward )
    if ( nAward < AmbDuel.min_award or nAward > AmbDuel.max_award ) then eDuelist1:ChatPrint('ERROR: #4') return end

    if ( AmbDuel.ValidationProperties( nHealth, nArmor ) == false ) then eDuelist1:ChatPrint('ERROR: #5') return end
    if ( AmbDuel.ValidationPlayersData( eDuelist1, eDuelist2, nAward ) == false ) then return end
    if ( AmbDuel.ValidationGun( sGun ) == false ) then eDuelist1:ChatPrint('ERROR: #15') return end

    timer.Create( 'AmbDuelAccept', AmbDuel.time_accept, 1, function() end )

    duelist1 = eDuelist1
    duelist2 = eDuelist2
    award = nAward
    health = nHealth
    armor = nArmor
    gun = sGun

    AmbLib.notifySend( eDuelist1, 'Вы вызвали на дуэль игрока, ожидайте его ответа', 0, AmbDuel.time_accept, 'buttons/button6.wav' )
    AmbLib.notifySend( eDuelist2, 'Вас вызвали на дуэль, чтобы принять напишите /accept', 0, AmbDuel.time_accept, 'buttons/button6.wav' )

end

function AmbDuel.AcceptDuel( ePly )

    if ( ePly == duelist2 ) and timer.Exists( 'AmbDuelAccept' ) then

        AmbDuel.Start( duelist1, duelist2, award, health, armor, gun )
        timer.Remove( 'AmbDuelAccept' )

    end

end

function AmbDuel.Start( eDuelist1, eDuelist2, nAward, nHealth, nArmor, sGun )

    timer.Create( 'AmbDuelTime', AmbDuel.time_duel, 1, function() 

        AmbDuel.End( 1 )
    
    end )

    AmbDuel.SetDuelist( eDuelist1, true )
    AmbStats.Players.addStats( eDuelist1, '$', -award )
    eDuelist1:Spawn()
    eDuelist1:SetPos( AmbDuel.places[1].pos )
    eDuelist1:SetEyeAngles( AmbDuel.places[1].ang )
    eDuelist1:SetHealth( nHealth )
    eDuelist1:SetArmor( nArmor )
    eDuelist1:StripWeapons()
    eDuelist1:Freeze( true )
    AmbLib.notifySend( eDuelist1, 'Дуэль начнется через: '..AmbDuel.delay_start..' секунд!', 0, 14 )

    AmbDuel.SetDuelist( eDuelist2, true )
    AmbStats.Players.addStats( eDuelist2, '$', -award )
    eDuelist2:Spawn()
    eDuelist2:SetPos( AmbDuel.places[2].pos )
    eDuelist2:SetEyeAngles( AmbDuel.places[2].ang )
    eDuelist2:SetHealth( nHealth )
    eDuelist2:SetArmor( nArmor )
    eDuelist2:StripWeapons()
    eDuelist2:Freeze( true )
    AmbLib.notifySend( eDuelist2, 'Дуэль начнется через: '..AmbDuel.delay_start..' секунд!', 0, 14 )

    timer.Create( 'AmbDuelFreezeStart', AmbDuel.delay_start, 1, function()
    
        eDuelist1:Freeze( false )
        eDuelist1:Give( sGun )
        eDuelist1:GiveAmmo( 255, eDuelist1:GetWeapon( sGun ):GetPrimaryAmmoType() )

        eDuelist2:Freeze( false )
        eDuelist2:Give( sGun )
        eDuelist2:GiveAmmo( 255, eDuelist2:GetWeapon( sGun ):GetPrimaryAmmoType() )
    
    end )

    if AmbDuel.bet then

        AmbDuel.max_bet = math.Round( award / 2 )
        AmbDuel.SendAllPlayersMaxBet( AmbDuel.max_bet )

    end

end

function AmbDuel.End( nFlag )

    if not timer.Exists( 'AmbDuelTime' ) then return end

    timer.Create( 'AmbDuelDelay', AmbDuel.delay, 1, function() end )

    if ( nFlag == 0 ) then

        timer.Remove( 'AmbDuelTime' )

        winner:SetPos( AmbDuel.places['end'].pos )
        winner:SetEyeAngles( AmbDuel.places['end'].ang )
        AmbStats.Players.addStats( winner, '$', award * 2 )
        AmbLib.notifySend( winner, 'Вы одержали победу в дуэли!', 1, 12 )
        AmbDuel.ReturnWeapon( winner )

        AmbLib.notifySend( loser, 'Вы не смогли в дуэль!', 1, 6, 'buttons/button10.wav' )

        if AmbDuel.bet then

            AmbDuel.winner = winner
            AmbDuel.TheEndBet()

        end

    else -- time is up

        if IsValid( duelist1 ) and duelist1:Alive() then 

            duelist1:Kill() 
            AmbLib.notifySend( duelist1, 'Время вышло!', 4, 1 )

        end

        if IsValid( duelist2 ) and duelist2:Alive() then 
        
            duelist2:Kill() 
            AmbLib.notifySend( duelist2, 'Время вышло!', 4, 1 )

        end

    end

    AmbDuel.SetDuelist( duelist1, false )
    AmbDuel.SetDuelist( duelist2, false )

end

function AmbDuel.ReturnWeapon( eWinner )

    eWinner:StripWeapons()
    eWinner:StripAmmo()

     for _, gun in pairs( AmbDuel.return_guns ) do

        winner:Give( gun )

    end

end

function AmbDuel.SetDuelist( ePly, bool )

    ePly:SetNWBool( 'Duel', bool )

end

function AmbDuel.IsDuelist( ePly )

    return ePly:GetNWBool( 'Duel' )

end

function AmbDuel.ValidationPlayersData( ePly1, ePly2, nAward )

    if ( IsValid( ePly1 ) == false ) or ( IsValid( ePly1 ) == false ) then ePly1:ChatPrint('ERROR: #6') return false end
    if ePly1:GetNWBool( 'amb_bad') or ePly2:GetNWBool( 'amb_bad') then ePly1:ChatPrint('ERROR: #7') return false end
    if ( ePly1 == ePly2 ) then eDuelist1:ChatPrint('ERROR: #8') return false end
    if ( ePly1:IsPlayer() == false ) or ( ePly2:IsPlayer() == false ) then ePly1:ChatPrint('ERROR: #9') return false end

    if ( AmbStats.Players.getStats( ePly1, '$' ) < nAward ) then ePly1:ChatPrint('ERROR: #10') return false end
    if ( AmbStats.Players.getStats( ePly2, '$' ) < nAward ) then ePly1:ChatPrint('ERROR: #11') return false end
    if ( AmbStats.Players.getStats( ePly1, '!' ) < AmbDuel.min_level ) then ePly1:ChatPrint('ERROR: #12') return false end
    if ( AmbStats.Players.getStats( ePly2, '!' ) < AmbDuel.min_level ) then ePly1:ChatPrint('ERROR: #13') return false end

    -- todo: will make check distance between ePly2 and NPC ( for DarkRP )

    if ( ePly1:Team() ~= AMB_TEAM_PVP or ePly2:Team() ~= AMB_TEAM_PVP ) then ePly1:ChatPrint('ERROR: #14') return false end -- only sandbox

    return true

end

function AmbDuel.ValidationProperties( nHealth, nArmor )

    if ( nHealth < 1 or nHealth > AmbDuel.max_health ) then return false end
    if ( nArmor < 0 or nHealth > 255 ) then return false end

    return true

end

function AmbDuel.ValidationGun( sGun )
    
    for _, gun in pairs( AmbDuel.access_guns ) do

        if ( gun == sGun ) then return true end

    end

    return false

end

hook.Add( 'PlayerDeath', 'TheEndDuel', function( eVictim, _, eAttacker )

    if ( AmbDuel.IsDuelist( eVictim ) == false or AmbDuel.IsDuelist( eAttacker ) == false ) then return end

    winner = eAttacker
    loser = eVictim
    AmbDuel.End( 0 )

end )

hook.Add( 'PlayerDisconnected', 'TheEndDuel', function( ePly ) 

    if AmbDuel.IsDuelist( ePly ) then

        if ( ePly == duelist1 ) then

            winner = duelist2
        
        elseif ( ePly == duelist2 ) then

            winner = duelist1

        end

        AmbDuel.End( 0 )

    end

end )

hook.Add( 'CanPlayerSuicide', 'RestrictDuelist', function( ePly )

	if AmbDuel.IsDuelist( ePly ) then

        return false

    end

end )

hook.Add( 'PlayerGiveSWEP', 'RestrictDuelist', function( ePly )

    if AmbDuel.IsDuelist( ePly ) then

        return false

    end

end )

hook.Add( 'PlayerSpawnSWEP', 'RestrictDuelist', function( ePly )

    if AmbDuel.IsDuelist( ePly ) then

        return false

    end

end )

hook.Add( 'PlayerSpawnSENT', 'RestrictDuelist', function( ePly )

    if AmbDuel.IsDuelist( ePly ) then

        return false

    end

end )

hook.Add( 'PlayerSpawnProp', 'amb_0x726', function( ePly )

    if AmbDuel.IsDuelist( ePly ) then

        return false

    end

end )

util.AddNetworkString( 'amb_duel' )
net.Receive( 'amb_duel', function( nLen, caller )

    if ( IsValid( caller ) == false ) then return end
    if ( AmbStats.Players.getStats( caller, '!' ) < AmbDuel.min_level ) then caller:Kick( 'HIGHT PING (>255)' ) return end

    local options = {}
    options.duelist1 = caller
    options.duelist2 = net.ReadEntity()
    options.award = net.ReadUInt( 22 )
    options.health = net.ReadInt( 22 )
    options.armor = net.ReadInt( 22 )
    options.gun = net.ReadString()

    caller:ChatPrint('SDASd')

    AmbDuel.PreparingStart( options.duelist1, options.duelist2, options.award, options.health, options.armor, options.gun )

    options = nil

end )