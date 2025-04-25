hook.Add( "EntityTakeDamage", "zone_NotDamage!", function( targ, dmg )
	if ( zone:InsideSafeZone( targ:GetPos() ) ) then
		dmg:SetDamage( 0 )
	end

	local attacker = dmg:GetAttacker()
	if IsValid(attacker) and ( zone:InsideSafeZone( attacker:GetPos() ) )  then
		dmg:SetDamage( 0 )
	end

	local infl = dmg:GetInflictor()
	if IsValid(infl) and ( zone:InsideSafeZone( infl:GetPos() ) ) then
		dmg:SetDamage( 0 )
	end
end )


hook.Add("PlayerSpawnObject", "not_SpawnInSpawn", function( ply, mdl )
	if ( zone:InsideSafeZone( ply:GetPos() ) ) then
		return false
	end
end)


