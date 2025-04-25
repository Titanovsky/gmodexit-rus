AmbPropCore = AmbPropCore or {}

AmbPropCore.max_dist = 32

hook.Add( 'PlayerSpawnedProp', 'FreezePropsOnSpawn', function( ePly, sModel, ent )

    local phys = ent:GetPhysicsObject()
    if IsValid( phys ) then 

        phys:EnableMotion( false ) 

    end

end )

--[[

hook.Add( 'PhysgunDrop', 'DropTheProp', function( ePly, ent )

    if ( ent:GetClass() == 'prop_physics' ) or ( ent:GetClass() == 'prop_dynamic' ) then

        local phys = ent:GetPhysicsObject()
        if IsValid( phys ) then 

            phys:EnableMotion( false ) 

        end

    end

end )

hook.Add( 'OnPhysgunReload', 'BlockReload', function( ePhysgun, ePly )

    return false

end )

AmbPropCore.conditions = { 

    freeze = function( ent )

        ent.save_mat = false
        ent:SetMaterial( 'models/wireframe' )
        ent:SetCollisionGroup( COLLISION_GROUP_WORLD )

    end,

    unfreeze = function( ent )

        ent.save_mat = true
        ent:SetMaterial( ent.original_mat )
        ent:SetCollisionGroup( COLLISION_GROUP_NONE )
        
    end

}

function AmbPropCore.PropCondition( eProp, nCondition )

    if ( nCondition == 1 ) then 

        AmbPropCore.conditions['freeze']( eProp ) 

    else

        AmbPropCore.conditions['unfreeze']( eProp )

    end

end

function AmbPropCore.PropCheck( ent, eCreator )

    local phys = ent:GetPhysicsObject()
    if IsValid( phys ) then

        phys:EnableMotion( false ) 

    end

    for _, ent2 in pairs( ents.FindInSphere( ent:GetPos(), ent:BoundingRadius() ) ) do

        if ent2:IsPlayer() and ent2:Alive() or ent2:IsNPC() then

            return AmbPropCore.PropCondition( ent, 1 )

        end

    end

    AmbPropCore.PropCondition( ent, 2 )

end

hook.Add( 'OnPhysgunPickup', 'amb_0x128', function( ePly, ent )

    if ( ent:GetClass() == 'prop_physics' or ent:GetClass() == 'prop_dynamic' ) then
    
        if ent.save_mat then ent.original_mat = ent:GetMaterial() end

        AmbPropCore.PropCondition( ent, 1, ent.original_mat )

    end

end )
]]