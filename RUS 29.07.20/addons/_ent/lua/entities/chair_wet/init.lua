AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local COLOR_CHAIR = Color(224, 255, 230)
local mat = "models/debug/debugwhite"

function ENT:Initialize()
	self:SetModel( "models/props_c17/chair02a.mdl" )
	self:SetMoveType(MOVETYPE_NONE)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetNWBool("IsReloaded", true)
    self:SetColor(COLOR_CHAIR)
    self:SetMaterial(mat)
    self:DropToFloor()

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:EnableMotion( false )
	end
end

function ENT:Use( ent )
	if self:GetNWBool("IsReloaded") == true then

		ent:Kill()

		self:SetNWBool("IsReloaded", false)
		timer.Simple(210, function() self:SetNWBool("IsReloaded", true) end)
	else
		ent:SendLua("notification.AddLegacy( 'Уже кто-то сидел.. Попробуйте позже!', NOTIFY_ERROR, 3 )")
	end
end
