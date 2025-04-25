
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


-- net strings for sending info between client & server

delay = 0
delay2 = 0
-- used to prevent flooding triggers in ENT:Use

function ENT:Initialize()

self:SetNWString("morphModel", "models/props_c17/chair02a.mdl")
self:SetNWString("morphName", "стул")

util.AddNetworkString("EntUse_" .. self:EntIndex())
util.AddNetworkString("EntResponse_" .. self:EntIndex())
util.AddNetworkString("musicc_" .. self:EntIndex())
util.AddNetworkString("EntModelChange_" .. self:EntIndex())
self:SetNWFloat("delay", 0)
self:SetNWFloat("delay2", 0)

self:SetModel(self:GetNWString("morphModel"))
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:SetUseType(SIMPLE_USE)

self:SetPos(self:GetPos() + Vector(0, 0, self:GetModelScale()))

        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use( ent )

-- здесь задержка между юзами №1 - можно поменять
if ent:IsPlayer() and CurTime() - delay >= 20 then
  delay = CurTime()
  delay2 = CurTime()
  net.Start("EntUse_" .. self:EntIndex())
  net.WriteEntity(ent)
  net.WriteString("ok")
  net.Send(ent)
else
  -- вторая задержка для задержки, защита от овердохуя уведомлений на экране
  if CurTime() - delay2 >= 6 then
    net.Start("EntUse_" .. self:EntIndex())
    net.WriteEntity(ent)
    net.WriteString("not_ok")
    net.Send(ent)
    delay2 = CurTime()
end
end
end

function ENT:Think()
-- here we're waiting for user response in derma window
net.Receive("EntResponse_" .. self:EntIndex(), function()
  local getter = net.ReadEntity()
  local str = net.ReadString()
  if str == "weapon" then
    getter:Give("weapon_pistol")
    getter:GiveAmmo(228, "Pistol", false)
  elseif str == "weapon_ar" then
    getter:Give("weapon_ar2", true)
    getter:GiveAmmo(1, "AR2AltFire", false)
  elseif str == "slap" then
    getter:TakeDamage(50, self)
  end
end)
net.Receive("musicc_" .. self:EntIndex(), function()

  net.Start("musicc_" .. self:EntIndex())
  net.WriteEntity(player)
  net.Send(net.ReadEntity())

end)
net.Receive("EntModelChange_" .. self:EntIndex(), function()

  self:SetModel(net.ReadString())
  self:SetNWString("morphModel", net.ReadString())
  self:SetMoveType( MOVETYPE_VPHYSICS )
  self:SetSolid( SOLID_VPHYSICS )
  self:SetUseType(SIMPLE_USE)
  local phys = self:GetPhysicsObject()
  if (phys:IsValid()) then
    phys:Wake()
  end
end)
end
