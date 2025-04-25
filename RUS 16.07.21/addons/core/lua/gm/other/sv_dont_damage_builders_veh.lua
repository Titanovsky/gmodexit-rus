
-- Others

hook.Add( 'EntityTakeDamage', 'AMB.VehicleDontDamageForBuilders', function( eObj, dmgInfo )
	if not eObj:IsVehicle() then return end

	local driver = eObj:GetDriver()
	if IsValid( driver ) and ( driver:Team() == AMB_TEAM_BUILD ) then return true end
end )