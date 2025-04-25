--[[
	Конфиг первого сервера: [RUs].
	Основный скрипт параметров, влияющих на сервер.
	Комментируются все детали в amb_doc.lua
	Сервер находится в полном подчинений проекта: [ Ambition ]


	Примеры названий:

	local amb_var = nil
	local function AmbLib_func( sString, nNumber, fNumber )

	amb_var = nil -- global
	function AmbLib_funcStart() -- global

	local COLOR_BLOHA -- it's for static var

	tTableAdmins = {}

	[26.04.20]
		• Первая версия конфига.
	.
	[27.04.20]
		• Добавил chto-to.
	.
]]


AMB = AMB or {} -- при reload инициализирует свою же, не создаёт миллион раз одну и ту же таблу.

if CLIENT then return end -- все параметры нужны только для сервера.


AMB.config = {} -- инициализируем конфиг

-- ##############_MAIN_###################
AMB.config.loader_enable 		= true; -- turn on/off loader of scripts.
AMB.config.module_libs 			= true; -- turn on/off custom libraries.
AMB.config.module_admins 		= false; -- turn on/off [AMB] AdminMode.
AMB.config.module_propcore 		= false; -- turn on/off [AMB] PropCore.
AMB.config.module_player_stats 	= true; -- turn on/off [AMB] PropCore.
-- #######################################

AMB.config.gamemode 	= "Sandbox"; -- define current gamemode.
AMB.config.database 	= "sql" -- Type of databases: sql, mysql, data.

AMB.config.hurtplayers 			= true; -- player can to damage others?
AMB.config.noclip 				= false; -- player can to fly?
AMB.config.BlockDeathSound 		= true; -- turn off sound post death.

AMB.config.module_economic 		= false; -- [AMB] Ecomomic
AMB.config.module_events 		= false; -- [AMB] Events v1.0


MsgN( "\n| [AMB] Config has loaded |\n" )
-- Данное творение принадлежит проекту [ Ambition ]