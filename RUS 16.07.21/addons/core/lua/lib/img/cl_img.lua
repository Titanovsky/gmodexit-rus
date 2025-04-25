local x_main, y_main = 240, 240
local COLOR_APLHA = Color(0,0,0,0)
local chat_x, chat_y = chat.GetChatBoxPos()

net.Receive( "rus_send_img", function( url )
	local url = net.ReadString()

	local img = vgui.Create( "DHTML" )
	img:SetSize( x_main, y_main )
	img:SetPos( chat_x, chat_y - 320 )
	img:SetHTML("<body style='overflow: hidden;'>   <img src=" .. url .. " style='   width: " .. x_main .. " ;  max-height:".. y_main ..";'  > </body>")

	timer.Simple( 6, function() img:Remove() end )
end )

--[[

-- старьё


net.Receive( "rus_send_img", function( url )
	local url = net.ReadString()

	local frame = vgui.Create("DFrame")
	frame:SetSize( 250, 250)
	frame:SetTitle("")
	frame:SetPos( chat_x, chat_y - 342)
	frame:ShowCloseButton( false )
	frame.Paint = function( self, w, h )
		draw.RoundedBox( 1, 0, 0, w, h, COLOR_APLHA )
	end

	local img = vgui.Create( "DHTML", frame )
	img:Dock( FILL )
	img:OpenURL( url )

	timer.Simple( 6, function() frame:Remove() end )
end )
]]