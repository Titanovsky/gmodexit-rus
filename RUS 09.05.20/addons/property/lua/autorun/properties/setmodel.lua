AddCSLuaFile()
local ModelClipboard = ""
local SetModelPanel = nil
properties.Add("copymodel", 
{
    MenuLabel		=	"Copy Model",
    Order			=	1599,
    MenuIcon		=	"icon16/page_copy.png",

    Filter    = function(self, ent, ply)  -- A function that determines whether an entity is valid for this property
                  if (!IsValid(ent)) then return false end
                  if (ent:IsPlayer()) then return false end
                  if (!gamemode.Call("CanProperty", ply, "ignite", ent)) then return false end
                  return true 
              end,

    Action    = function(self, ent) -- The action to perform upon using the property ( Clientside )
                    SetClipboardText(ent:GetModel())
                    ModelClipboard = ent:GetModel()
                    self:MsgStart() 
                        net.WriteString(ent:GetModel())
                    self:MsgEnd()
                end
});


local function CreateSetModelPanel() -- This is really messy, but it works.
    SetModelPanel = vgui.Create("DFrame")
    SetModelPanel:SetDeleteOnClose(false)
    SetModelPanel:SetSize(320, 116)
    SetModelPanel:Center()    
    SetModelPanel:MakePopup()
    SetModelPanel.Label = SetModelPanel:Add("DLabel")
    SetModelPanel.Label:SetText("Model")
    SetModelPanel.Label:SetPos(8, 28)

    SetModelPanel.TextBox = SetModelPanel:Add("DTextEntry")
    SetModelPanel.TextBox:SetPos(8, 50)
    SetModelPanel.TextBox:SetSize(320 - 16, 24)
    SetModelPanel.TextBox:SetText("")

    SetModelPanel.Paste = SetModelPanel:Add("DButton")
    SetModelPanel.Paste:SetPos(8, 84)
    SetModelPanel.Paste:SetSize(148, 24)
    SetModelPanel.Paste:SetText("Paste Model")
    SetModelPanel.Paste:SetTooltip("Paste model copied from \"Copy Model\"")
    SetModelPanel.Paste.DoClick = function()   
        SetModelPanel.TextBox:SetText(ModelClipboard)
    end
    SetModelPanel.SetModel = SetModelPanel:Add("DButton")
    SetModelPanel.SetModel:SetPos(163, 84)
    SetModelPanel.SetModel:SetSize(148, 24)
    SetModelPanel.SetModel:SetText("Set Model")
end
local function SetModelPanelSetEntity(self, ent)
    SetModelPanel:SetVisible(true)
    SetModelPanel:SetTitle(tostring(ent))
    SetModelPanel.Ent = ent
    SetModelPanel.SetModel.DoClick = function()             
      self:MsgStart()
          net.WriteEntity(ent)
          net.WriteString(SetModelPanel.TextBox:GetValue())
      self:MsgEnd()
    end
end
properties.Add("setmodel", 
{
    MenuLabel		=	"Set Model",
    Order			=	1600,
    MenuIcon		=	"icon16/shape_handles.png",

    Filter    = function(self, ent, ply)  -- A function that determines whether an entity is valid for this property
                  if (!IsValid(ent)) then return false end
                  if (ent:IsPlayer() or ent:IsNPC() or ent:GetClass() == "prop_ragdoll" or string.find(ent:GetClass(), "prop_vehicle")) then return false end
                  if (!gamemode.Call("CanProperty", ply, "ignite", ent)) then return false end
                  return true 
                end,

    Action    = function(self, ent) -- The action to perform upon using the property ( Clientside )
                    if (!SetModelPanel) then
                        CreateSetModelPanel()
                    elseif (SetModelPanel:IsVisible() and SetModelPanel.Ent == ent) then return end
                    SetModelPanelSetEntity(self, ent)
                end,
              
     Receive  = function(self, length, player)					
                      local ent = net.ReadEntity()
                      local model = net.ReadString()
                      local phys = ent:GetPhysicsObject()
					  if (!self:Filter(ent, player) or !util.IsValidModel(model) or util.IsValidRagdoll(model)) then return end                
                      local frozen = phys:IsMoveable()
					  print(frozen)
					  ent:SetModel(model) 
                      ent:PhysicsInit(SOLID_VPHYSICS)      
                      ent:SetMoveType(MOVETYPE_VPHYSICS)     
                      ent:SetSolid(SOLID_VPHYSICS)
					  phys = ent:GetPhysicsObject()
					  phys:Wake()
					  phys:EnableMotion(frozen)
			    end	     
} );
