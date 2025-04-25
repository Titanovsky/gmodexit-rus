AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_junk/harpoon002a.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    --self:SetNWBool("IsLoaded", false)

	local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end

	self.hook = ents.Create("fishing_hook")
	self.hook:Spawn()
	self.hook:SetOwner(self:GetOwner())
	self.hook:SetPos(self:GetPos() + Vector(0,0,50))

	constraint.Rope(
		self, self.hook, 0, 0, 
		Vector(48,0,0), Vector(0,0,19), 
		100, 0, 0, 
		1, "cable/rope", false
	)
end

function ENT:OnRemove()
	if self.hook:IsValid() then
		self.hook:Remove()
	end
end

function ENT:Think()
	--print( self.hook:WaterLevel() )
end
