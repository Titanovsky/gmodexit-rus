local cmds = {
	['g_ragdoll_fadespeed'] = '1',
	['g_ragdoll_lvfadespeed'] = '1',
	['outfitter_enabled'] = '0',
	['r_3dsky'] = '0'
}

hook.Add("InitPostEntity", "amb_0x16", function()

	for name, v in pairs( cmds ) do
		MsgC( AMB_COLOR_AMBITION, '\n[Optimization]', AMB_COLOR_WHITE, ' '..name..' = '..v..';'   )
		RunConsoleCommand( name, v )
	end
end)