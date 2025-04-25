hook.Add("InitPostEntity", "ru_optimization_client", function()

	RunConsoleCommand("outfitter_enabled", "0")
	RunConsoleCommand("r_3dsky", "0")
end)