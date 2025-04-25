AmbCmds = AmbCmds or {}

util.AddNetworkString('amb_cmds_anim')
util.AddNetworkString('amb_cmds_urls')

hook.Add( 'PlayerSay', 'AmbCmdsSendCommand', function( ePly, sText, team )

	if team then ePly:Say( sText ) return "" end

	if ( string.GetChar( sText, 1 ) == '/' ) then

		sText = string.lower( sText )

		local tText = string.Explode( ' ', sText )
			
		if AmbCmds.table[ string.Trim( tText[ 1 ], '/' ) ] then AmbCmds.table[ string.Trim( tText[ 1 ], '/' ) ].func( ePly, tText ) end

	end

end )

util.AddNetworkString('amb_cmds_urls')
function AmbCmds.ShowUrl( ePly, sUrl )

    net.Start('amb_cmds_urls') 
        net.WriteString( sUrl ) 
    net.Send( ePly)

end

util.AddNetworkString('amb_cmds_concmd')
function AmbCmds.StartAnimation( ePly, nAct, bLoop )

    net.Start('amb_cmds_anim') 
        net.WriteUInt( tonumber( nAct ), 11 ) 
        net.WriteBool( bLoop ) 
        net.WriteEntity( ePly )
    net.Broadcast()

end

util.AddNetworkString('amb_cmds_concmd')
function AmbCmds.StartConCommand( ePly, sCommand )

    net.Start( 'amb_cmds_concmd' ) 
		net.WriteString( sCommand ) 
	net.Send( ePly ) 

end