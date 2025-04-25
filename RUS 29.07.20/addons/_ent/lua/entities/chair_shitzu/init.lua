AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local COLOR_CHAIR = Color( 242, 82, 82 )
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
	if ( self:GetNWBool("IsReloaded") ) then
		ent:SendLua('surface.PlaySound("ru_reborn/spooky_porno.wav")')
		ent:Say("/me купил пиано")
		timer.Simple(200, function() self:SetNWBool("IsReloaded", true) end)
	else
		ent:SendLua("notification.AddLegacy( 'Уже кто-то сидел.. Попробуйте позже!', NOTIFY_ERROR, 3 )")
	end
end
