local attempts = {}

hook.Add( 'CheckPassword', 'Ambi.Defense.AntiFrequentReconnect', function( sSteamID64 ) 
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.frequent_reconnect_enable == false ) then return end
    
    if not attempts[ sSteamID64 ] then attempts[ sSteamID64 ] = 0 end
    
    attempts[ sSteamID64 ] = attempts[ sSteamID64 ] + 1

    if ( attempts[ sSteamID64 ] > Config.frequent_reconnect_max ) then return false, '[Ambi Defense] '..Config.frequent_reconnect_block_reason end

    timer.Create( 'AntiFrequentReconnect:'..sSteamID64, Config.frequent_reconnect_block_time, 1, function() 
        attempts[ sSteamID64 ] = 0
    end )
end )