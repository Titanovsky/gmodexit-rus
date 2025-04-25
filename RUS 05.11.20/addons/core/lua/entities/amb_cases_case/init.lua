AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( 'models/ptejack/props/crates/weapons_crate.mdl' )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetRenderMode( RENDERMODE_NORMAL )
	self:SetUseType( SIMPLE_USE )
	self:SetNWString('name', 'Unknow')
	self:SetNWInt('type', 0)

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

function ENT:Use( ePly )
	local type_ent = tonumber( self:GetNWInt('type') ) -- почистил немного код
	local func = AmbCases.cases[ type_ent ].func

	if ( IsValid( ePly ) ) then
		func( ePly )
	end
	self:Remove()
end

