AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/maxofs2d/button_02.mdl" )
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

			local r = math.random(1, 6)

			if r == 1 then
				ent:Kill()
			elseif r == 2 then
				ent:Give("weapon_rpg")
				ent:GiveAmmo(20, "RPG_Round", true)
			elseif r == 3 then
				ent:Say("Ищу парня")
			elseif r == 4 then
				ent:Say("Я гей")
			elseif r == 5 then
				ent:SetHealth(666)
				ent:SetArmor(1)
				ent:SetColor(Color(255,0,0,255))
				ent:Give("breadfish_weap")
			elseif r == 6 then
				local rub = math.random(10, 25000)
				ent:RUB_add(rub)
				ent:SendLua("notification.AddLegacy( 'Оу, вы взяли деньги!', NOTIFY_GENERIC, 3 )")
			end

			self:SetNWBool("IsReloaded", false)
			timer.Simple(1200, function() self:SetNWBool("IsReloaded", true) end)
		else
			ent:SendLua("notification.AddLegacy( 'Кнопка горячая.. Попробуйте позже!', NOTIFY_ERROR, 3 )")
		end
	end
end
