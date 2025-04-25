local COLOR_WHITE	= Color(255,255,255)
local COLOR_BRACKET = Color( 196, 196, 196 )
local COLOR_TEXT 	= Color( 244, 244, 244 )
local COLOR_GRAY 	= Color( 200, 200, 200 )

hook.Add( "OnPlayerChat", "amb_0x1234", function( ePly, sText )
	if ( ePly == nil ) or ( ePly == Entity(-1) ) then

		chat.AddText( COLOR_BRACKET, "[", COLOR_WHITE, "?", COLOR_BRACKET, "] ", COLOR_TEXT, sText )
	else
		if ( ePly:GetNWInt('amb_orgs') > 0 ) then

			local COLOR_ORGS = AmbOrgs[ ePly:GetNWInt('amb_orgs') ].color
			chat.AddText( COLOR_GRAY, "["..ePly:EntIndex().."]", COLOR_ORGS, " [", COLOR_WHITE, ePly:GetNWString('amb_players_name'), COLOR_ORGS, "] ", COLOR_TEXT, sText )
		else
			local COLOR_TEAMS = team.GetColor( ePly:Team() )
			chat.AddText( COLOR_GRAY, "["..ePly:EntIndex().."]", COLOR_TEAMS, " [", COLOR_WHITE, ePly:GetNWString('amb_players_name'), COLOR_TEAMS, "] ", COLOR_TEXT, sText )
		end
	end
	return true
end)