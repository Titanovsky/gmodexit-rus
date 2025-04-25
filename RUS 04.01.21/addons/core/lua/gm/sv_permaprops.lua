AmbPermaProps = AmbPermaProps or {}
AmbPermaProps.Entities = AmbPermaProps.Entities or {}

AmbPermaProps.Entities = {

	{ class = 'npc_igs', pos = Vector( 3059, -8065, -4 ), ang = Angle( 0, 140, 0 ), map = 'gm_blesmont' },
	{ class = 'npc_igs', pos = Vector( 10308, -10029, -8 ), ang = Angle( 0, -180, 0 ), map = 'gm_blesmont' },
	{ class = 'npc_igs', pos = Vector( -6107, 9293, 1024 ), ang = Angle( 0, -80, 0 ), map = 'gm_blesmont' },
	{ class = 'amb_npc_shop_skin', pos = Vector( 2382, -11001, -8 ), ang = Angle( 0, 90, 0 ), map = 'gm_blesmont' },

	{ class = 'npc_igs', pos = Vector( -4391, -2983, 250 ), ang = Angle( 0, -64, 0 ), map = 'gm_construct' },
	{ class = 'npc_igs', pos = Vector( 1737, -1627, -144 ), ang = Angle( 0, -180, 0 ), map = 'gm_construct' },
	{ class = 'npc_igs', pos = Vector( 1711, 6325, -31 ), ang = Angle( 0, -135, 0 ), map = 'gm_construct' },

	{ class = 'npc_igs', pos = Vector( 94, -974, -12785 ), ang = Angle( 0, 90, 0 ), map = 'gm_flatgrass' },
	{ class = 'npc_igs', pos = Vector( 5, 984, -12785 ), ang = Angle( 0, -90, 0 ), map = 'gm_flatgrass' },
	{ class = 'npc_igs', pos = Vector( 58, 23, -12281 ), ang = Angle( 0, math.random( -90, 90 ), 0 ), map = 'gm_flatgrass' },

	{ class = 'npc_igs', pos = Vector( 1551, -9325, -8825 ), ang = Angle( 0, -90, 0 ), map = 'gm_genesis' },
	{ class = 'npc_igs', pos = Vector( 4647, 1082, -8188 ), ang = Angle( 0, 180, 0 ), map = 'gm_genesis' },
	{ class = 'npc_igs', pos = Vector( -9359, 14088, -8107 ), ang = Angle( 0, 0, 0 ), map = 'gm_genesis' },

	{ class = 'npc_igs', pos = Vector( -8778, -8051, 196 ), ang = Angle( 0, -90, 0 ), map = 'gm_rus' },
	{ class = 'npc_igs', pos = Vector( 4630, -3638, 564 ), ang = Angle( 0, -180, 0 ), map = 'gm_rus' },
	{ class = 'npc_igs', pos = Vector( 7108, -7947, 557 ), ang = Angle( 0, 90, 0 ), map = 'gm_rus' },

	{ class = 'npc_igs', pos = Vector( -4886, 11540, -2420 ), ang = Angle( 0, 60, 0 ), map = 'gm_eastern_dunes01a' },
	{ class = 'npc_igs', pos = Vector( 4434, 3004, -154 ), ang = Angle( 0, 180, 0 ), map = 'gm_eastern_dunes01a' },
	{ class = 'npc_igs', pos = Vector( 8922, -5550, -1817 ), ang = Angle( 0, 175, 0 ), map = 'gm_eastern_dunes01a' },
	{ class = 'npc_igs', pos = Vector( 5199, 1136, -2038 ), ang = Angle( 0, 180, 0 ), map = 'gm_eastern_dunes01a' },
	{ class = 'npc_igs', pos = Vector( 5671, 8370, -2028 ), ang = Angle( 0, 90, 0 ), map = 'gm_eastern_dunes01a' },

	{ class = 'npc_igs', pos = Vector( 1867, -8567, 562 ), ang = Angle( 0, -180, 0 ), map = 'gm_rus_alter' },
	{ class = 'npc_igs', pos = Vector( 5698, -2788, 551 ), ang = Angle( 0, 180, 0 ), map = 'gm_rus_alter' },
	{ class = 'npc_igs', pos = Vector( 6968, 2247, 556 ), ang = Angle( 0, -90, 0 ), map = 'gm_rus_alter' },

}

function AmbPermaProps.Spawn()

	for name, v in ipairs( AmbPermaProps.Entities ) do

		if ( v.map ~= game.GetMap() ) then continue end
		
		local ent = ents.Create( v.class )
		ent:SetPos( v.pos )
		ent:SetAngles( v.ang )
		ent:Spawn()

		print( '[AmbPerma] Spawned Entity: '..v.class )

	end

end


hook.Add( 'PostCleanupMap', 'SpawnEntsAfterCleanUp', function() AmbPermaProps.Spawn() end)
hook.Add( 'Initialize', 'SpawnPermaEnts', function()

	timer.Simple( 2, function() AmbPermaProps.Spawn() end)

end)