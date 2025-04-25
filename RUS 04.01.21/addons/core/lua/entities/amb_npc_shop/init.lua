AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel( 'models/gman_high.mdl' )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:PhysicsInit( SOLID_BBOX )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:CapabilitiesAdd( CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )

	self.type_shop = 0

	local phys = self:GetPhysicsObject()

	if ( IsValid( phys ) ) then

		phys:EnableMotion( false )
		
	end

end

function ENT:Use( ePly )

	--
end