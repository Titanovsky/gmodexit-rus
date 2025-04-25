function Ambi.VoteMap.Add( sMap, sDescription, sLogo, sWid )
    Ambi.VoteMap.Config.maps[ sMap ] = {
        description = sDescription or '',
        logo = sLogo or 'https://i.imgur.com/o9dFS5r.png',
        wid = sWid,
    }
end

if not Ambi.ChatCommands then return end
local Add = Ambi.ChatCommands.AddCommand

local TYPE = 'VoteMap'

Add( 'rtv', TYPE, 'Проголосовать за вызов смены карты', 0.75, function( ePly, tArgs ) 
    if not ePly.rtv then Ambi.VoteMap.AddRTV( ePly ) end

    ePly:ChatPrint( 'RTV: '..Ambi.VoteMap.GetRTV()..'/'..#player.GetHumans() )
    Ambi.VoteMap.StartRTV()
end )