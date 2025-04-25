if SERVER then
	local access_string = "E2DICOVERY"
	access_string =  string.lower(access_string)

	if ULib ~= nil then
		--function ucl.registerAccess(	access,groups,comment,category	)

		ULib.ucl.registerAccess(access_string, {"admin", "superadmin"}, "Give access to E2 Viewer", "E2 Viewer")
	end
end