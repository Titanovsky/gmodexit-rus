local count = {}

hook.Add( 'PlayerSay', 'Ambi.Defense.AntiChatFlood', function( ePly, sText ) 
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.chat_flood_enable == false ) then return end

    local sid = ePly:SteamID()
    if not count[ sid ] then count[ sid ] = 0 end

    count[ sid ] = count[ sid ] + 1

    if ( count[ sid ] >= Config.chat_flood_max ) then Ambi.Defense.Punish( ePly, Config.chat_flood_punishment, 'Не флудите в чат!', 'Игрок '..ePly:Nick()..'('..ePly:SteamID()..') флудит в чат!' )  return false end

    timer.Create( 'AntiChatFlood:'..sid, Config.chat_flood_delay, 1, function() 
        count[ sid ] = 0
    end )
end )