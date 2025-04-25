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


team.SetUp( AMB_TEAM_CITIZEN, 'Citizen', AMB_COLOR_AMBITION )
team.SetUp( AMB_TEAM_PVP, 'PVP', AMB_COLOR_AMBITION )
team.SetUp( AMB_TEAM_BUILD, 'Builder', AMB_COLOR_AMBITION )
team.SetUp( AMB_TEAM_RP, 'RolePlayer', AMB_COLOR_AMBITION )
