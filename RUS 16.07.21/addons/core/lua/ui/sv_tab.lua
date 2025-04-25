util.AddNetworkString('amb_tab_update')

hook.Add( 'PlayerConnect', 'amb_0x4224', function(ply)
	net.Start('amb_tab_update')
	net.Broadcast()
end )

hook.Add( 'PlayerDisconnected', 'amb_0x4224', function(ply)
	net.Start('amb_tab_update')
	net.Broadcast()
end )

hook.Add( 'PlayerInitialSpawn', 'amb_0x4224', function(ply)
	net.Start('amb_tab_update')
	net.Broadcast()
end )

hook.Add( 'PlayerJoinTeam', 'amb_0x4224', function(ply)
	net.Start('amb_tab_update')
	net.Broadcast()
end )

AmbImgs = AmbImgs or {}
AmbImgs.imgs = AmbImgs.imgs or {}

AmbDB.createDataBase( 'amb_imgs', [[
    'ID' varchar(255) NOT NULL PRIMARY KEY,
	'UniqueID' varchar(255),
    'Name' varchar(255),
    'Picture' varchar(255)]]
)


util.AddNetworkString( 'amb_scoreboard_send_img' )
util.AddNetworkString( 'amb_scoreboard_remove_img' )
util.AddNetworkString( 'amb_scoreboard_update_img' )

function AmbImgs.givePlyImg( ePly, img )
	AmbImgs.imgs[ ePly:SteamID() ] = img

	if ( AmbDB.selectDate( 'amb_imgs', 'ID', 'ID', ePly:SteamID() ) == ePly:SteamID() ) then
		AmbDB.updateDate( 'amb_imgs', 'Picture', img, 'ID', ePly:SteamID() )
		AmbDB.updateDate( 'amb_imgs', 'Name', ePly:GetNWString('amb_players_name'), 'ID', ePly:SteamID() )
	else
		local query = Format( "%s, %s, %s, %s", sql.SQLStr(ePly:SteamID()), sql.SQLStr(ePly:UniqueID()), sql.SQLStr(ePly:GetNWString('amb_players_name')), sql.SQLStr( img ) )
		AmbDB.insertDate( 'amb_imgs', "ID, UniqueID, Name, Picture", query )
	end

	net.Start( 'amb_scoreboard_send_img' )
		net.WriteString( img )
		net.WriteEntity( ePly )
	net.Broadcast()

	-- PrintTable( AmbImgs.imgs ) -- debug
end

function AmbImgs.removePlyImg( ePly )
	AmbImgs.imgs[ ePly:SteamID() ] = nil
	AmbDB.wipeDate( 'amb_imgs', 'ID', ePly:SteamID() )
	ePly:ChatPrint( 'У вас забрали Donate-Picture' )

	net.Start( 'amb_scoreboard_remove_img' )
		net.WriteEntity( ePly )
	net.Broadcast()
end

function AmbImgs.updatePlyImg( ePly )
	-- print('HA') -- debug
	if ( AmbDB.selectDate( 'amb_imgs', 'ID', 'ID', ePly:SteamID() ) == ePly:SteamID() ) then
		local png = AmbDB.selectDate( 'amb_imgs', 'Picture', 'ID', ePly:SteamID() )
		-- ePly:ChatPrint( png ) -- debug
		AmbImgs.imgs[ ePly:SteamID() ] = png
		-- print(' DA ') -- debug

		net.Start( 'amb_scoreboard_update_img' )
			net.WriteTable( AmbImgs.imgs )
		net.Broadcast()
		return
	end

	net.Start( 'amb_scoreboard_update_img' ) -- only one player
		net.WriteTable( AmbImgs.imgs )
	net.Send( ePly )

end

hook.Add( 'PlayerInitialSpawn', 'amb_0x0042', function( ePly )
	AmbImgs.updatePlyImg( ePly )
end )