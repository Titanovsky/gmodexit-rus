E2VguiPanels = {
    ["vgui_elements"] = { --used to register the panel create/modify functions
        ["functions"] = {}
    },
    ["panels"] = {} --used to store the panels of every e2 clientside for easier access
}

E2VguiLib = {
    ["Buddies"] = {}, --list of buddies (they are allowed to create panels for this player)
    ["panelFunctions"] = { --functions for every attribute
        text = function(panel,value) panel:SetText(value) end,
        width = function(panel,value) panel:SetWidth(value) end,
        height = function(panel,value) panel:SetHeight(value) end,
        title = function(panel,value) panel:SetTitle(value) end,
        --TODO implement parenting functions
        --parent = function(panel,value,...) panel:SetParent(E2VguiLib.GetPanelByID(value,panel["pnlData"]["e2EntityID"])) end,
        posX = function(panel,value) local old_posX,old_posY = panel:GetPos() panel:SetPos(value,old_posY) end,
        posY = function(panel,value) local old_posX,old_posY = panel:GetPos() panel:SetPos(old_posX,value) end,
        visible = function(panel,value) panel:SetVisible(value) end,
        putCenter = function(panel,value) if value == true then panel:Center() end end,
        sizable = function(panel,value) panel:SetSizable(value) end,
        deleteOnClose = function(panel,value) panel:SetDeleteOnClose(value) end,
        makepopup = function(panel,value) if value == true then panel:MakePopup() end end,
        mouseinput = function(panel,value) panel:SetMouseInputEnabled(value) end,
        keyboardinput = function(panel,value) panel:SetKeyBoardInputEnabled(value) end,
        showCloseButton = function(panel,value) panel:ShowCloseButton(value) end,
        dark = function(panel,value) panel:SetDark(value) end,
        decimals = function(panel,value) panel:SetDecimals(value) end,
        max = function(panel,value) panel:SetMax(value) end,
        min = function(panel,value) panel:SetMin(value) end,
        removeLine = function(panel,value) if IsValid(panel:GetLine(value)) then panel:RemoveLine(value) end end,
        sortByColumn = function(panel,value) panel:SortByColumn(value[1],value[2]) end,
        textcolor = function(panel,value) panel:SetTextColor(value) end,
        font = function(panel,values)
            local fontname = values[1]
            local fontsize = values[2]
            --we us the same table wiremod uses for egp fonts
            local font = "WireEGP_" .. fontsize .. "_" .. fontname
            if (!EGP.ValidFonts_Lookup[font]) then
                local fontTable =
                {
                    font=fontname,
                    size = fontsize,
                    weight = 800,
                    antialias = true,
                    additive = false
                }
                surface.CreateFont( font, fontTable )
                EGP.ValidFonts_Lookup[font] = true
            end
            panel:SetFont(font)
        end,
        checked = function(panel,value) panel:SetValue(value) end,
        value = function(panel,value) panel:SetValue(value) end,
        choice = function(panel,value) panel:AddChoice(value[1],value[2]) end,
        clear = function(panel,value) panel:Clear() end,
        indent = function(panel,value) panel:SetIndent(value) end,
        showpalette = function(panel,value) panel:SetPalette(value) end,
        showalphabar = function(panel,value) panel:SetAlphaBar(value) end,
        showwangs = function(panel,value) panel:SetWangs(value) end,
        colorvalue = function(panel,value) panel:SetColor(value) end,
        textwrap = function(panel,value) panel:SetWrap(value) end,
        autoStrechVertical = function(panel,value) panel:SetAutoStretchVertical(value) end,
        addsheet = function(panel,values)
            local sheet_pnl = E2VguiLib.GetPanelByID(values["panelID"],values["e2EntityID"])
            if(not ispanel(sheet_pnl)) then return end
            if values["icon"] == "" then values["icon"] = nil end
            panel:AddSheet(values["name"],sheet_pnl,values["icon"])
        end,
        addColumn = function(panel,values) panel:AddColumn(values["column"],values["position"]) end,
        addLine = function(panel,...)
            if #panel.Lines < 200 then --if we exceed 200 lines don't add more
                panel:AddLine(unpack(...))
            end
        end,
        closeTab = function(panel,value)
            local pnl = nil
            for index,tab in pairs(panel:GetItems()) do
                if tab.Name == value then
                    pnl = tab["Tab"]
                end
            end

            if IsValid(pnl) then
                //prevent it from removing the tab if only one is left
                if #panel.Items == 1 then return end
                panel:CloseTab(pnl,true)
            end
        end,
        multiselect = function(panel,value) panel:SetMultiSelect(value) end,
        dock = function(panel,value) panel:Dock(value) end,
        dockMargin = function(panel,values) panel:DockMargin(values[1],values[2],values[3],values[4]) end,
        dockPadding = function(panel,values) panel:DockPadding(values[1],values[2],values[3],values[4]) end,
        enabled = function(panel,value) panel:SetEnabled(value) end,
        icon = function(panel,value) panel:SetIcon(value) end,
        model = function(panel,value) panel:SetModel(value) end,
        fov = function(panel,value) panel:SetFOV(value) end,
        campos = function(panel,value) panel:SetCamPos(value) end,
        lookat = function(panel,value) panel:SetLookAt(value) end,
        ambientlight = function(panel,value) panel:SetAmbientLight(value) end,
        animatemodel = function(panel,value) panel:SetAnimated(value) end,
        directionallight = function(panel,values)
            panel:SetDirectionalLight(values[1],values[2])
        end,
        label = function(panel,value) panel:SetLabel(value) end,
        drawOutlinedRect = function(panel,value)
            function panel:PaintOver()
                surface.SetDrawColor(value)
                self:DrawOutlinedRect()
            end
        end,
        sortItems = function(panel,value) panel:SetSortItems(value) end,
        backgroundBlur = function(panel,value) panel:SetBackgroundBlur(value) end
    }
}


