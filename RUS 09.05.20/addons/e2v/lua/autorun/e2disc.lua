local access_string = "E2DICOVERY"
access_string =  string.lower(access_string)

local function can(ply)
	local result = false
	
	-- Check if ULib is loaded
	if ULib ~= nil then
		result = ULib.ucl.query(ply, access_string)	
	end
	
	-- Check if exsto is loaded
	if exsto ~= nil and not result then
		result = ply:IsAllowed(access_string)
	end
	
	-- Check if Evolve is Loaded
	if evolve ~= nil and not result then
		result = ply:EV_HasPrivilege( access_string )
	end
	
	if result == false and not result then
		result = ply:IsAdmin()
	end
	
	return result
end

if SERVER then
	AddCSLuaFile()
	util.AddNetworkString("findmeallthee2saround-fast!!!11")
	
	net.Receive("findmeallthee2saround-fast!!!11",function(len,ply)
		if not can(ply) then return end
		local act = net.ReadUInt(2)
		if !act then return end
		local i = net.ReadUInt(16)
		if !i then return end
		local Ent = Entity(i)
		if not IsValid(Ent) then return end
		
		if act == 0 then
			
			local E2s = ents.FindByClass("gmod_wire_expression2")
			for k,v in pairs(E2s) do
				if v:GetNWEntity("player", NULL) == Ent or (v.CPPIGetOwner and v:CPPIGetOwner() == Ent) then
					v:Remove()
				end
			end
		elseif act == 1 then
			Ent:Remove()
		elseif act == 2 then
			local E2s = ents.FindByClass("gmod_wire_expression2")
			local c = 0
			for k,v in pairs(E2s) do
				if v:GetNWEntity("player", NULL) == Ent or (v.CPPIGetOwner and v:CPPIGetOwner() == Ent) then
					v:Remove()
				end
			end
			Ent:Kick( "E2 Abuse" )
		elseif act == 3 then
			ply:SetPos(Ent:GetPos())
		end
	end)
	
	hook.Add("PlayerSay", "findmeallthee2saround-fast!!!11", function( ply, text, team )
		if (string.lower(string.sub( text, 1, 3 )) == "!e2") then
			ply:ConCommand( "e2menu" )
			return ""
		end
	end)
