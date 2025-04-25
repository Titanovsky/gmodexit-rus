local classes = {
    [ 'prop_physics' ] = true,
    [ 'prop_dynamic' ] = true,
}

hook.Add( 'PlayerSpawnedProp', 'Ambi.Rus.PropDefense', function( ePly, sMdl, eObj )
    if ( ePly:GetLevel() >= 5 ) then return end

    local phys = eObj:GetPhysicsObject()
    if IsValid( phys ) then phys:EnableMotion( false ) end

    eObj:SetCustomCollisionCheck( true )
end )

hook.Add( 'ShouldCollide', 'Ambi.Rus.PropDefense', function( eObj1, eObj2 )
    if classes[ eObj1:GetClass() ] and classes[ eObj2:GetClass() ] then return false end
end )

hook.Add( 'OnPhysgunPickup', 'Ambi.Rus.PropDefense', function( ePly, eObj )
    if ( ePly:GetLevel() >= 5 ) then return end
    if not IsValid( eObj ) then return end

    eObj.old_collision, eObj.old_material = eObj.old_collision or eObj:GetCollisionGroup(), eObj.old_material or eObj:GetMaterial()

    eObj:SetCollisionGroup( COLLISION_GROUP_WORLD )
    eObj:SetMaterial( 'models/wireframe' )
end )

hook.Add( 'PhysgunDrop', 'Ambi.Rus.PropDefense', function( ePly, eObj )
    if ( ePly:GetLevel() >= 5 ) then return end
    if not IsValid( eObj ) then return end

    eObj:GetPhysicsObject():EnableMotion( false )

    local around_entities = ents.FindInSphere( eObj:LocalToWorld( eObj:OBBCenter() ), eObj:BoundingRadius() )
    for _, ent in ipairs( around_entities ) do
        if ent:IsPlayer() then return false end
    end

    eObj:SetCollisionGroup( eObj.old_collision or 0 )
    eObj:SetMaterial( eObj.old_material or '' )
    eObj.old_collision, eObj.old_material = nil
end )

hook.Add( 'OnPhysgunReload', 'Ambi.Rus.PropDefense', function( _, ePly)
    if ( ePly:GetLevel() < 10 ) then ePly:ChatPrint( 'Доступно с 10+ уровня!' ) return false end
end )