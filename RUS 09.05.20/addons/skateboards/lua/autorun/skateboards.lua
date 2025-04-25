
AddCSLuaFile()

if ( SERVER ) then

	CreateConVar( "sbox_maxskateboards", 1, { FCVAR_NOTIFY, FCVAR_ARCHIVE } )
	CreateConVar( "sv_skateboard_adminonly", 0, { FCVAR_NOTIFY, FCVAR_ARCHIVE } )
	CreateConVar( "sv_skateboard_cansteal", 0, { FCVAR_NOTIFY, FCVAR_ARCHIVE } )
	CreateConVar( "sv_skateboard_canshare", 1, { FCVAR_NOTIFY, FCVAR_ARCHIVE } )
	//CreateConVar( "sv_skateboard_points", "45", { FCVAR_NOTIFY, FCVAR_ARCHIVE } )
	CreateConVar( "sv_skateboard_canfall", "1", { FCVAR_NOTIFY, FCVAR_ARCHIVE } )

else
	CreateConVar( "cl_skateboard_developer", "0", FCVAR_CHEAT )

	language.Add( "modulus_skateboard", "Skateboard" )
	language.Add( "modulus_skateboard_hull", "Skateboard" )
	language.Add( "modulus_skateboard_avatar", "Skateboard" )

	killicon.Add( "modulus_skateboard", "modulus_skateboard/deathicon", Color( 255, 80, 0, 255 ) )
	killicon.AddAlias( "modulus_skateboard_hull", "modulus_skateboard" )
	killicon.AddAlias( "modulus_skateboard_avatar", "modulus_skateboard" )
end

/* ------------------------------------------------
	Skateboard Types
------------------------------------------------ */

SkateboardTypes = {}

table.insert( SkateboardTypes, {
	
	model = "models/skateboard/skateboard.mdl",
	name = "Garry's Board",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/models/skateboard/skate_deck.vmt",
		"materials/models/skateboard/skate_deck.vtf",
		"materials/models/skateboard/skate_misc.vmt",
		"materials/models/skateboard/skate_misc.vtf",
	}
} )



table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/oth10/skateboa10.mdl",
	name = "Stripes",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/oth10/metal_galv.vmt",
		"materials/hexedskate/oth10/metal_galv.vtf",
		"materials/hexedskate/oth10/metal_galv2.vmt",
		"materials/hexedskate/oth10/metal_galv2.vtf",
		"materials/hexedskate/oth10/skate_deck.vmt",
		"materials/hexedskate/oth10/skate_deck.vtf",
		"materials/hexedskate/oth10/skate_misc.vmt",
		"materials/hexedskate/oth10/skate_misc.vtf",
	}
} )

table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/oth11/skateboa11.mdl",
	name = "Element",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/oth11/metal_galv.vmt",
		"materials/hexedskate/oth11/metal_galv.vtf",
		"materials/hexedskate/oth11/metal_galv2.vmt",
		"materials/hexedskate/oth11/metal_galv2.vtf",
		"materials/hexedskate/oth11/skate_deck.vmt",
		"materials/hexedskate/oth11/skate_deck.vtf",
		"materials/hexedskate/oth11/skate_misc.vmt",
		"materials/hexedskate/oth11/skate_misc.vtf",
	}
} )

table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/oth12/skateboa12.mdl",
	name = "Blind",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/oth12/metal_galv.vmt",
		"materials/hexedskate/oth12/metal_galv.vtf",
		"materials/hexedskate/oth12/metal_galv2.vmt",
		"materials/hexedskate/oth12/metal_galv2.vtf",
		"materials/hexedskate/oth12/skate_deck.vmt",
		"materials/hexedskate/oth12/skate_deck.vtf",
		"materials/hexedskate/oth12/skate_misc.vmt",
		"materials/hexedskate/oth12/skate_misc.vtf",
	}
} )

table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/othe2/skateboar2.mdl",
	name = "Habitat",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/othe2/metal_galv.vmt",
		"materials/hexedskate/othe2/metal_galv.vtf",
		"materials/hexedskate/othe2/metal_galv2.vmt",
		"materials/hexedskate/othe2/metal_galv2.vtf",
		"materials/hexedskate/othe2/skate_deck.vmt",
		"materials/hexedskate/othe2/skate_deck.vtf",
		"materials/hexedskate/othe2/skate_misc.vmt",
		"materials/hexedskate/othe2/skate_misc.vtf",
	}
} )

