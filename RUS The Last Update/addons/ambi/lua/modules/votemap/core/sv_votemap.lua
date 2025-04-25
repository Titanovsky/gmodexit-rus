local C = Ambi.General.Global.Colors

hook.Add( 'PostGamemodeLoaded', 'Ambi.VoteMap.DownloadMap', function()
    timer.Simple( 1, function()
        print( '===========================================================' )
        local map = Ambi.VoteMap.Config.maps[ game.GetMap() ]
        if map and map.wid then print( 'MAP', map.wid ) resource.AddWorkshop( map.wid ) end
    end )
end )

local maps = {}
local change_map = false
local current_max_players = 0 -- Потому что игроки выходят/заходят, и чтобы постоянно #player.GetHumans() не скакал

local function GetMap()
    local map
    local vote = 0

    for name, count in SortedPairs( maps ) do
        if not map then map = name end

        if ( count >= vote ) then 
            vote = count 
            map = name
        end
    end

    return map
end

local function ChangeMap( sName )
    if not sName then return end
    change_map = true
    
    timer.Create( 'AmbiVoteMapChangeMap', Ambi.VoteMap.Config.delay_before_changelevel, 1, function()
        for _, ply in ipairs( player.GetHumans() ) do
            ply:ChatPrint( '[VoteMap] Через 10 секунд поменяется карта' )
        end

        timer.Simple( 5, function()
            for _, ply in ipairs( player.GetHumans() ) do
                ply:ChatPrint( '[VoteMap] Через 5 секунд поменяется карта' )
            end

            timer.Simple( 5, function() RunConsoleCommand( 'changelevel', sName ) end )
        end )
    end )
end

net.AddString( Ambi.VoteMap.Config.net_start_votemap )
net.AddString( Ambi.VoteMap.Config.net_receive_answer )
function Ambi.VoteMap.Start()
    if Ambi.VoteMap.starting_votemap then return end

    Ambi.VoteMap.starting_votemap = true
    print( '[VoteMap] Start Vote - '..os.date( '%X', os.time() ) )

    net.Start( Ambi.VoteMap.Config.net_start_votemap )
    net.Broadcast()

    current_max_players = #player.GetHumans()

    timer.Create( 'AmbiVoteMapStartChangeMap', Ambi.VoteMap.Config.delay_before_vote, 1, function()
        for _, ply in ipairs( player.GetHumans() ) do
            ply:ChatPrint( '[VoteMap] Голосование Началось - '..os.date( '%X', os.time() ) )
            ply.given_answer_votemap = false
        end

        timer.Create( 'VoteMapEnd', Ambi.VoteMap.Config.delay_end_vote, 1, Ambi.VoteMap.End )
    end )
end

function Ambi.VoteMap.End()
    local givers = 0
    for _, ply in ipairs( player.GetHumans() ) do 
        if ply.given_answer_votemap then givers = givers + 1 end 
    end

    local map = GetMap()
    local str = ''
    if ( givers == 0 ) then 
        str = 'Карта остаётся, никто не проголосовал' 
    elseif not map then
        str = 'Карта остаётся'
    elseif map and ( map == game.GetMap() ) then
        str = 'Карта остаётся, больше голосов за нынешнюю карту'
    else
        print( '[VoteMap] Will change map on '..map )
        str = 'Следующая карта '..map..' через '..AMB.VoteMap.Config.delay_before_changelevel..' секунд'
        ChangeMap( map )
    end

    for _, ply in ipairs( player.GetHumans() ) do
        ply:ChatSend( C.AMBI_BLUE, '[VoteMap] ', C.ABS_WHITE, 'Проголосовали: '..givers..'/'..#player.GetHumans() )
        ply:ChatSend( C.AMBI_BLUE, '[VoteMap] ', C.ABS_WHITE, str )
        ply:ChatSend( C.AMBI_BLUE, '[VoteMap] ', C.ABS_WHITE, 'Голосование Завершилось - '..os.date( '%X', os.time() ) )
        ply.given_answer_votemap = false
    end

    maps = {}
    Ambi.VoteMap.starting_votemap = false
    print( '[VoteMap] End Vote - '..os.date( '%X', os.time() ) )

    timer.Remove( 'VoteMapEnd' )
end

timer.Create( 'AmbiTimerVoteMap', Ambi.VoteMap.Config.delay_call_vote, 0, Ambi.VoteMap.Start )

net.Receive( Ambi.VoteMap.Config.net_receive_answer, function( _, ePly )
    if ePly.given_answer_votemap then return end 

    ePly.given_answer_votemap = true
    local name = net.ReadString() or ''
    if not AMB.VoteMap.Config.maps[ name ] then return end

    if not maps[ name ] then maps[ name ] = 0 end
    maps[ name ] = maps[ name ] + 1

    for _, ply in ipairs( player.GetHumans() ) do
        ply:ChatSend( C.FLAT_BLUE, ePly:Name(), C.ABS_WHITE, ' проголосовал за ', name == game.GetMap() and C.AMBI_RED or C.AMBI, name )
    end

    if ( maps[ name ] >= current_max_players ) then Ambi.VoteMap.End() end
end )

-- RTV -----------------------------------------------------------------------------------------------------------
local rtv = 0

function Ambi.VoteMap.GetRTV()
    return rtv
end

function Ambi.VoteMap.AddRTV( ePly )
    if not ePly.rtv then 
        ePly.rtv = true
        rtv = rtv + 1
    end
end

function Ambi.VoteMap.StartRTV()
    if ( rtv >= #player.GetHumans() ) then 
        Ambi.VoteMap.Start() 
        rtv = 0
    end
end

hook.Add( 'PlayerDisconnected', 'Ambi.VoteMap.RemoveRTV', function( ePly )
    if ePly.rtv and ( rtv > 0 ) then rtv = rtv - 1 end
end ) 

-- AutoChange Default -----------------------------------------------------------------------------------------------------------
hook.Add( 'PlayerDisconnected', 'Ambi.VoteMap.AutoChangeDefaultMap', function( ePly )
    if not Ambi.VoteMap.Config.autochange_default_map_enable then return end

    local map = Ambi.VoteMap.Config.autochange_default_map
    if ( #player.GetHumans() == 1 ) and ( game.GetMap() ~= map ) and not change_map then 
        print( '[VoteMap] Change on default map: '..map )
        RunConsoleCommand( 'changelevel', map ) 
    end
end )