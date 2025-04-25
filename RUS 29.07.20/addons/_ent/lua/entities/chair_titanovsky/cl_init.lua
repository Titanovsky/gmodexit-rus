include('shared.lua')

local COLOR_CHAIR = Color( 0, 0, 0, 255 )
local COLOR_WHITE = Color( 255, 255, 255 )
local dist = 666

function ENT:Draw()
	self:DrawModel()
	self:DrawShadow(false)

	if self:GetPos():Distance( LocalPlayer():GetPos() ) < dist then
        local pos = self:GetPos() + Vector(15, 0, 35)
        cam.Start3D2D( pos + self:GetAngles():Up(), Angle( 0, LocalPlayer():EyeAngles().yaw - 90, 90 ), 0.25 )
            draw.SimpleTextOutlined( "Titanovsky", "DermaLarge", -120, -200, COLOR_CHAIR, TEXT_ALIGN_СENTER, TEXT_ALIGN_СENTER, 0.6, COLOR_WHITE )
        cam.End3D2D()
    end
end