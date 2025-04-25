AmbKits = AmbKits or {}

function AmbKits.SetKit( ePly, sKit )

    if not ( AmbKits.kits[ sKit ] ) then return AmbLib.chatSend( ePly, AMB_COLOR_RED, '[•] ', AMB_COLOR_WHITE, 'Набора не существует!' ) end

    local check_access, check_delay = AmbKits.ValidateKit( ePly, sKit )

    if ( check_access == true and check_delay == false ) then

        AmbKits.GiveKit( ePly, sKit )
        AmbLib.chatSend( ePly, AMB_COLOR_GREEN, '[•] ', AMB_COLOR_WHITE, 'Вы получили набор ', AMB_COLOR_GREEN, sKit )
        print( '[AmbKits] Player: '..ePly:GetNWString( 'amb_players_name' )..' set kit '..sKit )

        if ( AmbKits.kits[ sKit ][ 'once' ] ) then

            AmbKits.CreateDelay( ePly, sKit, os.time() + AmbKits.time_f )

        else

            AmbKits.CreateDelay( ePly, sKit, os.time() + AmbKits.kits[ sKit ][ 'interval' ] )

        end

    elseif ( check_access == true and check_delay == true ) then

        local delay = tonumber( AmbKits.GetTime( ePly, sKit ) )
        local time = os.date( '%c', delay )

        AmbLib.chatSend( ePly, AMB_COLOR_RED, '[•] ', AMB_COLOR_WHITE, 'Подождите: ', AMB_COLOR_GRAY, time )

    else

        AmbLib.chatSend( ePly, AMB_COLOR_RED, '[•] ', AMB_COLOR_WHITE, 'Набор ', AMB_COLOR_RED, sKit, AMB_COLOR_WHITE, ' вам не доступен!' )

    end

end

concommand.Add( 'kit', function( ePly, cmd, args )

    AmbKits.SetKit( ePly, args[1] )

end )

function AmbKits.GiveKit( ePly, sKit )

    return AmbKits.kits[ sKit ][ 'func' ]( ePly )

end

function AmbKits.CheckAccessKit( ePly, sKit )
    
    return AmbKits.kits[ sKit ][ 'check' ]( ePly )

end

function AmbKits.ValidateKit( ePly, sKit )

    return AmbKits.CheckAccessKit( ePly, sKit ), AmbKits.CheckDelay( ePly, sKit )

end