if ( AMB.config.module_permaprops == false ) then return end

AmbPermaProps = AmbPermaProps or {}
AmbPermaProps.Entities = AmbPermaProps.Entities or {}

AmbPermaProps.Entities = {
	['amb_npc_job_employer'] = { Vector( 587, -11736, -2 ), Angle( 0, 135, 0 ) },
	['amb_npc_shop_skin'] = { Vector( -334, -11727, 1 ), Angle( 0, 30, 0 ) },
	['npc_igs']	= { Vector( 123, -11728, -12 ), Angle( 0, 90, 0 ) },
}

AmbPermaProps.Props = {
	--{  'models/hunter/plates/plate5x7.mdl', Vector( 7033, -2737, 663 ), Angle( 90, -90, 180 ), true },
	--{  'models/hunter/plates/plate1x1.mdl', Vector( 7141, -2170, 593 ), Angle( 45, 180, 0 ), true },
	--{  'models/hunter/plates/plate1x1.mdl', Vector( 7085, -2423, 580 ), Angle( 45, 180, 0 ), true }
}

function AmbPermaProps.spawn()
	for name, v in pairs( AmbPermaProps.Entities ) do

		for k, vv in pairs( ents.GetAll() ) do
			if name == vv:GetClass() then vv:Remove() end
		end

		local ent = ents.Create( name )
		ent:SetPos( v[1] )
		ent:SetAngles( v[2] )
		ent:Spawn()
		print( '[AmbPerma] Spawned ent: '..name )
	end

	for k, prop in pairs( AmbPermaProps.Props ) do

		for _, vv in pairs( ents.GetAll() ) do
			if prop[1] == vv:GetClass() then vv:Remove() end
		end

		local perma_prop = ents.Create('prop_physics')
		perma_prop:SetModel( prop[1] )
		perma_prop:SetPos( prop[2] )
		perma_prop:SetAngles( prop[3] )
		if ( v[4] ) then
			perma_prop:PhysicsInit( SOLID_VPHYSICS )
			perma_prop:SetMoveType( MOVETYPE_NONE )
			local phys = self:GetPhysicsObject()
			if ( IsValid( phys ) ) then phys:EnableMotion( false ) end
		else
			perma_prop:PhysicsInit( SOLID_VPHYSICS )
			perma_prop:SetMoveType( MOVETYPE_VPHYSICS )
		end
		print( '[AmbPerma] Spawned prop: '..v[1] )
	end
end

hook.Add( "PostCleanupMap", "amb_0x32", function()
	AmbPermaProps.spawn()
end)

hook.Add( "Initialize", "amb_0x32", function()
	timer.Simple( 2, function()
		AmbPermaProps.spawn()
	end)
end)