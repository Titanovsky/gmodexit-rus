--[[
	Конфигурация Sandbox: [RUs].
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[07.05.20]
		• Первые конфигурации.
	.
	[07.08.20]
		• Тут ещё странный синтаксис, лол
	.
##########################################################################################
]]
local function AmbGM_pInit() -- print in console, when server initialization
	MsgN("[AMB] _sv : active!")
end
hook.Add("Initialize", "amb_0x2", AmbGM_pInit )

local function AmbGM_pGamemode() -- print, when gamemode has load.
	MsgN("[AMB] _gm : active!")
end
hook.Add("OnGamemodeLoaded", "amb_0x2", AmbGM_pGamemode )

local function AmbGM_pPlayerConnect( ePly )
	MsgC( Color(255,0,0), ePly, Color(180,20,20), " has been connect!" )
end
hook.Add("PlayerConnect", "amb_0x2", AmbGM_pPlayerConnect)

local function AmbGM_rSoundDeath()
	return false
end
hook.Add("PlayerDeathSound", "amb_0x2", AmbGM_restrictSoundDeath)

-- Данное творение принадлежит проекту [ Ambition ]