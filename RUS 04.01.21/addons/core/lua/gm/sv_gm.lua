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
##########################################################################################
]]

if ( AMB == false ) then return end -- Don't Remove, Please!

local cmds = {
	['sbox_playershurtplayers'] = AMB.config.hurtplayers,
	['sbox_noclip'] = AMB.config.noclip
}

local function AmbGamemode_init() -- print in console, when server initialization
	MsgN("  	[Ambition] Server Initialization")
end
hook.Add( "Initialize", "amb_0x2", AmbGamemode_init )

local function AmbGamemode_gamemodeLoaded() -- print, when gamemode has load.
	MsgN("  	[Ambition] Gamemode Loaded")
end
hook.Add( "OnGamemodeLoaded", "amb_0x2", AmbGamemode_gamemodeLoaded )

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
AmbGamemode_runCmds()

-- Данное творение принадлежит проекту [ Ambition ]