include('shared.lua')

function ENT:Draw()

    self:DrawModel(self:GetNWString("morphModel"))

    if self:GetPos():Distance(LocalPlayer():GetPos()) < 500 then
      local pos = self:LocalToWorld(Vector(10, 0, 50))
      cam.Start3D2D(pos + self:GetAngles():Up(), Angle(0, LocalPlayer():EyeAngles().yaw - 90, 90), 0.45)
      surface.SetFont( "CloseCaption_Normal" )
        surface.SetTextColor( 175, 175, 255, 255 - self:GetPos():Distance(LocalPlayer():GetPos()) / 2)
      surface.SetDrawColor(28, 28, 28, 155 - self:GetPos():Distance(LocalPlayer():GetPos()) / 2)
      surface.DrawRect( -55, 0, 132, 30)
      surface.SetTextPos( -50, 0 )
      surface.DrawText( "Оксид стула" )
      cam.End3D2D()
    end
end

function MorphModelList(obj)
  local Window = vgui.Create("DFrame")
  Window:SetSize(500, 550)
  Window:SetTitle("Смена модели")
  Window:SetVisible(true)
  Window:SetDraggable(false)
  Window:ShowCloseButton(true)
  Window:Center()
  Window:MakePopup()

  local ModelPanel = vgui.Create( "DModelPanel", Window)
  ModelPanel:SetPos( 25, 25 )
  ModelPanel:SetSize( 200, 200 )
  ModelPanel:SetModel( "models/props_c17/FurnitureChair001a.mdl" )
  ModelPanel:SetLookAt(ModelPanel.Entity:GetPos())


  local ModelPanel2 = vgui.Create( "DModelPanel", Window)
  ModelPanel2:SetPos(250, 25)
  ModelPanel2:SetSize(200, 200)
  ModelPanel2:SetModel("models/props_c17/chair02a.mdl")
  ModelPanel2:SetLookAt(ModelPanel2.Entity:GetPos())

  local ModelPanel3 = vgui.Create( "DModelPanel", Window)
  ModelPanel3:SetPos( 25, 250 )
  ModelPanel3:SetSize( 200, 200 )
  ModelPanel3:SetModel( "models/props_wasteland/controlroom_chair001a.mdl" )
  ModelPanel3:SetLookAt(ModelPanel3.Entity:GetPos())

  local ModelPanel4 = vgui.Create( "DModelPanel", Window)
  ModelPanel4:SetPos( 250, 250 )
  ModelPanel4:SetSize( 200, 200 )
  ModelPanel4:SetModel("models/props_interiors/furniture_chair01a.mdl")
  ModelPanel4:SetLookAt(ModelPanel4.Entity:GetPos())

  local BTN_box = vgui.Create("DButton", Window)
  BTN_box:SetText("Сменить модель")
  BTN_box:SetPos(75, 175)
  BTN_box:SetSize(100, 50)
  BTN_box.DoClick = function()
    net.Start("EntModelChange_" .. obj:EntIndex())
    net.WriteString("models/props_c17/FurnitureChair001a.mdl")
    net.SendToServer()
    Window:Close()
  end

  local BTN_box2 = vgui.Create("DButton", Window)
  BTN_box2:SetText("Сменить модель")
  BTN_box2:SetPos(300, 175)
  BTN_box2:SetSize(100, 50)
  BTN_box2.DoClick = function()
    net.Start("EntModelChange_" .. obj:EntIndex())
    net.WriteString("models/props_c17/chair02a.mdl")
    net.SendToServer()
    Window:Close()
  end

  local BTN_box3 = vgui.Create("DButton", Window)
  BTN_box3:SetText("Сменить модель")
  BTN_box3:SetPos(75, 400)
  BTN_box3:SetSize(100, 50)
  BTN_box3.DoClick = function()
    net.Start("EntModelChange_" .. obj:EntIndex())
    net.WriteString("models/props_wasteland/controlroom_chair001a.mdl")
    net.SendToServer()
    Window:Close()
  end

  local BTN_box4 = vgui.Create("DButton", Window)
  BTN_box4:SetText("Сменить модель")
  BTN_box4:SetPos(300, 400)
  BTN_box4:SetSize(100, 50)
  BTN_box4.DoClick = function()
    net.Start("EntModelChange_" .. obj:EntIndex())
    net.WriteString("models/props_interiors/furniture_chair01a.mdl")
    net.SendToServer()
    Window:Close()
  end