--used to register a new created panel
function E2VguiLib.RegisterNewPanel(e2EntityID ,uniqueID, pnl)
    E2VguiPanels.panels[e2EntityID][uniqueID] = pnl
    pnl["pnlData"]["e2EntityID"] = e2EntityID
    --  TODO:Add hooks later ?
    --	hook.Run("E2VguiLib.RegisterNewPanel",LocalPlayer(),e2EntityID,pnl)
end


--function to retrieve a panel of a specified e2
function E2VguiLib.GetPanelByID(uniqueID,e2EntityID)
    if E2VguiPanels["panels"][e2EntityID] == nil then return end
    local pnl = E2VguiPanels["panels"][e2EntityID][uniqueID]
    return pnl
end


--used to apply a table of changes
--'otherFormat' indicates if it is a 'changes'-table or 'paneldata'-table
function E2VguiLib.applyAttributes(panel,attributes,otherFormat)
    if otherFormat == true then
        local pnlData = {}
        for key,value in pairs(attributes) do
            if E2VguiLib.panelFunctions[key] != nil and value != nil then
        		E2VguiLib.panelFunctions[key](panel,value)
        	end
            pnlData[key] = value
        end
        return pnlData
    else
        local pnlData = {}
        for _,values in pairs(attributes) do
            local key = values[1]
            local value = values[2]
            if E2VguiLib.panelFunctions[key] != nil and value != nil then
        		E2VguiLib.panelFunctions[key](panel,value)
        	end
            pnlData[key] = value
        end
        return pnlData
    end
end

--this updates the pos and size values of the panel that is stored on the server
function E2VguiLib.UpdatePosAndSizeServer(e2EntityID,uniqueID,panel)
    net.Start("E2Vgui.UpdateServerValues")
    net.WriteInt(e2EntityID,32)
    net.WriteInt(uniqueID,32)
    local posX,posY = panel:GetPos()
    local width,height = panel:GetSize()
    net.WriteTable({
        posX = posX,
        posY = posY,
        width = width,
        height = height
    })
    net.SendToServer()
