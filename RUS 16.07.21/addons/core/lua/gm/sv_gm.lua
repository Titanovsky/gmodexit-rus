--[[
	Конфигурация Sandbox: [RUs].
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[07.05.20]
		• Первые конфигурации.
	.
	[07.08.20]
		• Тут ещё странный синтаксис, лол local function AmbGM_pInit(), что это за 'p'
	.
	[09.08.20]
		• Немного поменял, в частности странный синтаксис.
	.
	[01.05.21]
		• Добавил своё говно
	.
##########################################################################################
]]

if ( AMB == false ) then return end

local cmds = {
	['sbox_playershurtplayers'] = AMB.config.hurtplayers,
	['sbox_noclip'] = AMB.config.noclip
}

local function AmbGamemode_deathSound()
	return AMB.config.OnDeathSound 
end
hook.Add( "PlayerDeathSound", "amb_0x2", AmbGamemode_deathSound )

local function AmbGamemode_runCmds()

	for cmd, value in pairs( cmds ) do

		RunConsoleCommand( cmd, value )
		MsgN( " [Ambition] ConVar: "..cmd.." = "..tostring( value )..";" )

	end

end

hook.Add( 'PostGamemodeLoaded', 'WriteConVars', AmbGamemode_runCmds )

hook.Add( 'PlayerSpawn', 'NotifyOn9May', function( ePly )

	--local r = tobool( math.random( 0, 1 ) )
	--if r then AmbLib.chatSend( ePly, AMB_COLOR_RED, '>> 9 Мая состоится Глобальный Ивент в 16:00 по МСК' ) end

end )

--[[

local url = 'https://discordtalk.000webhostapp.com/post_discord.php'

local function SendMessageToDiscord( ePly, sText )

	local tab = { msg = sText, author = ePly:Nick() }

	http.Post( url, tab, function( body, length, headers, code ) 

		print( '[Discord] Message Code: '..code ) 
	
	end )

end

timer.Simple( 2, function()

	local url = 'https://discordtalk.000webhostapp.com/to_discord.html'
	http.Fetch( url, function( sBody )

		print( sBody )

	end )

end )

hook.Add( 'PlayerSay', 'DiscordSendMessage', function( ePly, sText )

	SendMessageToDiscord( ePly, sText )

end )

]]

--[[
local body = ''

local function SendMessageToGmod( sAuthor, sText )

	local message = '[Discord] ['..sAuthor..'] '..sText

	print( message )
	for _, ply in ipairs( player.GetAll() ) do ply:ChatPrint( message ) end

end

timer.Create( 'DiscordCheckToGmodMessages', 2.54, 0, function()

	http.Fetch( 'https://discordtalk.000webhostapp.com/to_gmod.html', function( sBody )

		if ( sBody == body ) then return end

		body = sBody

		sBody = string.Explode( ';', sBody )

		local message = string.Explode( ':', sBody[ 1 ] )
		local author = string.Explode( ':', sBody[ 2 ] )

		SendMessageToGmod( author[ 2 ], message[ 2 ] )

	end )

end )
]]--