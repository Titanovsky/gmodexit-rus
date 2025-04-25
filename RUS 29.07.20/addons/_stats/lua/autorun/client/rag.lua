hook.Add( "CreateClientsideRagdoll", "fade_out_corpses", function( entity, ragdoll )

	ragdoll:SetSaveValue( "m_bFadingOut", true )

end )

