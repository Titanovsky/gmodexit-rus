AmbVote = AmbVote or {}

AmbVote.delay = math.random( 5000, 6100 )
AmbVote.time_end_vote = 72
AmbVote.time_until_changelevel = 180
AmbVote.maps = {

    'gm_construct',
    'gm_flatgrass',
    'gm_rus',
    'gm_rus_alter',
    'gm_genesis',
    'gm_blesmont',
    'gm_sunsetgulch'

}

local function SendChatAll( ... )

    local tab = { ... }

    for _, v in pairs( player.GetAll() ) do

        AmbLib.chatSend( v, unpack( tab ) )

    end

end

local function SendSoundAll( sSound )

    for _, ply in pairs( player.GetHumans() ) do

        ply:SendLua( 'surface.PlaySound("'..sSound..'")' )
    
    end

end

function AmbVote.StartVote()

    if AmbVote.start_vote then return end

    AmbVote.votes = {}

    AmbVote.start_vote = true
    AmbVote.start_vote_map = true

    SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Началось голосование следующей карты! ('..math.floor( AmbVote.time_end_vote/60 )..' минуты)' )
    SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Для выбора карты введите в чат её номер' )
    SendSoundAll( 'ambition/amb_zombie_mode_sounds_pack/vote_start.mp3' )

    for k, map in ipairs( AmbVote.maps ) do
            
        AmbVote.votes[ k ] = 0
        SendChatAll( AMB_COLOR_RED, k..'. ', AMB_COLOR_WHITE, map )

    end

    timer.Simple( AmbVote.time_end_vote, function() AmbVote.EndVote() end )

end
timer.Create( 'AmbTimer[AmbVoteMap]', AmbVote.delay, 0, function() AmbVote.StartVote() end )

function AmbVote.PairsVotes()

    local max_v = AmbVote.votes[ 1 ]
    local max_id = 0

    for i = 1, #AmbVote.votes do

        if ( AmbVote.votes[ i ] >= max_v ) then

            max_v = AmbVote.votes[ i ]
            max_id = i

        end

    end

    if ( max_v > 0 ) then return max_id end

    return false

end

function AmbVote.EndVote()

    if not AmbVote.start_vote then return false end

    local result_vote = AmbVote.PairsVotes()

    AmbVote.start_vote = false
    AmbVote.start_vote_map = false
    AmbVote.votes = nil

    for _, ply in pairs( player.GetHumans() ) do

        ply.voter = false

    end

    SendSoundAll( 'ambition/amb_zombie_mode_sounds_pack/vote_end.mp3' )

    if not AmbVote.maps[ result_vote ] then

        SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Голосование завершено, карта остаётся. Нет результатов' )
    
        return false

    end

    if ( AmbVote.maps[ result_vote ] == game.GetMap() ) then SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Голосование завершено, карта остаётся. Большинство оставили эту карту' ) return end

    SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Голосование завершено, карта поменяется на ', AMB_COLOR_RED, tostring( AmbVote.maps[ result_vote ] ), AMB_COLOR_WHITE, ' через ', AMB_COLOR_AMETHYST, tostring( math.floor( AmbVote.time_until_changelevel/60 ) ), AMB_COLOR_WHITE, ' минуты' )
    timer.Simple( AmbVote.time_until_changelevel-10, function()

        game.CleanUpMap()
        timer.Simple( 5, function() SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Карта поменяется через 5 секунд' ) end )
        timer.Simple( 10, function() RunConsoleCommand( 'changelevel', AmbVote.maps[ result_vote ] ) end )
        
    end )

    return true

end

function AmbVote.PairsVotesBool()

    if ( AmbVote.votes[ 1 ] > AmbVote.votes[ 2 ] ) then return true end

    return false

end

function AmbVote.StartVoteRPVoice()

    if AmbVote.start_vote then return end

    AmbVote.votes = {}

    AmbVote.start_vote = true
    AmbVote.start_vote_rp_voice = true

    SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Началось голосование на Вкл/Выкл RP Voice' )
    SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Чтобы проголосовать введите в чат номер выбора!' )
     SendSoundAll( 'buttons/bell1.wav' )

    AmbVote.votes[ 1 ] = 0
    AmbVote.votes[ 2 ] = 0
    SendChatAll( AMB_COLOR_GREEN, '1. ', AMB_COLOR_WHITE, 'Включить' )
    SendChatAll( AMB_COLOR_RED, '2. ', AMB_COLOR_WHITE, 'Выключить' )

    timer.Simple( AmbVote.time_end_vote/2, function() AmbVote.EndVoteRPVoice() end )

end

function AmbVote.EndVoteRPVoice()

    if not AmbVote.start_vote then return false end

    local result_vote = AmbVote.PairsVotesBool()

    AmbVote.start_vote = false
    AmbVote.start_vote_rp_voice = false
    AmbVote.votes = nil

    for _, ply in pairs( player.GetHumans() ) do

        ply.voter = false

    end

    if not result_vote then

        SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Голосование завершено, РП Войс выключен.' )

        RunConsoleCommand( 'amb_rp_voice', '0' )

        return false

    end

    SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'RP Войс будет включён.' )

    RunConsoleCommand( 'amb_rp_voice', '1' )

    return true

