include("shared.lua")
 

function ENT:Draw()
	
	if self:GetPos():Distance( LocalPlayer():GetPos() ) < 1624 then
		self:DrawModel()
		local pos = self:GetPos() + Vector(0, 0, 20)
		cam.Start3D2D( pos + self:GetAngles():Up(), Angle( 0, LocalPlayer():EyeAngles().yaw - 90, 90 ), 0.15 )
	        draw.SimpleTextOutlined( self:GetNWString('name'), "ambFont22", 0, -32, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0.5, AMB_COLOR_AMBITION )
	    cam.End3D2D()
	end
end
