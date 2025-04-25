AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local COLOR_CHAIR = Color( 255, 255, 255 )
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
    if IsValid( phys ) then
    	phys:EnableMotion(false)
    end

end

function ENT:Use( ent )
	if ent:IsPlayer() and IsValid(ent) then
		if self:GetNWBool("IsReloaded") == true then

			for _, ply in pairs(player.GetHumans() ) do
				ply:SendLua( "chat.AddText( Color(0,0,0),'(Console) ', Color(152, 212, 255), 'added ', Color(74, 0, 131), LocalPlayer():Nick(), Color(152, 212, 255), ' to group ', Color(0,255,0), 'owner' )" )
			end
			--ent:SendLua( "chat.AddText( Color(214, 214, 214),' Титан ушёл, но обещал вернуться...' )" )

			self:SetNWBool("IsReloaded", false)
			timer.Simple(496, function() self:SetNWBool("IsReloaded", true) end)
		else
			ent:SendLua("notification.AddLegacy( 'Стул горячий, нельзя сесть!.', NOTIFY_ERROR, 3 )")
		end
	end
end
