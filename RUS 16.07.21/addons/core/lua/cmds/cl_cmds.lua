AmbCmds = AmbCmds or {}

local COLOR_CMD = Color( 77, 206, 235 )

concommand.Add( 'amb_show_cmds', function() 

    chat.AddText( AMB_COLOR_AMBITION, '##########################' )
	for name, cmd in SortedPairs( AmbCmds.table ) do

	    chat.AddText(  COLOR_CMD, '/'..name..' — ', AMB_COLOR_WHITE, cmd.description )

	end
	chat.AddText(  AMB_COLOR_AMBITION, '##########################' )

end )

local limits = { 

    'props',
    'sents',
    'effects',
    'ragdolls',
    'vehicles',
    'npcs',
    'balloons',
    'buttons',
    'emitters',
    'dynamites',
    'lights',
    'lamps',
    'wheels',
    'thrusters',
    'hoverballs'

}

concommand.Add( 'amb_show_limits', function() 

    chat.AddText( AMB_COLOR_AMBITION, '##########################' )
	for _, name in SortedPairs( limits ) do

		chat.AddText(  AMB_COLOR_RED, name, AMB_COLOR_WHITE, "	[ "..tostring(LocalPlayer():GetCount( name ))..'/', AMB_COLOR_RED, tostring( LocalPlayer():GetNWInt('amb_players_limit_'..name) ), AMB_COLOR_WHITE, ' ]' )

	end
	chat.AddText(  AMB_COLOR_AMBITION, '##########################' )

end )

concommand.Add( 'amb_show_stats', function() 

    chat.AddText( AMB_COLOR_AMBITION, "==================" )
	chat.AddText( AMB_COLOR_AMBITION, "Имя: ", AMB_COLOR_WHITE, LocalPlayer():GetNWString('amb_players_name') )
	chat.AddText( AMB_COLOR_AMBITION, "Био.Эссенция: ",  AMB_COLOR_WHITE, tostring( LocalPlayer():GetNWInt('amb_players_money') ) )
	chat.AddText( AMB_COLOR_AMBITION, "Уровень: ",  AMB_COLOR_WHITE, tostring( LocalPlayer():GetNWFloat('amb_players_level') ), " ["..LocalPlayer():GetNWString('amb_players_exp').."/"..LocalPlayer():GetNWString('amb_players_max_exp').."]" )
	chat.AddText( AMB_COLOR_AMBITION, "Е2Акссеса: ",  AMB_COLOR_WHITE, tostring( LocalPlayer():GetNWInt('amb_players_e2') ) )
	chat.AddText( AMB_COLOR_AMBITION, "Голод: ",  AMB_COLOR_WHITE, tostring( LocalPlayer():GetNWInt('Hunger') ) )
	chat.AddText( AMB_COLOR_AMBITION, "==================" )

end )

net.Receive( 'amb_cmds_anim', function( len ) 

    local act = net.ReadUInt( 11 )
    local is_loop = net.ReadBool()  
    local ePly = net.ReadEntity() 
    
    ePly:AnimRestartGesture( GESTURE_SLOT_CUSTOM, act, is_loop ) 
    
end )

net.Receive( 'amb_cmds_urls', function() 

    local url = net.ReadString() 

    gui.OpenURL( url ) 
    
end )

net.Receive( 'amb_cmds_concmd', function() 

    local cmd = net.ReadString() 
    
    LocalPlayer():ConCommand( cmd ) 
    
end )