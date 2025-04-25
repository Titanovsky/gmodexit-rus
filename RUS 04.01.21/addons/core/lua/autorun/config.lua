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
	[08.08.20]
		• Решил, что матрицей для DarkRP будет служить [RUs], а значит придётся обновить конфиг и сделать его более важным.
		• Добавил все существующие модули ( permaprops, duel, drinks, workshopdl и т.д ).
	.
	[09.08.20]
		• Потихоньку сюда добавляю модули, ибо в аддонах делаю проверку на них.
	.
	[10.08.20]
		• Добавил survive.
	.
	[24.09.20]
		• Добавил большой модуль rp.
	.
]]

AMB = AMB or {}

AMB.config = {} 

-- ##############_MAIN_###################
AMB.config.loader_enable 		= true;
AMB.config.module_libs 			= true;
AMB.config.module_admins 		= false;
AMB.config.module_propcore 		= false;
AMB.config.module_stats 		= true;
-- #######################################

AMB.config.gamemode 	= "Sandbox";
--AMB.config.database 	= "sql" -- Type of databases: sql, mysql, data.

AMB.config.hurtplayers 			= 1;
AMB.config.noclip 				= 0;
AMB.config.OnDeathSound 		= false;

AMB.config.module_economic 		= true;
AMB.config.module_events 		= true;
AMB.config.module_drinks		= true; 
AMB.config.module_duel 			= true;
AMB.config.module_workshopdl 	= true;
AMB.config.module_permaprops 	= true;
AMB.config.module_antilag_sbox 	= true;
AMB.config.module_e2chips 		= true;
AMB.config.module_survive 		= true;
AMB.config.module_chemistry 	= false;
AMB.config.module_rp_zone		= true;

MsgN( "\n		| [Ambition] Main Config Has Loaded |         \n" )
-- Данное творение принадлежит проекту [ Ambition ]