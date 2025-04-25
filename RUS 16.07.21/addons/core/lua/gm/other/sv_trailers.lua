local models = {
	[ 'models/gta_sa/industrial/artict1.mdl' ] = true,
	[ 'models/gta_sa/industrial/artict2a.mdl' ] = true,
	[ 'models/gta_sa/industrial/artict2.mdl' ] = true,
	[ 'models/gta_sa/industrial/artict3.mdl' ] = true,
	[ 'models/gta_sa/industrial/petrotr.mdl' ] = true
}

hook.Add( 'PlayerUse', 'AMB.VehicleDisconnecteTrailers', function( ePly, eObj )
	if IsValid( eObj ) and eObj:IsVehicle() and models[ eObj:GetModel() ] and eObj.is_connected and IsValid( eObj.connecter ) then 
		Trailers.DisconnectEnt( eObj.connecter )

		local return_color = eObj:GetColor()
		eObj:SetColor( Color( 255, 0, 0 ) )
		timer.Simple( 0.55, function()
			if not IsValid( eObj ) then return end

			eObj:SetColor( return_color )
		end )

		ePly:ChatPrint( 'Вы отцепили груз!' )
	end
end )