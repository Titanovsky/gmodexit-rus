hook.Add("HUDPaint", "ru_hud_build_mode", function() 
	local ply = LocalPlayer()
	local buildmode = ply:GetNWBool("IsBuild")
	local w = ScrW()
	local h = ScrH()

	local COLOR_TEXT = Color( 255, 255, 255 )
	local COLOR_OUTLINE = Color( 57, 181, 4 )

	if buildmode == true then
		draw.SimpleTextOutlined( "Build", "ZN", w * 0.14, h * 0.96, COLOR_TEXT, 1, 1, 1, COLOR_OUTLINE)
	end
end)