AmbPropCore = AmbPropCore or {}

AmbPropCore.max_dist = 32

hook.Add( 'PlayerSpawnedProp', 'FreezePropsOnSpawn', function( ePly, sModel, ent )

    local phys = ent:GetPhysicsObject()
    if IsValid( phys ) then 

        phys:EnableMotion( false ) 

    end

end )


hook.Add( 'PhysgunDrop', 'DropTheProp', function( ePly, eObj )

    if ( eObj:GetClass() == 'prop_physics' ) or ( eObj:GetClass() == 'prop_dynamic' ) then

        if ( AmbStats.Players.getStats( ePly, '!' ) < 10 ) then

            local phys = eObj:GetPhysicsObject()
            if IsValid( phys ) then 

                phys:EnableMotion( false ) 

            end

        end

    end

end )

hook.Add( 'PhysgunPickup', 'PickUpProp', function( ePly, eObj )

    if ( eObj:GetClass() == 'prop_physics' ) or ( eObj:GetClass() == 'prop_dynamic' ) then

        if ( AmbStats.Players.getStats( ePly, '!' ) < 10 ) then

            local phys = eObj:GetPhysicsObject()
            if IsValid( phys ) then 

                phys:EnableMotion( false ) 

            end

        end

    end

end )

hook.Add( 'PlayerInitialSpawn', 'AmbPropProtectionOnSpawnWarningOnDisableProps', function( ePly )

    timer.Simple( 20, function() 
        
        if ( AmbStats.Players.getStats( ePly, '!' ) > 10 ) then return end
        if not IsValid( ePly ) then return end

        AmbLib.notifySend( ePly, 'Вы не сможете расфризить пропы, пока не достигните 10 уровня!', 2, 128, 'buttons/button5.wav' ) 
            
    end )
        
end )

hook.Add( 'PlayerSpawnedProp', 'AmbPropProtectionPropToPropSetCollision', function( ePly, _, eProp )

    if ( tonumber( ePly:GetNWInt( 'amb_players_level' ) ) < 10 ) then eProp:SetCustomCollisionCheck( true ) end

end )

hook.Add( 'ShouldCollide', 'AmbPropProtectionPropToProp', function( ePropFirst, ePropSecond )

    if IsValid( ePropFirst ) and ( ePropFirst:GetClass() == 'prop_physics' ) and IsValid( ePropSecond ) and ( ePropSecond:GetClass() == 'prop_physics' ) then return false end

end )