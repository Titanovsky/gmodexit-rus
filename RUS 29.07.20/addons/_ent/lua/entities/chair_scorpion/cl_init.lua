include('shared.lua')

local COLOR_CHAIR = Color( 212, 140, 32 )
local COLOR_WHITE = Color( 255, 255, 255 )
local dist = 666

function ENT:Draw()
	self:DrawModel()
	self:DrawShadow(false)

	if self:GetPos():Distance( LocalPlayer():GetPos() ) < dist then
        local pos = self:GetPos() + Vector(15, 0, 35)
        cam.Start3D2D( pos + self:GetAngles():Up(), Angle( 0, LocalPlayer():EyeAngles().yaw - 90, 90 ), 0.25 )
            draw.SimpleTextOutlined( "[♏]666scorpion", "DermaLarge", -120, -120, Color( 255, 255, 255, 255 ), TEXT_ALIGN_СENTER, TEXT_ALIGN_СENTER, 1, COLOR_CHAIR )
        cam.End3D2D()
    end
end