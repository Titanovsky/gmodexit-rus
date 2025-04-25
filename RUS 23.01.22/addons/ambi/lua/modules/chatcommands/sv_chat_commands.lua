hook.Add( 'PlayerSay', 'Ambi.ChatCommands.ExecuteCommand', function( ePly, sText )
    if ( sText[ 1 ] ~= Ambi.ChatCommands.Config.prefix ) then return end

    local tab = string.Explode( ' ', sText )
    local cmd = string.sub( string.lower( tab[ 1 ] ), 2, #tab[ 1 ] )

    local command = Ambi.ChatCommands.cmds[ cmd ]
    if not command then return end

    if timer.Exists( 'AmbiChatCommandDelay:'..cmd..'['..ePly:SteamID()..']' ) then return end
    timer.Create( 'AmbiChatCommandDelay:'..cmd..'['..ePly:SteamID()..']', command.delay, 1, function() end )
    
    command.Action( ePly, tab )

    if not command.send_in_chat then return '' end
end )