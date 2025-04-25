AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local COLOR_CHAIR = Color(255, 255, 255)
local mat = "models/debug/debugwhite"

function ENT:Initialize()
	self:SetModel( "models/xqm/modernchair.mdl" )
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

		ent:SetHealth( 50 )
		ent:Give('weapon_hl2pipe')

		self:SetNWBool("IsReloaded", false)
		timer.Simple(180, function() self:SetNWBool("IsReloaded", true) end)
	else
		ent:SendLua("notification.AddLegacy( 'Уже кто-то сидел.. Попробуйте позже!', NOTIFY_ERROR, 3 )")
	end
end