end


--Maybe optimise this by creating a 'children' table for each panel ?
function E2VguiLib.GetChildPanelIDs(uniqueID,e2EntityID,pnlList)
    local tbl = pnlList or {uniqueID}
    local pnl = E2VguiLib.GetPanelByID(uniqueID,e2EntityID)
    if pnl != nil then
        if pnl:HasChildren() then
            for k,v in pairs(pnl:GetChildren()) do
                --if the pnl has childs get their child panels as well
                if v:HasChildren() and table.HasValue(tbl,v.uniqueID) then
                    local panels = E2VguiLib.GetChildPanelIDs(uniqueID,e2EntityID,tbl)
                    table.Add(tbl,panels)
                end
                --Add the ID to the list
                if v.uniqueID != nil then
                    table.insert(tbl,v.uniqueID)
                    --remove the OnRemove() function to prevent redundant calling and spamming with net-messages
                    v.OnRemove = function() return end
                end
            end
        end
    end
    return tbl
end


--function to buddy a player, will use name to identify but actually buddies the steamID (updates the datebase and sends new update to server)
function E2VguiLib.AddBuddyPlayerByName(name)
    local target = nil
    for k,v in pairs(player.GetAll()) do
        if v:Nick() == name then
            target = v
            break
        end
    end
    if target == nil or target:IsBot() then return end
    E2VguiLib.AddBuddyPlayer(target)
end

--function to buddy a player (updates the datebase and sends new update to server)
function E2VguiLib.AddBuddyPlayer(target)
    if not IsValid(target) or target:IsBot() then return end
    net.Start("E2Vgui.AddRemoveBuddy")
    net.WriteBool(true)
    net.WriteEntity(target)
    net.SendToServer()
    E2VguiLib.AddBuddyToDatabase(target)
    E2VguiLib.ReloadE2VguiPermissionMenu()
    print("[E2VguiCore] Added "..target:Nick() .. " as buddy! He can create derma panels on your client!")
end


--unbuddy a player (updates the datebase and sends new update to server)
function E2VguiLib.RemoveBuddyByName(name)
    local target = nil
    for k,v in pairs(player.GetAll()) do
        if v:Nick() == name then
            target = v
            break
        end
    end
    if target == nil or target:IsBot() then return end
    E2VguiLib.RemoveBuddy(target)
end

--unbuddy a player (updates the datebase and sends update to server)
function E2VguiLib.RemoveBuddy(target)
    if target == nil or target:IsBot() then return end
    net.Start("E2Vgui.AddRemoveBuddy")
    net.WriteBool(false)
    net.WriteEntity(target)
    net.SendToServer()
    E2VguiLib.Buddies[target:SteamID()] = false
    E2VguiLib.RemoveBuddyFromDatabase(target:SteamID())
    E2VguiLib.ReloadE2VguiPermissionMenu()
    print("[E2VguiCore] Removed "..target:Nick() .. " as buddy! He can't create derma panels on your client anymore!")
end

--returns all buddies
function E2VguiLib.GetBuddyPlayers()
    local tbl = {}
    for k,v in pairs(E2VguiLib.Buddies) do
        table.insert(tbl,player.GetBySteamID(k))
    end
    return tbl
end


--used to remove the panel clientside and automatically informs the server
--e.g. when you close a Dframe with the close button
function E2VguiLib.RemovePanelWithChilds(panel,e2EntityID)
    local name = panel["uniqueID"]
    local pnlData = panel["pnlData"]
    local panels = E2VguiLib.GetChildPanelIDs(name,e2EntityID)

    for k,v in pairs(panels) do
        --remove the panel on clientside table
        E2VguiPanels["panels"][e2EntityID][v] = nil
    end

    --notify the server of removal
    net.Start("E2Vgui.NotifyPanelRemove")
        -- -2 : none -1: single / 0 : multiple / 1 : all
        net.WriteInt(0,3)
        net.WriteInt(e2EntityID,32)
        net.WriteTable(panels)
    net.SendToServer()
