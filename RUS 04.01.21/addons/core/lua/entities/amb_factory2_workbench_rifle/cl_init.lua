include( 'shared.lua' )

local flags_colors = {
	AMB_COLOR_AMBITION,
	AMB_COLOR_ERROR
}

local function PrintChat( sText, nFlag )

	chat.AddText( flags_colors[ nFlag ], '[•] ', AMB_COLOR_WHITE, sText )

end

local function CheckDetails()

	for k, v in pairs( AmbFactory2Chunks ) do
		
		if ( LocalPlayer():GetNWInt( 'Detail_'..k ) == 0 ) then PrintChat( 'Вам нужна деталь '..AmbFactory2Chunks[ k ].chunk, 2 ) return false end

	end

	return true

end

local font = 'ambFont22'
local COLOR_GREEN = Color( 0, 255, 0 )
local panel = { w = 480, h = 140, x = -250, y = -64 }

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:DrawTranslucent()

	self:Draw()
	self:DrawShadow( false )

	if imgui.Entity3D2D( self, Vector( 14, 0, 35.4 ), Angle( 0, 90, 0 ), 0.1, 600 ) then

		draw.RoundedBox( 4, panel.x, panel.y, panel.w, panel.h, AMB_COLOR_AMBITION )
		draw.RoundedBox( 4, panel.x + 6, panel.y + 6, panel.w - 12, panel.h - 12, AMB_COLOR_SMALL_BLACK )

		draw.SimpleTextOutlined( 'Workbench Rifle', 'ambFont32', -12, -36, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		if imgui.xTextButton( 'Craft', font, -60, 28, 84, 36, 2, AMB_COLOR_GREEN, COLOR_GREEN, AMB_COLOR_GREEN ) and ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= 82 ) then

			if CheckDetails() then

				net.Start( 'amb_f2_wr' )
					net.WriteEntity( self )
				net.SendToServer()

			end

		end

    	imgui.End3D2D()

	end

end