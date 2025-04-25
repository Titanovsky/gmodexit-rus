local COLOR_WHITE	= Color(255,255,255)
local COLOR_BRACKET = Color( 196, 196, 196 )
local COLOR_TEXT 	= Color( 244, 244, 244 )
local COLOR_GRAY 	= Color( 200, 200, 200 )

hook.Add( "OnPlayerChat", "amb_0x1234", function( ePly, sText )

	if not ePly or ( ePly == Entity( -1 ) ) then

		chat.AddText( COLOR_WHITE, '[?] ', COLOR_TEXT, sText )

	else

		chat.AddText( COLOR_TEXT, "["..ePly:EntIndex().."]", team.GetColor( ePly:Team() )," [", ePly:GetNWString('amb_players_name').."] ", COLOR_TEXT, sText )

	end

	return true

end )