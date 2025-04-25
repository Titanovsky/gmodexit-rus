AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

local mdl = 'models/healthvial.mdl'

function ENT:Initialize()
	self:SetModel( mdl )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( 25 )

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end

	self:SetNWString( 'virus_name', 'Unknow' )
    self:SetNWString( 'virus_model', 'models/vortigaunt.mdl' )
    self:SetNWInt( 'virus_opt_runspeed', 200 )
    self:SetNWInt( 'virus_opt_jumppower', 200 )
    self:SetNWInt( 'virus_opt_health', 200 )

end

function ENT:Use( ePly )
	AmbChemistry.acceptVirus( ePly, self )
	self:Remove()
end

function ENT:OnTakeDamage( dmg )
	self:SetHealth( self:Health() - dmg:GetDamage() )
	if ( self:Health() <= 0 ) and ( IsValid( self ) ) then 
		self:Remove() 
	end
end


