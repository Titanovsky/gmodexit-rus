TOOL.Category		= "Construction"
TOOL.Name			= "#Adv Mass"
TOOL.Command		= nil
TOOL.ConfigName		= nil

TOOL.ClientConVar["BoneNum"] 			= "0"
TOOL.ClientConVar["Gravity"] 			= "0"
TOOL.ClientConVar["Mass"] 				= "1"

if CLIENT then
	language.Add("Tool.adv_mass.name", "Advanced Mass")
	language.Add("Tool.adv_mass.desc", "Set or get the mass and gravity influenced of an entities bones.")
	language.Add("Tool.adv_mass.0", "Left click to set. Right click to get. Reload to restore.")
	
	local EFFECT = {}
	local BoneCount = 0
	EFFECT.Draw = {}
	--[[
		EFFECT.Draw[BoneNum][1] = Type
		EFFECT.Draw[BoneNum][2] = Pos
	]]
	
	net.Receive("DrawBoneAdvMass",function()
		local String = net.ReadString()
		if String == "0" then
			if IsValid(EFFECT.Ent) then
				EFFECT.Ent:SetColor(EFFECT.EntColor)
				EFFECT.Ent:SetRenderMode(EFFECT.EntRenderMode)
			end
			EFFECT.Ent = nil
			EFFECT.Draw = {}
			if EFFECT.Remove == false then EFFECT.Remove = true end
		else
			local Table = string.Explode("_",String)
			if Table[1] == "b" then
				BoneCount = tonumber(Table[2]) or 0
			elseif Table[1] == "e" then
				local Ent = ents.GetByIndex(tonumber(Table[2]))
				if Ent != EFFECT.Ent then
					EFFECT.Draw = {}
					if IsValid(EFFECT.Ent) then
						EFFECT.Ent:SetColor(EFFECT.EntColor)
						EFFECT.Ent:SetRenderMode(EFFECT.EntRenderMode)
					end
					EFFECT.Ent = nil
					if IsValid(Ent) then
						EFFECT.Ent = Ent
						EFFECT.EntColor = Ent:GetColor()
						EFFECT.EntRenderMode = Ent:GetRenderMode()
						Ent:SetRenderMode(1)
						Ent:SetColor(Color(EFFECT.EntColor.r,EFFECT.EntColor.g,EFFECT.EntColor.b,150))
					end
				end
			else
				if EFFECT.Remove == nil then util.Effect("render_advmass_bone", EffectData()) end
				EFFECT.Remove = false
				
				local Bone = tonumber(Table[1])
				if !EFFECT.Draw[Bone] then EFFECT.Draw[Bone] = {} end
				local val = GetConVarNumber("adv_mass_BoneNum") or 0
				if val == 0 or val == Bone then EFFECT.Draw[Bone][1] = 2 else EFFECT.Draw[Bone][1] = 1 end
				EFFECT.Draw[Bone][2] = Vector(tonumber(Table[2]),tonumber(Table[3]),tonumber(Table[4]))
			end
		end
	end)
	
	function EFFECT:Init(data) end

	function EFFECT:Think()
		-- This makes the effect always visible.
		local pl = LocalPlayer()
		local Pos = pl:EyePos()
		local Trace = {}
		Trace.start = Pos
		Trace.endpos = Pos+(pl:GetAimVector()*10)
		Trace.filter = {pl}
		local TR = util.TraceLine(Trace)
		self:SetPos(TR.HitPos)
		
		if EFFECT.Remove or EFFECT.Remove == nil then
			EFFECT.Remove = nil
			return false
		end
		-- Set alpha to 150.
		if IsValid(EFFECT.Ent) then
			EFFECT.Ent:SetRenderMode(1)
			EFFECT.Ent:SetColor(Color(EFFECT.EntColor.r,EFFECT.EntColor.g,EFFECT.EntColor.b,150))
		end
		return true
	end
	
	local Glow = Material("sprites/light_glow02_add")
	
	function EFFECT:Render()
		render.SetMaterial(Glow)
		for i=1,#EFFECT.Draw do if EFFECT.Draw[i] then if EFFECT.Draw[i][1] == 1 then render.DrawSprite(EFFECT.Draw[i][2], 10, 10, Color(100, 255, 100, 255)) elseif EFFECT.Draw[i][1] == 2 then render.DrawSprite(EFFECT.Draw[i][2], 10, 10, Color(255, 255, 255, 255)) end end end
	end
	
	effects.Register(EFFECT,"render_advmass_bone",true)
	
	function TOOL.BuildCPanel(CPanel)
		CPanel:AddControl("Header", { Text = "#Tool.adv_mass.name", Description	= "#Tool.adv_mass.desc" })
		
		CPanel.BoneSelector = vgui.Create("Panel", CPanel)
		CPanel.BoneSelector:Dock(TOP)
		CPanel.BoneSelector:DockMargin(4, 20, 0, 0)
		CPanel.BoneSelector:SetVisible(true)
		
		CPanel.BoneSelector.Label = vgui.Create("DLabel", CPanel.BoneSelector)
		CPanel.BoneSelector.Label:SetMouseInputEnabled(true)
		CPanel.BoneSelector.Label:SetDark(true)
		CPanel.BoneSelector.Label:SetText("Bone")
		
		local function RemoveSpace(str)
			if type(str) != "string" or str == "" then return "" end
			local T = string.Explode(" ", str)
			for i=1,#T do if T[i] != "" then return T[i] end end
			return ""
		end
		
		local function SetText(str)
			str = RemoveSpace(str)
			local Length = string.len(str)
			if Length == 1 then str = "   "..str elseif Length == 2 then str = "  "..str elseif str == "All" then str = "  "..str elseif Length == 3 then str = " "..str end
			CPanel.BoneSelector.TextArea:SetText(str)
		end
		
		CPanel.BoneSelector.ButtonD = CPanel.BoneSelector:Add("DButton")
		CPanel.BoneSelector.ButtonD:SetText("<")
		CPanel.BoneSelector.ButtonD.DoClick = function()
			local val = tonumber(RemoveSpace(CPanel.BoneSelector.TextArea:GetText())) or 0
			val = val-1
			if val < 0 then val = BoneCount end
			if val < 1 then
				SetText("All")
				RunConsoleCommand("adv_mass_BoneNum", "0")
			else
				local str = tostring(val)
				RunConsoleCommand("adv_mass_BoneNum", str)
				SetText(str)
			end
		end
		
		CPanel.BoneSelector.TextArea = CPanel.BoneSelector:Add("DTextEntry")
		CPanel.BoneSelector.TextArea:SetDrawBackground(false)
		CPanel.BoneSelector.TextArea:SetNumeric(false)
		
		CPanel.BoneSelector.TextArea.OnMousePressed = function(val)
			local str = RemoveSpace(CPanel.BoneSelector.TextArea:GetText())
			CPanel.BoneSelector.TextArea.PressedText = str
			local Length = string.len(str)
			if Length == 1 then str = "   " elseif Length == 2 then str = "  " elseif str == "All" then str = "  " elseif Length == 3 then str = " " end
			CPanel.BoneSelector.TextArea:SetText(str)
			CPanel.BoneSelector.TextArea:OnGetFocus()
		end
		
		CPanel.BoneSelector.TextArea.UpdateConvarValue = function(val)
			local str = RemoveSpace(val:GetValue())
			if str == "" then if CPanel.BoneSelector.TextArea.PressedText then str = CPanel.BoneSelector.TextArea.PressedText else str = "0" end end
			CPanel.BoneSelector.TextArea.PressedText = nil
			val = tonumber(str) or 0
			if val then
				if val > BoneCount then val = BoneCount end
				if val < 1 then val = 0 end
				RunConsoleCommand("adv_mass_BoneNum", tostring(val))
				if val == 0 then
					CPanel.BoneSelector.TextArea:SetText("  All")
					CPanel.BoneSelector.TextArea:SetCaretPos(CPanel.BoneSelector.TextArea:GetCaretPos())
				else
					CPanel.BoneSelector.TextArea:SetCaretPos(0)
					SetText(tostring(val))
				end
			end
		end
		
		CPanel.BoneSelector.ButtonU = CPanel.BoneSelector:Add("DButton")
		CPanel.BoneSelector.ButtonU:SetText(">")
		CPanel.BoneSelector.ButtonU.DoClick = function()
			local val = tonumber(RemoveSpace(CPanel.BoneSelector.TextArea:GetText())) or 0
			val = val+1
			if val > BoneCount then val = 0 end
			if val < 1 then
				SetText("All")
				RunConsoleCommand("adv_mass_BoneNum", "0")
			else
				local str = tostring(val)
				RunConsoleCommand("adv_mass_BoneNum", str)
				SetText(str)
			end
		end
		
		CPanel.BoneSelector:SetTall(32)
		
		function CPanel.BoneSelector:PerformLayout()
			local PanelWide = CPanel:GetWide()
			local TextAreaPos = (PanelWide/2)-15
			CPanel.BoneSelector.Label:SetPos(5, 0)
			CPanel.BoneSelector.Label:SetWide(100, 0)
			CPanel.BoneSelector.ButtonD:SetPos(TextAreaPos-30, 0)
			CPanel.BoneSelector.ButtonD:SetWide(25)
			CPanel.BoneSelector.TextArea:SetPos(TextAreaPos, 0)
			CPanel.BoneSelector.TextArea:SetWide(30)
			CPanel.BoneSelector.ButtonU:SetPos(TextAreaPos+35, 0)
			CPanel.BoneSelector.ButtonU:SetWide(25)
		end
		
		local val = GetConVarNumber("adv_mass_BoneNum") or 0
		if val then
			if CPanel.BoneSelector.TextArea != vgui.GetKeyboardFocus() then
				if val < 1 then
					SetText("All")
				else
					local str = tostring(val)
					if string.find(str,".",1,true) then str = string.Explode(".", str, true)[1] end
					SetText(str)
				end
			end
		end
		
		cvars.AddChangeCallback("adv_mass_BoneNum", function(_,Old,New)
			local str = New
			New = tonumber(New)
			if New and EFFECT and EFFECT.Draw then if New == 0 then for i=1,#EFFECT.Draw do if EFFECT.Draw[i] then EFFECT.Draw[i][1] = 2 end end else for i=1,#EFFECT.Draw do if EFFECT.Draw[i] then if New == i then EFFECT.Draw[i][1] = 2 else EFFECT.Draw[i][1] = 1 end end end end end
			if str and CPanel and CPanel.BoneSelector and CPanel.BoneSelector.TextArea then
				if !New or New < 1 then
					SetText("All")
				else
					if string.find(str,".",1,true) then str = string.Explode(".", str, true)[1] end
					SetText(str)
				end
			end
		end)
		
		function CPanel:Think()
			if CPanel.BoneSelector and CPanel.BoneSelector.BoneCount != BoneCount then
				CPanel.BoneSelector.BoneCount = BoneCount
				SetText("All")
				RunConsoleCommand("adv_mass_BoneNum", "0")
				if BoneCount <= 1 then CPanel.BoneSelector:SetVisible(false) else CPanel.BoneSelector:SetVisible(true) end
			end
		end
		
		CPanel:AddControl("Checkbox", {Label = "#Influenced By Gravity", Command = "adv_mass_Gravity"})
		
		CPanel.MassSlider = vgui.Create("DNumSlider", CPanel)
		CPanel.MassSlider:Dock(TOP)
		CPanel.MassSlider:DockMargin(4, 20, 0, 0)
		CPanel.MassSlider:SetVisible(true)
		CPanel.MassSlider:SetConVar("adv_mass_Mass")
		CPanel.MassSlider:SetDark(true)
		CPanel.MassSlider:SetMinMax(0,50000)
		CPanel.MassSlider:SetDecimals(2)
		CPanel.MassSlider:SetText("#Mass:")
		function CPanel.MassSlider:PerformLayout()
			local Left = 5
			CPanel.MassSlider.Label:SetPos(Left, 0)
			CPanel.MassSlider.Label:SetWide(30, 0)
			Left = Left+30
			CPanel.MassSlider.Slider:SetPos(Left, 0)
			local Right = CPanel:GetWide()-10
			Right = Right-55
			CPanel.MassSlider.TextArea:SetPos(Right, 0)
			CPanel.MassSlider.TextArea:SetWide(50)
			CPanel.MassSlider.Slider:SetWide((Right-Left)-5)
		end
	end
	
	function TOOL:LeftClick(trace)
		if !trace.Entity then return end
		if !trace.Entity:IsValid() then return end
		if trace.Entity:IsPlayer() then return end
		return true
	end
	
	function TOOL:RightClick(trace)
		if !trace.Entity then return end
		if !trace.Entity:IsValid() then return end
		if trace.Entity:IsPlayer() then return end
		return true
	end
	
	function TOOL:Reload(trace)
		if !trace.Entity then return end
		if !trace.Entity:IsValid() then return end
		if trace.Entity:IsPlayer() then return end
		return true
	end
	
	return
