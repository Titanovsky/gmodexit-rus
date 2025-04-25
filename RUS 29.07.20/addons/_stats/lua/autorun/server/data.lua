local ply_struct = FindMetaTable("Player")

sql.Query("CREATE TABLE IF NOT EXISTS ru_gmod( nick varchar(255), steamid varchar(255), rub int, lvl int, exp int, next_exp int )")

function query(str)
	return sql.QueryValue(str)
end



function ply_struct:RUB_set( int )
	self:SetNWInt("rub", int )
	self:RUB_save()
end

function ply_struct:RUB_add( int )
	self:SetNWInt("rub", self:GetNWInt("rub") + int )
	self:RUB_save()
end

function ply_struct:RUB_minus( int )
	self:SetNWInt("rub", self:GetNWInt("rub") - int )
	self:RUB_save()
end

function ply_struct:LVL_set( int )
	self:SetNWInt("lvl", int )
	self:NEXP_set( 0 )
	self:EXP_set( 0 )
	self:NEXP_add()
	self:LVL_save()
end

function ply_struct:LVL_add( int )
	self:SetNWInt("lvl", self:GetNWInt("lvl") + int )
	self:NEXP_set( 0 )
	self:EXP_set( 0 )
	self:NEXP_add()
	self:LVL_save()
end

--

function ply_struct:EXP_set( int )
	self:SetNWInt("exp", int )
	self:EXP_save()
end

function ply_struct:EXP_add( int )
	self:SetNWInt("exp", self:GetNWInt("exp") + int )
	if tonumber(self:GetNWInt("exp")) >= tonumber(self:GetNWInt("next_exp")) then
		self:SetNWInt("exp", 0)
		self:LVL_add(1)
		self:NEXP_add()
	end
	self:EXP_save()
end

function ply_struct:EXP_new()
	local time = 20
	if self:TimeConnected() > time then
		self:EXP_add(1)
		if tonumber(self:GetNWInt("exp")) >= tonumber(self:GetNWInt("next_exp")) then
			self:SetNWInt("exp", 0)
			self:LVL_add(1)
			self:NEXP_add()
		end
	end
end

--

function ply_struct:NEXP_set( int )
	self:SetNWInt("next_exp", int )
	self:NEXP_save()
end

function ply_struct:NEXP_add()
	local cur = 2
	self:SetNWInt("next_exp", self:GetNWInt("next_exp") + cur * self:GetNWInt("lvl") )
	self:NEXP_save()
end




--[[
function ply_struct:STATS_setup()
	if ( !self:GetNWInt("friskCoins") ) or ( self:GetNWInt("friskCoins") == nil ) or (self:GetNWInt("friskCoins") == 0) then
		self:SetNWInt( "friskCoins", 10 )
	end

	if ( !self:GetNWInt("rub") ) or ( self:GetNWInt("rub") == nil ) then
		self:SetNWInt( "rub", 5000 )
	end

	if ( !self:GetNWInt("lvl") ) or ( self:GetNWInt("lvl") == nil ) or (self:GetNWInt("lvl") == 0) then
		self:SetNWInt( "lvl", 1 )
	end

	if ( !self:GetNWInt("exp") ) or ( self:GetNWInt("exp") == nil ) or (self:GetNWInt("exp") == 0) then
		self:SetNWInt( "exp", 0 )
	end

	if ( !self:GetNWInt("next_exp") ) or ( self:GetNWInt("next_exp") == nil ) or (self:GetNWInt("next_exp") == 0)then
		self:SetNWInt( "next_exp", 2 )
	end
end
]]

function ply_struct:STATS_init()
	local steamid = sql.SQLStr( self:SteamID() )
	local nick = sql.SQLStr( self:Nick() )

	if ( query( "SELECT * FROM ru_gmod WHERE steamid=" .. steamid ) ) then
		local rub = query("SELECT rub FROM ru_gmod WHERE steamid=" .. steamid)
		local lvl = query("SELECT lvl FROM ru_gmod WHERE steamid=" .. steamid)
		local exp = query("SELECT exp FROM ru_gmod WHERE steamid=" .. steamid)
		local next_exp = query("SELECT next_exp FROM ru_gmod WHERE steamid=" .. steamid)
		self:RUB_set( rub )
		self:LVL_set( lvl )
		self:EXP_set( exp )
		self:NEXP_set( next_exp )
	else
		query("INSERT INTO ru_gmod(nick, steamid, rub, lvl, exp, next_exp) VALUES("..nick..", "..steamid..", '6000', '1', '0', '2')")
		local rub = query("SELECT rub FROM ru_gmod WHERE steamid=" .. steamid)
		local lvl = query("SELECT lvl FROM ru_gmod WHERE steamid=" .. steamid)
		local exp = query("SELECT exp FROM ru_gmod WHERE steamid=" .. steamid)
		local next_exp = query("SELECT next_exp FROM ru_gmod WHERE steamid=" .. steamid)
		self:RUB_set( rub )
		self:LVL_set( lvl )
		self:EXP_set( exp )
		self:NEXP_set( next_exp )
		print("DataBase is created!")
	end
end

