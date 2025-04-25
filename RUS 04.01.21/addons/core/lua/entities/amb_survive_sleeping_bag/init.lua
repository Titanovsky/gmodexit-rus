AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

local mdl = 'models/props_c17/FurnitureBed001a.mdl'

function ENT:Initialize()
	self:SetModel( mdl )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetRenderMode( RENDERMODE_NORMAL )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( 200 )
	self.can_use = true
	self.ply = nil

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:EnableMotion( false )
	end
end

function ENT:Use( ePly )

	if ( self.can_use ) then

		self.can_use = false
		self.ply = ePly
		self:SetColor( team.GetColor( self.ply:Team() ) )
		self.ply:ChatPrint('[•] You private it sleeping bag')
		
		AmbSurvive.points_spawn[ePly:SteamID()] = self:GetPos() + Vector( 0, 0, 25 )

	end

end

function ENT:OnTakeDamage( dmg )
	self:SetHealth( self:Health() - dmg:GetDamage() )

	if ( self:Health() <= 0 ) and IsValid( self ) then
	
		self:Remove() 

	end

end

function ENT:OnRemove()
	if self.can_use then return end
	
	if IsValid( self.ply ) then

		AmbSurvive.points_spawn[ self.ply:SteamID() ] = nil

	end

end
