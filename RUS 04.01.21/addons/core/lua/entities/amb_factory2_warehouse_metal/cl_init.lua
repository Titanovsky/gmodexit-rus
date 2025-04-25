include( 'shared.lua' )

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
local w_ent = 280
local h_ent = 200
local x_ent = -250
local y_ent = -260

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:DrawTranslucent()

	self:Draw()
	self:DrawShadow( false )

	local condition_color = ( self:GetNWInt( 'Metal' ) > 0 ) and AMB_COLOR_GREEN or AMB_COLOR_RED

	if imgui.Entity3D2D( self, Vector( 19, 0, 32 ), Angle( 0, 60, 90 ), 0.1, 600 ) then

		--local x_mouse, y_mouse = imgui.CursorPos()
		--imgui.xCursor( x_mouse, y_mouse, 512, 512 )

		draw.RoundedBox( 4, x_ent, y_ent, w_ent, h_ent, AMB_COLOR_AMBITION )
		draw.RoundedBox( 4, x_ent + 6, y_ent + 6, w_ent - 12, h_ent - 12, AMB_COLOR_SMALL_BLACK )

		draw.SimpleTextOutlined( 'Metal Warehouse', 'ambFont32', -110, -230, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )
		draw.SimpleTextOutlined( 'Condition: ', 'ambFont22', -190, -180, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )
		draw.SimpleTextOutlined( self:GetNWInt( 'Metal' )..' units', 'ambFont22', -140, -180, condition_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		if timer.Exists( 'AmbFactory2ReloadMetals'..self:EntIndex() ) then

			draw.SimpleTextOutlined( math.Round( timer.TimeLeft( 'AmbFactory2ReloadMetals'..self:EntIndex() ) ), 'ambFont32', 18, -80, AMB_COLOR_BLUE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		end

		if ( timer.Exists( 'AmbTimeFac2TakeMetall'..LocalPlayer():SteamID() ) ) then

			draw.SimpleTextOutlined( 'Wait '..math.Round( timer.TimeLeft( 'AmbTimeFac2TakeMetall'..LocalPlayer():SteamID() ) )..' seconds', 'ambFont18', -234, -150, AMB_COLOR_RED, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		end

		if imgui.xTextButton( 'To take', font, -160, -120, 100, 42, 2, AMB_COLOR_GREEN, COLOR_GREEN, AMB_COLOR_GREEN ) and ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= 82 ) and ( self:GetNWInt( 'Metal' ) > 0 ) and ( timer.Exists( 'AmbTimeFac2TakeMetall'..LocalPlayer():SteamID() ) == false ) then

			net.Start( 'amb_f2_wm' )
				net.WriteEntity( self )
			net.SendToServer()

			timer.Create( 'AmbTimeFac2TakeMetall'..LocalPlayer():SteamID(), self.cooldown_taker, 1, function() end )

		end

    	imgui.End3D2D()

	end

end