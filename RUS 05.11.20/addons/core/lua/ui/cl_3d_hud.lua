
local function AmbHud_PlayerHud1( ply )
	if ( !IsValid( ply ) ) then return end
	if ( ply == LocalPlayer() ) then return end
	if ( !ply:Alive() ) then return end

	local dis = LocalPlayer():GetPos():Distance( ply:GetPos() )

	if ( dis < 650 ) then

		local offset = Vector( 0, 0, 70 )
		local ang = LocalPlayer():EyeAngles()
		local pos = ply:GetPos() + offset + ang:Up()

		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )

		cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.15 )
			if #ply:GetNWString('amb_players_name') > 1 then
				draw.SimpleTextOutlined( ply:GetNWString('amb_players_name')..' ['..ply:EntIndex()..']', "DermaLarge", 0, -15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			elseif ply:IsBot() then
				draw.SimpleTextOutlined( ply:Nick()..' ['..ply:EntIndex()..']', "DermaLarge", 0, -15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			else
				draw.SimpleTextOutlined( 'Заходит...', "DermaLarge", 0, -15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			end

			if #ply:GetNWString('amb_players_virus_name') > 1 then
				draw.SimpleTextOutlined( 'Заражён: '..ply:GetNWString('amb_players_virus_name'), "DermaLarge", 0, -54, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_RED )
			end

			if ply:GetNWBool("amb_bad") == true then
				draw.SimpleTextOutlined( "Bad Entity", "DermaLarge", 0, -45, Color( 200, 0, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			end
		cam.End3D2D()
	end
end



hook.Add( "PostPlayerDraw", "amb_0x16", function( ePly )
	AmbHud_PlayerHud1( ePly )
	--AmbVGUI_drawPanelNPC( ePly, 660 )
end )