local function prt()
	print( query( "SELECT * FROM ru_gmod WHERE steamid=" .. "STEAM_0:0:7451458" ) ) -- парсим
end

function ply_struct:E2ACCESSES_init()
	local lvl = tonumber(self:GetNWInt("lvl"))
	if lvl >= 2 then self:SetNWInt("e2ac", 1)
		if lvl >= 6 then self:SetNWInt("e2ac", 2)
			if lvl >= 9 then self:SetNWInt("e2ac", 3)
			end
		end
	end
	if self:SteamID() == "STEAM_0:0:164590602" or self:SteamID() == "STEAM_0:0:22217177" or self:SteamID() == "STEAM_0:0:156690484" or self:SteamID() == "STEAM_0:0:426598565" or self:SteamID() == "STEAM_0:0:109747041" or self:SteamID() == "STEAM_0:1:95303327" then
		self:SetNWInt("e2ac", 4)
	end
end



function ply_struct:RUB_save()
	local steamid = sql.SQLStr( self:SteamID() )
	local rub = sql.SQLStr( self:GetNWInt("rub") )
	sql.Query( "UPDATE ru_gmod SET rub=".. rub .." WHERE steamid=" .. steamid )
end

function ply_struct:LVL_save()
	local steamid = sql.SQLStr( self:SteamID() )
	local lvl = sql.SQLStr( self:GetNWInt("lvl") )
	sql.Query( "UPDATE ru_gmod SET lvl=".. lvl .." WHERE steamid=" .. steamid )
end

function ply_struct:EXP_save()
	local steamid = sql.SQLStr( self:SteamID() )
	local exp = sql.SQLStr( self:GetNWInt("exp") )
	sql.Query( "UPDATE ru_gmod SET exp=".. exp .." WHERE steamid=" .. steamid )
end

function ply_struct:NEXP_save()
	local steamid = sql.SQLStr( self:SteamID() )
	local next_exp = sql.SQLStr( self:GetNWInt("next_exp") )
	sql.Query( "UPDATE ru_gmod SET next_exp=".. next_exp .." WHERE steamid=" .. steamid )
end




hook.Add("PlayerInitialSpawn", "stats_players_init", function( ply )
	ply:STATS_init()
	ply:E2ACCESSES_init()
	--timer.Simple(2, function() ply:STATS_setup() end)


	--print("RUB: "..tonumber(ply:GetNWInt("rub")))
	--print("AC:"..ply:GetNWInt("e2ac"))
	--print("LVL: "..ply:GetNWInt("lvl"))
	--print("EXP: "..ply:GetNWInt("exp").."/"..ply:GetNWInt("next_exp"))
end)


local payday_delay = 674

function STATS_payday()
	print("[AmbPayday] Acitve")
	timer.Create("amb_PayDay[Timer]", payday_delay, 0, function()
		for _, v in pairs( player.GetAll() ) do
			local payday_money_check = math.random( 820, 7120 )
			local payday_allowance = math.random( 32, v:GetNWInt("lvl") * 82 )
			v:RUB_add( payday_money_check + payday_allowance )
			v:EXP_new()
			--v:SendLua("chat.AddText( Color(245, 183, 12), '[•]  Пришла Заработная Плата!' )")
			--v:SendLua("chat.AddText( Color(235, 235, 235), 'Вы заработали: ', Color(235, 102, 82), "..payday_money_check.." )")
			--v:SendLua("chat.AddText( Color(235, 235, 235), 'Надбавка за LVL: ', Color(92, 177, 237), "..payday_allowance.." )")
			--v:SendLua("chat.AddText( Color(235, 235, 235), 'Всего: ', Color(168, 240, 144), "..payday_money_check + payday_allowance.." )")
			v:ChatPrint("Вы заработали: "..payday_money_check)
			v:ChatPrint("Надбавка за уровень: "..payday_allowance)
			v:ChatPrint("Всего: "..payday_money_check + payday_allowance)
			v:SendLua("surface.PlaySound( 'garrysmod/save_load4.wav' )")
			v:SendLua("notification.AddLegacy( 'Зарплата! ', NOTIFY_GENERIC, 3 )")
		end
	end)
end

function AmbPayday_showTime( ePly )
	ePly:ChatPrint("До зарплаты осталось: "..math.floor( timer.TimeLeft("amb_PayDay[Timer]") ).." сек" )
end
concommand.Add("payday_time", function(ply)
	AmbPayday_showTime( ply )
end)

hook.Add("Initialize", "init_levels_payday", function()
	timer.Simple( 10, STATS_payday )
end)

local reward = 50
local reward_ply = reward * 1.9



hook.Add("PlayerDeath", "ru_rubaks_death", function( victim, inf, attack)

	--[[
	if victim:IsBot() then
		attack:RUB_add( reward )
		attack:SendLua("notification.AddLegacy( 'Добыча: "..reward.." Рубаксов', NOTIFY_GENERIC, 3 )")
	elseif victim:IsPlayer() and victim ~= attack and victim:IsBot() == false then
		attack:RUB_add( reward_ply )
		attack:SendLua("notification.AddLegacy( 'Добыча: "..reward_ply.." Рубаксов', NOTIFY_GENERIC, 3 )")
	end
	]]
end)