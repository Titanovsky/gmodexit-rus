local access_string = "E2DICOVERY"
access_string =  string.lower(access_string)

local PLUGIN = {}
PLUGIN.Title = "E2 Viewer"
PLUGIN.Description = "Gives access to E2 Viewer."
PLUGIN.Author = "Knackrack615 & Uke"
PLUGIN.Privileges = { access_string }

evolve:RegisterPlugin( PLUGIN )