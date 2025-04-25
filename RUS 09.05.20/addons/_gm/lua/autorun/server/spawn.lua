local spawn_pos = {
	Vector( -4055, -3095, 385 ),
	Vector( -4237, -3095, 385 ),
	Vector( -4457, -3095, 385 ),
	Vector( -4622, -3095, 385 ),
	Vector( -4017, -3295, 385 ),
	Vector( -4237, -3295, 385 ),
	Vector( -4457, -3295, 385 ),
	Vector( -4622, -3295, 385 ),
	Vector( -4017, -3495, 385 ),
	Vector( -4237, -3495, 385 ),
	Vector( -4457, -3495, 385 ),
	Vector( -4622, -3495, 385 ),
}

hook.Add( "PlayerSpawn", "ru_spawn_post_death", function( ply, tr )
	ply:SetPos( table.Random( spawn_pos ) )
	ply:SetEyeAngles( Angle( 0, 90, 0 ) )
end)

hook.Add( "PlayerLoadout", "ru_loadout", function( ply )

	ply:Give( "weapon_physgun" )
	ply:Give( "weapon_physcannon" )
	ply:Give( "gmod_tool" )

	return true
end)