AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_junk/harpoon002a.mdl" )
	self:SetMaterial( "phoenix_storms/wood" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS) 
    self:SetUseType( SIMPLE_USE )
	self:SetHealth( 200 )


	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
	
	timer.Create("ambrod[1]", 300, 1, function()
		if IsValid( self ) then self:Remove() end
	end)


	self.hook = ents.Create( "amb_fishing_hook" )
	self.hook:Spawn()
	self.hook:SetOwner( self )
	self.hook:SetPos( self:GetPos() + Vector(0,0,50) )

	constraint.Rope( -- такая дремучая фигня
		self, self.hook, 0, 0, 
		Vector(48,0,0), Vector(0,0,19), 
		100, 0, 0, 
		1, "cable/rope", false
	)
	self.hook:CPPISetOwner( self:CPPIGetOwner() )
end

function ENT:OnRemove()
	if ( self.hook:IsValid() ) then
		self.hook:Remove()
	end
end

function ENT:OnTakeDamage( tDmg )
	if IsValid( self ) then
		self:SetHealth( self:Health() - tDmg:GetDamage() )
		if (self:Health() <= 0 ) then
			self:Remove()
		end
	end
end


function ENT:Think()
	self:SetNWFloat( "time", timer.TimeLeft("ambrod[1]") )
	--print( self.hook:WaterLevel() )
end
