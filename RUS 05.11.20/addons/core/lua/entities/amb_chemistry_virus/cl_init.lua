include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	self:DrawShadow( false )

	if self:GetPos():Distance( LocalPlayer():GetPos() ) < 199 then
		local pos = self:GetPos() + Vector(0, 0, 20)
		cam.Start3D2D( pos + self:GetAngles():Up(), Angle( 0, LocalPlayer():EyeAngles().yaw - 90, 90 ), 0.15 )
	        draw.SimpleTextOutlined( self:GetNWString('virus_name'), "DermaLarge", -15, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 0.5, Color( 20, 20, 255, 255 ) )
	    cam.End3D2D()
	end
end
