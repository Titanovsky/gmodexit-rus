AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel( 'models/props/cs_assault/dryer_box.mdl' )
	self:PhysicsInit( 6 )
	self:SetMoveType( 6 )
	self:SetUseType( SIMPLE_USE )

	self.prop = 'models/props_c17/chair02a.mdl'

	local phys = self:GetPhysicsObject()
	
	if ( IsValid( phys ) ) then

		phys:Wake()

	end

end

function ENT:Use( ePly )

	local prop = ents.Create( 'prop_physics' )
	prop:SetModel( self.prop )
	prop:SetPos( self:GetPos() )
	prop:PhysicsInit( 6 )
	prop:SetMoveType( 6 )
	prop:Spawn()

	self:Remove()

end