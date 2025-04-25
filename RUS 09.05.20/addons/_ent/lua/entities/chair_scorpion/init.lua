AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_c17/chair02a.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetNWBool("IsReloaded", true)
    self.reload = self:GetNWBool("IsReloaded")

	local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end
end

function ENT:Use( ent )
	if ent:IsPlayer() and IsValid(ent) then
		if self:GetNWBool("IsReloaded") == true then

			ent:SetArmor(100)
			ent:Give("cw_l115")

			self:SetNWBool("IsReloaded", false)
			timer.Simple(580, function() self:SetNWBool("IsReloaded", true) end)
		else
			ent:SendLua("notification.AddLegacy( 'Уже кто-то сидел.. Попробуйте позже!', NOTIFY_ERROR, 3 )")
		end
	end
end
