AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local COLOR_CHAIR = Color( 0, 239, 247 )
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
    self:SetNWBool("IsReloaded", true)

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:EnableMotion( false )
	end
end

function ENT:Use( ent )
	if self:GetNWBool("IsReloaded") == true then

		ent:Give("weapon_hl2pan")
		ent:SendLua("notification.AddLegacy( 'слеш ми погладил', NOTIFY_GENERIC, 5 )")

		self:SetNWBool("IsReloaded", false)
		timer.Simple(364, function() self:SetNWBool("IsReloaded", true) end)
	else
		ent:SendLua("notification.AddLegacy( 'Уже кто-то сидел.. Попробуйте позже!', NOTIFY_ERROR, 3 )")
	end
end
