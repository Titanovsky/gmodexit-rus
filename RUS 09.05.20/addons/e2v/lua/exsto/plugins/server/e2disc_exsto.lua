local access_string = "E2DICOVERY"
access_string =  string.lower(access_string)

local PLUGIN = exsto.CreatePlugin()

PLUGIN:SetInfo({
	Name = "E2 Viewer",
	ID = access_string,
	Desc = "Gives access to E2 Viewer!",
	Owner = "Knackrack615 & Uke",
	CleanUnload = true;
} )

function PLUGIN:Init()
	exsto.CreateFlag( access_string, "Gives access to E2 Viewer!" )
end

function PLUGIN:OnUnload()
	exsto.Flags[access_string] = nil
end

PLUGIN:Register()