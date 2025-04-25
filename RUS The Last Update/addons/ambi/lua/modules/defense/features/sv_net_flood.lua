local players = {}

hook.Add( '[Ambi.General.Network.CanIncoming]', 'Ambi.Defense.AntiNetFlood', function( ePly, sName, fAction )
    if ePly.defense_block_msg then return false end -- Чтобы не вызывалось наказание столько раз, сколько игрок нафлудил

    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.net_flood_enable == false ) then return end

    local sid = ePly:SteamID()

    if not players[ sid ] then players[ sid ] = {} end
    if not players[ sid ][ sName ] then players[ sid ][ sName ] = 0 end

    local max = Config.net_flood_exceptiones[ sName ] and Config.net_flood_exceptiones[ sName ].max or Config.net_flood_max
    if ( players[ sid ][ sName ] > max ) then 
        ePly.defense_block_msg = true
        Ambi.Defense.Punish( ePly, Config.net_flood_punishment, 'Флуд сетевыми сообщениями!', 'Флудит net ['..sName..']' ) 
        
        return false 
    end
    
    players[ sid ][ sName ] = players[ sid ][ sName ] + 1

    local delay = Config.net_flood_exceptiones[ sName ] and Config.net_flood_exceptiones[ sName ].delay or Config.net_flood_delay
    timer.Create( 'AntiNetFlood:'..sid..':'..sName, delay, 1, function() 
        players[ sid ][ sName ] = 0
    end )

    if Config.net_flood_log then print( '[Defense] '..ePly:Nick()..'('..sid..') send to server: '..sName..' ['..players[ sid ][ sName ]..'/'..max..']' ) end
end )