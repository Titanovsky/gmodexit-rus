local SQL, NW, C = Ambi.SQL, Ambi.NW, Ambi.General.Global.Colors

-- XP ------------------------------------------------------------------------------
timer.Create( '[PayDay]', 600, 0, function()
    print( os.date( '[PayDay] %X', os.time() ) )

    for _, ply in ipairs( player.GetAll() ) do
        ply:ChatSend( C.AMBI_GREEN, '>> ', C.ABS_WHITE, os.date( '%X', os.time() ) )

        if not ply.ready then continue end
        if ( ply:TimeConnected() < 120 ) then continue end

        local time = math.floor( ply:TimeConnected() / 60 ) -- minutes
        time = math.floor( time / 60 ) -- hour

        local xp = ( 3 - time <= 0 ) and 50 or math.floor( 250 - ( 100 * time ), 600 - ( 100 * time ) )
        ply:AddXP( xp )
    end
end )

hook.Add( 'OnNPCKilled', 'Ambi.Rus.FarmXP', function( eNPC, eAttacker )
    if not eAttacker:IsPlayer() then return end

    eAttacker:AddXP( math.random( 8, 64 ) ) -- 1, 25
end )

hook.Add( 'PlayerDeath', 'Ambi.Rus.AddXPForKills', function( eVictim, _, eAttacker )
    if ( eVictim == eAttacker ) then return end

    if not eAttacker:IsPlayer() then return end
    if eVictim:IsBot() then 
        local sid = eAttacker:SteamID()
        if timer.Exists( 'AmbiRusDelayBotXP['..sid..']' ) then return end

        eAttacker:AddXP( math.random( 10, 40 ) ) 
        timer.Create( 'AmbiRusDelayBotXP['..sid..']', 2, 1, function() end )
        return 
    end 

    eAttacker:AddXP( math.random( 25, 72 ) ) -- 20, 50
end )

hook.Add( 'PlayerGiveSWEP', 'Ambi.Rus.FarmXP', function( ePly )
    if ( ePly:Team() ~= RUS_TEAM_PVP ) then return end
    if timer.Exists( 'DelayObjFarmXP['..ePly:SteamID()..']' ) then return end

    ePly:AddXP( math.random( 4, 24 ) ) -- 1, 20
    timer.Create( 'DelayObjFarmXP['..ePly:SteamID()..']', 2, 1, function() end )
end )

hook.Add( 'PlayerSpawnedProp', 'Ambi.Rus.AddXPForProps', function( ePly )
    if ( ePly:Team() ~= RUS_TEAM_BUILD ) then return end
    if timer.Exists( 'DelayObjFarmXP['..ePly:SteamID()..']' ) then return end

    ePly:AddXP( math.random( 4, 24 ) ) -- 1, 20
    timer.Create( 'DelayObjFarmXP['..ePly:SteamID()..']', 2, 1, function() end )
end )

hook.Add( 'PlayerSpawnedSENT', 'AMB.Rus.AddXPForSents', function( ePly )
    if ( ePly:Team() ~= RUS_TEAM_BUILD ) then return end
    if timer.Exists( 'DelayObjFarmXP['..ePly:SteamID()..']' ) then return end

    ePly:AddXP( math.random( 4, 24 ) ) -- 1, 32
    timer.Create( 'DelayObjFarmXP['..ePly:SteamID()..']', 2, 1, function() end )
end )

hook.Add( 'PlayerSpawnedNPC', 'Ambi.Rus.AddXPForProps', function( ePly )
    if ( ePly:Team() ~= RUS_TEAM_BUILD ) then return end
    if timer.Exists( 'DelayObjFarmXP['..ePly:SteamID()..']' ) then return end

    ePly:AddXP( math.random( 4, 24 ) ) -- 1, 32
    timer.Create( 'DelayObjFarmXP['..ePly:SteamID()..']', 2, 1, function() end )
end )