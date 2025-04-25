local ply_struct = FindMetaTable("Player")

sql.Query("CREATE TABLE IF NOT EXISTS ru_gmod( nick varchar(255), steamid varchar(255), frisk_coins int, rub int, lvl int, exp int, next_exp int )")

function query(str) 
	return sql.QueryValue(str)
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
		local fc = query("SELECT frisk_coins FROM ru_gmod WHERE steamid=" .. steamid)
		local rub = query("SELECT rub FROM ru_gmod WHERE steamid=" .. steamid)
		local lvl = query("SELECT lvl FROM ru_gmod WHERE steamid=" .. steamid)
		local exp = query("SELECT exp FROM ru_gmod WHERE steamid=" .. steamid)
		local next_exp = query("SELECT next_exp FROM ru_gmod WHERE steamid=" .. steamid)
		self:FC_set( fc )
		self:RUB_set( rub )
		self:LVL_set( lvl )
		self:EXP_set( exp )
		self:NEXP_set( next_exp )
	else
		query("INSERT INTO ru_gmod(nick, steamid, frisk_coins, rub, lvl, exp, next_exp) VALUES("..nick..", "..steamid..", '0', '5000', '1', '0', '2')")
		local fc = query("SELECT frisk_coins FROM ru_gmod WHERE steamid=" .. steamid)
		local rub = query("SELECT rub FROM ru_gmod WHERE steamid=" .. steamid)
		local lvl = query("SELECT lvl FROM ru_gmod WHERE steamid=" .. steamid)
		local exp = query("SELECT exp FROM ru_gmod WHERE steamid=" .. steamid)
		local next_exp = query("SELECT next_exp FROM ru_gmod WHERE steamid=" .. steamid)
		self:FC_set( fc )
		self:RUB_set( rub )
		self:LVL_set( lvl )
		self:EXP_set( exp )
		self:NEXP_set( next_exp )
		print("DataBase is created!")
	end
end

function ply_struct:E2ACCESSES_init()
	local lvl = tonumber(self:GetNWInt("lvl"))
	if lvl >= 2 then self:SetNWInt("e2ac", 1) 
		if lvl >= 6 then self:SetNWInt("e2ac", 2)
			if lvl >= 9 then self:SetNWInt("e2ac", 3)
			end
		end
	end
end




function ply_struct:FC_save()
	local steamid = sql.SQLStr( self:SteamID() )
	local fc = sql.SQLStr( self:GetNWInt("friskCoins") )
	sql.Query( "UPDATE ru_gmod SET frisk_coins=".. fc .." WHERE steamid=" .. steamid )
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


	print("RUB: "..tonumber(ply:GetNWInt("rub")))
	print("AC:"..ply:GetNWInt("e2ac"))
	print("FC: "..ply:GetNWInt("friskCoins"))
	print("LVL: "..ply:GetNWInt("lvl"))
	print("EXP: "..ply:GetNWInt("exp").."/"..ply:GetNWInt("next_exp"))
end)

hook.Add("PlayerSpawn", "e2_ac_init", function( ply )
	ply:E2ACCESSES_init()

	local hints = {}
end)



function STATS_payday()
	local delay = 600
	local money_check = 12000
	local fc_check = 2

	timer.Simple( delay, function()
		for _, v in pairs( player.GetAll() ) do
			v:RUB_add( money_check )
			v:FC_add( fc_check )
			v:EXP_new()
			v:SendLua("surface.PlaySound( 'garrysmod/save_load4.wav' )")
			v:SendLua("notification.AddLegacy( 'Зарплата! ', NOTIFY_GENERIC, 5 )")
			v:SendLua("chat.AddText( Color(224, 211, 108), '[!]  Check' )")
		end
		STATS_payday()
    end)
end

hook.Add("Initialize", "init_levels", function()
	STATS_payday()
end)


