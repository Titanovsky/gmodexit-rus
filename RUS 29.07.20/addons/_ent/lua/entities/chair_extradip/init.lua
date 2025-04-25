AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local COLOR_CHAIR = Color( 99, 150, 212 )
local mat = "models/debug/debugwhite"

function ENT:Initialize()
	self:SetModel( "models/props_c17/chair02a.mdl" )
	self:SetMoveType(MOVETYPE_NONE)
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

		ent:SendLua("chat.AddText(Color(255,255,255), 'noTitanovskyDuplication()')") -- Action

		self:SetNWBool("IsReloaded", false)
		timer.Simple(380, function() self:SetNWBool("IsReloaded", true) end)
	else
		ent:SendLua("notification.AddLegacy( 'Уже кто-то сидел.. Попробуйте позже!', NOTIFY_ERROR, 3 )")
	end
end
