local categ_event = '[RUs] Event'

-- WARP ------------------------------------
local warps = {}

function ulx.warp( calling_ply, nWarp )

	local warp = warps[ nWarp or 1 ]
	if not warp then return end

	calling_ply:SetPos( warp )

end
local warp = ulx.command( categ_event, "ulx warp", ulx.warp, "/warp" )
warp:defaultAccess( ULib.ACCESS_ALL )
warp:addParam{ type=ULib.cmds.NumArg, min=1, default=1, hint='Номер Варпа', ULib.cmds.optional, ULib.cmds.round }
warp:help( 'Варпнуться на точку' )

function ulx.setwarp( calling_ply, nWarp )

	local warp = warps[ nWarp ]

	if warp then  

		warps[ nWarp ] = nil
		ulx.fancyLogAdmin( calling_ply, false, '#A закрыл #i варп', nWarp )

	else

		warps[ nWarp ] = calling_ply:GetPos()
		ulx.fancyLogAdmin( calling_ply, false, '#A открыл #i варп', nWarp )

	end

end
local setwarp = ulx.command( categ_event, "ulx setwarp", ulx.setwarp, "/setwarp" )
setwarp:defaultAccess( ULib.ACCESS_ADMIN )
setwarp:addParam{ type=ULib.cmds.NumArg, min=1, default=1, hint='Номер Варпа', ULib.cmds.optional, ULib.cmds.round }
setwarp:help( "Create/Unlocked warp or Remove/Locked warp." )

function ulx.getwarps( calling_ply, nWarp )

	for i, _ in SortedPairs( warps ) do calling_ply:ChatPrint( 'Warp: '..i ) end

end
local getwarps = ulx.command( categ_event, 'ulx getwarps', ulx.getwarps, '/getwarps' )
getwarps:defaultAccess( ULib.ACCESS_ALL )
getwarps:help( 'Узнать все открыте варпы' )

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

function ulx.cancelvotemap( calling_ply )
	timer.Remove( 'AmbVoteChangeMap' )

	ulx.fancyLogAdmin( calling_ply, false, "#A отменил голосование на Смену карты"  )
end
local cancelvotemap = ulx.command( cat_officer, "ulx cancelvotemap", ulx.cancelvotemap, "/cancelvotemap" )
cancelvotemap:defaultAccess( ULib.ACCESS_ADMIN )
cancelvotemap:help( 'Отменить голосование на Смену карты' )

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

local cat_jobs = 'Работы'

function ulx.setjob( calling_ply, eTarget, nJob )

	if nJob == 0 then calling_ply.job = nil ulx.fancyLogAdmin( calling_ply, false, '#A удалил работу игроку #T', eTarget  ) return end

	eTarget.job = nJob

	local color = ( nJob == 1 ) and AMB_COLOR_RED:ToVector() or AMB_COLOR_BLUE:ToVector()
	eTarget:SetPlayerColor( color ) 
	eTarget:Spawn()

	ulx.fancyLogAdmin( calling_ply, false, "#A поменял игроку #T работу на #i", eTarget, nJob  )

end
local setjob = ulx.command( cat_jobs, "ulx setjob", ulx.setjob, "/setjob" )
setjob:addParam{ type=ULib.cmds.PlayerArg }
setjob:addParam{ type=ULib.cmds.NumArg, min = 0, max = 2, default=1, hint='Номер', ULib.cmds.optional, ULib.cmds.round }
setjob:defaultAccess( ULib.ACCESS_ADMIN )
setjob:help( 'Выбрать игроку 1 или 2 работу, 0 - удаляет' )

local spawnsjobs = {}
spawnsjobs[ 1 ] = {}
spawnsjobs[ 2 ] = {}

local frags = {}
frags[ 1 ] = 0
frags[ 2 ] = 0

function ulx.setspawnjob( calling_ply, nJob )

	spawnsjobs[ nJob ] = {}
	spawnsjobs[ nJob ][ 1 ] = { pos = calling_ply:GetPos(), ang = calling_ply:EyeAngles() }

	ulx.fancyLogAdmin( calling_ply, false, "#A изменил спавны для работы #i", nJob  )

end
local setspawnjob = ulx.command( cat_jobs, 'ulx setspawnjob', ulx.setspawnjob, "/setspawnjob" )
setspawnjob:addParam{ type=ULib.cmds.NumArg, min = 1, max = 2, default=1, hint='Работы', ULib.cmds.optional, ULib.cmds.round }
setspawnjob:defaultAccess( ULib.ACCESS_ADMIN )
setspawnjob:help( 'Изменить (удалить предыдущие) спавны' )

function ulx.addspawnjob( calling_ply, nJob )

	spawnsjobs[ nJob ][ #spawnsjobs[ nJob ] + 1 ] = { pos = calling_ply:GetPos(), ang = calling_ply:EyeAngles() }

	ulx.fancyLogAdmin( calling_ply, false, "#A добавил спавны для работы #i", nJob  )

end
local addspawnjob = ulx.command( cat_jobs, 'ulx addspawnjob', ulx.addspawnjob, "/addspawnjob" )
addspawnjob:addParam{ type=ULib.cmds.NumArg, min = 1, max = 2, default=1, hint='Работы', ULib.cmds.optional, ULib.cmds.round }
addspawnjob:defaultAccess( ULib.ACCESS_ADMIN )
addspawnjob:help( 'Добавил спавны' )

if SERVER then

	hook.Add( 'PlayerSpawn', 'JobsSetPlayer', function( ePly ) 

		local job = ePly.job
		if not job then return end

		timer.Simple( 0.2, function() 
		
			local color = ( job == 1 ) and AMB_COLOR_RED or AMB_COLOR_BLUE
			ePly:SetMaterial( 'phoenix_storms/Fender_white' )
			ePly:SetColor( color ) 

			if ( #spawnsjobs[ job ] > 0 ) then 
			
				local tab = table.Random( spawnsjobs[ job ] )
				ePly:SetPos( tab.pos ) 
				ePly:SetEyeAngles( tab.ang ) 
				
			end
			
		end )

	end )

	hook.Add( 'PlayerDeath', 'addFrags', function( eVictim, _, eAttacker )

		local job = eAttacker.job
		local job2 = eVictim.job
		if job and job2 and ( job ~= job2 ) then 

			local name = ( job == 1 ) and 'Красные' or 'Синие'		
			frags[ job ] = frags[ job ] + 1 


			for _, v in ipairs( player.GetHumans() ) do

				v:ChatPrint( '['..name..'] Фраги: '..frags[ job ] )

			end

		end

	end )

	hook.Add( 'PlayerShouldTakeDamage' , 'blockDamageForteams', function( ePly, eAttacker )

		local job1, job2 = ePly.job, eAttacker.job

		if job1 and job2 and ( job1 == job2 ) then return false end

	end )

end