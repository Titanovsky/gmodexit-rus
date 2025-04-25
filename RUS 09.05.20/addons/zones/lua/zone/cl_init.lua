surface.CreateFont( "ZN", {
	font = "Tahoma",
	size = 24,
	weight = 2,
	antialias = true,
} )

local COLOR_SAFE = Color(0, 138, 212, 150)

hook.Add( "PostDrawOpaqueRenderables", "zone_RenderDraw", function()
	for k,v in pairs( zone.Data ) do
		if ( v.Status == "safe" ) then
			render.DrawWireframeBox( v.Center, Angle( 0, 0, 0 ), v.SizeBackwards, v.SizeForwards, COLOR_SAFE, true )
		elseif ( v.Status == "build" ) then
			render.DrawWireframeBox( v.Center, Angle( 0, 0, 0 ), v.SizeBackwards, v.SizeForwards, Color( 224, 167, 61, 0), true )
		elseif ( v.Status == "base" ) then
			render.DrawWireframeBox( v.Center, Angle( 0, 0, 0 ), v.SizeBackwards, v.SizeForwards, Color(150, 0, 0), true )
		end
	end
end )

timer.Create( "zone_start", 0.4, 0, function()
	if ( !IsValid( LocalPlayer() ) or !LocalPlayer().GetPos ) then return end
	
	zone.DrawHUDSafe = zone:InsideSafeZone( LocalPlayer():GetPos() )
	zone.DrawHUDBuild = zone:InsideBuildZone( LocalPlayer():GetPos() )
	zone.DrawHUDBase = zone:InsideBaseZone( LocalPlayer():GetPos() )
end )

local w = ScrW()
local h = ScrH()

hook.Add( "HUDPaint", "zone_ClientDraw", function()
	
	local ply = LocalPlayer()
	local buildmode = ply:GetNWBool("IsBuild")
	
	if ( zone.DrawHUDSafe ) and buildmode == false then
		draw.SimpleTextOutlined( "Зона Спавна", "ZN", w * 0.14, h * 0.96, Color( 255,255,255 ), 1, 1, 1, COLOR_SAFE )
	end
end )