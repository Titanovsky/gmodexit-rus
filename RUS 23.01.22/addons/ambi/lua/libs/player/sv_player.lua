local AddString = Ambi.General.Network.AddString
local PLAYER = FindMetaTable( 'Player' )

-- -------------------------------------------------------------------------------------
local net = net
-- -------------------------------------------------------------------------------------

local net_str = AddString( 'ambi_player_run_command' )
function PLAYER:RunCommand( sText )
    net.Start( net_str )
        net.WriteString( sText or '' )
    net.Send( self )
end

local net_str = AddString( 'ambi_player_open_url' )
function PLAYER:OpenURL( sURL )
    net.Start( net_str )
        net.WriteString( sURL or '' )
    net.Send( self )
end