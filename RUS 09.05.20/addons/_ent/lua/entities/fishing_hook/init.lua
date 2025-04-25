AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_junk/meathook001a.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetNWBool("Catch", false)

	local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end
end

function ENT:TakeCatch()
	if self:GetNWBool("Catch") == true then
		self.catch = ents.Create("fishing_catch")
		self.catch:Spawn()
		self.catch:SetPos(self:GetPos())
		self.catch:SetParent(self)
	end
end

function ENT:Use()
	if self:GetNWBool("Catch") == true then
		self:SetNWBool("Catch", false)
		if self.catch:IsValid() then
			self.catch:SetParent(nil)
			self.catch:SetPos(self:GetPos())
		end
	end
end

function ENT:OnRemove()
	if self.catch:IsValid() then
		self.catch:Remove()
	end
end