else
	local highlight = {}
	local panel = nil

	function e2list()
		if not can(LocalPlayer()) then chat.AddText("Only admins have access to it.") return end
		
		if panel and panel.Close then panel:Close() end
		
		local matOutline = CreateMaterial( "BlackOutline", "UnlitGeneric", { [ "$basetexture" ] = "models/debug/debugwhite", ["$color"] = "1 0 0" } )
	 
		hook.Add("HUDPaint","findmee2s",function()
			for k,v in pairs(highlight) do
				if v and IsValid(v) then
					local ts = v:GetPos():ToScreen()
					local px, py, vis = ts.x, ts.y, ts.visible
					if vis then
						local s = 20
						local s_ = s/2
						
						cam.Start3D()
							render.SuppressEngineLighting(true) 
							render.MaterialOverride(matOutline)
							render.SetBlend(1)
							render.SetColorModulation( 1, 0, 0 )
							local mod = v:GetModel()
							render.CullMode( 1 )
							v:SetModel("models/holograms/icosphere2.mdl")
							v:DrawModel()
							v:SetModel(mod)
							render.SetColorModulation( 1, 1, 1 )
							render.MaterialOverride()
							render.CullMode( 0 )
							v:DrawModel()
							render.SuppressEngineLighting(false) 
						cam.End3D()
						surface.SetDrawColor(255,0,0,255)
						surface.DrawOutlinedRect(px-s_,py-s_,s,s)
						
						surface.SetFont("TargetIDSmall")
						surface.SetTextColor(255,255,255,255)
						surface.SetTextPos(px+s_,py-s_-4)
						surface.DrawText(v:GetNWString("name", "generic") or "")
						surface.SetTextPos(px+s_,py-s_+8)
						surface.DrawText("E2 ["..tostring(v:EntIndex()).."]")
						surface.SetTextPos(px+s_,py-s_+20)
						surface.DrawText(v:GetNWEntity("player", NULL):Name())
						
					end
				else
					highlight[k] = nil
				end
			end
		end)
		
		local sx,sy = 900,600
		
		RunConsoleCommand("wire_expression_ops_sync","1") --keep uptaded
		
		local UselessPanel = vgui.Create( "DFrame" )
		UselessPanel:SetSize( sx, sy )
		UselessPanel:Center()
		UselessPanel:SetTitle( "E2 Viewer" )
		UselessPanel:SetVisible( true )
		UselessPanel:SetDraggable( true )
		UselessPanel:ShowCloseButton( true )
		UselessPanel.btnClose.DoClick = function ( button ) RunConsoleCommand("wire_expression_ops_sync","0"); UselessPanel:Close() end
		UselessPanel:SetIcon("icon16/find.png")
		UselessPanel:MakePopup()
		
		panel = UselessPanel
		
		local DermaListView = vgui.Create("DListView",UselessPanel)
		DermaListView:SetParent(UselessPanel)
		DermaListView:SetPos(0, 20)
		DermaListView:SetSize(sx, sy-20)
		DermaListView:SetMultiSelect(false)
		DermaListView:AddColumn("E2 Name"):SetWide(185)
		DermaListView:AddColumn("Owner"):SetWide(185)
		DermaListView:AddColumn("OPS"):SetFixedWidth(74)
		DermaListView:AddColumn("CPU Time"):SetFixedWidth(56)
		DermaListView:AddColumn("Options"):SetFixedWidth(400)--space for the buttons
		
		local hardquota = GetConVar("wire_expression2_quotahard")
		local softquota = GetConVar("wire_expression2_quotasoft")
		
		local function send(a,b)
			net.Start("findmeallthee2saround-fast!!!11")
				net.WriteUInt(a,2) --1:remove 2:kick 3:goto
				net.WriteUInt(b,16) --entity
			net.SendToServer()
			print(a,b)
		end
		
		local ln = 0
		local n = 0
		
		local function Refresh()
			DermaListView:Clear()
			local E2s = ents.FindByClass("gmod_wire_expression2")
			
			ln = #E2s
			n = ln
			
			for k,v in pairs(E2s) do
				local owner = v:GetNWEntity("player", NULL)
				local name = v:GetNWString("name", "generic")

				local line = DermaListView:AddLine(name,owner,"","")
				
				local oid = owner:EntIndex()
				line.Columns[ 2 ].Value = tostring(oid..name)
				function line:Think()
					if not IsValid(v) or not v.GetOverlayData then
						Refresh()
						function self:Think() end
						return
					end
					
					local owner = v:GetNWEntity("player", NULL)
					local oid = owner.Name and owner:Name() or tostring(owner)
					local name = v:GetNWString("name", "generic")
					
					local data = v:GetOverlayData()
					if data then
						local prfbench = data.prfbench
						local prfcount = data.prfcount
						local timebench = data.timebench

						local e2_hardquota = hardquota:GetInt()
						local e2_softquota = softquota:GetInt()
						
						self.Columns[ 3 ]:SetText(string.format("%i (%i%%)",prfbench,prfbench / e2_softquota * 100))
						self.Columns[ 3 ].Value = prfbench
						
						self.Columns[ 4 ]:SetText(string.format("%ius",timebench*1000000))
						self.Columns[ 4 ].Value = timebench
					end
					self.Columns[ 1 ]:SetText(name)
					self.Columns[ 1 ].Value = name
					self.Columns[ 2 ]:SetText(oid)
					self.Columns[ 2 ].Value = oid
				end
				
				local Y = vgui.Create("DButton", line)
				Y:SetText("Remove")
				function Y:DoClick() send(1,v:EntIndex()) Refresh() end
				Y:SetPos(sx-400,0)
				Y:SetSize(80,17)
				Y:SetFont("Trebuchet18")
				Y:SetTextColor(Color(0,0,0))
				
				local Y = vgui.Create("DButton", line)
				Y:SetText("-All")
				function Y:DoClick() 
					local menu = DermaMenu() 
					menu:AddOption("Cancel"):SetImage( "icon16/cancel.png" )
					menu:AddOption("Confirm", function() send(0,owner:EntIndex()) Refresh() end):SetImage( "icon16/accept.png" )
					menu:Open()
				end
				Y:SetPos(sx-330,0)
				Y:SetSize(30,17)
				Y:SetFont("Trebuchet18")
				Y:SetTextColor(Color(0,0,0))
				
				local Y = vgui.Create("DButton", line)
				Y:SetText("Kick Owner")
				function Y:DoClick() local menu = DermaMenu() 
					menu:AddOption("Cancel"):SetImage( "icon16/cancel.png" )
					menu:AddOption("Confirm", function() send(2,owner:EntIndex()) Refresh() end):SetImage( "icon16/accept.png" )
					menu:Open() end
				Y:SetPos(sx-100,0)
				Y:SetSize(100,17)
				Y:SetFont("DebugFixedSmall")
				Y:SetTextColor(Color(0,0,0))
				
				local Y = vgui.Create("DButton", line)
				Y:SetText("Highlight")
				function Y:UpdateName()
					if not highlight[v:EntIndex()] then
						self:SetText("Highlight")
					else
						self:SetText("Hide")
					end
				end
				function Y:DoClick()
					if not highlight[v:EntIndex()] then
						highlight[v:EntIndex()] = v
					else
						highlight[v:EntIndex()] = nil
					end
					self:UpdateName()
				end
				Y:UpdateName()
				Y:SetPos(sx-300,0)
				Y:SetSize(100,17)
				Y:SetFont("Trebuchet18")
				Y:SetTextColor(Color(0,0,0))
				
				local Y = vgui.Create("DButton", line)
				Y:SetText("Goto")
				function Y:DoClick() send(3,v:EntIndex()) end
				Y:SetPos(sx-200,0)
				Y:SetSize(100,17)
				Y:SetFont("Trebuchet18")
				Y:SetTextColor(Color(0,0,0))
			end
			DermaListView:SortByColumn( 2, false )
		end
		Refresh()

		local ST = SysTime
		local ti = ST() + 0.4
		function DermaListView:Think()
			if ti < ST() then
				ti = ST() + 0.4
				local E2s = ents.FindByClass("gmod_wire_expression2")
				n = #E2s
				
				if ln != n then Refresh() end
			end
		end

	end
	concommand.Add( "e2menu", function() e2list() end )
end