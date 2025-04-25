local C = Ambi.General.Global.Colors
local Add = Ambi.Kit.Add
local ONCE, NO_ONCE, MINUTE, HOUR = true, false, 60, 60 * 60

Add( 'bonus', 'Хороший способ фарма XP', NO_ONCE, MINUTE * 10, function( ePly )
    if ( ePly:GetLevel() == 1 ) then ePly:AddXP( 800 ) end

    local time = math.floor( ePly:TimeConnected() / 60 ) -- minutes
    time = math.floor( time / 30 ) -- half-hour

    local bonus = 100 * time
    ePly:AddXP( 25 + bonus )

    return true
end )

Add( 'zozda', 'Набор Жожды', NO_ONCE, HOUR, function( ePly )
    for _, ply in ipairs( player.GetAll() ) do
        ply:ChatSend( C.FLAT_BLUE, 'Игрок ', C.FLAT_GREEN, ePly:Gamename(), C.FLAT_BLUE, ' понюхал смачную бебру!' )
    end

    ePly:Give( 'weapong_rpg' )
    ePly:SetHealth( 255 )

    return true
end )