end

TOOL.SteadyThinkTime = CurTime()+0.25

util.AddNetworkString("DrawBoneAdvMass")

function TOOL:LeftClick(trace)
	if !trace.Entity then return end
	if !trace.Entity:IsValid() then return end
	if trace.Entity:IsPlayer() then return end
	
	local pl = self:GetOwner()
	if !pl:IsValid() then return end
	local Phys = trace.Entity:GetPhysicsObject()
	if !Phys:IsValid() then return end
	
	if !self.BoneMassTable then self.BoneMassTable = {} end
	if !self.BoneGravityTable then self.BoneGravityTable = {} end
	
	local UndoTable = {}
	
	self.BoneCount = trace.Entity:GetPhysicsObjectCount()
	
	local BoneNum = self:GetClientNumber("BoneNum")
	if BoneNum < 0 then BoneNum = 0 end
	local Gravity = tobool(self:GetClientNumber("Gravity"))
	local Mass = self:GetClientNumber("Mass")
	
	if BoneNum == 0 then
		local BoneCount = self.BoneCount-1
		for i=0,BoneCount do
			local BonePhys = trace.Entity:GetPhysicsObjectNum(i)
			if BonePhys:IsValid() then
				UndoTable[i] = {}
				UndoTable[i][1] = BonePhys:IsGravityEnabled()
				UndoTable[i][2] = BonePhys:GetMass()
				constraint.MassModification(trace.Entity, i, false, Gravity)
			end
		end
	elseif self.BoneCount >= BoneNum then
		local BonePhys = trace.Entity:GetPhysicsObjectNum(BoneNum-1)
		if BonePhys:IsValid() then
			UndoTable[BoneNum-1] = {}
			UndoTable[BoneNum-1][1] = BonePhys:IsGravityEnabled()
			UndoTable[BoneNum-1][2] = BonePhys:GetMass()
			constraint.MassModification(trace.Entity, BoneNum-1, false, Gravity)
		end
	end
	
	if Mass < 0 then
		Mass = 0
		pl:ConCommand("adv_mass_Mass 0")
	end
	
	if BoneNum == 0 then
		self:SetBoneMassTable(trace.Entity)
		self:SetBoneMass(trace.Entity,Mass)
	elseif self.BoneCount >= BoneNum then
		constraint.MassModification(trace.Entity, BoneNum-1, Mass, nil)
	end
	
	self.SteadyThinkTime = CurTime()+0.50
	
	local function UndoGravityMass(Undo, Ent, Table, Num)
		if Ent:IsValid() then
			if Ent.AdvMassDummy then
				local PlayerID
				for k,v in pairs(Ent.AdvMassDummy) do
					if v and v:IsValid() and IsValid(v.Owner) then
						PlayerID = v.Owner:UniqueID()
						PlayerUndo = undo:GetTable()[PlayerID]
						break
					end 
				end
				if PlayerUndo then
					for k1,v1 in pairs(PlayerUndo) do
						if PlayerUndo[k1] and PlayerUndo[k1].Name and PlayerUndo[k1].Name == "Undo Set Gravity/Mass" and PlayerUndo[k1].Entities and PlayerUndo[k1].Entities[1] then
							for k2,v2 in pairs(Ent.AdvMassDummy) do
								if k2 > Num and v2 and v2:IsValid() and PlayerUndo[k1].Entities[1] == v2 then
									undo:GetTable()[PlayerID][k1] = nil
									break
								end
							end
						end
					end
				end
				for k,v in pairs(Ent.AdvMassDummy) do
					if k > Num and v and v:IsValid() then
						v:Remove()
						Ent.AdvMassDummy[k] = nil
					end
				end
				Ent.AdvMassDummy[Num] = nil
			end
		
			local BoneCount = Ent:GetPhysicsObjectCount()-1
			for i=0,BoneCount do
				if Table[i] then
					constraint.MassModification(Ent, i, Table[i][2], Table[i][1])
				end
			end
		end
	end

	undo.Create("Undo Set Gravity/Mass")
	local Dummy = ents.Create("info_null")
	Dummy.Owner = self:GetOwner()
	local SetRemove
	if !trace.Entity.AdvMassDummy then
		trace.Entity.AdvMassDummy = {}
		SetRemove = true
	end
	trace.Entity.AdvMassDummy[#trace.Entity.AdvMassDummy+1] = Dummy
	undo.AddEntity(Dummy)
	undo.SetPlayer(pl)
	undo.AddFunction(UndoGravityMass, trace.Entity, UndoTable,#trace.Entity.AdvMassDummy)
	undo.SetCustomUndoText("Undone Set Gravity/Mass")
	undo.Finish()
	
	if SetRemove then
		trace.Entity:CallOnRemove("UndoAdvMass"..trace.Entity:EntIndex(),function(Ent)
			if Ent.AdvMassDummy then
				local PlayerID
				local PlayerUndo
				for k,v in pairs(Ent.AdvMassDummy) do
					if v and v:IsValid() and IsValid(v.Owner) then
						PlayerID = v.Owner:UniqueID()
						PlayerUndo = undo:GetTable()[PlayerID]
						break
					end 
				end
				if PlayerUndo then
					for k1,v1 in pairs(PlayerUndo) do
						if PlayerUndo[k1] and PlayerUndo[k1].Name and PlayerUndo[k1].Name == "Undo Set Gravity/Mass" and PlayerUndo[k1].Entities and PlayerUndo[k1].Entities[1] then
							for k2,v2 in pairs(Ent.AdvMassDummy) do
								if v2 and v2:IsValid() and PlayerUndo[k1].Entities[1] == v2 then
									undo:GetTable()[PlayerID][k1] = nil
									break
								end
							end
						end
					end
				end
				for k,v in pairs(Ent.AdvMassDummy) do if v and v:IsValid() then v:Remove() end end
			end
		end,trace.Entity)
	end
	
	return true
end

function TOOL:RightClick(trace)
	if !trace.Entity then return end
	if trace.Entity:IsWorld() and (self.BoneMassTable or self.BoneGravityTable)  then
		self.BoneMassTable = nil
		self.BoneGravityTable = nil
		local pl = self:GetOwner()
		if pl:IsValid() then
			pl:ConCommand("adv_mass_BoneNum 0")
			net.Start("DrawBoneAdvMass")
			net.WriteString("b")
			net.Send(pl)
		end
		return true
	end
	if !trace.Entity:IsValid() then return end
	if trace.Entity:IsPlayer() then return end
	
	self.SelectedEnt = trace.Entity
	local pl = self:GetOwner()
	if !pl:IsValid() then
		self.SelectedEnt = NULL
		return
	end
	local Phys = trace.Entity:GetPhysicsObject()
	if !Phys:IsValid() then
		self.SelectedEnt = NULL
		return
	end
	
	self.BoneMassTable = {}
	self.BoneGravityTable = {}
	
	local BoneNum = self:GetClientNumber("BoneNum")
	self.BoneNum = BoneNum
	local BoneCount = trace.Entity:GetPhysicsObjectCount()
	local pl = self:GetOwner()
	if pl:IsValid() then
		net.Start("DrawBoneAdvMass")
		net.WriteString("b_"..BoneCount)
		net.Send(pl)
	end
	self.BoneCount = BoneCount
	
	self:SetBoneGravityTable(trace.Entity)
	
	if BoneNum == 0 or BoneCount == 0 or BoneNum > BoneCount then
		BoneNum = 0
		pl:ConCommand("adv_mass_BoneNum 0")
		if Phys:IsGravityEnabled() then
			self.Gravity = true
			pl:ConCommand("adv_mass_Gravity 1")
		else
			self.Gravity = false
			pl:ConCommand("adv_mass_Gravity 0")
		end
	else
		if trace.Entity:GetPhysicsObjectNum(BoneNum-1):IsGravityEnabled() then
			self.Gravity = true
			pl:ConCommand("adv_mass_Gravity 1")
		else
			self.Gravity = false
			pl:ConCommand("adv_mass_Gravity 0")
		end
	end
	
	self.TotalMass = self:SetBoneMassTable(trace.Entity)
	
	if BoneNum == 0 then
		pl:ConCommand("adv_mass_Mass "..tostring(self.TotalMass))
	else
		local Mass = trace.Entity:GetPhysicsObjectNum(BoneNum-1):GetMass()
		self.Mass = Mass
		pl:ConCommand("adv_mass_Mass "..tostring(Mass))
	end
	
	self.SteadyThinkTime = CurTime()+0.50
	
	return true
end

function TOOL:Reload(trace)
	if !trace.Entity then return end
	if trace.Entity:IsWorld() and (self.BoneMassTable or self.BoneGravityTable)  then
		self.BoneMassTable = nil
		self.BoneGravityTable = nil
		local pl = self:GetOwner()
		if pl:IsValid() then
			pl:ConCommand("adv_mass_BoneNum 0")
			net.Start("DrawBoneAdvMass")
			net.WriteString("b")
			net.Send(pl)
		end
		return true
	end
	if !trace.Entity:IsValid() then end
	if trace.Entity:IsPlayer() then return end
	
	local DidRemove
	
	if trace.Entity:GetTable().Constraints then
		for k, v in pairs(trace.Entity:GetTable().Constraints) do
			if v:IsValid() then
				local CTab = v:GetTable()
				if CTab.Type == "MassModification" then
					v:Remove()
					DidRemove = true
				end
			end
		end
	end
	
	if trace.Entity.AdvMassDummy then
		local PlayerID
		local PlayerUndo
		for k,v in pairs(trace.Entity.AdvMassDummy) do
			if v and v:IsValid() and IsValid(v.Owner) then
				PlayerID = v.Owner:UniqueID()
				PlayerUndo = undo:GetTable()[PlayerID]
				break
			end 
		end
		if PlayerUndo then
			for k1,v1 in pairs(PlayerUndo) do
				if PlayerUndo[k1] and PlayerUndo[k1].Name and PlayerUndo[k1].Name == "Undo Set Gravity/Mass" and PlayerUndo[k1].Entities and PlayerUndo[k1].Entities[1] then
					for k2,v2 in pairs(trace.Entity.AdvMassDummy) do
						if v2 and v2:IsValid() and PlayerUndo[k1].Entities[1] == v2 then
							undo:GetTable()[PlayerID][k1] = nil
							break
						end
					end
				end
			end
		end
		for k,v in pairs(trace.Entity.AdvMassDummy) do if v and v:IsValid() then v:Remove() end end
	end
	
	return DidRemove
end

local SendToClient = {}

function TOOL:Think()
	if self.BoneMassTable and self.BoneGravityTable then
		local CurTime = CurTime()
		if CurTime >= self.SteadyThinkTime then
			self.SteadyThinkTime = CurTime+0.25
			local pl = self:GetOwner()
			if pl:IsValid() then
				local BoneNum = self:GetClientNumber("BoneNum")
				if BoneNum != self.BoneNum then
					self.BoneNum = BoneNum
					if BoneNum == 0 then
						if self.BoneGravityTable[1] != nil then
							if self.BoneGravityTable[1] then
								pl:ConCommand("adv_mass_Gravity 1")
							else
								pl:ConCommand("adv_mass_Gravity 0")
							end
						end
						if self.BoneMassTable[1] and self.TotalMass then pl:ConCommand("adv_mass_Mass "..tostring(self:GetEntMass())) end
					else
						if self.BoneGravityTable[BoneNum] != nil then
							if self.BoneGravityTable[BoneNum] then
								pl:ConCommand("adv_mass_Gravity 1")
							else
								pl:ConCommand("adv_mass_Gravity 0")
							end
						end
						if self.BoneMassTable[BoneNum] != nil and self.TotalMass then
							pl:ConCommand("adv_mass_Mass "..tostring(self.BoneMassTable[BoneNum]))
						end
					end
				end
			end
		elseif self.SteadyThinkTime-0.25 > CurTime then
			self.SteadyThinkTime = CurTime+0.25
		end
	end
	
	local pl = self:GetOwner()
	if !SendToClient[pl] then SendToClient[pl] = {} end
	local trace = pl:GetEyeTrace()
	if trace.Hit and trace.Entity:IsValid() and trace.Entity:GetPhysicsObjectCount() > 1 then
		if trace.Entity != self.DrawEntity then
			self.DrawEntity = trace.Entity
			SendToClient[pl] = {}
			net.Start("DrawBoneAdvMass")
			net.WriteString("e_"..trace.Entity:EntIndex())
			net.Send(pl)
		end
		local BoneCount = trace.Entity:GetPhysicsObjectCount()
		for i=1,BoneCount do
			local Phys = trace.Entity:GetPhysicsObjectNum(i-1)
			if Phys and Phys:IsValid() then
				local Pos = Phys:GetPos()
				if !SendToClient[pl][i] then SendToClient[pl][i] = {} end
				if Pos != SendToClient[pl][i][1] then
					SendToClient[pl][i][1] = Pos
					SendToClient[pl][i][2] = true
				end
			end
		end
	else
		if SendToClient[pl][1] and IsValid(pl) then
			SendToClient[pl] = {}
			self.DrawEntity = nil
			net.Start("DrawBoneAdvMass")
			net.WriteString("0")
			net.Send(pl)
		end
	end
end

function TOOL:SetBoneMassTable(Ent)
	local Sum1 = 0
	for i=1,self.BoneCount do
		local BoneMass = Ent:GetPhysicsObjectNum(i-1):GetMass()
		self.BoneMassTable[i] = BoneMass
		Sum1 = BoneMass+Sum1
	end
	return Sum1
end

function TOOL:SetBoneGravityTable(Ent)
	for i=1,self.BoneCount do self.BoneGravityTable[i] = Ent:GetPhysicsObjectNum(i-1):IsGravityEnabled() end
end

function TOOL:GetEntMass()
	local Sum = 0
	for i=1,#self.BoneMassTable do Sum = self.BoneMassTable[i]+Sum end
	return Sum
end

function TOOL:SetBoneMass(Ent,TotalMass)
	local Sum = self:GetEntMass()
	if Sum == 0 then
		local Mass = TotalMass/self.BoneCount
		for i=1,#self.BoneMassTable do constraint.MassModification(Ent, i-1, Mass, nil) end
	else
		local Factor = TotalMass/Sum
		for i=1,#self.BoneMassTable do constraint.MassModification(Ent, i-1, self.BoneMassTable[i]*Factor, nil) end
	end
	return Sum
end

function TOOL:Holster()
	local pl = self:GetOwner()
	SendToClient[pl] = {}
	self.DrawEntity = nil
	net.Start("DrawBoneAdvMass")
	net.WriteString("0")
	net.Send(pl)
	net.Start("DrawBoneAdvMass")
	net.WriteString("b")
	net.Send(pl)
end

hook.Add("Tick", "AdvMassTick", function()
	for k,pl in pairs(player.GetAll()) do
		if SendToClient[pl] then
			for i=1, #SendToClient[pl] do
				if SendToClient[pl][i][2] then
					net.Start("DrawBoneAdvMass")
					net.WriteString(i.."_"..SendToClient[pl][i][1].x.."_"..SendToClient[pl][i][1].y.."_"..SendToClient[pl][i][1].z)
					net.Send(pl)
					SendToClient[pl][i][2] = false
				end
			end
		end
	end
end)

CreateConVar("adv_mass_MinimumMass", "0.01", {FCVAR_REPLICATED, FCVAR_ARCHIVE})

function constraint.MassModification(Ent1, Bone1, NewMass, NewGravity)
	if !Ent1 or !Ent1:IsValid() then return false end
	
	Bone1 = Bone1 or 0
	
	if type(NewMass) == "number" or NewMass == false then if NewMass then NewMass = math.Clamp(NewMass,math.Clamp(GetConVarNumber("adv_mass_MinimumMass") or 0.01,0,50000),50000) end else return end
	
	if type(NewGravity) != "boolean" and NewGravity != nil then return end
	
	local Phys = Ent1:GetPhysicsObjectNum(Bone1)
	
	if !Phys or !Phys:IsValid() then return false end
	
	if NewMass and NewGravity == nil and Phys:GetMass() == NewMass then return end
	
	if !NewMass and NewGravity != nil and Phys:IsGravityEnabled() == NewGravity then return end
	
	if Phys:GetMass() == NewMass and Phys:IsGravityEnabled() == NewGravity then return end
	
	local Constraint
	
	if Ent1:GetTable().Constraints then
		for k, v in pairs(Ent1:GetTable().Constraints) do
			if v and v:IsValid() then
				local CTab = v:GetTable()
				if CTab.Type == "MassModification" and CTab.Bone1 == Bone1 then
					Constraint = v
					break
				end
			end	
		end
	end
	
	if Constraint then
		local ctable = Constraint:GetTable()
		if NewMass then ctable.NewMass = NewMass end
		if NewGravity != nil then ctable.NewGravity = NewGravity end
		Constraint:SetTable(ctable)
	else
		Constraint = ents.Create("info_null")
		if !Constraint or !Constraint:IsValid() then return false end
		
		Ent1:GetTable().Constraints = Ent1:GetTable().Constraints or {}
		table.insert(Ent1:GetTable().Constraints, Constraint)
		Ent1:DeleteOnRemove(Constraint)
		
		local OwnMass = Phys:GetMass()
		local OwnGravity = Phys:IsGravityEnabled()
		
		if !NewMass then NewMass = OwnMass end
		if NewGravity == nil then NewGravity = OwnGravity end
		
		local ctable = 
		{
			Type 			= "MassModification",
			Ent1  			= Ent1,
			Bone1 			= Bone1,
			NewMass 		= NewMass,
			NewGravity		= NewGravity,
			OwnMass			= OwnMass,
			OwnGravity		= OwnGravity
		}
		
		Constraint:SetTable(ctable)
		
		Constraint:CallOnRemove("MassModification", function(Constraint)
			if Constraint and IsValid(Constraint.Ent1) and Constraint.Bone1 then
				local Phys = Constraint.Ent1:GetPhysicsObjectNum(Constraint.Bone1)
				if Phys and Phys:IsValid() then
					if Constraint.OwnMass then Phys:SetMass(Constraint.OwnMass) end
					if Constraint.OwnGravity then Phys:EnableGravity(Constraint.OwnGravity) end
				end
			end
		end,Constraint)
	end
	
	if NewMass then Phys:SetMass(NewMass) end
	if NewGravity != nil then Phys:EnableGravity(NewGravity) end
	
	return Constraint
end
duplicator.RegisterConstraint("MassModification", constraint.MassModification, "Ent1", "Bone1", "NewMass", "NewGravity")