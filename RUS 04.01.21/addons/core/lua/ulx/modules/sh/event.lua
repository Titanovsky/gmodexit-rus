local categ_event = '[RUs] Event'

-- WARP ------------------------------------
local warpOn = false
local warpPos = Vector(0,0,0)

function ulx.warp( calling_ply )
	if warpOn then
		calling_ply:SetPos( warpPos )
		ulx.fancyLogAdmin( calling_ply, false, "#A Send in warp" )
	else
		ULib.tsayError( calling_ply, "Warp has locked!", true )
	end
end
local warp = ulx.command( categ_event, "ulx warp", ulx.warp, "/warp" )
warp:defaultAccess( ULib.ACCESS_ALL )
warp:help( "Teleport in Warp" )

function ulx.setwarp( calling_ply )
	if warpOn then
		warpOn = false
		ulx.fancyLogAdmin( calling_ply, false, "#A Closed warp" )
	else
		warpOn = true
		warpPos = calling_ply:GetPos() + Vector( 0, 0, 16 )
		ulx.fancyLogAdmin( calling_ply, false, "#A Open warp" )
	end
end
local setwarp = ulx.command( categ_event, "ulx setwarp", ulx.setwarp, "/setwarp" )
setwarp:defaultAccess( ULib.ACCESS_ADMIN )
setwarp:help( "Create/Unlocked warp or Remove/Locked warp." )

------------------------------------

function ulx.stripsweaponsevent( calling_ply )

	for k, v in pairs(player.GetHumans()) do
		if ( v ~= calling_ply ) and ( ( calling_ply:GetPos():Distance( v:GetPos() ) ) <= 1200 )then
			v:StripWeapons()
		end
	end
    ulx.fancyLogAdmin( calling_ply, false, "#A strip weapon around radius 1200 units"  )
end
local stripsweaponsevent = ulx.command( categ_event, "ulx swe", ulx.stripsweaponsevent, "/swe" )
stripsweaponsevent:defaultAccess( ULib.ACCESS_ADMIN )
stripsweaponsevent:help( "Strip weapons around player on 1200 units." )

function ulx.hpevent( calling_ply, number )

	for k, v in pairs(player.GetHumans()) do
		if ( v ~= calling_ply ) and ( ( calling_ply:GetPos():Distance( v:GetPos() ) ) <= 1200 ) then
			v:SetHealth( number )
		end
	end

	ulx.fancyLogAdmin( calling_ply, false, "#A add Health players around radius 1200 units"  )
end
local hpevent = ulx.command( categ_event, "ulx he", ulx.hpevent, "/he" )
hpevent:addParam{ type=ULib.cmds.NumArg, hint="HP" }
hpevent:defaultAccess( ULib.ACCESS_ADMIN )
hpevent:help( "Add HP for radius 1200 units." )

local function playSoundCount( count )
	for k, v in pairs( player.GetHumans() ) do
		v:SendLua('surface.PlaySound( "ambition/amb_zombie_mode_sounds_pack/countdown/'..tostring(count)..'.wav" )')
	end
end

function ulx.countdown( calling_ply, max )

	for i = 1, max do timer.Simple( i-0.75, function() playSoundCount( i ) end ) end

	ulx.fancyLogAdmin( calling_ply, false, "#A start `CountDown` to #i", max  )
end
local countdown = ulx.command( categ_event, "ulx countdown", ulx.countdown, "/countdown" )
countdown:addParam{ type=ULib.cmds.NumArg, min=1, max=10, hint="Count", ULib.cmds.round }
countdown:defaultAccess( ULib.ACCESS_ADMIN )
countdown:help( "Countdowns." )

local cat_helper = '[RUs] Хелпер'

function ulx.setweather( calling_ply, sWeather )

	AmbTimeCycle.SetTimeEnvironment( sWeather )

	ulx.fancyLogAdmin( calling_ply, false, "#A установил погоду #s", sWeather  )

end
local setweather = ulx.command( cat_helper, "ulx setweather", ulx.setweather, "/setweather" )
setweather:addParam{ type=ULib.cmds.StringArg, hint="погода", ULib.cmds.optional }
setweather:defaultAccess( ULib.ACCESS_ADMIN )
setweather:help( "Изменить погоду: day, night, sundown, christmas." )

