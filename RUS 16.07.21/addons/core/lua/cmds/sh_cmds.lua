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
AmbCmds.AddCmd( 'time', 'Показать время', function( ePly, tArgs ) AmbLib.chatSend( ePly, AMB_COLOR_AMBITION, '[•] ', AMB_COLOR_WHITE, 'Время ', AMB_COLOR_AMBITION, AmbTimeCycle.time_h..':'..AmbTimeCycle.time_m, AMB_COLOR_WHITE, '  |  День ', AMB_COLOR_AMBITION, tostring( AmbTimeCycle.time_d ) ) end )
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

AmbCmds.AddCmd( 'ignoretts', 'Вкл/Выкл прослушивание TTS', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'amb_tts_ignore '..tArgs[ 2 ] ) end )
AmbCmds.AddCmd( 'stopsound', 'Выключить звуки', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'stopsound' ) end )
AmbCmds.AddCmd( 'skybox', 'Вкл/Выкл скайбокс (Увеличивает FPS)', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'r_3dsky '..tArgs[ 2 ] ) end )

AmbCmds.AddCmd( 'citizen', 'Войти в режим: Вошедший', function( ePly, tArgs ) AmbStats.Players.changeTeam( ePly, AMB_TEAM_CITIZEN ) end )
AmbCmds.AddCmd( 'pvp', 'Войти в режим: PVP', function( ePly, tArgs ) AmbStats.Players.changeTeam( ePly, AMB_TEAM_PVP ) end )
AmbCmds.AddCmd( 'rp', 'Войти в режим: Role Play', function( ePly, tArgs ) AmbStats.Players.changeTeam( ePly, AMB_TEAM_RP ) end )
AmbCmds.AddCmd( 'build', 'Войти в режим: Строительства', function( ePly, tArgs ) AmbStats.Players.changeTeam( ePly, AMB_TEAM_BUILD ) end )

AmbCmds.AddCmd( 'orgcreate', 'Создать организацию', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'org_register' ) end )
AmbCmds.AddCmd( 'org', 'Меню организаций', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'org_menu' ) end )

AmbCmds.AddCmd( 'inv', 'Открыть JMOD инвентарь', function( ePly, tArgs ) AmbCmds.StartConCommand( ePly, 'jmod_ez_inv' ) end )

AmbCmds.AddCmd( 'ignore', 'Игнорировать/Не игнорировать сообщения игрока по его ID', function( ePly, tArgs ) ePly:SendLua( "AmbChat.SetIgnore( Entity( "..tArgs[ 2 ].." ) )" ) end )

AmbCmds.AddCmd( 'runspeed', 'Установить скорость бега себе в Build режиме [0-1600]', function( ePly, tArgs ) AmbStats.Players.SetSpeedBuilder( ePly, 1, tonumber( tArgs[ 2 ] ) ) end )
AmbCmds.AddCmd( 'walkspeed', 'Установить скорость ходьбы себе в Build режиме [0-1600]', function( ePly, tArgs ) AmbStats.Players.SetSpeedBuilder( ePly, 2, tonumber( tArgs[ 2 ] ) ) end )
AmbCmds.AddCmd( 'bhop', 'Включить AutoBhop', function( ePly, tArgs ) ePly:SendLua( 'LocalPlayer():ConCommand("amb_bhop 1")' ) end )

local access_id = { 

    [ 'STEAM_0:1:95303327' ] = true,
    [ 'STEAM_0:0:426598565' ] = true,
    [ '123' ] = true

}

AmbCmds.AddCmd( 'sf', 'Релоднуть старфальского', function( ePly, tArgs ) 

	if not access_id[ ePly:SteamID() ] then return end

	RunConsoleCommand( 'sf_reload_amb' )
	
end )

AmbCmds.AddCmd( 'status', 'Установить статус в TAB', function( ePly, tArgs ) 

	ePly.status = ''

	for i, word in pairs( tArgs ) do

		if ( i == 1 ) then continue end
		ePly.status = ePly.status..word..' '

	end

	if ( utf8.len( ePly.status ) > 48 ) then return end

	AmbLib.chatSend( ePly, AMB_COLOR_BLUE, '[•] ', AMB_COLOR_WHITE, 'Вы установили статус: ', AMB_COLOR_AMBITION, ePly.status )
	ePly:SetNWString( 'Status', ePly.status )

end )

AmbCmds.AddCmd( 'statuscolor', 'Установить цвет статусу в TAB', function( ePly, tArgs ) 

	local color = {}

	tArgs[ 2 ], tArgs[ 3 ], tArgs[ 4 ] = tArgs[ 2 ] or 0, tArgs[ 3 ] or 0, tArgs[ 4 ] or 0

	color.r = math.floor( tonumber( tArgs[ 2 ] ) )
	color.g = math.floor( tonumber( tArgs[ 3 ] ) )
	color.b = math.floor( tonumber( tArgs[ 4 ] ) )

	if ( color.r > 255 ) then color.r = 255 end
	if ( color.g > 255 ) then color.g = 255 end
	if ( color.b > 255 ) then color.b = 255 end

	if ( color.r < 0 ) then color.r = 255 end
	if ( color.g < 0 ) then color.g = 255 end
	if ( color.b < 0 ) then color.b = 255 end

	local vec_color = Vector( color.r, color.g, color.b )

	AmbLib.chatSend( ePly, AMB_COLOR_BLUE, '[•] ', AMB_COLOR_WHITE, 'Вы установили ', vec_color:ToColor(), 'цвет', AMB_COLOR_WHITE, ' статусу' )
	ePly:SetNWVector( 'StatusColor', vec_color )

end )

