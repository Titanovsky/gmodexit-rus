AddCSLuaFile( 'shared.lua' ); AddCSLuaFile( 'cl_init.lua' ); include( 'shared.lua' )

function ENT:Initialize()

	self:CreateFood( 'Фасоль' )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( 10 )

	local phys = self:GetPhysicsObject()

	if IsValid( phys ) then

		phys:Wake()
		phys:EnableMotion( true )

	end

end

function ENT:CreateFood( sFood )

	local tab = AmbSurvive.Hunger.foods[ sFood ]

	if not tab then return end

	self:SetModel( tab.mdl )
	self:SetNWString( 'Name', sFood )

end

function ENT:Use( ePly )

	AmbSurvive.Hunger.SatisfyHunger( ePly, self:GetNWString( 'Name' ) )
	self:Remove()

end

function ENT:OnTakeDamage( tDmg )

	self:SetHealth( self:Health() - tDmg:GetDamage() )

	if ( self:Health() <= 0 ) and IsValid( self ) then 

		self:Remove() 

	end

end