print("XUI")

hook.Add("InitPostEntity()", "ru_optimization_client", function() 
	local ply = LocalPlayer()

	ply:ConCommand("r_3dsky 0")
	ply:ConCommand("outfitter_enabled 0")
end)