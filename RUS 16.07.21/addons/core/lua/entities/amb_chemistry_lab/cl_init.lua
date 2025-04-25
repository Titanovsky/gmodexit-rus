include("shared.lua")

local max_dist = 2800
local color1 = Color( 0, 0, 0, 250 )
local color2 = AMB_COLOR_RED
local font = 'ambFont32'

function ENT:Draw()
	self:DrawModel()
	self:DrawShadow( false )

	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis( ang:Up(), 90 )

	if self:GetPos():Distance( LocalPlayer():GetPos() ) < max_dist then
		cam.Start3D2D( pos + ang:Up() * 109 + ang:Right() * 12 + ang:Forward() * -21, ang + Angle( 0, 0, 90 ), 0.15 )
			draw.RoundedBox( 4, 0, 0, 280, 64, color1 )
	        draw.SimpleText( 'Лаборатория Вирусов', font, 6, 28, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
	    cam.End3D2D()
	end
end
