hook.Add( 'PostGamemodeLoaded', 'Ambi.Rus.RemoveHostnameThink', function() 
    timer.Remove( 'HostnameThink' )
end )

local RANDOM_EMOJI = {
    '🎅🏻', '🎄', '☃️', '❄️'
}

local RANDOM_PHRASES = {
    'Халявная Админка',
    'PVP / BUILD',
    'Готовимся к Новому Году',
    'Фотосессия и Подарки!',
    'Подарки!',
    'Новые Обновления',
    '50 GB Контент 😈',
    'ПРАЗДНИК К НАМ ПРИХОДИТ!',
    'Кола - Кола санкционная здеся',
    'Билли Джин Насрал в Кувшин',
    'Nanomachines, son!',
    'Обновление подъездает...',
    'Why you bullying me?',
}

timer.Create( 'ChangeHostname', 120, 0, function() 
    local hostname = table.Random( RANDOM_EMOJI )..' RUS || The Last Update'

    RunConsoleCommand( 'hostname', hostname )
    SetGlobalString( 'ServerName', hostname )
end )