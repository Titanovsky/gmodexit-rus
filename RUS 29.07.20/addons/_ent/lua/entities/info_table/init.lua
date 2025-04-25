AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_combine/breendesk.mdl" )
	self:SetMoveType( MOVETYPE_NONE ) 
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)
    --self:SetNWBool("IsReloaded", true)
    --self.reload = self:GetNWBool("IsLoaded")

	local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Sleep()
	end
end

function ENT:Use( ply )
	if ply:IsPlayer() and IsValid(ply) then
		ply:Say("/help")
	end
end
