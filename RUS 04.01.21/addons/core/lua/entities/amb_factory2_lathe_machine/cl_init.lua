include( 'shared.lua' )

local w_panel = 188
local h_panel = 84
local COLOR_PANEL = Color( 0, 0, 0, 200 )

local function ShowMenuLatheMachine( eMachine )

	local function CheckMetal( nCount )

		if ( LocalPlayer():GetNWInt( 'Metal' ) >= nCount ) then return AMB_COLOR_GREEN end

		return AMB_COLOR_RED

	end

	local frame = vgui.Create( 'DFrame' )
	frame:SetSize( 412, 224 )
	frame:Center()
	frame:SetTitle( '' )
	frame:MakePopup()
	frame.Paint = function( self, w, h )

		draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_AMBITION )
		draw.RoundedBox( 4, 4, 4, w-8, h-8, AMB_COLOR_SMALL_BLACK )

	end

	local grid = vgui.Create( 'DGrid', frame )
	grid:SetPos( 12, 32 )
	grid:SetCols( #eMachine.flags/2 )
	grid:SetColWide( w_panel + 12 )
	grid:SetRowHeight( h_panel + 12 )

	for k, flag in pairs( eMachine.flags ) do
		
		local workpiece = vgui.Create( 'DPanel' )
		workpiece:SetSize( w_panel, h_panel )
		workpiece.Paint = function( self, w, h )

			draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
			draw.SimpleTextOutlined( flag.chunk, 'ambFont22', w/2, 26, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )
			draw.SimpleTextOutlined( 'Metals: ', 'ambFont18', 6, h-12, AMB_COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )
			draw.SimpleTextOutlined( flag.metal, 'ambFont18', 62, h-11, CheckMetal( flag.metal ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		end
		grid:AddItem( workpiece )

		local send = vgui.Create( 'DButton', workpiece )
		send:SetSize( 72, 26 )
		send:SetPos( workpiece:GetWide() - send:GetWide() - 6, workpiece:GetTall() - send:GetTall() - 6 )
		send:SetFont( 'ambFont18' )
		send:SetTextColor( CheckMetal( flag.metal ) )
		send:SetText( 'To make' )
		send.Paint = function( self, w, h )

			draw.RoundedBox( 1, 0, 0, w, h, CheckMetal( flag.metal ) )
			draw.RoundedBox( 1, 2, 2, w-4, h-4, COLOR_PANEL )

		end
		send.DoClick = function()

			if ( LocalPlayer():GetNWInt( 'Metal' ) >= flag.metal ) then

				frame:Remove()
				
				net.Start( 'amb_f2_lm' )
					net.WriteEntity( eMachine )
					net.WriteUInt( k, 3 )
				net.SendToServer()

				surface.PlaySound( 'buttons/button9.wav' )

			else

				surface.PlaySound( 'buttons/button10.wav' )

			end

		end

	end
 
end

local flags_colors = {
	AMB_COLOR_AMBITION,
	AMB_COLOR_ERROR
}

local function PrintChat( sText, nFlag )

	chat.AddText( flags_colors[ nFlag ], '[•] ', AMB_COLOR_WHITE, sText )

end

local max_dist = 2400
local font = 'ambFont22'
local COLOR_GREEN = Color( 0, 255, 0 )

local w_ent = 670
local h_ent = 120
local x_ent = -320
local y_ent = -72

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:DrawTranslucent()

	self:Draw()
	self:DrawShadow( false )

	local condition_color = self:GetNWBool( 'Occupied' ) and AMB_COLOR_RED or AMB_COLOR_GREEN
	local condition_text = self:GetNWBool( 'Occupied' ) and '× OCCUPIED' or '✓ LOOSELY'

	if imgui.Entity3D2D( self, Vector( 14.8, 0, 16.8 ), Angle( 0, 90, 0 ), 0.1, 600 ) then

		draw.RoundedBox( 4, x_ent, y_ent, w_ent, h_ent, AMB_COLOR_AMBITION )
		draw.RoundedBox( 4, x_ent + 6, y_ent + 6, w_ent - 12, h_ent - 12, AMB_COLOR_SMALL_BLACK )

		draw.SimpleTextOutlined( 'Lathe Machine', 'ambFont32', 0, -46, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )
		draw.SimpleTextOutlined( condition_text, 'ambFont22', -310, 26, condition_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		if imgui.xTextButton( 'To make workpiece', font, -90, 0, 180, 36, 2, condition_color, COLOR_GREEN, condition_color ) and ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= 82 ) and ( LocalPlayer():GetNWInt( 'Metal' ) > 0 ) and ( self:GetNWBool( 'Occupied' ) == false ) then

			ShowMenuLatheMachine( self )

		end

    	imgui.End3D2D()

	end

end
