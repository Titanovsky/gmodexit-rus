--[[
	Основные переменные и таблицы для серверов на проекте [ Ambition ].
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[05.09.20]
		• Эту сис-му тоже сделал где-то в середине августа. Код надо переработать + добавить приглашения и менюшку.
	.
    [12.10.20]
        • Полностью переделал систему: добавил архитектуру, разделил на блоки, переписал логику.
    .
]]

AmbDuel = AmbDuel or {} 

AmbDuel.min_award = 5
AmbDuel.max_award = 10000

AmbDuel.max_health = 400

AmbDuel.delay = 45
AmbDuel.time_duel = 300
AmbDuel.time_accept = 25
AmbDuel.delay_start = 15

AmbDuel.bet = true

AmbDuel.places = { 
    [1] = { pos = Vector( -9034, -15348, 590 ), ang = Angle( 0, -90, 0 ) },
    [2] = { pos = Vector( -8105, -15029, 590 ), ang = Angle( 0, 90, 0 ) },
    ['end'] = { pos = Vector( -8423, -14806, 653 ), ang = Angle( 0, 90, 0 ) }
}

AmbDuel.min_level = 2
AmbDuel.return_guns = {
    'weapon_physgun',
    'weapon_physcannon'
}
AmbDuel.access_guns = {
    'weapon_crossbow',
    'weapon_357',

    'arccw_minigun',
    'arccw_awm'
}
