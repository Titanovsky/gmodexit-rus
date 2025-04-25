AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/chairs/armchair.mdl" )
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

			for _, v in pairs(player.GetHumans()) do
				v:SendLua( "chat.AddText( Color(0,0,0),'(Console) ', Color(152, 212, 255), 'added ', Color(74, 0, 131), LocalPlayer():Nick(), Color(152, 212, 255), ' to group ', Color(0,255,0), 'owner' )" )
			end

			self:SetNWBool("IsReloaded", false)
			timer.Simple(600, function() self:SetNWBool("IsReloaded", true) end)
		else
			ent:SendLua("notification.AddLegacy( 'ВЫ ЧТО ХОТИТЕ КУШАЦ?!', NOTIFY_ERROR, 3 )")
		end
	end
end
