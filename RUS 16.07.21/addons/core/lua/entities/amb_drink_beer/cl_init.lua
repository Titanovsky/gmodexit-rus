include("shared.lua")

local max_dist = 1600
local font = 'ambFont32'

function ENT:Draw()

	self:DrawShadow( false )

    local _,max = self:GetRotatedAABB( self:OBBMins(), self:OBBMaxs() )
    local rot = ( self:GetPos() - EyePos() ):Angle().yaw - 90
	local center = self:LocalToWorld( self:OBBCenter() )

	if ( self:GetPos():Distance( LocalPlayer():GetPos() ) < max_dist ) then

		self:DrawModel()

		cam.Start3D2D( center + Vector( 0, 0, math.abs( max.z / 2 ) + 8 ), Angle( 0, rot, 90 ), 0.13 )

	        draw.SimpleTextOutlined( 'Пиво', font, 0, 0, AMB_COLOR_AMBITION, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

	    cam.End3D2D()
	end

end