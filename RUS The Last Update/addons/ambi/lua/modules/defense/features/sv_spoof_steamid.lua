hook.Add( 'PlayerInitialSpawn', 'Ambi.Defense.AntiSteamIDSpoof', function( ePly )
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.spoof_steamid == false ) then return end

    timer.Simple( 0, function()
        if ( IsValid( ePly ) == false ) or ePly:IsBot() or ( ePly.IsFullyAuthenticated == nil ) or ePly:IsFullyAuthenticated() then return end

        Ambi.Defense.Punish( ePly, Config.spoof_steamid_punishment, 'Вы не авторизовались во время! Попробуйте перезайти!', 'Игрок '..ePly:Nick()..'('..ePly:SteamID()..') не смог авторизоваться в отведённое время, возможно Spoof SteamID' ) 
    end )
end )