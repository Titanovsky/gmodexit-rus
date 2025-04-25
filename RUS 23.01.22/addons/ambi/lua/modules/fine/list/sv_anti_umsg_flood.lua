local Add, Give = Ambi.Fine.Add, Ambi.Fine.Give
-- Не доделан
local antiumsgflood = 'AntiUmsgFlood'
Add( antiumsgflood, 'Защита от флуда в старой библе umsg', 2, 0.65, 8, function( ePly )
    local date = os.date( '%x %X', os.time() )
    ePly:Kick( '[AntiCheat] Вы кикнуты за флуд запросами!\n\nДата: '..date )
end )

--[[
local old_umsg_Start = umsg.Start
function umsg.Start( sMessage, recipientPlayers )

    local enable = AMB.Fine.Config.umsg_start
    local word = enable and '[Block] ' or ''
    AMB.Debug( function() print( '[Debug] Umsg Start '..word..'"'..sMessage..'"' ) end )

    if enable then old_umsg_Start( str, receivers ) end

end
]]--
