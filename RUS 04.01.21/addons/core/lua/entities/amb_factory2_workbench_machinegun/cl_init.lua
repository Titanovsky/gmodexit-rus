include( 'shared.lua' )

local max_dist = 2400
local font = 'ambFont22'

function ENT:Draw()

	self:DrawModel()
    self:DrawShadow( false )

	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis( ang:Up(), 90)

	if ( self:GetPos():Distance( LocalPlayer():GetPos() ) < max_dist ) then

		cam.Start3D2D( pos + ang:Up() * 16.8, ang, 0.15 )
			draw.RoundedBox( 4, -370, -140, 740, 270, AMB_COLOR_AMBITION )
	    cam.End3D2D()

	end

end
