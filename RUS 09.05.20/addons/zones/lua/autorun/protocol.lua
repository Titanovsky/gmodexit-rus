zone = zone or { Data = {} }

if ( SERVER ) then
	include( "zone/sv_init.lua")
	AddCSLuaFile( "zone/cl_init.lua" )
	
	include( "zone/shared.lua" )
	AddCSLuaFile( "zone/shared.lua" )
	
	include( "zone/config.lua" )
	AddCSLuaFile( "zone/config.lua" )
else
	include( "zone/shared.lua" )
	include( "zone/cl_init.lua" )
	include( "zone/config.lua" )
end