function ulx.startvoterpvoice( calling_ply )

	AmbVote.StartVoteRPVoice()

	ulx.fancyLogAdmin( calling_ply, false, "#A запустил голосование на Вкл/Выкл RP Voice"  )

end
local startvoterpvoice = ulx.command( cat_helper, "ulx startvoterpvoice", ulx.startvoterpvoice, "/startvoterpvoice" )
startvoterpvoice:defaultAccess( ULib.ACCESS_ADMIN )
startvoterpvoice:help( 'Запустить голосование на Вкл/Выкл RP Voice' )

function ulx.startvotefalldamage( calling_ply )

	AmbVote.StartVoteFallDamage()

	ulx.fancyLogAdmin( calling_ply, false, "#A запустил голосование на Вкл/Выкл Реалистичный Урон от Падения"  )

end
local startvotefalldamage = ulx.command( cat_helper, "ulx startvotefalldamage", ulx.startvotefalldamage, "/startvotefalldamage" )
startvotefalldamage:defaultAccess( ULib.ACCESS_ADMIN )
startvotefalldamage:help( 'Запустить голосование на Вкл/Выкл Реалистичный Урон от Падения' )

local cat_officer = '[RUs] Офицер'

function ulx.startvotemap( calling_ply )

	AmbVote.StartVote()

	ulx.fancyLogAdmin( calling_ply, false, "#A запустил голосование на Смену карты"  )

end
local startvotemap = ulx.command( cat_officer, "ulx startvotemap", ulx.startvotemap, "/startvotemap" )
startvotemap:defaultAccess( ULib.ACCESS_ADMIN )
startvotemap:help( 'Запустить голосование на Смену карты' )

function ulx.setmodel( calling_ply, eTarget, sModel )

	if not util.IsValidModel( sModel ) then sModel = 'models/Kleiner.mdl' end

	eTarget:SetModel( sModel )

	ulx.fancyLogAdmin( calling_ply, false, "#A поменял модель #T", eTarget  )

end
local setmodel = ulx.command( cat_officer, "ulx setmodel", ulx.setmodel, "/setmodel" )
setmodel:addParam{ type=ULib.cmds.PlayerArg }
setmodel:addParam{ type=ULib.cmds.StringArg, hint="модельку", ULib.cmds.optional }
setmodel:defaultAccess( ULib.ACCESS_ADMIN )
setmodel:help( 'Изменить модель игрока' )

local teams = { 

	[ 'pvp' ] = AMB_TEAM_PVP,
	[ 'rp' ] = AMB_TEAM_RP,
	[ 'build' ] = AMB_TEAM_BUILD,
	[ 'citizen' ] = AMB_TEAM_CITIZEN,

}

function ulx.setteam( calling_ply, eTarget, sTeam )

	if not teams[ sTeam ] then sTeam = 'citizen' end

	AmbStats.Players.changeTeam( eTarget, teams[ sTeam ] )

	ulx.fancyLogAdmin( calling_ply, false, "#A поменял тиму игроку #T на #s", eTarget, sTeam  )

end
local setteam = ulx.command( cat_officer, "ulx setteam", ulx.setteam, "/setteam" )
setteam:addParam{ type=ULib.cmds.PlayerArg }
setteam:addParam{ type=ULib.cmds.StringArg, hint="название тимы", ULib.cmds.optional }
setteam:defaultAccess( ULib.ACCESS_ADMIN )
setteam:help( 'Изменить тиму игроку: pvp, rp, build, citizen' )

local cat_admin = '[RUs] Администратор'

function ulx.bot( calling_ply )

	RunConsoleCommand( 'bot' )

	ulx.fancyLogAdmin( calling_ply, false, '#A пригласил Бота на чай')

end
local bot = ulx.command( cat_admin, "ulx bot", ulx.bot, "/bot" )
bot:defaultAccess( ULib.ACCESS_ADMIN )
bot:help( 'Заспавнить бота' )