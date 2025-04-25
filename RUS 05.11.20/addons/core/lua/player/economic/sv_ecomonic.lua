if ( AMB.config.module_economic == false ) then return false end

AmbEconomic = AmbEconomic or {}

local payday_delay = 600
local payday_modif	= 1

local COLOR_TEXT    = Color( 240, 240, 240 )
local COLOR_GRAY	= Color( 189, 189, 189 )
local COLOR_RED     = Color( 242, 90, 73 )
local COLOR_ORANGE	= Color( 240, 172, 36 )

function AmbEconomic.startPayDay()
	print( '\n[AmbEconomic] PayDay | '..os.date( '%X',os.time() ) )
	for k, v in pairs( player.GetHumans() ) do
		AmbLib.chatSend( v, COLOR_ORANGE, "[•] ", COLOR_TEXT, " Пришла зарплата | "..os.date( '%X',os.time() ) )
		if ( #player.GetAll() ) > 3 then
			if ( v:Team() == AMB_TEAM_PVP ) or ( v:Team() == AMB_TEAM_RP ) then
				if v:GetUserGroup() == 'vip' then
					AmbStats.Players.addStats( v, "$", 1 * AmbStats.Players.getStats( v, "!" ) * payday_modif )
				elseif ( v:GetUserGroup() ~= 'vip' ) and v:GetUserGroup() ~= 'user' then
					AmbStats.Players.addStats( v, "$", 1 * AmbStats.Players.getStats( v, "!" ) * payday_modif )
				else
					AmbStats.Players.addStats( v, "$", 1 * AmbStats.Players.getStats( v, "!" ) * payday_modif )
				end
			else
				if v:GetUserGroup() ~= 'user' then
					AmbStats.Players.addStats( v, "$", 2 * AmbStats.Players.getStats( v, "!" ) * payday_modif )
				else
					AmbStats.Players.addStats( v, "$", 1 * AmbStats.Players.getStats( v, "!" ) * payday_modif )
				end
			end
			AmbStats.Players.newLevel( v )
		else
			AmbLib.notifySend( v, 'Oops.. Very faw players :(', 1, 6, 'buttons/button15.wav' )
		end
	end
end
--AmbEconomic.startPayDay()
local function debugWeapons()
	print( AmbEconomic.WeaponsList[''] )
end


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
				AmbLib.notifySend( ePly, 'Not enough BE: '..weapons_tab[2], 1, 3, 'buttons/button10.wav' )
				return false
			end
		else
			AmbLib.notifySend( ePly, 'Not enough Level: '..weapons_tab[1], 1, 3, 'buttons/button10.wav' )
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
				AmbLib.notifySend( ePly, 'Not enough BE: '..ents_tab[2], 1, 3, 'buttons/button10.wav' )
				return false
			end
		else
			AmbLib.notifySend( ePly, 'Not enough Level: '..ents_tab[1], 1, 3, 'buttons/button10.wav' )
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
				AmbLib.notifySend( ePly, 'Not enough BE: '..ents_tab[2], 1, 3, 'buttons/button10.wav' )
				return false
			end
		else
			AmbLib.notifySend( ePly, 'Not enough Level: '..ents_tab[1], 1, 3, 'buttons/button10.wav' )
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
			AmbLib.notifySend( ePly, 'Not enough BE: '..standart_cost, 1, 3, 'buttons/button10.wav' )
			return false
		end
	end
end

if not timer.Exists('AmbTimer[PayDay]') then
	timer.Create( 'AmbTimer[PayDay]', payday_delay, 0, function()
		AmbEconomic.startPayDay()
	end )
end

function AmbEconomic.transferMoney( eSender, eRecipient, value )
	for k, v in pairs( player.GetAll() ) do
		if v:EntIndex() == tonumber( eRecipient ) then
			eRecipient = v
		end
	end
	if IsEntity( eRecipient ) == false then return AmbLib.notifySend( eSender, 'Access Denied', 1, 3, 'UI/buttonclick.wav' ) end
	value = math.floor( value )
	eSender:ChatPrint( tostring(eRecipient).." "..value )
	if tonumber( value ) > 0 then
		if tonumber( eSender:GetNWFloat('amb_players_money') ) >= tonumber( value ) then
			AmbStats.Players.addStats( eSender, 	"$", -tonumber( value ) )
			AmbStats.Players.addStats( eRecipient, 	"$", tonumber( value ) )

			AmbLib.chatSend( eRecipient, COLOR_ORANGE, "[•] ", COLOR_TEXT, 'Player ', COLOR_GRAY, eSender:GetNWString('amb_players_name'), COLOR_TEXT, ' send you Bio. Essensia!' )
		end
	end
end
concommand.Add( 'amb_transfer', function( ply, cmd, args ) AmbEconomic.transferMoney( ply, args[1], args[2] ) end )

function AmbEconomic.killPay( hunter, targ )
	if tonumber( targ:GetNWFloat('amb_players_level') ) >= 1 and tonumber( targ:GetNWFloat('amb_players_money') ) > 2 then
		if tonumber( targ:GetNWFloat('amb_players_level') ) >= 4 and tonumber( targ:GetNWFloat('amb_players_money') ) > 6 then
			if tonumber( targ:GetNWFloat('amb_players_level') ) >= 10 and tonumber( targ:GetNWFloat('amb_players_money') ) > 12 then
				AmbStats.Players.addStats( targ, "$", -12 )
				return AmbStats.Players.addStats( hunter, "$", 12 )
			end
			AmbStats.Players.addStats( targ, "$", -6 )
			return AmbStats.Players.addStats( hunter, "$", 6 )
		end
		AmbStats.Players.addStats( targ, "$", -2 )
		return AmbStats.Players.addStats( hunter, "$", 2 )
	elseif tonumber( targ:GetNWFloat('amb_players_level') ) == 1 then
		return
	end
end

hook.Add( "PlayerDeath", "amb_0x3492", function( victim, inflictor, attacker )
    if IsValid( attacker ) and attacker:IsPlayer() and victim:IsPlayer() and !victim:IsBot() then
        if IsValid( victim ) and victim:GetNWBool('amb_duelant') == false then
        	AmbEconomic.killPay( attacker, victim )
        end
    end
end )
