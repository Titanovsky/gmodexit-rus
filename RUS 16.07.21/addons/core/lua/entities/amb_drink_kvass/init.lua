AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

function ENT:Initialize()

	self:SetModel( 'models/props_junk/garbage_plasticbottle003a.mdl' )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetRenderMode( RENDERMODE_NORMAL )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( 35 )

end

function ENT:Use( ePly )

	AmbDrinks.AddDrunk( ePly, 0.1, 2 )
	self:Remove()

end

function ENT:OnTakeDamage( dmg )

	self:SetHealth( self:Health() - dmg:GetDamage() )
	if ( self:Health() <= 0 ) and IsValid( self ) then self:Remove() end

end
