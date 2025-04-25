local COLOR_TEXT = Color( 240, 240, 240 )
local COLOR_MAIN = Color( 214, 137, 56 )
local COLOR_SUBMAIN = Color( 54, 54, 54 )
local COLOR_PANEL_OUTLINE = Color( 221, 129, 56 )
local COLOR_PANEL = Color( 72, 72, 72 )

local w = ScrW()
  local h = ScrH()

function AmbRegister_guide()
	local frame = vgui.Create( "DFrame" )
    frame:SetTitle( "" )
    frame:SetSize( 200, 200 )
    frame:Center()
    frame:MakePopup()
    frame:ShowCloseButton( false )
    frame.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, COLOR_MAIN )
        draw.RoundedBox( 0, 2, 2, w-4, h-4, COLOR_SUBMAIN )
    end

    local btn_start = vgui.Create("DButton", frame )
    btn_start:SetText( "Да, по Игре" )
    btn_start:SetTextColor( COLOR_TEXT )
    btn_start:SetSize( 100, 30 )
    btn_start:SetPos( frame:GetWide()/2, frame:GetTall()/2 )
    btn_start.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, COLOR_PANEL )
    end
    btn_start.DoClick = function()
        frame:Remove()
    end
end
