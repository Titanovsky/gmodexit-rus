local TEMP;
local TYPES = {
    [ 'joinleave' ] = true,
    [ 'namechange' ] = true,
}

hook.Add( 'ChatText', 'Ambi.Rus.BlockChatMessages', function( _, _, _, sType )
	if TYPES[ sType ] then return true end
end )