local function checkAdmin(ply)
	-- The server console always has access. `ply` is NULL in this case
	local isConsole = ply == nil or ply == NULL
	if isConsole then
		return true
	end
	local canAdmin = hook.Run("TextscreensCanAdmin", ply) -- run custom hook function to check admin
	if canAdmin == nil then -- if hook hasn't returned anything, default to super admin check
		canAdmin = ply:IsSuperAdmin()
	end
	return canAdmin
end

if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("textscreens_config.lua")
	include("textscreens_config.lua")
	CreateConVar( "sbox_maxtextscreens", "16", true )

	local version = "1.16.0"

	local function StringRandom(int)
		math.randomseed(os.time())
		local s = ""

		for i = 1, int do
			s = s .. string.char(math.random(65, 90))
		end

		return s
	end

	local textscreens = {}

	local function SpawnPermaTextscreens()
		textscreens = file.Read("sammyservers_textscreens.txt", "DATA")
		if not textscreens or textscreens == "" then
			textscreens = {}
			return
		end
		textscreens = util.JSONToTable(textscreens)

		local existingTextscreens = {}
		for k,v in pairs(ents.FindByClass("sammyservers_textscreen")) do
			if not v.uniqueName then continue end
			existingTextscreens[v.uniqueName] = true
		end

		local count = 0
		for k, v in pairs(textscreens) do
			if v.MapName ~= game.GetMap() then continue end
			if existingTextscreens[v.uniqueName] then continue end

			local textScreen = ents.Create("sammyservers_textscreen")
			textScreen:SetPos(Vector(v.posx, v.posy, v.posz))
			textScreen:SetAngles(Angle(v.angp, v.angy, v.angr))
			textScreen.uniqueName = v.uniqueName
			textScreen:Spawn()
			textScreen:Activate()
			textScreen:SetMoveType(MOVETYPE_NONE)

			for lineNum, lineData in pairs(v.lines or {}) do
				textScreen:SetLine(lineNum, lineData.text, Color(lineData.color.r, lineData.color.g, lineData.color.b, lineData.color.a), lineData.size, lineData.font)
			end

			textScreen:SetIsPersisted(true)
			count = count + 1
		end

	end

	hook.Add("InitPostEntity", "loadTextScreens", function()
		timer.Simple(10, SpawnPermaTextscreens)
	end)

	hook.Add("PostCleanupMap", "loadTextScreens", SpawnPermaTextscreens)

	-- If a player, use ChatPrint method, else print directly to server console
	local function printMessage(ply, msg)
		local isConsole = ply == nil or ply == NULL
		if isConsole then
			print(msg)
		else
			ply:ChatPrint(msg)
		end
	end
	concommand.Add("SS_TextScreen", function(ply, cmd, args)
		if not checkAdmin(ply) or not args or not args[1] or not args[2] or not (args[1] == "delete" or args[1] == "add") then
			printMessage(ply, "not authorised, or bad arguments")
			return
		end
		local ent = Entity(args[2])
		if not IsValid(ent) or ent:GetClass() ~= "sammyservers_textscreen" then return false end

		if args[1] == "add" then
			local pos = ent:GetPos()
			local ang = ent:GetAngles()
			local toAdd = {}
			toAdd.posx = pos.x
			toAdd.posy = pos.y
			toAdd.posz = pos.z
			toAdd.angp = ang.p
			toAdd.angy = ang.y
			toAdd.angr = ang.r
			-- So we can reference it easily later because EntIndexes are so unreliable
			toAdd.uniqueName = StringRandom(10)
			toAdd.MapName = game.GetMap()
			toAdd.lines = ent.lines
			table.insert(textscreens, toAdd)
			file.Write("sammyservers_textscreens.txt", util.TableToJSON(textscreens))
			ent:SetIsPersisted(true)

			return printMessage(ply, "Текстскрин сохранён.")
		else
			for k, v in pairs(textscreens) do
				if v.uniqueName == ent.uniqueName then
					textscreens[k] = nil
				end
			end

			ent:Remove()
			file.Write("sammyservers_textscreens.txt", util.TableToJSON(textscreens))

			return printMessage(ply, "Textscreen removed and is no longer permanent.")
		end
	end)

end

if CLIENT then
	include("textscreens_config.lua")

	properties.Add("addPermaScreen", {
		MenuLabel = "Оставить навсегда",
		Order = 2001,
		MenuIcon = "icon16/transmit.png",
		Filter = function(self, ent, ply)
			if not IsValid(ent) or ent:GetClass() ~= "sammyservers_textscreen" then return false end
			if ent:GetIsPersisted() then return false end

			return checkAdmin(ply)
		end,
		Action = function(self, ent)
			if not IsValid(ent) then return false end

			return RunConsoleCommand("SS_TextScreen", "add", ent:EntIndex())
		end
	})

	properties.Add("removePermaScreen", {
		MenuLabel = "Удалить",
		Order = 2002,
		MenuIcon = "icon16/transmit_delete.png",
		Filter = function(self, ent, ply)
			if not IsValid(ent) or ent:GetClass() ~= "sammyservers_textscreen" then return false end
			if not ent:GetIsPersisted() then return false end

			return checkAdmin(ply)
		end,
		Action = function(self, ent)
			if not IsValid(ent) then return end

			return RunConsoleCommand("SS_TextScreen", "delete", ent:EntIndex())
		end
	})
end