end

function MorphChooser(obj)
  local Window = vgui.Create("DFrame")
  Window:SetSize(300, 250)
  Window:SetTitle("Смена модели")
  Window:SetVisible(true)
  Window:SetDraggable(false)
  Window:ShowCloseButton(true)
  Window:Center()
  Window:MakePopup()

  local Label1 = vgui.Create("DLabel", Window)
  Label1:SetText("Для смены модели введите пароль: ")
  Label1:SetPos(0, 40)
  Label1:SizeToContents()
  Label1:CenterHorizontal()

  local Password = vgui.Create("DTextEntry", Window)
  Password:SetSize(100, 20)
  Password:SetPos(0, 60)
  Password:CenterHorizontal()
  Password.OnEnter = function()
    if Password:GetValue() == "2815"  then
      local Label2 = vgui.Create("DLabel", Window)
      Label2:SetText("Пароль совпадает!")
      Label2:SetPos(0, 80)
      Label2:SizeToContents()
      Label2:CenterHorizontal()
      local ContBTN = vgui.Create("DButton", Window)
      ContBTN:SetText("Сменить модель")
      ContBTN:SetPos(0, 110)
      ContBTN:SetSize(100, 50)
      ContBTN:CenterHorizontal()
      ContBTN.DoClick = function()
        MorphModelList(obj)
      end
    else
      Window:Close()
    end
end
end



function MainMenu(obj, player)
  local Window = vgui.Create("DFrame")
  Window:SetSize(400, 230)
  Window:SetTitle("Че-то тут есть...")
  Window:SetVisible(true)
  Window:SetDraggable(false)
  Window:ShowCloseButton(true)
  Window:Center()
  Window:MakePopup()

  local Label1 = vgui.Create("DLabel", Window)
  Label1:SetText("Выберите что-нибудь:")
  Label1:SetPos(0, 40)
  Label1:SizeToContents()
  Label1:CenterHorizontal()


  -- first button - gives player pistol and 228 ammo(lol)

  local Button = vgui.Create("DButton", Window)
  Button:SetText("Оружие")
  Button:SetPos(25, 95)
  Button:SetSize(100, 60)
  Button.DoClick = function()
    net.Start("EntResponse_" .. obj:EntIndex())
    net.WriteEntity(player)
    net.WriteString("weapon")
    net.SendToServer()
    Window:Close()
  end

  -- second button - gives player 50 damage

  Button2 = vgui.Create("DButton", Window)
  Button2:SetText("Музыка")
  Button2:SetPos(150, 95)
  Button2:SetSize(100, 60)
  Button2.DoClick = function()
    net.Start("musicc_" .. obj:EntIndex())
    net.WriteEntity(player)
    net.SendToServer()
    Window:Close()
     Window:Close()
  end

  -- third button - daft punk for your soul

  Button3 = vgui.Create("DButton", Window)
  Button3:SetText("Смена модели?")
  Button3:SetPos(275, 95)
  Button3:SetSize(100, 60)
  Button3.DoClick = function()
    MorphChooser(obj)
     end
end


function ENT:Think()
-- waiting for entity net msg to draw derma
net.Receive("EntUse_" .. self:EntIndex(), function()

local player = net.ReadEntity()
local status = net.ReadString()
if status == "ok" then
-- if ok - drawing derma
  MainMenu(self, player)

elseif status == "not_ok" then
-- show cooldown notification
notification.AddLegacy("Wait! The weapon isn't ready!", NOTIFY_ERROR, 5)
end

end)

net.Receive("musicc_" .. self:EntIndex(), function()
local sosund = nil
  sound.PlayURL("https://amk.do.am/hack_sound.mp3","", function(url)
  if ( IsValid( url ) ) then
    url:SetPos( self:GetPos() )
    url:Play()
    sosund = url
  end
  end)
  end)
end
