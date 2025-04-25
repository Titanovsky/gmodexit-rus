include( 'shared.lua' )

local flags_colors = {
	AMB_COLOR_AMBITION,
	AMB_COLOR_ERROR
}

local function PrintChat( sText, nFlag )

	chat.AddText( flags_colors[ nFlag ], '[•] ', AMB_COLOR_WHITE, sText )

end

local function CheckWorkpieces()

	for k, v in pairs( AmbFactory2Chunks ) do
		
		if ( LocalPlayer():GetNWInt( 'Workpiece_'..k ) > 0 ) then return true end

	end

	return false

end

local font = 'ambFont22'
local COLOR_GREEN = Color( 0, 255, 0 )
local panel = { w = 480, h = 140, x = -250, y = 26 }

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:DrawTranslucent()

	self:Draw()
	self:DrawShadow( false )

	local condition_color = self:GetNWBool( 'Occupied' ) and AMB_COLOR_RED or AMB_COLOR_GREEN
	local condition_text = self:GetNWBool( 'Occupied' ) and '× OCCUPIED' or '✓ LOOSELY'

	if imgui.Entity3D2D( self, Vector( 14.8, 0, 20 ), Angle( 0, 90, 0 ), 0.1, 600 ) then

		draw.RoundedBox( 4, panel.x, panel.y, panel.w, panel.h, AMB_COLOR_AMBITION )
		draw.RoundedBox( 4, panel.x + 6, panel.y + 6, panel.w - 12, panel.h - 12, AMB_COLOR_SMALL_BLACK )

		draw.SimpleTextOutlined( 'Miling Machine', 'ambFont32', -12, 52, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )
		draw.SimpleTextOutlined( condition_text, 'ambFont22', -242, 144, condition_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		if imgui.xTextButton( 'Make the detail', font, -90, 120, 148, 36, 2, condition_color, COLOR_GREEN, condition_color ) and ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= 82 ) then

			if CheckWorkpieces() and ( self:GetNWBool( 'Occupied' ) == false ) then

				net.Start( 'amb_f2_mm' )
					net.WriteEntity( self )
				net.SendToServer()

			elseif ( CheckWorkpieces() == false ) then

				PrintChat( 'У вас нет заготовок', 2 )

			elseif self:GetNWBool( 'Occupied' ) then

				PrintChat( 'Фрезерный Станок кем-то занят!', 2 )

			end

		end

    	imgui.End3D2D()

	end

end