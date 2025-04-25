Ambi.RegEntity = Ambi.RegEntity or {}

local C, Gen = Ambi.General.Global.Colors, Ambi.General

function Ambi.RegEntity.Create( sClass, sType, sPrintName, sCategory, bSpawnable, bHasPhysics, sModel, sMat, cColor, nUseType, nRenderMode, bDropToFloor, nMoveType, nPhysicInit, nCollisionGroup, bEnableMotion, bWake, bSleep )
    -- todo
end

function Ambi.RegEntity.Initialize( eObj, sModel, sMat, cColor, nUseType, nRenderMode, bDropToFloor )
    sMat = sMat or ''
    cColor = cColor or C.ABS_WHITE
    nUseType = nUseType or SIMPLE_USE
    nRenderMode = nRenderMode or RENDERMODE_NORMAL

    if sModel then eObj:SetModel( sModel ) end
    eObj:SetMaterial( sMat )
    eObj:SetColor( cColor )
    eObj:SetUseType( nUseType )
    eObj:SetRenderMode( nRenderMode )
    if bDropToFloor then eObj:DropToFloor() end

    return eObj
end

function Ambi.RegEntity.Physics( eObj, nMoveType, nPhysicInit, nCollisionGroup, bEnableMotion, bWake, bSleep ) -- old name
    -- for NPC: Ambi.RegEntity.Physics( self, MOVETYPE_NONE, SOLID_BBOX, COLLISION_GROUP_PLAYER, false )
    
    nMoveType = nMoveType or MOVETYPE_VPHYSICS
    nPhysicInit = nPhysicInit or SOLID_VPHYSICS
    nCollisionGroup = nCollisionGroup or COLLISION_GROUP_NONE

    eObj:SetMoveType( nMoveType )
    eObj:PhysicsInit( nPhysicInit )
    eObj:SetCollisionGroup( nCollisionGroup )

    local phys = eObj:GetPhysicsObject()
    if IsValid( phys ) then 
        phys:EnableMotion( bEnableMotion ) 
        if bWake then phys:Wake() end
        if bSleep then phys:Sleep() end
    end

    return phys
end

function Ambi.RegEntity.SetPhysics( eObj, nMoveType, nPhysicInit, nCollisionGroup, bEnableMotion, bWake, bSleep )
    return Ambi.RegEntity.Physics( eObj, nMoveType, nPhysicInit, nCollisionGroup, bEnableMotion, bWake, bSleep )
end

function Ambi.RegEntity.SetPhysicsNPC( eObj, nMoveType, nPhysicInit, nCollisionGroup, bEnableMotion, bWake, bSleep )
    return Ambi.RegEntity.Physics( eObj, MOVETYPE_NONE, SOLID_BBOX, COLLISION_GROUP_PLAYER, false )
end

function Ambi.RegEntity.Capability( eObj, nCap ) -- old name
    if not nCap then Gen.Error( 'Entities', 'Capability not found' ) return end

    eObj:CapabilitiesAdd( nCap )

    return eObj
end

function Ambi.RegEntity.SetCapability( eObj, nCap )
    return Ambi.RegEntity.Capability( eObj, nCap )
end

function Ambi.RegEntity.Hull( eObj, nHullType ) -- old name
    nHullType = nHullType or HULL_HUMAN

    eObj:SetHullType( nHullType )
	eObj:SetHullSizeNormal()

    return eObj
end

function Ambi.RegEntity.SetHull( eObj, nHullType )
    return Ambi.RegEntity.Hull( eObj, nHullType )
end