end








--[[-------------------------------------------------------------------------
CONSOLE COMMANDS
---------------------------------------------------------------------------]]
concommand.Add( "wire_vgui_listbuddies",
function( ply, cmd, args )
    local buddyPlayers = E2VguiLib.GetBuddiesFromDatabase()
    if #buddyPlayers <= 0 then
        print("[E2VguiCore] No buddies exist!")
        return
    end
    print("[E2VguiCore] Buddied Players:")
    print("---------------------------------------")
    for k,entry in pairs(buddyPlayers) do
        print(entry.UserName.." - "..entry.SteamID)
    end
    print("---------------------------------------")
end
,nil,
"Prints a list of all buddies",0)

concommand.Add( "wire_vgui_addbuddy",
function( ply, cmd, args )
    if #args == 0 then return end
    local name = args[1]
    E2VguiLib.AddBuddyPlayerByName(name)
end
,function()
    local tbl = {}
    for k,v in pairs(player.GetAll()) do
        if v != LocalPlayer() and not v:IsBot() and E2VguiLib.Buddies[v:SteamID()] != true then
            table.insert(tbl,"wire_vgui_addbuddy " .. "\""..v:Nick() .. "\"")
        end
    end
    return tbl
end,
"Adds a player to your buddy list which allows him to create derma panels on your client with E2",0)

concommand.Add( "wire_vgui_removebuddy",
function( ply, cmd, args )
    if #args == 0 then return end
    local name = args[1]
    E2VguiLib.RemoveBuddyByName(name)
end
,function()
    local tbl = {}
    for k,v in pairs(E2VguiLib.Buddies) do
        local ply = player.GetBySteamID( k )
        if ply != LocalPlayer():SteamID() then
            table.insert(tbl,"wire_vgui_removebuddy " .. "\"".. ply:Nick() .. "\"")
        end
    end
    return tbl
end,
"Removes a buddy from your list so he can't create derma panels on your client anymore",0)








