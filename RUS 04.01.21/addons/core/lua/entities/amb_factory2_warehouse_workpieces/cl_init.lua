include( 'shared.lua' )

local function ShowMenuWorkpieces()

	local frame = vgui.Create( 'DFrame' )
	frame:SetSize( 412, 224 )
	frame:Center()
	frame:SetTitle( '' )
	frame:MakePopup()
	frame.Paint = function( self, w, h )

		draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_AMBITION )
		draw.RoundedBox( 4, 4, 4, w-8, h-8, AMB_COLOR_SMALL_BLACK )

	end

end

local flags_colors = {
	AMB_COLOR_AMBITION,
	AMB_COLOR_ERROR
}

local function PrintChat( sText, nFlag )

	chat.AddText( flags_colors[ nFlag ], '[•] ', AMB_COLOR_WHITE, sText )

end

local function CreateDelay( nDelay )

	timer.Create( 'AmbFac2TakePutWarehouseWorkpiece'..LocalPlayer():SteamID(), nDelay, 1, function() end )

end

local function GetDelay()

	return math.Round( timer.TimeLeft( 'AmbFac2TakePutWarehouseWorkpiece'..LocalPlayer():SteamID() ) )

end

local function IsDelay()

	return timer.Exists( 'AmbFac2TakePutWarehouseWorkpiece'..LocalPlayer():SteamID() )

end

local max_dist = 2400
local font = 'ambFont22'
local COLOR_GREEN = Color( 0, 255, 0 )
local COLOR_BLUE = Color( 25, 115, 255 )
local positions_and_scale = {
	panel1 = { w = 320, h = 140, x = -160, y = -90 },
	panel2 = { w = 300, h = 200, x = -568, y = -150 }
}

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:ColorCondition( nType )

	local color = ( self:GetNWInt( 'Workpiece_'..nType ) > 0 ) and AMB_COLOR_GREEN or AMB_COLOR_RED

	return color

end

function ENT:DrawTranslucent()

	self:Draw()
	self:DrawShadow( false )

	if imgui.Entity3D2D( self, Vector( 10, 0, 26 ), Angle( 0, 90, 0 ), 0.1, 600 ) then

		draw.RoundedBox( 4, positions_and_scale.panel1.x, positions_and_scale.panel1.y, positions_and_scale.panel1.w, positions_and_scale.panel1.h, AMB_COLOR_AMBITION )
		draw.RoundedBox( 4, positions_and_scale.panel1.x + 6, positions_and_scale.panel1.y + 6, positions_and_scale.panel1.w - 12, positions_and_scale.panel1.h - 12, AMB_COLOR_SMALL_BLACK )

		draw.SimpleTextOutlined( 'Workpieces Warehouse', 'ambFont32', -2, -64, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		if imgui.xTextButton( 'Put', font, -120, -10, 100, 42, 2, AMB_COLOR_GREEN, COLOR_GREEN, AMB_COLOR_GREEN ) and ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= 82 ) and ( IsDelay() == false ) and LocalPlayer():GetNWBool( 'HaveWorkpiece' ) then

			net.Start( 'amb_f2_ww' )
				net.WriteEntity( self )
				net.WriteBit( false )
			net.SendToServer()
			CreateDelay( 8 )

		end

		if imgui.xTextButton( 'Take', font, 6, -10, 100, 42, 2, AMB_COLOR_BLUE, COLOR_BLUE, AMB_COLOR_BLUE ) and ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= 82 ) and ( IsDelay() == false ) and LocalPlayer():GetNWBool( 'HaveWorkpiece' ) then

			chat.AddText( 'Временно не работает!' )

		end

		draw.RoundedBox( 4, positions_and_scale.panel2.x, positions_and_scale.panel2.y, positions_and_scale.panel2.w, positions_and_scale.panel2.h, AMB_COLOR_AMBITION )
		draw.RoundedBox( 4, positions_and_scale.panel2.x + 6, positions_and_scale.panel2.y + 6, positions_and_scale.panel2.w - 12, positions_and_scale.panel2.h - 12, AMB_COLOR_SMALL_BLACK )

		draw.SimpleTextOutlined( 'Condition', 'ambFont32', -426, -120, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		for k, v in pairs( AmbFactory2Chunks ) do
			
			draw.SimpleTextOutlined( v.chunk, 'ambFont22', -556, -90 + 26 * k, AMB_COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )
			draw.SimpleTextOutlined( self:GetNWInt('Workpiece_'..k), 'ambFont22', -446, -90 + 26 * k, self:ColorCondition( k ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		end

		if IsDelay() then

			draw.SimpleTextOutlined( 'Wait '..GetDelay()..' seconds', 'ambFont18', -150, -26, AMB_COLOR_RED, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

		end

    	imgui.End3D2D()

	end

end
