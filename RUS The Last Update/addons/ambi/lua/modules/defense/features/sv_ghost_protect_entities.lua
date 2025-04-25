hook.Add( 'PlayerSpawnedProp', 'Ambi.Defense.GhostProtectEntities', function( ePly, sMdl, eObj )
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.ghost_protect_entities_enable == false ) then return end
    if ( Config.ghost_protect_entities_spawned_freeze == false ) then return end
    if not Config.ghost_protect_entities_list[ eObj:GetClass() ] then return end

    local phys = eObj:GetPhysicsObject()
    if IsValid( phys ) then phys:EnableMotion( false ) end

    --eObj:SetCustomCollisionCheck( true )
end )

hook.Add( 'PlayerSpawnedSENT', 'Ambi.Defense.GhostProtectEntities', function( ePly, eObj )
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.ghost_protect_entities_enable == false ) then return end
    if ( Config.ghost_protect_entities_spawned_freeze == false ) then return end
    if not Config.ghost_protect_entities_list[ eObj:GetClass() ] then return end

    local phys = eObj:GetPhysicsObject()
    if IsValid( phys ) then phys:EnableMotion( false ) end

    --eObj:SetCustomCollisionCheck( true )
end )

hook.Add( 'PlayerSpawnedVehicle', 'Ambi.Defense.GhostProtectEntities', function( ePly, eObj )
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.ghost_protect_entities_enable == false ) then return end
    if ( Config.ghost_protect_entities_spawned_freeze == false ) then return end
    if not Config.ghost_protect_entities_list[ eObj:GetClass() ] then return end

    local phys = eObj:GetPhysicsObject()
    if IsValid( phys ) then phys:EnableMotion( false ) end

    --eObj:SetCustomCollisionCheck( true )
end )

hook.Add( 'ShouldCollide', 'Ambi.Defense.GhostProtectEntities', function( eObj1, eObj2 )
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.ghost_protect_entities_enable == false ) then return end
    
    --if Config.ghost_protect_entities_list[ eObj1:GetClass() ] and Config.ghost_protect_entities_list[ eObj2:GetClass() ] then return false end
end )

hook.Add( 'OnPhysgunPickup', 'Ambi.Defense.GhostProtectEntities', function( ePly, eObj )
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.ghost_protect_entities_enable == false ) then return end
    if ( Config.ghost_protect_entities_physgun_pickup_freeze == false ) then return end
    if not Config.ghost_protect_entities_list[ eObj:GetClass() ] then return end

    if not IsValid( eObj ) then return end

    eObj.old_collision, eObj.old_material = eObj.old_collision or eObj:GetCollisionGroup(), eObj.old_material or eObj:GetMaterial()

    eObj:SetCollisionGroup( COLLISION_GROUP_WORLD )
    eObj:SetMaterial( 'models/wireframe' )
end )

hook.Add( 'PhysgunDrop', 'Ambi.Defense.GhostProtectEntities', function( ePly, eObj )
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.ghost_protect_entities_enable == false ) then return end
    if ( Config.ghost_protect_entities_physgun_pickup_freeze == false ) then return end

    if not IsValid( eObj ) then return end
    if not Config.ghost_protect_entities_list[ eObj:GetClass() ] then return end

    --eObj:GetPhysicsObject():EnableMotion( false )

    local around_entities = ents.FindInSphere( eObj:LocalToWorld( eObj:OBBCenter() ), eObj:BoundingRadius() )
    for _, ent in ipairs( around_entities ) do
        if ent:IsPlayer() then return false end
    end

    eObj:SetCollisionGroup( eObj.old_collision or 0 )
    eObj:SetMaterial( eObj.old_material or '' )
    eObj.old_collision, eObj.old_material = nil
end )

hook.Add( 'OnPhysgunReload', 'Ambi.Defense.GhostProtectEntities', function( _, ePly )
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.ghost_protect_entities_enable == false ) then return end

    if ( Config.ghost_protect_entities_physgun_reload == false ) then ePly:ChatPrint( '[Defense] Массовый расфриз заблокирован!' ) return false end
end )