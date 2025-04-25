
local function AmbHud_PlayerHud1( ply )
	if ( !IsValid( ply ) ) then return end
	if ( ply == LocalPlayer() ) then return end
	if ( !ply:Alive() ) then return end

	local dis = EyePos():DistToSqr( ply:GetPos() )

	if ( dis < 800^2 ) then

		local _,max = ply:GetRotatedAABB( ply:OBBMins(), ply:OBBMaxs() )
		local rot = ( ply:GetPos() - EyePos() ):Angle().yaw - 90 
		local center = ply:LocalToWorld( ply:OBBCenter() )

		cam.Start3D2D( center + Vector( 0, 0, math.abs( max.z/2 + 4 ) ), Angle( 0, rot, 90 ), 0.13 )

			if #ply:GetNWString('amb_players_name') > 1 then

				draw.SimpleTextOutlined( team.GetName( ply:Team() ), "amb_fonts32", 0, -15, team.GetColor( ply:Team() ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )
				draw.SimpleTextOutlined( ply:GetNWString('amb_players_name')..' ['..ply:EntIndex()..']', "amb_fonts32", 0, -45, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

			elseif ply:IsBot() then

				draw.SimpleTextOutlined( ply:Nick()..' ['..ply:EntIndex()..']', "amb_fonts32", 0, -15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

			else

				draw.SimpleTextOutlined( 'Заходит... ['..ply:EntIndex()..']', "amb_fonts32", 0, -15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )

			end

		cam.End3D2D()

	end

end



hook.Add( "PostPlayerDraw", "amb_0x16", function( ePly )

	AmbHud_PlayerHud1( ePly )

end )