--[[-------------------------------------------------------------------------
UTIL FUNCTIONS
---------------------------------------------------------------------------]]
--simple function to convert between lua tables and e2 tables
function E2VguiLib.convertToE2Table(tbl)
    /*	{n={},ntypes={},s={},stypes={},size=0}
    n 			- table for number keys
    ntypes 	- number indics
    s 			- table for string keys
    stypes 	- string indices
    */
    local e2table = {n={},ntypes={},s={},stypes={},size=0}
    local size = 0

    for k,v in pairs( tbl ) do
        local vtype = type(v)
        --convert number to Normal otherwise it won't get recognized as wire datatype
        if vtype == "number" then vtype = "normal" end
        local keyType = type(k)

        local e2Type = ""
        if wire_expression_types[string.upper(vtype)] != nil then
            e2Type = wire_expression_types[string.upper(vtype)][1]
        elseif vtype == "boolean" and wire_expression_types[string.upper(vtype)] == nil then
            --handle booleans beforehand because they have no type in e2
            e2Type = wire_expression_types["NORMAL"][1]
        else
            ErrorNoHalt("[CLIENT VGUI LIB] Unknown type detected key:"..vtype.." value:"..tostring(v))
            continue
        end

        --determine if the key is a number or anything else
        local indextype = (keyType == "number" and "n" or "s")
        if indextype == "n" then
            e2table[indextype.."types"][k] = e2Type
        else
            --convert the key to a string
            e2table[indextype.."types"][tostring(k)] = e2Type
        end

        if vtype == "table" then
            --colors are getting detected as table, so we make sure they get parsed as vector4
            if IsColor(v) then
                e2table[indextype.."types"][indextype == "n" and k or tostring(k)] = wire_expression_types["VECTOR4"][1]
                e2table[indextype][k] = {v.r,v.g,v.b,v.a}
				--[[
					First we check if its a nested table,
					otherwise it's a normal table or vector-table
				]]
			--check if it contains sub-tables, so it's not a vector3 or vector4
			elseif type(v[1]) == "table" then
				--TODO:this check isn't 100% proof
				--TODO:implement protection against recursive tables. Infinite loops!
				e2table[indextype][k] = E2VguiCore.convertToE2Table(v)
			elseif table.IsSequential(v) and #v==2 and type(v[1]) == "number" and type(v[2]) == "number" then
                e2table[indextype.."types"][indextype == "n" and k or tostring(k)] = wire_expression_types["VECTOR2"][1]
                e2table[indextype][k] = v
			elseif table.IsSequential(v) and #v==3 and type(v[1]) == "number" and type(v[2]) == "number" and type(v[3]) == "number" then
                e2table[indextype.."types"][indextype == "n" and k or tostring(k)] = wire_expression_types["VECTOR"][1]
                e2table[indextype][k] = v
			elseif table.IsSequential(v) and #v==4 and type(v[1]) == "number" and type(v[2]) == "number" and type(v[3]) == "number" and type(v[4]) == "number" then --its a vector4
                e2table[indextype.."types"][indextype == "n" and k or tostring(k)] = wire_expression_types["VECTOR4"][1]
                e2table[indextype][k] = v
			else
                --TODO:implement protection against recursive tables. Infinite loops!
                e2table[indextype][k] = E2VguiCore.convertToE2Table(v)
            end
        elseif vtype == "boolean" then
            --booleans have no type in e2 so parse them as number
            e2table[indextype.."types"][indextype == "n" and k or tostring(k)] = wire_expression_types["NORMAL"][1]
            e2table[indextype][k] = v and 1 or 0
        else
            --everything that has a valid type in e2 just put the value inside
            e2table[indextype][k] = v
        end
        size = size + 1
    end
    e2table.size = size
    return e2table
end

--Converts a e2table into a lua table
function E2VguiLib.convertToLuaTable(tbl)
    /*	{n={},ntypes={},s={},stypes={},size=0}
    n 			- table for number keys
    ntypes 	- number indics
    s 			- table for string keys
    stypes 	- string indices
    */
    local luatable = {}
	for key,value in pairs(tbl.s) do
		if istable(value) then
			luatable[key] = E2VguiLib.convertToLuaTable(value)
		else
			luatable[key] = value
		end
	end
	for key,value in pairs(tbl.n) do
		if istable(value) then
			luatable[key] = E2VguiLib.convertToLuaTable(value)
		else
			luatable[key] = value
		end
	end
    return luatable
end

