AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

local mdl = 'models/props_lab/servers.mdl'

function ENT:Initialize()
	self:SetModel( mdl )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( 800 )

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
end

function ENT:Use( ePly )
	ePly:SendLua('AmbChemistry.openMenu('..tostring( self:EntIndex() )..')')
end

function ENT:OnTakeDamage( dmg )
	self:SetHealth( self:Health() - dmg:GetDamage() )
	if ( self:Health() <= 0 ) and ( IsValid( self ) ) then 
		self:Remove() 
	end
end


