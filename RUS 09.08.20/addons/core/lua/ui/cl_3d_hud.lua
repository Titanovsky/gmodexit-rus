local function AmbVGUI_drawPanelNPC(ent, dist) -- thx for _AMD_ (gm-donate крутой сервис)
	dist = dist or EyePos():DistToSqr( ent:GetPos() )

	if ( dist > MAX_DIST ) then
		surface.SetAlphaMultiplier( math.Clamp( 3 - ( dist / 20000 ), 0, 1 ) )
		local _,max = ent:GetRotatedAABB( ent:OBBMins(), ent:OBBMaxs() )
		local rot = ( ent:GetPos() - EyePos() ):Angle().yaw - 90 --  чтобы крутилась.
		local center = ent:LocalToWorld( ent:OBBCenter() )

		cam.Start3D2D(center + Vector( 0, 0, math.abs( max.z / 2 ) + 12 ), Angle( 0, rot, 90 ), 0.13 )
		surface.SetFont('amb_fonts32')
			local x, y = surface.GetTextSize( MAIN_TEXT_NPC )
			draw.SimpleTextOutlined( MAIN_TEXT_NPC, MAIN_FONT, -x/2, 15, COLOR_TEXT, 0, 0, 1, Color(0,0,0) )
		cam.End3D2D()

		surface.SetAlphaMultiplier( 1 )
	end
end
local function AmbHud_PlayerHud( ply )
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
				draw.SimpleTextOutlined( ply:GetNWString('amb_players_name'), "DermaLarge", 0, -15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			elseif ply:IsBot() then
				draw.SimpleTextOutlined( ply:Nick(), "DermaLarge", 0, -15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			else
				draw.SimpleTextOutlined( 'Заходит...', "DermaLarge", 0, -15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			end

			if ply:SteamID() == 'STEAM_0:1:95303327' then
				draw.SimpleTextOutlined( 'Шериф', "DermaLarge", 0, -64, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 255 ) )
			end

			if ply:GetNWBool("amb_bad") == true then
				draw.SimpleTextOutlined( "Bad Entity", "DermaLarge", 0, -45, Color( 200, 0, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			end
		cam.End3D2D()
	end
end

hook.Add( "PostPlayerDraw", "amb_0x16", function( ePly )
	AmbHud_PlayerHud( ePly )
end )