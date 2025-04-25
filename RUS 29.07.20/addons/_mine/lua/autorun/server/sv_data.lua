print("[.ambition] Mine Has Loaded!")

if CLIENT then end

function AmbMine.SetOre( ePly, nType, nNumber )
    if ( ePly:IsPlayer() ) then
        if     ( nType == 1 ) then
            ePly:SetNWInt( "amb_mine_ore1", nNumber )
        elseif ( nType == 2 ) then
            ePly:SetNWInt( "amb_mine_ore2", nNumber )
        elseif ( nType == 3 ) then
            ePly:SetNWInt( "amb_mine_ore3", nNumber )
        elseif ( nType == 4 ) then
            ePly:SetNWInt( "amb_mine_ore4", nNumber )
        elseif ( nType == 5 ) then
            ePly:SetNWInt( "amb_mine_ore5", nNumber )
        elseif ( nType == 6 ) then
            ePly:SetNWInt( "amb_mine_ore6", nNumber )
        elseif ( nType == 7 ) then
            ePly:SetNWInt( "amb_mine_ore7", nNumber )
        elseif ( nType == 8 ) then
            ePly:SetNWInt( "amb_mine_ore8", nNumber )
        end
        AmbMine.SaveData( ePly, nType )
    end
end

function AmbMine.AddOre( ePly, nType, nNumber )
    if ( ePly:IsPlayer() ) then
        if     ( nType == 1 ) then
            ePly:SetNWInt( "amb_mine_ore1", tonumber( ePly:GetNWInt("amb_mine_ore1") ) + nNumber )
        elseif ( nType == 2 ) then
            ePly:SetNWInt( "amb_mine_ore2", ePly:GetNWInt("amb_mine_ore2") + nNumber )
        elseif ( nType == 3 ) then
            ePly:SetNWInt( "amb_mine_ore3", ePly:GetNWInt("amb_mine_ore3") + nNumber )
        elseif ( nType == 4 ) then
            ePly:SetNWInt( "amb_mine_ore4", ePly:GetNWInt("amb_mine_ore4") + nNumber )
        elseif ( nType == 5 ) then
            ePly:SetNWInt( "amb_mine_ore5", ePly:GetNWInt("amb_mine_ore5") + nNumber )
        elseif ( nType == 6 ) then
            ePly:SetNWInt( "amb_mine_ore6", ePly:GetNWInt("amb_mine_ore6") + nNumber )
        elseif ( nType == 7 ) then
            ePly:SetNWInt( "amb_mine_ore7", ePly:GetNWInt("amb_mine_ore7") + nNumber )
        elseif ( nType == 8 ) then
            ePly:SetNWInt( "amb_mine_ore8", ePly:GetNWInt("amb_mine_ore8") + nNumber )
        end
        AmbMine.SaveData( ePly, nType )
    end
end

function AmbMine.MinusOre( ePly, nType, nNumber )
    if ( ePly:IsPlayer() ) then
        if     ( nType == 1 ) then
            ePly:SetNWInt( "amb_mine_ore1", ePly:GetNWInt("amb_mine_ore1") - nNumber )
        elseif ( nType == 2 ) then
            ePly:SetNWInt( "amb_mine_ore2", ePly:GetNWInt("amb_mine_ore2") - nNumber )
        elseif ( nType == 3 ) then
            ePly:SetNWInt( "amb_mine_ore3", ePly:GetNWInt("amb_mine_ore3") - nNumber )
        elseif ( nType == 4 ) then
            ePly:SetNWInt( "amb_mine_ore4", ePly:GetNWInt("amb_mine_ore4") - nNumber )
        elseif ( nType == 5 ) then
            ePly:SetNWInt( "amb_mine_ore5", ePly:GetNWInt("amb_mine_ore5") - nNumber )
        elseif ( nType == 6 ) then
            ePly:SetNWInt( "amb_mine_ore6", ePly:GetNWInt("amb_mine_ore6") - nNumber )
        elseif ( nType == 7 ) then
            ePly:SetNWInt( "amb_mine_ore7", ePly:GetNWInt("amb_mine_ore7") - nNumber )
        elseif ( nType == 8 ) then
            ePly:SetNWInt( "amb_mine_ore8", ePly:GetNWInt("amb_mine_ore8") - nNumber )
        end
        AmbMine.SaveData( ePly, nType )
    end
end

