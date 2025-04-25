AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

local mdl = 'models/props_lab/servers.mdl'

function ENT:Initialize()
	self:SetModel( mdl )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( 800 )

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:EnableMotion( false )
	end
end

function ENT:Use( ePly )
	if ( AMB.config.module_chemistry ) then
		ePly:SendLua('AmbChemistry.openMenu('..tostring( self:EntIndex() )..')')
	end
end

function ENT:OnTakeDamage( dmg )
	self:SetHealth( self:Health() - dmg:GetDamage() )
	if ( self:Health() <= 0 and IsValid( self ) ) then 
		self:Remove() 
	end
end


