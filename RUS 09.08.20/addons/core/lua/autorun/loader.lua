if SERVER then 
	AddCSLuaFile()
end

function AMB.loadScripts( sDir, sText ) -- Загрузка скриптов (sv, cl, sh) на сервачок. Принимает папку и текст, который надо выводить
	MsgN( sText.."\n" )
	local files, dirs = file.Find( sDir .. "/*", "LUA" )
	for _, f in pairs( files ) do -- f - это файл
		local type_file = string.sub( f, 0, 2 ) -- Первые два символа.

		if ( type_file == "sv") then
			if SERVER then
				include( sDir .. "/" .. f )
			    MsgN( "[AMB] Added/Refresh file to (server): " .. f )
            end
		end

        if ( type_file == "cl") then
            if SERVER then
			    AddCSLuaFile( sDir .. "/" .. f )
			    MsgN( "[AMB] Added/Refresh file to (client): " .. f )
            elseif CLIENT then
                include( sDir .. "/" .. f )
            end
		end

		if ( type_file == "sh" ) then
			if SERVER then
                include( sDir .. "/" .. f )
			    AddCSLuaFile( sDir .. "/" .. f )
			    MsgN( "[AMB] Added/Refresh file to (shared - sv): " .. f )
            elseif CLIENT then
                include( sDir .. "/" .. f )
            end
		end
	end
	MsgN("======================================")
end

AMB.loadScripts( "lib", 	"| [AMB] Custom Library v1.0 |" ) -- библиотека
AMB.loadScripts( "gm", 		"| [AMB] Sandbox Structure |" ) -- настройки геймода
AMB.loadScripts( "orgs", 	"| [AMB] Organizations v1.1 |" ) -- организаций
AMB.loadScripts( "ui", 		"| [AMB] User Interface |" )
AMB.loadScripts( "player",  "| [AMB] Main Information of Player |" )
AMB.loadScripts( "opti", 	"| [AMB] Optimizations |" )
AMB.loadScripts( "cmds", 	"| [AMB] CMDs |" )
AMB.loadScripts( "duel", 	"| [AMB] Duel (2x2) System |" )
AMB.loadScripts( "raid", 	"| [AMB] Raid PVE System |" )
AMB.loadScripts( "drinks",  "| [AMB] Drinks Coctail & Bar System |" )

--AMB.loadScripts( "teams", "| [AMB] Teams |" ) -- настройки геймода
--AMB.loadScripts( "propcore", "| [AMB] Prop Core v1.0 |" )
--AMB.loadScripts("adminus", "| [AMB] Adminus |") -- админка