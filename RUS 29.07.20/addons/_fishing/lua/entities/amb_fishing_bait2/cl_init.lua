include('shared.lua') -- Данное творение принадлежит проекту [.ambition]

function ENT:Draw()
	self:DrawModel()
	self:DrawShadow( false ) -- zachem?
end
-- Данное творение принадлежит проекту [.ambition]