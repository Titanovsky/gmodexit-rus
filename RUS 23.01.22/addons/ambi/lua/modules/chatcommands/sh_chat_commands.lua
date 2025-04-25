local Error, Warning = Ambi.General.Error, Ambi.General.Warning

Ambi.ChatCommands.cmds = Ambi.ChatCommands.cmds or {}

function Ambi.ChatCommands.AddCommand( sName, sType, sDescription, nDelay, fAction, bDontSendInChat )
    if not fAction then Error( 'ChatCommands', 'fAction for AddCommand not found' ) return end

    if not sName or not isstring( sName ) then Warning( 'ChatCommands', 'sName for AddCommand not found, now sName = "test"' ) end
    sName = tostring( sName ) or 'test'

    if not nDelay then Warning( 'ChatCommands', 'nDelay for AddCommand not found, now nDelay = 1' ) end
    nDelay = nDelay or 1

    Ambi.ChatCommands.cmds[ sName ] = {
        type = sType or 'Other',
        desc = sDescription or '',
        delay = nDelay,
        send_in_chat = not bDontSendInChat,
        Action = fAction
    }
end

PrintTable( Ambi.ChatCommands.cmds )