end

function AmbVote.StartVoteFallDamage()

    if AmbVote.start_vote then return end

    AmbVote.votes = {}

    AmbVote.start_vote = true
    AmbVote.start_vote_rp_voice = true

    SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Началось голосование на Вкл/Выкл Реалистичный Урон от Падения' )
    SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Чтобы проголосовать введите в чат номер выбора!' )
    SendSoundAll( 'buttons/bell1.wav' )

    AmbVote.votes[ 1 ] = 0
    AmbVote.votes[ 2 ] = 0
    SendChatAll( AMB_COLOR_GREEN, '1. ', AMB_COLOR_WHITE, 'Включить' )
    SendChatAll( AMB_COLOR_RED, '2. ', AMB_COLOR_WHITE, 'Выключить' )

    timer.Simple( AmbVote.time_end_vote/2, function() AmbVote.EndVoteFallDamage() end )

end

function AmbVote.EndVoteFallDamage()

    if not AmbVote.start_vote then return false end

    local result_vote = AmbVote.PairsVotesBool()

    AmbVote.start_vote = false
    AmbVote.start_vote_falldamage = false
    AmbVote.votes = nil

    for _, ply in pairs( player.GetHumans() ) do

        ply.voter = false

    end

    if not result_vote then

        SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Голосование завершено, Реалистичный Урон от Падения выключен.' )

        RunConsoleCommand( 'mp_falldamage', '0' )

        return false

    end

    SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Реалистичный Урон от Падения будет включён.' )

    RunConsoleCommand( 'mp_falldamage', '1' )

    return true

end

hook.Add( 'PlayerSay', 'AmbitionVoteMap', function( ePly, sText ) 

    if AmbVote.start_vote then

        if AmbVote.maps[ tonumber( sText ) ] and not ePly.voter and AmbVote.start_vote_map then 
        
            AmbVote.votes[ tonumber( sText ) ] = AmbVote.votes[ tonumber( sText ) ] + 1
            ePly.voter = true
            AmbLib.chatSend( ePly, AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Вы проголосовали за ', AMB_COLOR_AMETHYST, AmbVote.maps[ tonumber( sText ) ], AMB_COLOR_WHITE, ', больше нельзя голосовать!' )
            SendChatAll( AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Карта ', AMB_COLOR_RED, AmbVote.maps[ tonumber( sText ) ]..' ['..AmbVote.votes[ tonumber( sText ) ]..'/'..#player.GetHumans()..']' )

            if ( AmbVote.votes[ tonumber( sText ) ] == #player.GetHumans() ) then AmbVote.EndVote() end
            
        end

        if AmbVote.start_vote_rp_voice and AmbVote.votes[ tonumber( sText ) ] and not ePly.voter then

            local result = ( sText == '1' ) and 'Положительный ответ' or 'Отрицательный ответ'

            AmbVote.votes[ tonumber( sText ) ] = AmbVote.votes[ tonumber( sText ) ] + 1
            ePly.voter = true
            AmbLib.chatSend( ePly, AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Вы дали '..result )

            if ( AmbVote.votes[ tonumber( sText ) ] == #player.GetHumans() ) then AmbVote.EndVoteRPVoice() end

        end

        if AmbVote.start_vote_falldamage and AmbVote.votes[ tonumber( sText ) ] and not ePly.voter then

            local result = ( sText == '1' ) and 'Положительный ответ' or 'Отрицательный ответ'

            AmbVote.votes[ tonumber( sText ) ] = AmbVote.votes[ tonumber( sText ) ] + 1
            ePly.voter = true
            AmbLib.chatSend( ePly, AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, 'Вы дали '..result )

            if ( AmbVote.votes[ tonumber( sText ) ] == #player.GetHumans() ) then AmbVote.EndVoteFallDamage() end

        end

    end

end )