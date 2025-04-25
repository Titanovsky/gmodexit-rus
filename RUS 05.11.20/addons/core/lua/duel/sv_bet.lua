AmbDuel = AmbDuel or {} 

AmbDuel.max_bet = 0
AmbDuel.winner = Entity( 0 )

local tab_players = {}

function AmbDuel.PlaceBet( ePlayer, eDuelist, nBet )

    if ( AmbDuel.bet == false ) then return end
    if ( timer.Exists( 'AmbDuelTime' ) == false ) then return end
    if ( tab_players[ ePlayer:EntIndex() ] == ePlayer ) then return end

    nBet = math.Round( nBet )
    if ( AmbStats.Players.getStats( ePlayer, '$' ) < nBet ) then return end
    if ( nBet > AmbDuel.max_bet ) then AmbLib.notifySend( ply, 'Ставка должна быть меньше '..AmbDuel.max_bet, 1, 6, 'buttons/button10.wav' ) return end

    ePlayer.duel_bet_duelist = eDuelist
    ePlayer.duel_bet = nBet
    AmbStats.Players.addStats( ePlayer, '$', -nBet )
    tab_players[ ePlayer:EntIndex() ] = ePlayer
    AmbLib.notifySend( ePlayer, 'Вы поставили ставку: '..nBet, 2, 10, 'buttons/button6.wav' )

end

function AmbDuel.TheEndBet()

    if ( AmbDuel.bet == false ) then return end

    for k, ply in pairs( tab_players ) do

        if ( IsValid( ply ) == false ) then continue end

        if ( ply.duel_bet_duelist == AmbDuel.winner ) then 

            AmbLib.notifySend( ply, 'Вы выйграли ставку!', 0, 6, 'buttons/button6.wav' )
            AmbStats.Players.addStats( ply, '$', ply.duel_bet * 2 )

        else

            AmbLib.notifySend( ply, 'Вы проиграли ставку!', 1, 6, 'buttons/button10.wav' )

        end

    end

    tab_players = {}

end

function AmbDuel.SendAllPlayersMaxBet( nBet )

    for _, v in pairs( player.GetAll() ) do
        
        v:SendLua( 'AmbDuel.max_bet='..tostring( nBet ) )

    end

end

util.AddNetworkString( 'amb_bet' )
net.Receive( 'amb_bet', function( nLen, caller )

    if ( AmbDuel.bet == false ) then caller:Kick( 'HIGHT PING (>254)' ) return end

    if ( IsValid( caller ) == false ) then return end
    if AmbDuel.IsDuelist( caller ) then caller:Kick( 'HIGHT PING (>258)' ) return end

    local duelist = net.ReadEntity()
    local bet = net.ReadUInt( 22 )

    AmbDuel.PlaceBet( caller, duelist, bet )

end )