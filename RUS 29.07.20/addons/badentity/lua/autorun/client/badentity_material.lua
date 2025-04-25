local w = ScrW()
local h = ScrH()
local COLOR_HUI = Color(0,0,0)

function BadEntity_Start()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetPos( w * 0.006, 5) 
	Frame:SetSize( 1300, 800 ) 
	Frame:SetTitle( "" ) 
	Frame:SetVisible( true ) 
	Frame:SetDraggable( false ) 
	Frame:ShowCloseButton( false ) 
	Frame:MakePopup()
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, COLOR_HUI ) 
	end

	local breen_img = vgui.Create("DImage", Frame)	
	breen_img:SetPos(1300/2-400, 800/2 - 400)	
	breen_img:SetSize(800, 700)
	breen_img:SetImage("core_one.png")

	timer.Simple(14, function() Frame:Remove() end)

	surface.PlaySound( "core_sound.wav" )
end
concommand.Add( "material_bad", function()
   BadEntity_Start()
end )