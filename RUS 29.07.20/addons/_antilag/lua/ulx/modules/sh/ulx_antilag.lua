local cd = 0
local CATEGORY_NAME = "[RU] Dev"
local CATEGORY_NAME2 = "[RU] Events"

function AntiLag_Start()
	for _, v in pairs(ents.FindByClass("prop_*")) do
		v = v:GetPhysicsObject()
		if IsValid(v) then
			v:EnableMotion(false)
		end
	end

	for _, v in pairs(ents.FindByClass("prop_ragdoll")) do
		v = v:GetPhysicsObject()
		if IsValid(v) then
			v:EnableMotion(false)
		end
	end

	for _, v in pairs(player.GetHumans()) do
		v:ConCommand("r_cleardecals")
		v:ConCommand("stopsound")
		v:SendLua("notification.AddLegacy( 'Запущена Anti-Lag System. Вы заморожены!', NOTIFY_GENERIC, 6 )")

		if IsValid(v) and v:Alive() then
			v:Freeze( true )
		end

		timer.Simple(3, function() v:Freeze(false) end)
	end
end

function ulx.antilag( calling_ply )
	if cd == 0 then
		ulx.fancyLogAdmin( calling_ply, "#A запустил Anti-Lag System" )
		cd = cd + 60
		timer.Simple( cd, function() cd = 0 end)
		AntiLag_Start()
	 else
		ULib.tsayError( calling_ply, "Задержка: 1 минута.", true )
	end
end
local antilag = ulx.command( CATEGORY_NAME, "ulx lag", ulx.antilag, "!lag" )
antilag:defaultAccess( ULib.ACCESS_ADMIN )
antilag:help( "Запустить говно." )

function ulx.setmodel( calling_ply, target, mdl )
	if IsValid(target) then
		ulx.fancyLogAdmin( calling_ply, "#A передал playermodel для #T вот такую #s", target, mdl )
		target:SetModel(mdl)
	end
end
local setmodel = ulx.command( CATEGORY_NAME2, "ulx model", ulx.setmodel, "!model" )
setmodel:addParam{ type=ULib.cmds.PlayerArg }
setmodel:addParam{ type=ULib.cmds.StringArg, hint="model", ULib.cmds.optional }
setmodel:defaultAccess( ULib.ACCESS_ADMIN )
setmodel:help( "Изменить модельку." )

function ulx.setscale( calling_ply, target, num )
	if IsValid(target) then
		ulx.fancyLogAdmin( calling_ply, "#A изменил длину #T на #i", target, num )
		target:SetModelScale( num, 1)
	end
end
local setscale = ulx.command( CATEGORY_NAME2, "ulx scale", ulx.setscale, "!scale" )
setscale:addParam{ type=ULib.cmds.PlayerArg }
setscale:addParam{ type=ULib.cmds.NumArg, min=0.4, max=25, default=1, hint="размер", ULib.cmds.optional}
setscale:defaultAccess( ULib.ACCESS_ADMIN )
setscale:help( "Изменить размер модельки." )


if ( CLIENT ) then
	hook.Add("HUDPaint", "sdasd", function()
		local center = Vector( ScrW() / 2, ScrH() / 2, 0 )
		local scale = Vector( 100, 100, 0 )
	end )
end