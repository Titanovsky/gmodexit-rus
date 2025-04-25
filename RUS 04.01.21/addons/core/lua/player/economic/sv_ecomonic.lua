AmbEconomic = AmbEconomic or {}

local payday_delay = 540
local payday_modif = 1
local pay_for_kill = 5

local COLOR_TEXT    = Color( 240, 240, 240 )
local COLOR_GRAY	= Color( 189, 189, 189 )
local COLOR_RED     = Color( 242, 90, 73 )
local COLOR_ORANGE	= Color( 240, 172, 36 )

function AmbEconomic.startPayDay()

	print( '\n[AmbEconomic] PayDay | '..os.date( '%X',os.time() ) )

	for k, v in pairs( player.GetHumans() ) do

		AmbLib.chatSend( v, COLOR_ORANGE, "[•] ", COLOR_TEXT, " Пришла зарплата | "..os.date( '%X',os.time() ) )

		if ( #player.GetAll() > 1 ) then

			AmbStats.Players.addStats( v, "$", 2 * AmbStats.Players.getStats( v, "!" ) * payday_modif )
			AmbStats.Players.newLevel( v )

		else

			AmbLib.chatSend( v, AMB_COLOR_RED, "[•] ", COLOR_TEXT, 'Био. Эссенция и EXP выдаются, если на сервере несколько игроков!' )

		end

	end

end
if not timer.Exists('AmbTimer[PayDay]') then timer.Create( 'AmbTimer[PayDay]', payday_delay, 0, AmbEconomic.startPayDay ) end

function AmbEconomic.buy( ePly, sEnt, ent_type )
	if ( ent_type == 'weapons' ) then
		local weapons_tab = { 1, 0 }
		for name, v in pairs( AmbEconomic.WeaponsList ) do
			if sEnt == name then
				weapons_tab = { v[1], v[2] }
				break
			else
				weapons_tab = 'NaN'
			end
		end
		if weapons_tab == 'NaN' then return true end
		if tonumber( ePly:GetNWInt('amb_players_level') ) >= weapons_tab[1] then
			if tonumber( ePly:GetNWInt('amb_players_money') ) >= weapons_tab[2] then
				AmbStats.Players.addStats( ePly, "$", -weapons_tab[2] )
				return true
			else
				AmbLib.notifySend( ePly, 'Не хватает Био. Эссенций '..weapons_tab[2], 1, 6, 'buttons/button10.wav' )
				return false
			end
		else
			AmbLib.notifySend( ePly, 'Не хватает Уровня '..weapons_tab[1], 1, 6, 'buttons/button10.wav' )
			return false
		end
	elseif ( ent_type == 'ents' ) then
		local ents_tab = { 1, 0 }
		for name, v in pairs( AmbEconomic.EntitiesList ) do
			if sEnt == name then
				ents_tab = { v[1], v[2] }
				break
			else
				ents_tab = 'NaN'
			end
		end
		if ents_tab == 'NaN' then return true end
		if tonumber( ePly:GetNWInt('amb_players_level') ) >= ents_tab[1] then
			if tonumber( ePly:GetNWInt('amb_players_money') ) >= ents_tab[2] then
				AmbStats.Players.addStats( ePly, "$", -ents_tab[2] )
				return true
			else
				AmbLib.notifySend( ePly, 'Не хватает Био.Эссенций '..ents_tab[2]..' BE', 1, 6, 'buttons/button10.wav' )
				return false
			end
		else
			AmbLib.notifySend( ePly, 'Нужен уровень '..ents_tab[1], 1, 6, 'buttons/button10.wav' )
			return false
		end
	elseif ( ent_type == 'vehicles' ) then
		local ents_tab = { 2, 6 }
		for name, v in pairs( AmbEconomic.Vehicles ) do
			if sEnt == name then
				ents_tab = { v[1], v[2] }
				break
			else
				ents_tab = 'NaN'
			end
		end
		if ents_tab == 'NaN' then return true end
		if tonumber( ePly:GetNWInt('amb_players_level') ) >= ents_tab[1] then
			if tonumber( ePly:GetNWInt('amb_players_money') ) >= ents_tab[2] then
				AmbStats.Players.addStats( ePly, "$", -ents_tab[2] )
				return true
			else
				AmbLib.notifySend( ePly, 'Не хватает Био. Эссенций '..ents_tab[2], 1, 6, 'buttons/button10.wav' )
				return false
			end
		else
			AmbLib.notifySend( ePly, 'Нужен уровень '..ents_tab[1], 1, 6, 'buttons/button10.wav' )
			return false
		end
	elseif ( ent_type == 'skin' ) then
		local standart_cost = 8

		for name, cost in pairs( AmbShopCloth.FemaleModels ) do
			if ( name == sEnt ) then
				standart_cost = cost
			end
		end

		for name, cost in pairs( AmbShopCloth.MaleModels ) do
			if ( name == sEnt ) then
				standart_cost = cost
			end
		end

		for name, cost in pairs( AmbShopCloth.SpecModels ) do
			if ( name == sEnt ) then
				standart_cost = cost
			end
		end

		if tonumber( ePly:GetNWInt('amb_players_money') ) >= standart_cost then
			AmbStats.Players.addStats( ePly, "$", -standart_cost )
			AmbStats.Players.setStats( ePly, 'skin', sEnt )
			return true
		else
			AmbLib.notifySend( ePly, 'Не хватает Био. Эссенций '..standart_cost, 1, 6, 'buttons/button10.wav' )
			return false
		end
	end
end

function AmbEconomic.transferMoney( eSender, eRecipient, value )
	
	eRecipient = Entity( tonumber( eRecipient ) ) -- сначала приходит, как string, обозначающий EntIndex

	if not IsValid( eRecipient ) or not eRecipient:IsPlayer() then AmbLib.notifySend( eSender, 'Нельзя передать Био. Эссенцию!', 1, 5, 'UI/buttonclick.wav' ) return end

	value = math.floor( value )

	if tonumber( eSender:GetNWFloat('amb_players_money') ) >= tonumber( value ) then

		AmbStats.Players.addStats( eSender, 	"$", -tonumber( value ) )
		AmbStats.Players.addStats( eRecipient, 	"$", tonumber( value ) )

		AmbLib.chatSend( eSender, COLOR_ORANGE, "[•] ", AMB_COLOR_WHITE, 'Вы передали ', AMB_COLOR_AMBITION, tostring( value ), AMB_COLOR_WHITE, ' Био. Эссенций игроку ', AMB_COLOR_AMBITION, AmbStats.Players.getStats( eRecipient, 'name' ) )
		AmbLib.chatSend( eRecipient, COLOR_ORANGE, "[•] ", AMB_COLOR_WHITE, 'Вам передал ', AMB_COLOR_AMBITION, tostring( value ), AMB_COLOR_WHITE, ' Био. Эссенций, игрок ', AMB_COLOR_AMBITION, AmbStats.Players.getStats( eSender, 'name' ) )

	end

end
concommand.Add( 'amb_transfer', function( ply, cmd, args ) AmbEconomic.transferMoney( ply, args[1], args[2] ) end )

function AmbEconomic.killPay( eVictim, eInf, eHunter )

	if not IsValid( eVictim ) or not IsValid( eHunter ) or not eVictim:IsPlayer() or not eHunter:IsPlayer() then return end
	if ( AmbStats.Players.getStats( eVictim, '!' ) <= 3 ) and not eVictim:IsBot() then AmbLib.chatSend( eHunter, AMB_COLOR_RED, "[•] ", AMB_COLOR_WHITE, 'Нельзя изъять Био. Эссенцию у этой Жертвы!' ) return end
	if ( eVictim:Team() ~= AMB_TEAM_PVP ) or ( eHunter:Team() ~= AMB_TEAM_PVP ) then AmbLib.chatSend( eHunter, AMB_COLOR_RED, "[•] ", AMB_COLOR_WHITE, 'Вы или Жертва не в PVP режиме!' ) return end
	if not eHunter.delay_hunter then eHunter.delay_hunter = {} end
	if eHunter.delay_hunter[ eVictim ] then AmbLib.chatSend( eHunter, AMB_COLOR_RED, "[•] ", AMB_COLOR_WHITE, 'У вас задержка на изъятие Био. Эссенций с этого игрока!' ) return end

	local bio = eVictim:IsBot() and pay_for_kill or pay_for_kill*2

	eHunter.delay_hunter[ eVictim ] = true
	timer.Simple( 32, function() 
	
		if IsValid( eHunter ) then eHunter.delay_hunter = nil end 
		
	end )

	AmbStats.Players.addStats( eHunter, '$', bio )

end
hook.Add( 'PlayerDeath', 'AmbitionEconomicPayForKill', AmbEconomic.killPay )
