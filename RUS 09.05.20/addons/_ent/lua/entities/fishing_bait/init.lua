AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_junk/watermelon01.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetNWBool("IsLoaded", false)
    self:SetColor(Color(0,220,0))
    self:SetHealth(0)

    local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end
end

function ENT:Touch(ent)
	if ent:GetClass() == "fishing_hook"  then
		self.hook = ent
		self:SetPos(self.hook:GetPos() + Vector(0,0,10))
		constraint.Weld(
			self.hook, self, 0, 
			0, 
			false, false
		)
		self:SetNWBool("IsLoaded", true)
	end
end

function ENT:Think()
	if self:WaterLevel() > 2 and self:GetNWBool("IsLoaded") == true then
		self.hook:SetNWBool("Catch", true)
		self.hook:TakeCatch()
		if self:IsValid() then
			self:Remove()
		end
	end
end


