
TOOL.Category = "Construction"
TOOL.Name = "Mass Center"

if CLIENT then

	language.Add("tool.masscenter.name", "Mass Center")
	language.Add("tool.masscenter.desc", "Displays the mass center of selected objects")
	language.Add("tool.masscenter.0", "Primary: select (hold use for area). Secondary: apply. Reload: reset")
	CreateClientConVar("masscenter_radius", "300", true, false)
	
	local clientselection = {}
	local entitymasses = {}
	
	local function Render()
		local masscenter = Vector(0,0,0)
		local totalmass = 0
		for k,v in pairs(entitymasses) do
			if IsValid(v.entity) then
				if totalmass == 0 then masscenter = v.entity:LocalToWorld(v.center) end
				totalmass = totalmass + v.mass
				local vec = v.entity:LocalToWorld(v.center)-masscenter
				masscenter = masscenter + vec:GetNormalized()*(vec:Length()*(v.mass/totalmass))
			end
		end
		if totalmass == 0 then
			net.Start("masscenter_request") net.WriteTable({}) net.SendToServer()
			hook.Remove("HUDPaint","masscenter_render")
			return
		end
		local x1 = (masscenter+Vector(5,0,0)):ToScreen()
		local x2 = (masscenter+Vector(-5,0,0)):ToScreen()
		local y1 = (masscenter+Vector(0,5,0)):ToScreen()
		local y2 = (masscenter+Vector(0,-5,0)):ToScreen()
		local z1 = (masscenter+Vector(0,0,5)):ToScreen()
		local z2 = (masscenter+Vector(0,0,-5)):ToScreen()
		surface.SetDrawColor(255,0,0)
		surface.DrawLine(x1.x,x1.y,x2.x,x2.y)
		surface.SetDrawColor(0,255,0)
		surface.DrawLine(y1.x,y1.y,y2.x,y2.y)
		surface.SetDrawColor(0,0,255)
		surface.DrawLine(z1.x,z1.y,z2.x,z2.y)
		surface.SetFont("DebugFixed")
		local textpos = (masscenter+(EyeAngles():Right()*3)+(EyeAngles():Up()*-3)):ToScreen()
		surface.SetTextPos(textpos.x,textpos.y)
		local text = math.Round(totalmass).." kg"
		local w,h = surface.GetTextSize(text)
		surface.SetDrawColor(0,0,0,128)
		surface.DrawRect(textpos.x-3,textpos.y,w+6,h)
		surface.SetTextColor(255,255,255)
		surface.DrawText(text)
	end
	
	local function Selected(ent)
		for k,v in pairs(clientselection) do if v.entity == ent then return k end end
	end
	
	local function Select(ent)
		if IsValid(ent) and not ent:IsPlayer() and not IsValid(ent:GetParent()) and not Selected(ent) and ent:GetMoveType() == MOVETYPE_VPHYSICS then
			clientselection[#clientselection+1] = {entity = ent, color = ent:GetColor(), material = ent:GetMaterial()}
			ent:SetColor(Color(0,255,0,128))
			ent:SetMaterial("models/debug/debugwhite")
			ent:SetRenderMode(RENDERMODE_TRANSALPHA)
			if game.SinglePlayer() then net.Start("masscenter_color") net.WriteTable({entity = ent, color = Color(0,255,0,128), material = "models/debug/debugwhite"}) net.SendToServer() end
		end
	end
	
	local function Deselect(ent)
		local i = Selected(ent)
		if i then
			if IsValid(ent) then
				ent:SetColor(clientselection[i].color)
				ent:SetMaterial(clientselection[i].material)
				if game.SinglePlayer() then net.Start("masscenter_color") net.WriteTable({entity = ent, color = clientselection[i].color, material = clientselection[i].material}) net.SendToServer() end
			end
			table.remove(clientselection,i)
		end
	end
	
	net.Receive("masscenter_leftclick",function(len, ply)
		local trace = net.ReadTable()
		if LocalPlayer():KeyDown(IN_USE) then
			local selection = ents.FindInSphere(trace.HitPos, GetConVar("masscenter_radius"):GetInt())
			for i = 1,#selection do Select(selection[i]) end
		else
			if Selected(trace.Entity) then Deselect(trace.Entity) else Select(trace.Entity) end
		end
	end)
	
	net.Receive("masscenter_rightclick",function(len, ply)
		net.Start("masscenter_request") net.WriteTable(clientselection) net.SendToServer()
		while #clientselection > 0 do
			Deselect(clientselection[1].entity)
		end
	end)
	
	net.Receive("masscenter_reload",function(len, ply)
		net.Start("masscenter_request") net.WriteTable({}) net.SendToServer()
		while #clientselection > 0 do
			Deselect(clientselection[1].entity)
		end
	end)
	
	net.Receive("masscenter_request",function(len, ply)
		entitymasses = net.ReadTable()
		if #entitymasses > 0 then
			hook.Add("HUDPaint","masscenter_render",Render)
		else
			hook.Remove("HUDPaint","masscenter_render")
		end
	end)
	
else

	util.AddNetworkString("masscenter_leftclick")
	util.AddNetworkString("masscenter_rightclick")
	util.AddNetworkString("masscenter_reload")
	util.AddNetworkString("masscenter_request")
	util.AddNetworkString("masscenter_color")
	
	net.Receive("masscenter_request",function(len, ply)
		local ents = net.ReadTable()
		timer.Create("masscenter_"..ply:SteamID(),0.1,0,function()
			local entitymasses = {}
			for k,v in pairs(ents) do
				if IsValid(v.entity) then
					local physobj = v.entity:GetPhysicsObject()
					if IsValid(physobj) and physobj:GetMass() > 0 then
						entitymasses[#entitymasses+1] = {entity = v.entity, mass = physobj:GetMass(), center = physobj:GetMassCenter()}
					end
				end
			end
			if IsValid(ply) and ply:GetActiveWeapon():GetClass() ~= "weapon_physgun" then
				net.Start("masscenter_request") net.WriteTable(entitymasses) net.Send(ply)
			end
			if #entitymasses == 0 or not IsValid(ply) then
				timer.Remove("masscenter_"..ply:SteamID())
			end
		end)
	end)
	
	net.Receive("masscenter_color",function(len, ply)
		if not game.SinglePlayer() then return end
		local tab = net.ReadTable()
		if IsValid(tab.entity) then
			tab.entity:SetColor(tab.color)
			tab.entity:SetMaterial(tab.material)
			tab.entity:SetRenderMode(RENDERMODE_TRANSALPHA)
		end
	end)
	
end

function TOOL:LeftClick(trace)
	if CLIENT then return true end
	net.Start("masscenter_leftclick") net.WriteTable(trace) net.Send(self:GetOwner())
	return true
end

function TOOL:RightClick(trace)
	if CLIENT then return true end
	net.Start("masscenter_rightclick") net.WriteTable(trace) net.Send(self:GetOwner())
	return true
end

function TOOL:Reload(trace)
	if CLIENT then return true end
	net.Start("masscenter_reload") net.WriteTable(trace) net.Send(self:GetOwner())
	return true
end

function TOOL.BuildCPanel(CPanel)
	local Slider = vgui.Create("DNumSlider")
	Slider:SetDark(true)
	Slider:SetText("Area selection radius")
	Slider:SetMin(1)
	Slider:SetMax(1000)
	Slider:SetDecimals(0)
	Slider:SetValue(GetConVar("masscenter_radius"):GetInt())
	Slider.OnValueChanged = function()  GetConVar("masscenter_radius"):SetInt(Slider:GetValue())  end
	CPanel:SetName("Mass Center V2.01")
	CPanel:AddItem(Slider)
end