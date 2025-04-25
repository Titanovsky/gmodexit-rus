AmbSurvive = AmbSurvive or {}
AmbSurvive.points_spawn = AmbSurvive.points_spawn or {}

function AmbSurvive.SpawnOnSleepingBag( ePly )

    if AmbSurvive.points_spawn[ ePly:SteamID() ] then

        timer.Simple( 0.1, function()

            ePly:SetPos( AmbSurvive.points_spawn[ ePly:SteamID() ] )

        end )

    end

end
hook.Add( 'PlayerSpawn', 'AmbSurviveSpawnOnSleepingBag', AmbSurvive.SpawnOnSleepingBag )