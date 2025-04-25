AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local COLOR_CHAIR = Color(0,0,0)
local mat = "models/debug/debugwhite"

function ENT:Initialize()
	self:SetModel( "models/props_c17/chair02a.mdl" )
	self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetColor(COLOR_CHAIR)
    self:SetMaterial(mat)
    self:DropToFloor()

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:EnableMotion(false)
	end
end

function ENT:Use( ent )
	if ent:IsPlayer() and IsValid(ent) then
		ent:Say("/stats")
	end
end
