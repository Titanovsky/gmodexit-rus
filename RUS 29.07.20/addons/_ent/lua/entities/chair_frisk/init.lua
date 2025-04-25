AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local COLOR_CHAIR = Color( 255, 0, 0 )
local mat = "models/debug/debugwhite"

function ENT:Initialize()
	self:SetModel( "models/props_c17/chair02a.mdl" )
	self:SetMoveType(MOVETYPE_NONE)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetColor(COLOR_CHAIR)
    self:SetMaterial(mat)
    self:DropToFloor()

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:EnableMotion( false )
	end
end

function ENT:Use( ent )
	IGS.UI(ent)
end
