AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

local COLOR_BUG = Color( 227, 187, 7 )

function ENT:Initialize()
	self:SetModel( "models/props_junk/garbage_bag001a.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetColor( COLOR_BUG )
	self:SetUseType( 3 )

    local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
end

local sum = math.random( 1, 10000 )

function ENT:Use( eEnt )
	if ( eEnt:IsPlayer() ) then
		eEnt:ChatPrint( "Вы нашли: "..sum )
		self:Remove()
		eEnt:RUB_add( sum )
	end
end


