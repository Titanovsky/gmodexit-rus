AmbCmds = AmbCmds or {}

local prefix = '/'
local COLOR_ERROR 	= Color( 204, 38, 8 )
local COLOR_TEXT    = Color( 252, 252, 252 )
local COLOR_ORANGE  = Color( 235, 155, 52 )
local COLOR_GRAY    = Color( 214, 214, 214 )

local rock_paper_scissors = {
	'Бумагу',
	'Камень',
	'Ножницы'
}

local url_rule 		= "https://steamcommunity.com/groups/ambitiongmod/discussions/1/2918850377439698156/"
local url_vk 		= "https://vk.com/ambgmod"
local url_steam		= "https://steamcommunity.com/groups/ambitiongmod"
local url_discord 	= "https://discord.gg/G4vzxrq" 
local url_content 	= 'https://steamcommunity.com/sharedfiles/filedetails/?id=2041976090'


AmbCmds.Cmds = {
	['cmd']	= { '#cmds_cmd', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('amb_list') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['limits']	= { '#cmds_limits', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('amb_list_limits') net.WriteEntity( args[1] ) net.Send( args[1] ) end },

	['citizen'] = { '#cmds_citizen', function( ... ) local args = { ... } AmbStats.Players.changeTeam( args[1], AMB_TEAM_CITIZEN ) end },
	['pvp'] 	= { 'To change status on PVP.', function( ... ) local args = { ... } AmbStats.Players.changeTeam( args[1], AMB_TEAM_PVP ) end },
	['build'] 	= { 'To change status on Builder.', function( ... ) local args = { ... } AmbStats.Players.changeTeam( args[1], AMB_TEAM_BUILD ) end },
	['rp'] 		= { 'To change status on RolePlayer.', function( ... ) local args = { ... } AmbStats.Players.changeTeam( args[1], AMB_TEAM_RP ) end },

	['танец'] 		= { 'To start animation Act Dance.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act dance') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['смех'] 		= { 'To start animation Act Laugh.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act laugh') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['зомби'] 		= { 'To start animation Act Zombie.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act zombie') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['флекс'] 		= { 'To start animation Act Muscle.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act muscle') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['царь'] 		= { 'To start animation Act Pers.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act pers') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['салют'] 		= { 'To start animation Act Salute.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act salute') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['робот'] 		= { 'To start animation Act Robot.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act robot') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['qq'] 			= { 'To start animation Act Wave.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act wave') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['радость'] 	= { 'To start animation Act Cheer.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act cheer') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['туда']		= { 'To start animation Act Forward.', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('act forward') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['уважение']	= { 'To start animation Act Bow.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act bow') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['да']			= { 'To start animation Act Agree.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act agree') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['нет']			= { 'To start animation Act Disagree.', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('act disagree') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['сюда']		= { 'To start animation Act Becon.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act becon') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['стой']		= { 'To start animation Act Halt.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act halt') net.WriteEntity( args[1] ) net.Send( args[1] ) end },

	['org'] 	= { 'Menu of organization.', function( ... ) local args = { ... } net.Start('amb_cmds_orgs') net.WriteString('org_menu') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['orgreg'] 	= { 'To register organization.', function( ... ) local args = { ... } net.Start('amb_cmds_orgs') net.WriteString('org_register') net.WriteEntity( args[1] ) net.Send( args[1] ) end },

	['суп'] 	= { 'To start animation [0-2048].', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( tonumber( args[2] ), 11 ) net.WriteEntity( args[1] ) net.WriteBool( false ) net.Broadcast() end },

	['stats'] 	= { 'Your main information.', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('amb_stats') net.WriteEntity( args[1] )  net.Send( args[1] ) end },
	['help']	= { 'To suggest how to play on server.', function( ... ) local args = { ... } args[1]:ChatPrint('Не доделал =/') end },
	['faq']		= { 'The most popular questions.', function( ... ) local args = { ... } args[1]:ChatPrint('Не доделал =/') end },

	['content']	= { 'URL Content (Workshop) of server.', function( ... ) local args = { ... } net.Start('amb_cmds_urls') net.WriteString(url_content) net.Send( args[1] ) end },
	['vk']		= { 'URL Group vk.com.', function( ... ) local args = { ... } net.Start('amb_cmds_urls') net.WriteString(url_vk) net.Send( args[1] ) end },
	['steam']	= { 'URL Group Steam.', function( ... ) local args = { ... } net.Start('amb_cmds_urls') net.WriteString(url_steam) net.Send( args[1] ) end },
	['discord']	= { 'URL Group Discord.', function( ... ) local args = { ... } net.Start('amb_cmds_urls') net.WriteString(url_discord) net.Send( args[1] ) end },
	['rule']	= { 'URL Group Discord.', function( ... ) local args = { ... } net.Start('amb_cmds_urls') net.WriteString(url_rule) net.Send( args[1] ) end },

	['kit']		= { 'Give a kit', function( ... ) local args = { ... } if not args[2] then return args[1]:SendLua('AmbKits.showKits()') end net.Start('amb_cmds_concmd') net.WriteString('kit '..tostring(args[2])) net.WriteEntity( args[1] ) net.Send( args[1] ) end },

	['id']	= { 'Entity ID of player', function( ... ) local args = { ... } args[1]:ChatPrint( args[1]:EntIndex() ) end },

	['transfer']	= { 'Send any BE on player', function( ... ) local args = { ... } AmbEconomic.transferMoney( args[1], args[2], args[3] ) end },
	['retry']	= { 'retry', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('retry') net.WriteEntity( args[1] ) net.Send( args[1] ) end },

	['камень'] = { 'Game[Rock_Paper_Scissors] Choice: Rock', function( ... ) local args = { ... } args[1]:Say( '/me choose: Камень' ) end },
	['ножницы'] = { 'Game[Rock_Paper_Scissors] Choice: Rock', function( ... ) local args = { ... } args[1]:Say( '/me choose: Ножницы' ) end },
	['бумага'] = { 'Game[Rock_Paper_Scissors] Choice: Rock', function( ... ) local args = { ... } args[1]:Say( '/me choose: Бумага' ) end },

	['roll'] = { 'The random number', function( ... ) local args = { ... } args[1]:Say( '/me choose: '..math.random(0,100) ) end },
	['tts ignore'] = { 'The random number', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('amb_tts_ignore '..args[3]) net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['ming'] = { 'The random number', function( ... ) local args = { ... } AmbCmds.isMing( args[2] ) end },
	['stopsound'] = { 'stopsound', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('stopsound') net.WriteEntity( args[1] ) net.Send( args[1] ) end },

	['lang'] = { '#cmds_lang', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('amb_lang '..args[2]) net.WriteEntity( args[1] ) net.Send( args[1] ) end },

	['solid'] = { '#cmds_lang', function( ... ) local args = { ... } args[1]:ChatPrint( args[1]:GetSolid() ) end },
	['movetype'] = { '#cmds_lang', function( ... ) local args = { ... } args[1]:ChatPrint( args[1]:GetMoveType() ) end },

	['duel'] = { '#cmds_lang', function( ... ) local args = { ... } args[1]:SendLua( 'AmbDuel.OpenRegister()' ) end },
	['accept'] = { '#cmds_lang', function( ... ) local args = { ... } AmbDuel.AcceptDuel( args[1] ) end },
	['bet'] = { '#cmds_lang', function( ... ) local args = { ... } args[1]:SendLua( 'AmbDuel.OpenBet()' ) end },

	['tab buttons'] = { '#cmds_lang', function( ... ) local args = { ... } local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('amb_tab_buttons '..args[3]) net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['tab info'] = { '#cmds_lang', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('amb_tab_info '..args[3]) net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['tab admin'] = { '#cmds_lang', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('amb_tab_admins '..args[3]) net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['hud'] = { '#cmds_lang', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('amb_hud '..args[2]) net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['hud logo'] = { '#cmds_lang', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('amb_hud_logo '..args[3]) net.WriteEntity( args[1] ) net.Send( args[1] ) end },
}


AmbCmds.ChatSpecWords = {
	['привет']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_TAUNT_SALUTE, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['долбоёб']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_SIGNAL_FORWARD, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['хуй']			= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( math.random( 1614, 1656 ), 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['титан']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_SIGNAL_GROUP, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['админ']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_SIGNAL_GROUP, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['донат']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_SIGNAL_GROUP, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['почему']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_GESTURE_DISAGREE, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['да']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_GESTURE_AGREE, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['ок']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_GESTURE_AGREE, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['нет']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_GESTURE_DISAGREE, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['неа']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_GESTURE_DISAGREE, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['нет']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_GESTURE_DISAGREE, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['лол']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_TAUNT_LAUGH, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	['xD']		= { 'd', function( ... ) local args = { ... } args[1]:ChatPrint('ты хуй') net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_TAUNT_LAUGH, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	[':D']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_TAUNT_LAUGH, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },

}

if ( SERVER ) then
	util.AddNetworkString('amb_cmds_concmd')
	util.AddNetworkString('amb_cmds_orgs')
	util.AddNetworkString('amb_cmds_anim')
	util.AddNetworkString('amb_cmds_urls')


	function AmbCmds.isMing( ent_index )
		local ply = Entity(ent_index)
		local valid_players = {}
		local ming_or_not = { 'Мингом', 'Не Мингом'}
		local rand_ming = table.Random( ming_or_not )

		if ( tonumber( ent_index ) == 0 ) then
			for k, pl in pairs( player.GetAll() ) do
				valid_players[k] = pl:EntIndex()
			end
			ply = Entity( table.Random(valid_players) )
		end

		if ( ply:IsPlayer() ) then
			for k, v in pairs( player.GetAll() ) do
				if rand_ming == 'Мингом' then
					if #ply:GetNWString('amb_players_name') > 0 then
						AmbLib.chatSend( v, COLOR_ORANGE, "[•] ", COLOR_TEXT, 'Внимание! '..ply:GetNWString('amb_players_name')..' оказался: ', AMB_COLOR_RED, rand_ming )
					else
						AmbLib.chatSend( v, COLOR_ORANGE, "[•] ", COLOR_TEXT, 'Внимание! '..ply:Nick()..' оказался: ', AMB_COLOR_RED, rand_ming )
					end
				else
					if #ply:GetNWString('amb_players_name') > 0 then
						AmbLib.chatSend( v, COLOR_ORANGE, "[•] ", COLOR_TEXT, 'Внимание! '..ply:GetNWString('amb_players_name')..' оказался: ', AMB_COLOR_GREEN, rand_ming )
					else
						AmbLib.chatSend( v, COLOR_ORANGE, "[•] ", COLOR_TEXT, 'Внимание! '..ply:Nick()..' оказался: ', AMB_COLOR_GREEN, rand_ming )
					end
				end
			end
		end
	end

	hook.Add( 'PlayerSay', 'amb_0x80', function( ePly, sText, team )
		if team then
			ePly:Say("[TEAM] "..sText)
			return ""
		end

		if not string.GetChar( sText, 1 ) == '/' then
			print('DA')
			for name, v in pairs( AmbCmds.ChatSpecWords ) do
				print('FOR')
				if string.find( sText, name ) then
					v[2]( ePly )
					return
				end
			end
		end

		if string.GetChar( sText, 1 ) == '/' then
			for name, v in pairs( AmbCmds.Cmds ) do
				--if string.find( sText, prefix..name, 1, #name ) then
				if string.match( sText, prefix..name ) then
					--ePly:ChatPrint( sText..' | '..prefix..name ) -- debug
					local tText = string.Explode(" ", sText )
					-- print( tText[2] ) -- debug
					v[2]( ePly, tText[2], tText[3], tText[4], tText[5], tText[6] )
					return
				end
			end
		end
	end )
elseif ( CLIENT ) then

	AmbLang.strings['#cmds_cmd'] = { 'The list of Chat Commands', 'Список команд.' }
	AmbLang.strings['#cmds_citizen'] = { 'To change status on Citizen.', 'Стать обычным игроком (ТП на спавн).' }
	AmbLang.strings['#cmds_lang'] = { 'Choice language client text.', 'Выбрать язык на сервере.' }
	AmbLang.strings['#cmds_limits'] = { 'The list of Limits.', 'Список лимитов.' }
	
	local function AmbCmds_list()
		chat.AddText( COLOR_ORANGE, '##########################' )
		for name, v in SortedPairs( AmbCmds.Cmds ) do
			chat.AddText(  COLOR_ORANGE, "/"..name.." — ", COLOR_TEXT, AmbLang.str( v[1] ) )
		end
		chat.AddText(  COLOR_ORANGE, '##########################' )
	end
	concommand.Add('amb_list', function() AmbCmds_list() end )

	local tab_limits = {
		'props',
		'sents',
		'ragdolls',
		'vehicles',
		'npcs',
		'balloons',
		'buttons',
		'emitters',
		'lights',
		'lamps',
		'wheels'

	}
	local function AmbCmds_listLimits()
		chat.AddText( COLOR_ORANGE, '##########################' )
		for _, v in SortedPairs( tab_limits ) do
			chat.AddText(  AMB_COLOR_RED, v, COLOR_TEXT, "	[ "..tostring(LocalPlayer():GetCount( v ))..'/', AMB_COLOR_RED, tostring( LocalPlayer():GetNWInt('amb_players_limit_'..v) ), COLOR_TEXT, ' ]' )
		end
		chat.AddText(  COLOR_ORANGE, '##########################' )
	end
	concommand.Add('amb_list_limits', function() AmbCmds_listLimits() end )

	local function AmbCmds_showStats( ePly )
		chat.AddText( COLOR_ORANGE, "==================" )
		chat.AddText( COLOR_ORANGE, "NAME: ", COLOR_TEXT, ePly:GetNWString('amb_players_name') )
		chat.AddText( COLOR_ORANGE, "BE: ",  COLOR_TEXT, tostring( ePly:GetNWInt('amb_players_money') ) )
		chat.AddText( COLOR_ORANGE, "LVL: ",  COLOR_TEXT, tostring( ePly:GetNWFloat('amb_players_level') ), " ["..ePly:GetNWString('amb_players_exp').."/"..ePly:GetNWString('amb_players_max_exp').."]" )
		chat.AddText( COLOR_ORANGE, "E2ACCESS: ",  COLOR_TEXT, tostring( ePly:GetNWInt('amb_players_e2') ) )
		chat.AddText( COLOR_ORANGE, "==================" )
	end
	concommand.Add('amb_stats', function( ply ) AmbCmds_showStats( ply ) end )

	net.Receive( 'amb_cmds_stats', function( len, ply ) local ePly = net.ReadEntity() print( ply ) AmbCmds_showStats( ePly ) end )
	net.Receive( 'amb_cmds_act', function( len, ply ) local act = net.ReadString() local ePly = net.ReadEntity() ePly:ConCommand( 'act '..act ) end )
	net.Receive( 'amb_cmds_orgs', function( len ) local flag = net.ReadString() local ePly = net.ReadEntity() ePly:ConCommand( flag ) end )
	net.Receive( 'amb_cmds_anim', function( len ) local act = net.ReadUInt( 11 ) local ePly = net.ReadEntity() local is_loop = net.ReadBool() ePly:AnimRestartGesture( GESTURE_SLOT_CUSTOM, act, is_loop ) end )
	net.Receive( 'amb_cmds_urls', function( len ) local url = net.ReadString() gui.OpenURL( url ) end )
	net.Receive( 'amb_cmds_concmd', function( len ) local cmd = net.ReadString() local ePly = net.ReadEntity() ePly:ConCommand( cmd ) end )
end