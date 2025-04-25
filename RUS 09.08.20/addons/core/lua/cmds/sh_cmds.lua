AmbCmds = AmbCmds or {}

local prefix = '/'
local COLOR_ERROR 	= Color( 204, 38, 8 )
local COLOR_TEXT    = Color( 252, 252, 252 )
local COLOR_ORANGE  = Color( 235, 155, 52 )
local COLOR_GRAY    = Color( 214, 214, 214 )


AmbCmds.Cmds = {
	['cmd']	= { 'The list of Chat Commands.', function( ... ) local args = { ... } if ( SERVER ) then AmbCmds.list( args[1] ) end end },

	['citizen'] = { 'To change status on Citizen.', function( ... ) local args = { ... } AmbStats.Players.changeStatus( args[1], 1 ) end },
	['pvp'] 	= { 'To change status on PVP.', function( ... ) local args = { ... } AmbStats.Players.changeStatus( args[1], 2 ) end },
	['build'] 	= { 'To change status on Builder.', function( ... ) local args = { ... } AmbStats.Players.changeStatus( args[1], 3 ) end },
	['rp'] 		= { 'To change status on RolePlayer.', function( ... ) local args = { ... } AmbStats.Players.changeStatus( args[1], 4 ) end },

	['танец'] 		= { 'To start animation Act Dance.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act dance') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['смех'] 		= { 'To start animation Act Laugh.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act laugh') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['зомби'] 		= { 'To start animation Act Zombie.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act zombie') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['флекс'] 		= { 'To start animation Act Muscle.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act muscle') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['царь'] 		= { 'To start animation Act Pers.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act pers') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['салют'] 		= { 'To start animation Act Salute.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act salute') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['робот'] 		= { 'To start animation Act Robot.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act robot') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['qq'] 			= { 'To start animation Act Wave.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act wave') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['радость'] 	= { 'To start animation Act Cheer.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act cheer') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['показать']	= { 'To start animation Act Forward.', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('act forward') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['уважение']	= { 'To start animation Act Bow.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act bow') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['да']			= { 'To start animation Act Agree.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act agree') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['нет']			= { 'To start animation Act Disagree.', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('act disagree') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['сюда']		= { 'To start animation Act Becon.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act becon') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['стой']		= { 'To start animation Act Halt.', function( ... ) local args = { ... } 	net.Start('amb_cmds_concmd') net.WriteString('act halt') net.WriteEntity( args[1] ) net.Send( args[1] ) end },

	['org'] 	= { 'Menu of organization.', function( ... ) local args = { ... } net.Start('amb_cmds_orgs') net.WriteString('org_menu') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['orgreg'] 	= { 'To register organization.', function( ... ) local args = { ... } net.Start('amb_cmds_orgs') net.WriteString('org_register') net.WriteEntity( args[1] ) net.Send( args[1] ) end },

	['суп'] 	= { 'To start animation [0-2048].', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( tonumber( args[2] ), 11 ) net.WriteEntity( args[1] ) net.WriteBool( false ) net.Broadcast() end },

	['stats'] 	= { 'Your main information.', function( ... ) local args = { ... } net.Start('amb_cmds_stats') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
	['help']	= { 'To suggest how to play on server.', function( ... ) local args = { ... } args[1]:ChatPrint('Не доделал =/') end },
	['faq']		= { 'The most popular questions.', function( ... ) local args = { ... } args[1]:ChatPrint('Не доделал =/') end },

	['content']	= { 'URL Content (Workshop) of server.', function( ... ) local args = { ... } net.Start('amb_cmds_urls') net.WriteString('https://steamcommunity.com/sharedfiles/filedetails/?id=2041976090') net.Send( args[1] ) end },
	['vk']		= { 'URL Group vk.com.', function( ... ) local args = { ... } net.Start('amb_cmds_urls') net.WriteString('https://steamcommunity.com/sharedfiles/filedetails/?id=2041976090') net.Send( args[1] ) end },
	['steam']	= { 'URL Group Steam.', function( ... ) local args = { ... } net.Start('amb_cmds_urls') net.WriteString('https://steamcommunity.com/sharedfiles/filedetails/?id=2041976090') net.Send( args[1] ) end },
	['discord']	= { 'URL Group Discord.', function( ... ) local args = { ... } net.Start('amb_cmds_urls') net.WriteString('https://steamcommunity.com/sharedfiles/filedetails/?id=2041976090') net.Send( args[1] ) end },

	['kit minecraft']	= { 'sda', function( ... ) local args = { ... } args[1]:ChatPrint('пошел нахуй') end },
	['id']	= { 'sda', function( ... ) local args = { ... } args[1]:ChatPrint( args[1]:EntIndex() ) end },

	['transfer']	= { 'sda', function( ... ) local args = { ... } AmbEconomic.transferMoney( args[1], args[2], args[3] ) end },
	['retry']	= { 'sda', function( ... ) local args = { ... } net.Start('amb_cmds_concmd') net.WriteString('retry') net.WriteEntity( args[1] ) net.Send( args[1] ) end },
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
	['xD']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_TAUNT_LAUGH, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },
	[':D']		= { 'd', function( ... ) local args = { ... } net.Start('amb_cmds_anim') net.WriteUInt( ACT_GMOD_TAUNT_LAUGH, 11 ) net.WriteEntity( args[1] ) net.WriteBool( true ) net.Broadcast() end },

}

if ( SERVER ) then
	util.AddNetworkString('amb_cmds_stats')
	util.AddNetworkString('amb_cmds_concmd')
	util.AddNetworkString('amb_cmds_act')
	util.AddNetworkString('amb_cmds_orgs')
	util.AddNetworkString('amb_cmds_anim')
	util.AddNetworkString('amb_cmds_urls')

	function AmbCmds.list( ePly )
		AmbLib.chatSend( ePly, COLOR_ORANGE, '##########################' )
		for name, v in pairs( AmbCmds.Cmds ) do
			AmbLib.chatSend( ePly, COLOR_ORANGE, "/"..name.." — ", COLOR_TEXT, v[1] )
		end
		AmbLib.chatSend( ePly, COLOR_ORANGE, '##########################' )
	end



	hook.Add( 'PlayerSay', 'amb_0x80', function( ePly, sText, team )
		if team then
			ePly:Say("[TEAM] "..sText)
			return ""
		end

		if not string.GetChar( sText, 1 ) == '/' then
			for name, v in pairs( AmbCmds.ChatSpecWords ) do
				if string.find( sText, name ) then
					v[2]( ePly )
					return
				end
			end
		end

		if string.GetChar( sText, 1 ) == '/' then
			for name, v in pairs( AmbCmds.Cmds ) do
				if string.find( sText, prefix..name ) then
					local tText = string.Explode(" ", sText )
					-- print( tText[2] ) -- debug
					v[2]( ePly, tText[2], tText[3] )
					return
				end
			end
		end
	end )
elseif ( CLIENT ) then

	local function AmbCmds_showStats( ePly )
		chat.AddText( COLOR_ORANGE, "==================" )
		chat.AddText( COLOR_ORANGE, "NAME: ", COLOR_TEXT, ePly:GetNWString('amb_players_name') )
		chat.AddText( COLOR_ORANGE, "AGE: ",  COLOR_TEXT, tostring( ePly:GetNWInt('amb_players_age') ) )
		chat.AddText( COLOR_ORANGE, "NATION: ",  COLOR_TEXT, ePly:GetNWString('amb_players_nation') )
		chat.AddText( COLOR_ORANGE, "SEX: ",  COLOR_TEXT, ePly:GetNWString('amb_players_sex') )
		chat.AddText( COLOR_ORANGE, "LVL: ",  COLOR_TEXT, ePly:GetNWInt('amb_players_level'), " ["..ePly:GetNWString('amb_players_exp').."/"..ePly:GetNWString('amb_players_max_exp').."]" )
		chat.AddText( COLOR_ORANGE, "E2ACCESS: ",  COLOR_TEXT, tostring( ePly:GetNWInt('amb_players_e2access') ) )
		chat.AddText( COLOR_ORANGE, "==================" )
	end

	net.Receive( 'amb_cmds_stats', function( len ) local ePly = net.ReadEntity() AmbCmds_showStats( ePly ) end )
	net.Receive( 'amb_cmds_act', function( len ) local act = net.ReadString() local ePly = net.ReadEntity() ePly:ConCommand( 'act '..act ) end )
	net.Receive( 'amb_cmds_orgs', function( len ) local flag = net.ReadString() local ePly = net.ReadEntity() ePly:ConCommand( flag ) end )
	net.Receive( 'amb_cmds_anim', function( len ) local act = net.ReadUInt( 11 ) local ePly = net.ReadEntity() local is_loop = net.ReadBool() ePly:AnimRestartGesture( GESTURE_SLOT_CUSTOM, act, is_loop ) end )
	net.Receive( 'amb_cmds_urls', function( len ) local url = net.ReadString() gui.OpenURL( url ) end )
	net.Receive( 'amb_cmds_concmd', function( len ) local cmd = net.ReadString() local ePly = net.ReadEntity() ePly:ConCommand( cmd ) end )
end