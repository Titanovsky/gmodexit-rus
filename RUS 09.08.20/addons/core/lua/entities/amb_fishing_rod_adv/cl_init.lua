include('shared.lua')
-- Данное творение принадлежит проекту [ Ambition ]

local COLOR = Color( 0, 0, 0, 255 )

function ENT:Draw()
	self:DrawModel()
	self:SetColor( COLOR )
	self:DrawShadow( false )
end

-- Данное творение принадлежит проекту [ Ambition ]