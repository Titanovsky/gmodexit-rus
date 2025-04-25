ENT.Base = "base_ai"
ENT.Type = "ai"

ENT.PrintName 	= "Продавец"
ENT.Category	= "[RU] Варка Наркотиков"

ENT.AutomaticFrameAdvance = true

ENT.Spawnable = true

function ENT:PhysicsCollide( data, physobj )
end

function ENT:PhysicsUpdate( physobj )
end

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end