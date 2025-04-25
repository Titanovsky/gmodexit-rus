include('shared.lua')

local COLOR_CHAIR = Color( 242, 82, 82 )
local COLOR_WHITE = Color( 255, 255, 255, 255 )
local dist = 666

function ENT:Draw()
	self:DrawModel()
	self:DrawShadow( false )

	if self:GetPos():Distance( LocalPlayer():GetPos() ) < dist then
        local pos = self:GetPos() + Vector(15, 0, 35)
        cam.Start3D2D( pos + self:GetAngles():Up(), Angle( 0, LocalPlayer():EyeAngles().yaw - 90, 90 ), 0.25 )
            draw.SimpleTextOutlined( "Sp00ky", "DermaLarge", -120, -120, COLOR_WHITE, TEXT_ALIGN_СENTER, TEXT_ALIGN_СENTER, 1, COLOR_CHAIR )
        cam.End3D2D()
    end
end