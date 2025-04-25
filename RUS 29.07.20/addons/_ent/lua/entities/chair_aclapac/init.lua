AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local COLOR_CHAIR = Color( 0, 200, 0 )
local mat = "models/debug/debugwhite"

function ENT:Initialize()
	self:SetModel( "models/nova/chair_office02.mdl" )
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

		ent:SendLua("chat.AddText( Color(207, 207, 207), 'Вы получили доступ к дупликатору!' )")

		self:SetNWBool("IsReloaded", false)
		timer.Simple(280, function() self:SetNWBool("IsReloaded", true) end)
	else
		ent:SendLua("notification.AddLegacy( 'Уже кто-то сидел.. Попробуйте позже!', NOTIFY_ERROR, 3 )")
	end
end