function AmbMine.Sell( ePly, nType )
    if ( ePly:IsPlayer() ) then
        if ( ePly:GetUserGroup() == "user" ) then
            ePly:RUB_add( AmbMine.Config.CostOres[nType] * ePly:GetNWInt("amb_mine_ore"..tostring(nType) ) ) -- метод из старой data для игрока, название убогое как и весь код даты игрока на старом [RU's]
        elseif ( ePly:GetUserGroup() == "vip") or ( ePly:GetUserGroup() == "officer") then
            ePly:RUB_add( AmbMine.Config.CostOres[nType] * ePly:GetNWInt("amb_mine_ore"..tostring(nType) ) * AmbMine.Config.ModifyCostVIP  )
         elseif ( ePly:GetUserGroup() == "admin") or ( ePly:GetUserGroup() == "avk") or ( ePly:GetUserGroup() == "superadmin") then
            ePly:RUB_add( AmbMine.Config.CostOres[nType] * ePly:GetNWInt("amb_mine_ore"..tostring(nType) ) * AmbMine.Config.ModifyCostAdmin  )
        end
        AmbMine.MinusOre( ePly, nType, ePly:GetNWInt("amb_mine_ore"..tostring(nType) ) )
    end
end

local function query( str ) 
	return sql.QueryValue( str )
end

function AmbMine.StartData()
    sql.Query("CREATE TABLE IF NOT EXISTS rus_mine( nick varchar(255), steamid varchar(255), ore1 int, ore2 int, ore3 int, ore4 int, ore5 int, ore6 int, ore7 int, ore8 int )")
end
hook.Add( "OnGamemodeLoaded", "amb_0x512", AmbMine.StartData )


function AmbMine.InitData( ePly )
    local steamid = sql.SQLStr( ePly:SteamID() )
	local nick = sql.SQLStr( ePly:Nick() )

	if ( query( "SELECT * FROM rus_mine WHERE steamid=" .. steamid ) ) then
		local ore1 = query("SELECT ore1 FROM rus_mine WHERE steamid=" .. steamid)
        local ore2 = query("SELECT ore2 FROM rus_mine WHERE steamid=" .. steamid)
        local ore3 = query("SELECT ore3 FROM rus_mine WHERE steamid=" .. steamid)
        local ore4 = query("SELECT ore4 FROM rus_mine WHERE steamid=" .. steamid)
        local ore5 = query("SELECT ore5 FROM rus_mine WHERE steamid=" .. steamid)
        local ore6 = query("SELECT ore6 FROM rus_mine WHERE steamid=" .. steamid)
        local ore7 = query("SELECT ore7 FROM rus_mine WHERE steamid=" .. steamid)
        local ore8 = query("SELECT ore8 FROM rus_mine WHERE steamid=" .. steamid)

		AmbMine.SetOre( ePly, 1, ore1 )
        AmbMine.SetOre( ePly, 2, ore2 )
        AmbMine.SetOre( ePly, 3, ore3 )
        AmbMine.SetOre( ePly, 4, ore4 )
        AmbMine.SetOre( ePly, 5, ore5 )
        AmbMine.SetOre( ePly, 6, ore6 )
        AmbMine.SetOre( ePly, 7, ore7 )
        AmbMine.SetOre( ePly, 8, ore8 )
	else
		query("INSERT INTO rus_mine(nick, steamid, ore1, ore2, ore3, ore4, ore5, ore6, ore7, ore8) VALUES("..nick..", "..steamid..", '0', '0', '0', '0', '0', '0', '0', '0')")
		local ore1 = query("SELECT ore1 FROM rus_mine WHERE steamid=" .. steamid)
        local ore2 = query("SELECT ore2 FROM rus_mine WHERE steamid=" .. steamid)
        local ore3 = query("SELECT ore3 FROM rus_mine WHERE steamid=" .. steamid)
        local ore4 = query("SELECT ore4 FROM rus_mine WHERE steamid=" .. steamid)
        local ore5 = query("SELECT ore5 FROM rus_mine WHERE steamid=" .. steamid)
        local ore6 = query("SELECT ore6 FROM rus_mine WHERE steamid=" .. steamid)
        local ore7 = query("SELECT ore7 FROM rus_mine WHERE steamid=" .. steamid)
        local ore8 = query("SELECT ore8 FROM rus_mine WHERE steamid=" .. steamid)
		AmbMine.SetOre( ePly, 1, ore1 )
        AmbMine.SetOre( ePly, 2, ore2 )
        AmbMine.SetOre( ePly, 3, ore3 )
        AmbMine.SetOre( ePly, 4, ore4 )
        AmbMine.SetOre( ePly, 5, ore5 )
        AmbMine.SetOre( ePly, 6, ore6 )
        AmbMine.SetOre( ePly, 7, ore7 )
        AmbMine.SetOre( ePly, 8, ore8 )
		print("[.ambition] New player for Mine")
	end
end
hook.Add( "PlayerInitialSpawn", "amb_0x32768", function( ply )
    if ( ply:IsPlayer() ) then
        AmbMine.InitData( ply )
    end
end )

function AmbMine.SaveData( ePly, nType )
    local steamid = sql.SQLStr( ePly:SteamID() )

    if ( nType == 1 ) then
        local ore = sql.SQLStr( ePly:GetNWInt("amb_mine_ore1") )
	    sql.Query( "UPDATE rus_mine SET ore1=".. ore .." WHERE steamid=" .. steamid )
    elseif ( nType == 2 ) then
        local ore = sql.SQLStr( ePly:GetNWInt("amb_mine_ore2") )
	    sql.Query( "UPDATE rus_mine SET ore2=".. ore .." WHERE steamid=" .. steamid )
    elseif ( nType == 3 ) then
        local ore = sql.SQLStr( ePly:GetNWInt("amb_mine_ore3") )
	    sql.Query( "UPDATE rus_mine SET ore3=".. ore .." WHERE steamid=" .. steamid )
    elseif ( nType == 4 ) then
        local ore = sql.SQLStr( ePly:GetNWInt("amb_mine_ore4") )
	    sql.Query( "UPDATE rus_mine SET ore4=".. ore .." WHERE steamid=" .. steamid )
    elseif ( nType == 5 ) then
        local ore = sql.SQLStr( ePly:GetNWInt("amb_mine_ore5") )
	    sql.Query( "UPDATE rus_mine SET ore5=".. ore .." WHERE steamid=" .. steamid )
    elseif ( nType == 6 ) then
        local ore = sql.SQLStr( ePly:GetNWInt("amb_mine_ore6") )
	    sql.Query( "UPDATE rus_mine SET ore6=".. ore .." WHERE steamid=" .. steamid )
    elseif ( nType == 7 ) then
        local ore = sql.SQLStr( ePly:GetNWInt("amb_mine_ore7") )
	    sql.Query( "UPDATE rus_mine SET ore7=".. ore .." WHERE steamid=" .. steamid )
    elseif ( nType == 8 ) then
        local ore = sql.SQLStr( ePly:GetNWInt("amb_mine_ore8") )
	    sql.Query( "UPDATE rus_mine SET ore8=".. ore .." WHERE steamid=" .. steamid )
    end
end

util.AddNetworkString("amb_mine_hud_net")

local function AmbMine_chatText( ePly, sText )
    if ( sText == "!mine" ) or ( sText == "/mine" ) then
        net.Start( "amb_mine_hud_net" )
        net.Send( ePly )
        return false
    elseif ( sText == "!selloreall" ) or ( sText == "/selloreall" ) then
        for i = 1, 8 do
            AmbMine.Sell( ePly, i )
        end
        return false
    elseif ( sText == "!sellore1" ) or ( sText == "/sellore1" ) then
        AmbMine.Sell( ePly, 1 )
        return false
    elseif ( sText == "!sellore2" ) or ( sText == "/sellore2" ) then
        AmbMine.Sell( ePly, 2 )
        return false
    elseif ( sText == "!sellore3" ) or ( sText == "/sellore3" ) then
        AmbMine.Sell( ePly, 3 )
        return false
    elseif ( sText == "!sellore4" ) or ( sText == "/sellore4" ) then
        AmbMine.Sell( ePly, 4 )
        return false
    elseif ( sText == "!sellore5" ) or ( sText == "/sellore5" ) then
        AmbMine.Sell( ePly, 5 )
        return false
    elseif ( sText == "!sellore6" ) or ( sText == "/sellore6" ) then
        AmbMine.Sell( ePly, 6 )
        return false
    elseif ( sText == "!sellore7" ) or ( sText == "/sellore7" ) then
        AmbMine.Sell( ePly, 7 )
        return false
    elseif ( sText == "!sellore8" ) or ( sText == "/sellore8" ) then
        AmbMine.Sell( ePly, 8 )
        return false
    end
end
hook.Add( "PlayerSay", "amb_0x4096", AmbMine_chatText )
-- Данное творение принадлежит проекту [.ambition]