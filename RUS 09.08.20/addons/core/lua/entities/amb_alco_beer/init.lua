AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_junk/garbage_glassbottle003a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetRenderMode( RENDERMODE_NORMAL )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( 35 )
end

function ENT:Use( ePly )
	if ( IsValid( ePly ) ) and AmbAlco.getDrunk( ePly ) == 0 then
		self:Remove() -- !!!
		AmbAlco.setDrunk( ePly, 1 )
		timer.Simple( 4, function() AmbAlco.removeDrunk( ePly ) end )
	end
end

function ENT:OnTakeDamage( dmg )
	self:SetHealth( self:Health() - dmg:GetDamage() )
	if ( self:Health() <= 0 ) and IsValid( self ) then self:Remove() end
end
