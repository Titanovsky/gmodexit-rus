util.AddNetworkString('amb_tab_update')

hook.Add( 'PlayerConnect', 'amb_0x4224', function(ply)
	net.Start('amb_tab_update')
	net.Broadcast()
end )

hook.Add( 'PlayerDisconnected', 'amb_0x4224', function(ply)
	net.Start('amb_tab_update')
	net.Broadcast()
end )

hook.Add( 'PlayerInitialSpawn', 'amb_0x4224', function(ply)
	net.Start('amb_tab_update')
	net.Broadcast()
end )

hook.Add( 'PlayerJoinTeam', 'amb_0x4224', function(ply)
	net.Start('amb_tab_update')
	net.Broadcast()
end )