local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local W, H = ScrW(), ScrH()

local cvar_is_render = CreateClientConVar( 'ambi_rus_world_message_render', '1', true )

hook.Add( 'HUDPaint', 'Ambi.WorldMessage.Render', function()
	if not cvar_is_render:GetBool() then return end

    for _, v in ipairs( world_messages ) do
        if ( LocalPlayer():GetPos():Distance( v.pos ) >= 800 ) then continue end
        local pos = v.pos:ToScreen()

        draw.SimpleTextOutlined( v.nick, UI.SafeFont( '24 Ambi' ), pos.x + 16, pos.y - 64, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
        draw.SimpleTextOutlined( v.date, UI.SafeFont( '22 Ambi' ), pos.x + 16, pos.y - 48, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
        draw.SimpleTextOutlined( v.text, UI.SafeFont( '22 Arial' ), pos.x + 16, pos.y - 32, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
    end
end )

world_messages = world_messages or {}

net.Receive( 'ambi_world_messages_sync', function() 
    world_messages = {}

    world_messages = net.ReadTable()
end )