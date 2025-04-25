//Clientside file only
local fileLimit = CreateClientConVar("MaterialMenu_fileLimit", "1000")  //Limit of files in a folder before we start cutting it off
local selMat, MM

local function MaterialsMenu()
    
    if MM then MM.Frame:SetVisible(true) return end

    MM = {}
    
    MM.Frame = vgui.Create("DFrame")
    MM.Frame:SetTitle("Material Browser")
    MM.Frame:SetSize(ScrW()/2, 2/3 * ScrH())
    MM.Frame:SetPos(ScrW()/2 - MM.Frame:GetWide()/2, ScrH()/2 - MM.Frame:GetTall()/2)
    MM.Frame:SetDraggable(true)
    MM.Frame:ShowCloseButton(true)
    MM.Frame:SetDeleteOnClose(false)
    MM.Frame:MakePopup()
    
    MM.Tree = vgui.Create("DTree", MM.Frame)
    MM.Tree:SetPos(15, 40)
    MM.Tree:SetSize(MM.Frame:GetWide()/2 - 30, MM.Frame:GetTall() - 71)
    MM.Tree:SetPadding(5)

    MM.MatPnl = vgui.Create("DPanel", MM.Frame)
    MM.MatPnl:SetPos(MM.Frame:GetWide()/2 + 15, 40)
    MM.MatPnl:SetSize(MM.Frame:GetWide()/2 - 30, MM.Frame:GetWide()/2 - 30)
    
    MM.Mat = vgui.Create("DImage", MM.MatPnl)
    MM.Mat:SetPos(3,3)
    MM.Mat:SetSize(MM.MatPnl:GetWide() - 6, MM.MatPnl:GetTall() - 6)

    MM.TreeNode = MM.Tree:AddNode("materials")
    MM.TreeNode.dir  = "materials/"
    MM.TreeNode.gen = false

    local btnSpace = MM.Frame:GetTall() - MM.MatPnl:GetTall() - 60
    local btnH = btnSpace/4

    MM.Btn1 = vgui.Create("DButton", MM.Frame)
    MM.Btn1:SetPos(MM.Frame:GetWide()/2 + 15, MM.MatPnl:GetTall() + 45)
    MM.Btn1:SetSize(MM.Frame:GetWide()/2 - 30, btnH)
    MM.Btn1:SetText("Copy Filepath to Clipboard")

    MM.Btn2 = vgui.Create("DButton", MM.Frame)
    MM.Btn2:SetPos(MM.Frame:GetWide()/2 + 15, MM.MatPnl:GetTall() + 45 + btnH)
    MM.Btn2:SetSize(MM.Frame:GetWide()/2 - 30, btnH)
    MM.Btn2:SetText("Use with Material Tool")
    MM.Btn2:SetTooltip("Note: This will fail if the server does not allow the material.")
    
    MM.Btn3 = vgui.Create("DButton", MM.Frame)
    MM.Btn3:SetPos(MM.Frame:GetWide()/2 + 15, MM.MatPnl:GetTall() + 45 + btnH*2)
    MM.Btn3:SetSize(MM.Frame:GetWide()/2 - 30, btnH)
    MM.Btn3:SetText("Use with Trails Tool")
    MM.Btn3:SetTooltip("Note: This will fail if the server does not allow the material.")

    MM.Btn4 = vgui.Create("DButton", MM.Frame)
    MM.Btn4:SetPos(15, MM.Frame:GetTall() - 30)
    MM.Btn4:SetSize(MM.Tree:GetWide(), 15)
    MM.Btn4:SetText("Refresh List")

    MM.ChkBox = vgui.Create("DCheckBoxLabel", MM.Frame)
    MM.ChkBox:SetText("Show original size")
    MM.ChkBox:SizeToContents()
    MM.ChkBox:SetPos(MM.Frame:GetWide()/2 + 15, MM.MatPnl:GetTall() + 45 + btnH*3 + btnH/2 - MM.ChkBox:GetTall()/2)
    
    //
    local function FindMaterials(node, dir)
        local files, dirs = file.Find(dir.."*", "GAME")
        
        for _,v in pairs(dirs) do
            local newNode = node:AddNode(v)
            newNode.dir = dir..v
            newNode.gen = false
        
            newNode.DoClick = function()
                if !newNode.gen then
                    FindMaterials(newNode, dir..v.."/")
                    newNode.gen = true
                end
            end
        end

        local function GenerateNodes(stop)
            local fileCount = 0

            for k,v in pairs(files) do
                if fileCount > fileLimit:GetInt() then break end
                local format = string.sub(v, -4)
                if format == ".vmt" or format == ".png" then
                    fileCount = fileCount + 1

                    local newNode = node:AddNode(v)
                    newNode.file   = v
                    newNode.dir    = dir
                    newNode.IsFile = true
                    newNode.format = format
                    newNode.Icon:SetImage("icon16/picture.png")

                    files[k] = ""
                end
            end
    
            if fileCount > fileLimit:GetInt() then
                local newNode = node:AddNode("Click to load more files...")
                newNode.Icon:SetImage("icon16/picture_add.png")
                newNode.DoClick = function() 
                    newNode:Remove()
                    GenerateNodes()
                end
            end
        end
        GenerateNodes()
    end
    FindMaterials(MM.TreeNode, "materials/")
    //

    local function ResizeMat()
        if !MM.ChkBox:GetChecked() then
            MM.Mat:SetPos(3,3)
            MM.Mat:SetSize(MM.MatPnl:GetWide() - 6, MM.MatPnl:GetTall() - 6)
        else
            MM.Mat:SizeToContents()
            MM.Mat:SetPos(MM.MatPnl:GetWide()/2 - MM.Mat:GetWide()/2, MM.MatPnl:GetTall()/2 - MM.Mat:GetTall()/2)
        end
    end
    
    MM.ChkBox.OnChange = ResizeMat
    
    MM.Tree.DoClick = function()
        local mat = MM.Tree:GetSelectedItem()
        if mat and mat.IsFile then
            selMat = string.sub(mat.dir .. mat:GetText(), 11, -5)
            MM.Btn2:SetDisabled(mat.format != ".vmt")
            MM.Btn3:SetDisabled(mat.format != ".vmt")
            MM.Mat:SetImage(selMat..mat.format)
            ResizeMat()
        end
    end
    
    MM.Btn1.DoClick = function()
        if !selMat then return end
        SetClipboardText(selMat)
    end
    
    MM.Btn2.DoClick = function()
        if !selMat then return end
        list.Add("OverrideMaterials", selMat, selMat)
        RunConsoleCommand("material_override", selMat)
        RunConsoleCommand("gmod_toolmode", "material")
        RunConsoleCommand("use", "gmod_tool")
        MM.Frame:SetVisible(false)
    end
    
    MM.Btn3.DoClick = function()
        if !selMat then return end
        list.Set("trail_materials", selMat, selMat)
        RunConsoleCommand("trails_material", selMat)
        RunConsoleCommand("gmod_toolmode", "trails")
        RunConsoleCommand("use", "gmod_tool")
        MM.Frame:SetVisible(false)
    end

    MM.Btn4.DoClick = function()
        MM.TreeNode:Remove()
        MM.TreeNode = MM.Tree:AddNode("materials")
        MM.TreeNode.dir  = "materials/"
        MM.TreeNode.gen = false
        
        FindMaterials(MM.TreeNode, "materials/")
    end
    
end
concommand.Add("MaterialMenu_Open", MaterialsMenu)
