local C = Ambi.General.Global.Colors

local TEAMS = {
    [ 256 ] = Color( 164, 245, 72), -- BUILD
    [ 257 ] = Color( 233, 88, 63), -- PVP
    [ 258 ] = Color( 72, 147, 245), -- RP
}

hook.Add( 'OnPlayerChat', 'Ambi.Rus.Chat', function( ePly, sText, bTeamChat, bIsDead )
    local nick = IsValid( ePly ) and ePly:Nick() or '?'
    local color = ( IsValid( ePly ) and TEAMS[ ePly:Team() ] ) and TEAMS[ ePly:Team() ] or C.ABS_WHITE

    if not string.IsValid( sText ) then return true end
    if ( #sText > 255 ) then return true end

    chat.AddText( color, '['..nick..'] ', C.ABS_WHITE, sText )

    return true
end )