table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/othe3/skateboar3.mdl",
	name = "Bubbles",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/othe3/metal_galv.vmt",
		"materials/hexedskate/othe3/metal_galv.vtf",
		"materials/hexedskate/othe3/metal_galv2.vmt",
		"materials/hexedskate/othe3/metal_galv2.vtf",
		"materials/hexedskate/othe3/skate_deck.vmt",
		"materials/hexedskate/othe3/skate_deck.vtf",
		"materials/hexedskate/othe3/skate_misc.vmt",
		"materials/hexedskate/othe3/skate_misc.vtf",
	}
} )


table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/othe4/skateboar4.mdl",
	name = "Template",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/othe4/metal_galv.vmt",
		"materials/hexedskate/othe4/metal_galv.vtf",
		"materials/hexedskate/othe4/metal_galv2.vmt",
		"materials/hexedskate/othe4/metal_galv2.vtf",
		"materials/hexedskate/othe4/skate_deck.vmt",
		"materials/hexedskate/othe4/skate_deck.vtf",
		"materials/hexedskate/othe4/skate_misc.vmt",
		"materials/hexedskate/othe4/skate_misc.vtf",
	}
} )

table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/othe5/skateboar5.mdl",
	name = "Skullhawk",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/othe5/metal_galv.vmt",
		"materials/hexedskate/othe5/metal_galv.vtf",
		"materials/hexedskate/othe5/metal_galv2.vmt",
		"materials/hexedskate/othe5/metal_galv2.vtf",
		"materials/hexedskate/othe5/skate_deck.vmt",
		"materials/hexedskate/othe5/skate_deck.vtf",
		"materials/hexedskate/othe5/skate_misc.vmt",
		"materials/hexedskate/othe5/skate_misc.vtf",
	}
} )

table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/othe6/skateboar6.mdl",
	name = "Iron Flip",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/othe6/metal_galv.vmt",
		"materials/hexedskate/othe6/metal_galv.vtf",
		"materials/hexedskate/othe6/metal_galv2.vmt",
		"materials/hexedskate/othe6/metal_galv2.vtf",
		"materials/hexedskate/othe6/skate_deck.vmt",
		"materials/hexedskate/othe6/skate_deck.vtf",
		"materials/hexedskate/othe6/skate_misc.vmt",
		"materials/hexedskate/othe6/skate_misc.vtf",
	}
} )


table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/othe7/skateboar7.mdl",
	name = "Clockwork",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/othe7/metal_galv.vmt",
		"materials/hexedskate/othe7/metal_galv.vtf",
		"materials/hexedskate/othe7/metal_galv2.vmt",
		"materials/hexedskate/othe7/metal_galv2.vtf",
		"materials/hexedskate/othe7/skate_deck.vmt",
		"materials/hexedskate/othe7/skate_deck.vtf",
		"materials/hexedskate/othe7/skate_misc.vmt",
		"materials/hexedskate/othe7/skate_misc.vtf",
	}
} )

table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/othe8/skateboar8.mdl",
	name = "Work",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/othe8/metal_galv.vmt",
		"materials/hexedskate/othe8/metal_galv.vtf",
		"materials/hexedskate/othe8/metal_galv2.vmt",
		"materials/hexedskate/othe8/metal_galv2.vtf",
		"materials/hexedskate/othe8/skate_deck.vmt",
		"materials/hexedskate/othe8/skate_deck.vtf",
		"materials/hexedskate/othe8/skate_misc.vmt",
		"materials/hexedskate/othe8/skate_misc.vtf",
	}
} )

table.insert( SkateboardTypes, {
	
	model = "models/hexedskate/othe9/skateboar9.mdl",
	name = "Fire",
	rotation = 90,
	driver = Vector( 0, 2, 1.5 ),
	files = {
		"materials/hexedskate/othe9/metal_galv.vmt",
		"materials/hexedskate/othe9/metal_galv.vtf",
		"materials/hexedskate/othe9/metal_galv2.vmt",
		"materials/hexedskate/othe9/metal_galv2.vtf",
		"materials/hexedskate/othe9/skate_deck.vmt",
		"materials/hexedskate/othe9/skate_deck.vtf",
		"materials/hexedskate/othe9/skate_misc.vmt",
		"materials/hexedskate/othe9/skate_misc.vtf",
	}
} )