local opti_commands = {

	mat_specular = { 0, 0, 1 },
	mat_filtertextures = { 0, 1, 1 },
	mat_filterlightmaps = { 0, 1, 1 },
	mat_fastspecular = { 1, 0, 0 },
	muzzleflash_light = { 0, 1, 1 },
	mat_picmip = { 4, -1, -1 },
	mat_antialias = { 0, 0, 1 },
	mat_shadowstate = { 0, 1, 1 },
	mat_disable_fancy_blending = { 1, 0, 0 },
	mat_vsync = { 0, 0, 0 },

	r_3dsky = { 0, 1, 1 },
	r_teeth = { 0, 1, 1 },
	r_eyes = { 0, 1, 1 },
	r_eyemove = { 0, 1, 1 },
	r_decals = { 0, 1, 1 },
	r_shadows = { 0, 1, 1 },
	r_dynamic = { 0, 1, 1 },
	r_drawflecks = { 0, 1, 1 },
	r_worldlights = { 0, 1, 1 },
	r_lod = { 8, -1, -1 },
	r_fastzreject = { 1, 0, 0 },

	datacachesize = { 512, 64, 512 },
	mem_max_heapsize = { 2048, 256, 2048 }

}

local multicore_commands = {

	gmod_mcore_test = { 1, 0 },
	mat_queue_mode = { 2, -1 },
	cl_threaded_client_leaf_system = { 1, 0 },
	cl_threaded_bone_setup = { 1, 0 },
	r_queued_ropes = { 1, 0 },
	r_threaded_client_shadow_manager = { 1, 0 },
	r_threaded_particles = { 1, 0 },
	r_threaded_renderables = { 1, 0 },
	studio_queue_mode = { 1, 0 },
	snd_mix_async = { 1, 0 }

}

AmbCmds.AddCmd( 'multicore', '( ОПАСНО ) включить/выключить многоядерную обработку', function( ePly, tArgs ) 

	local arg = tArgs[ 2 ] or '1'

	if ( arg == '1' ) then 
	
		local i = 0
		for command, v in pairs( multicore_commands ) do 
		
			i = i + 1
			timer.Simple( i, function() 
			
				ePly:SendLua( 'RunConsoleCommand( "'..command..'", "'..v[ 1 ]..'" )' ) 
				ePly:ChatPrint( command..' '..v[ 1 ] )
				if ( command == 'r_queued_ropes' ) then ePly:ChatPrint( 'Вы включили многоядерную обработку!' ) end

			end ) 
			
		end

	else

		local i = 0
		for command, v in pairs( multicore_commands ) do 
		
			i = i + 1
			timer.Simple( i, function() 
			
				ePly:SendLua( 'RunConsoleCommand( "'..command..'", "'..v[ 2 ]..'" )' ) 
				ePly:ChatPrint( command..' '..v[ 2 ] )
				if ( command == 'r_queued_ropes' ) then ePly:ChatPrint( 'Вы выключили многоядерную обработку!' ) end

			end ) 
			
		end

	end

end )

AmbCmds.AddCmd( 'settings', '( ОПАСНО ) определяет категорию настроек', function( ePly, tArgs ) 

	local arg = tArgs[ 2 ] or ''

	if ( arg == 'easy' ) then 
	
		local i = 0
		for command, tab in SortedPairs( opti_commands ) do 
		
			i = i + 2
			timer.Simple( i, function() 
			
				ePly:SendLua( 'RunConsoleCommand( "'..command..'", "'..tab[ 1 ]..'" )' ) 
				ePly:ChatPrint( command..' '..tab[ 1 ] )
				if ( command == 'r_worldlights' ) then ePly:ChatPrint( 'Вы переключили качество на '..arg ) end

			end )
			
		end

	elseif ( arg == 'medium' ) then

		local i = 0
		for command, tab in SortedPairs( opti_commands ) do 
		
			i = i + 2
			timer.Simple( i, function() 

				ePly:SendLua( 'RunConsoleCommand( "'..command..'", "'..tab[ 2 ]..'" )' ) 
				ePly:ChatPrint( command..' '..tab[ 2 ] )
				if ( command == 'r_worldlights' ) then ePly:ChatPrint( 'Вы переключили качество на '..arg ) end

			end )
			
		end

	elseif ( arg == 'high' ) then

		local i = 0
		for command, tab in SortedPairs( opti_commands ) do 
		
			i = i + 2
			timer.Simple( i, function() 

				ePly:SendLua( 'RunConsoleCommand( "'..command..'", "'..tab[ 3 ]..'" )' ) 
				ePly:ChatPrint( command..' '..tab[ 3 ] )
				if ( command == 'r_worldlights' ) then ePly:ChatPrint( 'Вы переключили качество на '..arg ) end

			end )
			
		end

	end

end )