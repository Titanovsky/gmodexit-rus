local util_SteamIDFrom64 = util.SteamIDFrom64

hook.Add( 'CheckPassword', 'Ambi.Whitelist.StopConnect', function( sSteamID64 )
	if Ambi.Whitelist.Config.enable and not Ambi.Whitelist.Config.allow[ util_SteamIDFrom64( sSteamID64 ) ] then
		return false, '[Whitelist] '..Ambi.Whitelist.Config.reason
	end
end )