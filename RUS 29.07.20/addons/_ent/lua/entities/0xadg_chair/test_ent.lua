AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "Test entity"
ENT.Author = "Garry Newman"
ENT.Information = "Idk, just testing it"
ENT.Category = "Fun + Games"

ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local ent = ents.Create( ClassName )
	ent:SetPos( tr.HitPos + tr.HitNormal * size )
	ent:Spawn()

	return ent

end

function ENT:Initialize()
  self:SetModel("models/props_borealis/bluebarrel001.mdl")
  self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
  if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
  local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end
function ENT:Use(ent)
if ent:IsPlayer() == 1 & CLIENT then
Window = vgui.Create("DFrame")
Window:SetSize(300, 200)
Window:SetTitle("Деликатний вопрос")
Window:SetVisible(true)
Window:SetDraggable(false)
Window:ShowCloseButton(true)
Window:Center()
Window:MakePopup()

Button = vgui.Create("DButton", Window)
Button:SetText("Получить оружие")
Button:SetPos(40, 100)
Button:SetSize(100, 50)
Button.DoClick = function()
  net.Start("BarrelResponse")
  net.WriteEntity(player)
  net.WriteString("weapon")
  net.SendToServer()
  print("msg sent2, act2:" .. player:Name())
  Window:Close()
end

Button2 = vgui.Create("DButton", Window)
Button2:SetText("Получить по жопе")
Button2:SetPos(160, 100)
Button2:SetSize(100, 50)
Button2.DoClick = function()
  net.Start("BarrelResponse")
  net.WriteEntity(player)
  net.WriteString("slap")
  net.SendToServer()
  print("msg sent2, act2:" .. player:Name())
  Window:Close()
end
end
end
