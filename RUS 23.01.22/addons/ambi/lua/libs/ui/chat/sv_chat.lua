Ambi.UI = Ambi.UI or {}
Ambi.UI.Chat = Ambi.UI.Chat or {}

-- -------------------------------------------------------------------------------------
local Network = Ambi.General.Network
local IsValid, net, surface, FindMetaTable, unpack = IsValid, net, surface, FindMetaTable, unpack
-- -------------------------------------------------------------------------------------
local CHAT_NET_STRING = Network.AddString( 'ambi_ui_chat_send' )

function Ambi.UI.Chat.Send( ePly, ... )
    if not IsValid( ePly ) or not ePly:IsPlayer() then return end
    local tab = { ... }

    net.Start( CHAT_NET_STRING )
        net.WriteTable( tab )
    net.Send( ePly )
end

function Ambi.UI.Chat.SendLocal( vPos, nRadius, ... )
    local tab = { ... }
    local entities = ents.FindInSphere( vPos or Vector( 0, 0, 0 ), nRadius or 0 )

    for i = 1, #entities do
        local ply = entities[ i ]
        if ply:IsPlayer() then
            net.Start( CHAT_NET_STRING )
                net.WriteTable( tab )
            net.Send( ply )
        end
    end
end

function Ambi.UI.Chat.SendFiler( fFilter, ... )
    if not fFilter then return end

    local tab = { ... }
    local players = player.GetHumans()

    for i = 1, #players do
        local ply = players[ i ]
        if fFilter( ply ) then
            net.Start( CHAT_NET_STRING )
                net.WriteTable( tab )
            net.Send( ply )
        end
    end
end

function Ambi.UI.Chat.SendAll( ... )
    local tab = { ... }

    net.Start( CHAT_NET_STRING )
        net.WriteTable( tab )
    net.Broadcast()
end

-- -------------------------------------------------------------------------------------
local PLAYER = FindMetaTable( 'Player' )

function PLAYER:ChatSend( ... )
    local tab = { ... }
    
    Ambi.UI.Chat.Send( self, unpack( tab ) )
end