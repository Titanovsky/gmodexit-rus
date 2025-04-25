local SQL = Ambi.SQL
local DB = SQL.CreateTable( 'times', 'SteamID TEXT, Time NUMERIC' )

hook.Add( 'PlayerInitialSpawn', 'Ambi.Time.SetTable', function( ePly )
    if ePly:IsBot() then return end

    local sid = ePly:SteamID()

    SQL.Get( DB, 'SteamID', 'SteamID', sid, function()
    end, function() 
        SQL.Insert( DB, 'SteamID, Time', '%s, %i', sid, 0 )
    end )

    ePly.enable_time_checker = true
end )

timer.Create( 'AmbiTimePlayerChecker', Ambi.Time.Config.save_players_time_delay, 0, function()
    if not Ambi.Time.Config.save_players_time then return end

    for _, ply in ipairs( player.GetAll() ) do
        if ply.enable_time_checker then 
            local sid = ply:SteamID()
            local time = tonumber( SQL.Select( DB, 'Time', 'SteamID', sid ) )
            SQL.Update( DB, 'Time', time + Ambi.Time.Config.save_players_time_delay, 'SteamID', sid ) 
        end
    end
end )