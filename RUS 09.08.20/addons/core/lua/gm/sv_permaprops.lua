AmbPermaProps = AmbPermaProps or {}
AmbPermaProps.Entities = AmbPermaProps.Entities or {}

AmbPermaProps.Entities = {
	['amb_npc_job_employer'] 	= { Vector( -23.364155, -12194.981445, -7.968750 ), Angle( 0, -90, 0 ) },
	['npc_igs']	= { Vector( -146.024368, -13885.052734, -7.968750 ), Angle( 0, -90, 0 ) },
	--['prop_physics'] 			= { Vector( 51.820198, -12410.330078, -3.768761 ), Angle( 0, 90, 90 ), 'models/props_borealis/mooring_cleat01.mdl' }
}

function AmbPermaProps.spawn()
	for name, v in pairs( AmbPermaProps.Entities ) do
		for k, vv in pairs( ents.GetAll() ) do
			if name == vv:GetClass() then vv:Remove() end
		end
		local ent = ents.Create( name )
		ent:SetPos( v[1] )
		ent:SetAngles( v[2] )
		if v[3] then
			ent:SetModel( v[3] )
			-- todo: добавить мувитайп и солид нормальный и физику.
		end
		ent:Spawn()
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