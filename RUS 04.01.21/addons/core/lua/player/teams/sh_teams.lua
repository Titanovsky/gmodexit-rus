--[[
	Стандартные команды (PVP, Build, RP, Player) в Shared.
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[30.07.20]
		• Замутил sh, чтобы тима была и на сервере, и на клиенте.
	.
	[17.08.20]
		• Выпилил клиентскую часть + поменял под глобальные переменные и добавил зелёный цвет рпшкам.
		• а нахрена я хотел обфусцировать скрипт? О_о
	.
]]

local COLOR_CITIZEN = Color( 189, 189, 189 )
local COLOR_PVP = Color( 219, 62, 44 )
local COLOR_BUILD = Color( 68, 194, 29 )
local COLOR_RP = Color( 47, 148, 224 )

team.SetUp( AMB_TEAM_CITIZEN, 'Citizen', COLOR_CITIZEN )
team.SetUp( AMB_TEAM_PVP, 'PVP', COLOR_PVP )
team.SetUp( AMB_TEAM_BUILD, 'Build', COLOR_BUILD )
team.SetUp( AMB_TEAM_RP, 'RP', COLOR_RP )