function E2VguiLib.ReloadE2VguiPermissionMenu(panel)
    if panel == nil then
        if E2VguiLib.E2VguiPermissionMenuPanel == nil then
            return
        else
            panel = E2VguiLib.E2VguiPermissionMenuPanel
        end
    end
    E2VguiLib.E2VguiPermissionMenuPanel = panel

    panel:Clear()
    local btnReload = vgui.Create("DButton")
	btnReload:SetText("Reload")
	btnReload.DoClick = function(self)
		E2VguiLib.ReloadE2VguiPermissionMenu()
	end
	panel:AddItem(btnReload)

	local lvPermissions =  vgui.Create( "DListView")
	lvPermissions:SetHeight(200)
	lvPermissions:AddColumn("Name")
	lvPermissions:AddColumn("Steam ID")

	local buddies = E2VguiLib.GetBuddiesFromDatabase()
	for i, buddy in ipairs(buddies) do
		lvPermissions:AddLine(buddy.UserName, buddy.SteamID)
	end

	panel:AddItem(lvPermissions)

	local btnRemove = vgui.Create("DButton")
	btnRemove:SetText("Remove selected Buddy")
	btnRemove.DoClick = function(self)
		local lineIdx, linePnl = lvPermissions:GetSelectedLine()
		if linePnl != nil then
            local steamID = linePnl:GetColumnText(2)
            local ply = player.GetBySteamID(steamID)
            if ply != nil then
                E2VguiLib.RemoveBuddy(ply)
            else
                E2VguiLib.RemoveBuddyFromDatabase(steamID)
            end
		end
		E2VguiLib.ReloadE2VguiPermissionMenu()
	end
	panel:AddItem(btnRemove)

	local label = vgui.Create("DLabel")
	label:SetText("Click to add as buddy:")
	label:SetDark(true)
	panel:AddItem(label)

    for i, ply in ipairs( player.GetAll() ) do
        if ply == LocalPlayer() then continue end
		local isBuddy = false
		for i, buddy in ipairs(buddies) do
			if buddy.SteamID == ply:SteamID() then
				isBuddy = true
				break
			end
		end
		if isBuddy == false and not ply:IsBot() then
			local button = vgui.Create("DButton")
			button:SetText(ply:Nick())
			button.DoClick = function(self)
				self:Remove()
				E2VguiLib.AddBuddyPlayer(ply)
				E2VguiLib.ReloadE2VguiPermissionMenu()
			end
			panel:AddItem(button)
		end
	end
end 

hook.Add( "PopulateToolMenu", "CreateE2VguiPermissionMenu", function() 
	spawnmenu.AddToolCategory( "Utilities", "#spawnmenu.utilities.e2vguicore", "E2 Vgui Core")
	spawnmenu.AddToolMenuOption( "Utilities", "#spawnmenu.utilities.e2vguicore", "E2VguiPermissionMenu", "Permissions", "", "", E2VguiLib.ReloadE2VguiPermissionMenu)
end)

function E2VguiLib.CreateBuddyTableIfNotExist()
	return sql.Query("CREATE TABLE IF NOT EXISTS e2_vgui_buddy_list(SteamID TEXT PRIMARY KEY, UserName TEXT)")
end

function E2VguiLib.GetBuddiesFromDatabase()
    E2VguiLib.CreateBuddyTableIfNotExist()
    local result = sql.Query("SELECT SteamID,UserName FROM e2_vgui_buddy_list")
	return result or {}
end

function E2VguiLib.AddBuddyToDatabase(ply)
    E2VguiLib.CreateBuddyTableIfNotExist()
    result = sql.Query("INSERT INTO e2_vgui_buddy_list(SteamID, UserName) VALUES('"..ply:SteamID().."', '".. ply:Nick() .."')")
    E2VguiLib.Buddies[ply:SteamID()] = true
	E2VguiLib.RegisterBuddiesOnServer()
end

function E2VguiLib.RemoveBuddyFromDatabase(steamID)
	local result = sql.Query("SELECT name FROM sqlite_master WHERE type='table' AND name='{e2_vgui_buddy_list}'");
	if result == nil then
		result = sql.Query("DELETE FROM e2_vgui_buddy_list WHERE SteamID='".. steamID .."';")
    end
    E2VguiLib.Buddies[steamID] = nil
	E2VguiLib.RegisterBuddiesOnServer()
end

--sends the buddy list to the server
function E2VguiLib.RegisterBuddiesOnServer()
	net.Start("E2Vgui.RegisterBuddiesOnServer")
	local buddies = {}

    for k, v in pairs(E2VguiLib.Buddies) do
        E2VguiLib.Buddies[k] = nil
    end

    for k,buddy in pairs(E2VguiLib.GetBuddiesFromDatabase()) do
		table.insert(buddies, buddy.SteamID)
		E2VguiLib.Buddies[buddy.SteamID] = true
	end

    net.WriteTable(buddies)
    net.SendToServer()
end
