AmbCmds = AmbCmds or {}
AmbCmds.table = AmbCmds.table or {}

local url_rule 		= "https://steamcommunity.com/groups/ambitiongmod/discussions/1/2918850377439698156/"
local url_vk 		= "https://vk.com/ambgmod"
local url_steam		= "https://steamcommunity.com/groups/ambitiongmod"
local url_discord 	= "https://discord.gg/G4vzxrq" 
local url_content 	= 'https://steamcommunity.com/sharedfiles/filedetails/?id=2041976090'

function AmbCmds.AddCmd( sName, sDescription, fAction )

	AmbCmds.table[ string.lower( sName ) ] = {

		description = sDescription..'.',
		func = fAction

	} 

end

AmbCmds.AddCmd( 'stats', 'Показать статистику', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'amb_show_stats' ) end )
AmbCmds.AddCmd( 'cmd', 'Показать все команды', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'amb_show_cmds' ) end )
AmbCmds.AddCmd( 'limit', 'Показать все команды', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'amb_show_limits' ) end )
AmbCmds.AddCmd( 'timevotemap', 'Показать сколько осталось до голосования на смену карты', function( ePly, tArgs ) AmbLib.chatSend( ePly, AMB_COLOR_AMBITION, '[•] ', AMB_COLOR_WHITE, 'Осталось ', AMB_COLOR_AMBITION, tostring( math.floor( timer.TimeLeft( 'AmbTimer[AmbVoteMap]' )/60 ) ), AMB_COLOR_WHITE, ' минут(ы) до Голосования на Смену Карты' ) end )
AmbCmds.AddCmd( 'time', 'Показать время', function( ePly, tArgs ) AmbLib.chatSend( ePly, AMB_COLOR_AMBITION, '[•] ', AMB_COLOR_WHITE, 'Время ', AMB_COLOR_AMBITION, AmbTimeCycle.time_h..':'..AmbTimeCycle.time_m..':'..AmbTimeCycle.time_s, AMB_COLOR_WHITE, ' День - ', AMB_COLOR_AMBITION, tostring( AmbTimeCycle.time_d ) ) end )
AmbCmds.AddCmd( 'суп', 'Включить анимацию от 0 до 2048', function( ePly, tArgs ) AmbCmds.StartAnimation( ePly, tArgs[ 2 ], false ) end )
AmbCmds.AddCmd( 'hud', 'Выбрать худ', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'amb_hud '..tArgs[ 2 ] ) end )
AmbCmds.AddCmd( 'outline', 'Вкл/Выкл прорисовку объектов', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'amb_outline '..tArgs[ 2 ] ) end )
AmbCmds.AddCmd( 'roll', 'Бросить кубик', function( ePly, tArgs ) ePly:Say( '/me бросил кубик и получил '..math.random( 0, 100 ) ) end )
AmbCmds.AddCmd( 'transfer', 'Передать Био. Эссенцию игроку по его Entity ID', function( ePly, tArgs ) AmbEconomic.transferMoney( ePly, tArgs[ 2 ], tArgs[ 3 ] ) end )

AmbCmds.AddCmd( 'rule', 'Правила сервера', function( ePly, tArgs ) AmbLib.chatSend( ePly, AMB_COLOR_AMBITION, '[•] ', AMB_COLOR_WHITE, 'Одно единственное правило — не мешать остальным игрокам!' ) end )
AmbCmds.AddCmd( 'content', 'Контент сервера', function( ePly, tArgs ) AmbCmds.ShowUrl( ePly, url_content ) end )
AmbCmds.AddCmd( 'vk', 'VK Группа', function( ePly, tArgs ) AmbCmds.ShowUrl( ePly, url_vk ) end )
AmbCmds.AddCmd( 'discord', 'Дискорд', function( ePly, tArgs ) AmbCmds.ShowUrl( ePly, url_discord ) end )
AmbCmds.AddCmd( 'steam', 'Steam Группа', function( ePly, tArgs ) AmbCmds.ShowUrl( ePly, url_steam ) end )

AmbCmds.AddCmd( 'tts ignore', 'Вкл/Выкл прослушивание TTS', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'amb_tts_ignore '..tArgs[ 3 ] ) end )
AmbCmds.AddCmd( 'stopsound', 'Выключить звуки', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'stopsound' ) end )
AmbCmds.AddCmd( 'skybox', 'Вкл/Выкл скайбокс (Увеличивает FPS)', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'r_3dsky '..tArgs[ 2 ] ) end )

AmbCmds.AddCmd( 'citizen', 'Войти в режим: Вошедший', function( ePly, tArgs ) AmbStats.Players.changeTeam( ePly, AMB_TEAM_CITIZEN ) end )
AmbCmds.AddCmd( 'pvp', 'Войти в режим: PVP', function( ePly, tArgs ) AmbStats.Players.changeTeam( ePly, AMB_TEAM_PVP ) end )
AmbCmds.AddCmd( 'rp', 'Войти в режим: Role Play', function( ePly, tArgs ) AmbStats.Players.changeTeam( ePly, AMB_TEAM_RP ) end )
AmbCmds.AddCmd( 'build', 'Войти в режим: Строительства', function( ePly, tArgs ) AmbStats.Players.changeTeam( ePly, AMB_TEAM_BUILD ) end )

AmbCmds.AddCmd( 'orgcreate', 'Создать организацию', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'org_register' ) end )
AmbCmds.AddCmd( 'org', 'Меню организаций', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'org_menu' ) end )

AmbCmds.AddCmd( 'inv', 'Открыть JMOD инвентарь', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'jmod_ez_inv' ) end )