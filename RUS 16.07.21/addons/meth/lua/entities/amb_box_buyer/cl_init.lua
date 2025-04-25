include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	self:DrawShadow(false)

	if self:GetPos():Distance( LocalPlayer():GetPos() ) < 300 then
        local pos = self:GetPos() + Vector(15, 0, 35)
        cam.Start3D2D( pos + self:GetAngles():Up(), Angle( 0, LocalPlayer():EyeAngles().yaw - 90, 90 ), 0.25 )
            if ( self:GetNWBool("IsActive") )  then
                draw.SimpleTextOutlined( "Продать в рабство покупателя [E]", "DermaLarge", -120, -200, Color( 0, 0, 0, 255 ), 
                TEXT_ALIGN_СENTER, TEXT_ALIGN_СENTER, 0.6, Color( 0, 100, 100, 255) )
            else
                draw.SimpleTextOutlined( "Нужен покупатель наркоты!", "DermaLarge", -120, -200, Color( 0, 0, 0, 255 ), 
                TEXT_ALIGN_СENTER, TEXT_ALIGN_СENTER, 0.6, Color( 0, 100, 100, 255) )
            end
        cam.End3D2D()
    end
end