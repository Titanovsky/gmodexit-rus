--[[
	Стандартные команды (PVP, Build, RP, Player) в Shared.
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[30.07.20]
		• Замутил sh, чтобы тима была и на сервере, и на клиенте.
	.
	todo: maybe to obfuscate this script?
]]

local COLOR_GRAY = Color( 243, 243, 243 )

team.SetUp( 1, 'Citizen', COLOR_GRAY )
team.SetUp( 2, 'PVP', COLOR_GRAY )
team.SetUp( 3, 'Builder', COLOR_GRAY )
team.SetUp( 4, 'RolePlayer', COLOR_GRAY )


if ( CLIENT ) then
	concommand.Add('mode', function( ePly, cmd, args )
		if !args[1] then return end
		if tonumber( args[1] ) > 0 and tonumber( args[1] ) < 5 then
			if ePly:GetNWBool( 'amb_bad' ) then return end
			net.Start('amb_teams_change')
				net.WriteEntity( ePly )
				net.WriteUInt( tonumber( args[1] ), 3 )
			net.SendToServer()
		end
	end )
end
