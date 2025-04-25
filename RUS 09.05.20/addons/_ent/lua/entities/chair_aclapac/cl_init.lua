include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	self:DrawShadow(false)

	if self:GetPos():Distance( LocalPlayer():GetPos() ) < 880 then
        local pos = self:GetPos() + Vector(15, 0, 35)
        cam.Start3D2D( pos + self:GetAngles():Up(), Angle( 0, LocalPlayer():EyeAngles().yaw - 90, 90 ), 0.25 )
            draw.SimpleTextOutlined( "Стул ACLAPAC", "DermaLarge", -120, -120, Color( 255, 255, 255, 255 ), TEXT_ALIGN_СENTER, TEXT_ALIGN_СENTER, 1, Color( 10, 163, 79, 255) )
        cam.End3D2D()
    end
end