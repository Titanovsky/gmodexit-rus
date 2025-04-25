util.AddNetworkString("amb_players_done_connection_") -- есть подозрения, что можно эксплойтить
util.AddNetworkString("amb_players_register_person")
util.AddNetworkString("amb_players_done_registration")
util.AddNetworkString("amb_players_accept")

net.Receive( "amb_players_done_connection_", function( len )
    local ePly = net.ReadEntity()
    if not IsValid( ePly ) then print('\n[AmbDebug] VERY BAD Connection!\n Len:'..len..'\n' ) return end
    local id = sql.SQLStr( ePly:SteamID() )
    ePly:Freeze( false )
    if ( sql.QueryValue( "SELECT * FROM amb_players WHERE ID=" .. id ) ) then
        print('\n[AmbDebug] Good Connection! '..ePly:Nick()..' Len:'..len..'\n' ) -- debug
        net.Start( "amb_players_register_person" )
            net.WriteUInt( 0, 3 )
        net.Send( ePly )
        AmbStats.Players.initialPerson( ePly ) -- нужно, чтобы инициализировать челика =/
    else
        print('\n[AmbDebug] Bad Connection! '..ePly:Nick() ) -- debug
        net.Start( "amb_players_register_person" )
            net.WriteUInt( 1, 3 )
        net.Send( ePly )
    end
end )

net.Receive( "amb_players_done_registration", function(len)
    local ePly          = net.ReadEntity()
    local ePly_name     = net.ReadString()

    if sql.Query("SELECT Name FROM `amb_players_stats` WHERE Name='"..ePly_name.."'") then
        AmbLib.chatSend( ePly, COLOR_RED, "[•] ", COLOR_TEXT, " Имя занято!" )
        return
    end

    local ePly_sex      = net.ReadString()
    local ePly_nation   = net.ReadString()
    local ePly_age      = net.ReadUInt( 7 )
    local ePly_skin     = net.ReadString()
    local ePly_home     = net.ReadString()


    if utf8.len(ePly_name) > 26 or utf8.len(ePly_name) < 2 then ePly_name = "Ban_For_Me" end
    if ePly_sex == 'Select a sex' then ePly_sex = "Male" end
    if ePly_nation == 'Select a nationality' then ePly_nation = "American" end
    if ePly_skin == '' then
        if ePly_sex == 'Female' then
            ePly_skin = "models/player/Group01/female_01.mdl"
        else
            ePly_skin = "models/player/Group01/male_08.mdl"
        end
    end
    if ePly_home == 'Select a Home' then ePly_home = 'Titanovsky' end

    net.Start('amb_players_accept')
    net.Send( ePly )
    ePly:SetNWString( "amb_players_name",   ePly_name )
    ePly:SetNWString( "amb_players_sex",    ePly_sex )
    ePly:SetNWString( "amb_players_nation", ePly_nation )
    ePly:SetNWFloat(    "amb_players_age",    ePly_age )
    ePly:SetNWString( "amb_players_skin",   ePly_skin )
    ePly:SetNWString( "amb_players_home",   ePly_home )
    AmbStats.Players.createPerson( ePly )
end )