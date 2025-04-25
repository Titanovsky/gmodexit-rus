local C = Ambi.General.Global.Colors
local ADMINS = {
    [ 'superadmin' ] = true,
    [ 'admin' ] = true,
    [ 'ahc' ] = true,
    [ 'officer' ] = true,
}

Ambi.Rus.restrict_items = Ambi.Rus.restrict_items or {}

-- ------------------------------------------------------------------------------
hook.Add( 'PlayerSpawnSENT', 'Ambi.Rus.Restrict', function( ePly, sClass )
    local info = Ambi.Rus.restrict_items[ 'Entities' ][ sClass ]
    if not info then return end

    if info.level and ( ePly:GetLevel() < info.level ) then ePly:ChatSend( C.AMBI_RED, 'Вам нужен '..info.level..' уровень' ) return false end
    if info.delay and timer.Exists( 'DelayFor:'..sClass..':'..ePly:SteamID() ) then ePly:NotifySend( Ambi.Rus.Config.notify_type, { time = 5, text = 'Подождите '..math.Round( timer.TimeLeft( 'DelayFor:'..sClass..':'..ePly:SteamID() ) ), color = C.AMBI_RED } ) return false end
    if info.admin and not ADMINS[ ePly:GetUserGroup() ] then ePly:ChatSend( C.AMBI_RED, 'Доступно только для админ-рангов!' ) return false end
end )

hook.Add( 'PlayerSpawnedSENT', 'Ambi.Rus.Restrict', function( ePly, eObj ) 
    local class = eObj:GetClass()
    local info = Ambi.Rus.restrict_items[ 'Entities' ][ class ]
    if not info then return end

    if info.delay then
        timer.Create( 'DelayFor:'..class..':'..ePly:SteamID(), info.delay, 1, function() end )
    end

    if ( ePly:GetLevel() < 5 ) then -- Защита
        local phys = eObj:GetPhysicsObject()
        if IsValid( phys ) then 
            phys:EnableMotion( false ) 
            phys:Sleep()
        end
    end
end )

-- ------------------------------------------------------------------------------
hook.Add( 'PlayerSpawnVehicle', 'Ambi.Rus.Restrict', function( ePly, _, sName ) 
    local info = Ambi.Rus.restrict_items[ 'Cars' ][ sClass ]
    if not info then return end

    if info.level and ( ePly:GetLevel() < info.level ) then ePly:ChatSend( C.AMBI_RED, 'Вам нужен '..info.level..' уровень' ) return false end
    if info.delay and timer.Exists( 'DelayFor:'..sClass..':'..ePly:SteamID() ) then ePly:NotifySend( Ambi.Rus.Config.notify_type, { time = 5, text = 'Подождите '..math.Round( timer.TimeLeft( 'DelayFor:'..sClass..':'..ePly:SteamID() ) ), color = C.AMBI_RED } ) return false end
    if info.admin and not ADMINS[ ePly:GetUserGroup() ] then ePly:ChatSend( C.AMBI_RED, 'Доступно только для админ-рангов!' ) return false end
end )

hook.Add( 'PlayerSpawnedVehicle', 'Ambi.Rus.Restrict', function( ePly, eObj ) 
    local class = simfphys.IsCar( eObj ) and eObj.VehicleName or eObj:GetVehicleClass()
    local info = Ambi.Rus.restrict_items[ 'Cars' ][ class ]
    if not info then return end

    if info.delay then
        timer.Create( 'DelayFor:'..class..':'..ePly:SteamID(), info.delay, 1, function() end )
    end
end )

-- ------------------------------------------------------------------------------
hook.Add( 'PlayerSpawnNPC', 'Ambi.Rus.Restrict', function( ePly, sClass ) 
    local info = Ambi.Rus.restrict_items[ 'NPC' ][ sClass ]
    if not info then return end

    if info.delay and timer.Exists( 'DelayFor:'..sClass..':'..ePly:SteamID() ) then ePly:NotifySend( Ambi.Rus.Config.notify_type, { time = 5, text = 'Подождите '..math.Round( timer.TimeLeft( 'DelayFor:'..sClass..':'..ePly:SteamID() ) ), color = C.AMBI_RED } ) return false end
    if info.admin and not ADMINS[ ePly:GetUserGroup() ] then ePly:ChatSend( C.AMBI_RED, 'Доступно только для админ-рангов!' ) return false end
end )

hook.Add( 'PlayerSpawnedNPC', 'Ambi.Rus.Restrict', function( ePly, eObj ) 
    local class = eObj:GetClass()
    local info = Ambi.Rus.restrict_items[ 'NPC' ][ class ]
    if not info then return end

    if info.delay then
        timer.Create( 'DelayFor:'..class..':'..ePly:SteamID(), info.delay, 1, function() end )
    end

    eObj:SetKeyValue( 'spawnflags', bit.bor( 8192, 262144, 131072 ) ) -- Workaround
end )

-- ------------------------------------------------------------------------------
hook.Add( 'PlayerSpawnSWEP', 'Ambi.Rus.Restrict', function( ePly, sClass )
    local info = Ambi.Rus.restrict_items[ 'Guns' ][ sClass ]
    if not info then return end

    if info.level and ( ePly:GetLevel() < info.level ) then ePly:ChatSend( C.AMBI_RED, 'Вам нужен '..info.level..' уровень' ) return false end
    if info.delay and timer.Exists( 'DelayFor:'..sClass..':'..ePly:SteamID() ) then ePly:NotifySend( Ambi.Rus.Config.notify_type, { time = 5, text = 'Подождите '..math.Round( timer.TimeLeft( 'DelayFor:'..sClass..':'..ePly:SteamID() ) ), color = C.AMBI_RED } ) return false end
    if info.admin and not ADMINS[ ePly:GetUserGroup() ] then ePly:ChatSend( C.AMBI_RED, 'Доступно только для админ-рангов!' ) return false end

    if info.delay then
        timer.Create( 'DelayFor:'..sClass..':'..ePly:SteamID(), info.delay, 1, function() end )
    end
end )

hook.Add( 'PlayerGiveSWEP', 'Ambi.Rus.Restrict', function( ePly, sClass )
    local info = Ambi.Rus.restrict_items[ 'Guns' ][ sClass ]
    if not info then return end

    if info.level and ( ePly:GetLevel() < info.level ) then ePly:ChatSend( C.AMBI_RED, 'Вам нужен '..info.level..' уровень' ) return false end
    if info.delay and timer.Exists( 'DelayFor:'..sClass..':'..ePly:SteamID() ) then ePly:NotifySend( Ambi.Rus.Config.notify_type, { time = 5, text = 'Подождите '..math.Round( timer.TimeLeft( 'DelayFor:'..sClass..':'..ePly:SteamID() ) ), color = C.AMBI_RED } ) return false end
    if info.admin and not ADMINS[ ePly:GetUserGroup() ] then ePly:ChatSend( C.AMBI_RED, 'Доступно только для админ-рангов!' ) return false end

    if info.delay then
        timer.Create( 'DelayFor:'..sClass..':'..ePly:SteamID(), info.delay, 1, function() end )
    end
end )

-- ------------------------------------------------------------------------------
hook.Add( 'CanTool', 'Ambi.Rus.Restrict', function( ePly, _, sTool ) 
    local info = Ambi.Rus.restrict_items[ 'Tools' ][ sTool ]
    if not info then return end

    if info.level and ( ePly:GetLevel() < info.level ) then ePly:ChatSend( C.AMBI_RED, 'Вам нужен '..info.level..' уровень' ) return false end
    if info.access and ( ePly:GetAccess() < info.access ) then ePly:ChatSend( C.AMBI_RED, 'Вам нужна '..info.access..' аксеса' ) return false end
    if info.admin and not ADMINS[ ePly:GetUserGroup() ] then ePly:ChatSend( C.AMBI_RED, 'Доступно только для админ-рангов!' ) return false end
end )

-- ------------------------------------------------------------------------------
hook.Add( 'CanProperty', 'Ambi.Rus.Restrict', function( ePly, sProperty, eObj )
    if not FPP then return end
    if ( eObj:CPPIGetOwner() == ePly ) then return end
    if ePly:IsSuperAdmin() then return end

    local owner = eObj:CPPIGetOwner()
    if not owner then return false end
    
    if ( owner != SERVER ) and owner:IsPlayer() then
        local friends = owner:CPPIGetFriends()

        if ( friends != CPPI.CPPI_DEFER ) then
            for _, v in pairs( friends ) do
                if ( v == ePly ) then return end
            end
        end

        ePly:ChatPrint( 'Данный объект принадлежит не вам!' )

        return false
    end
end )

hook.Add( 'PlayerSpawnRagdoll', 'Ambi.Rus.Restrict', function( ePly )
    if ePly:IsUserGroup( 'user' ) then ePly:ChatSend( C.AMBI_RED, 'Нужно быть особенным!' ) return false end

    return true
end )

hook.Add( 'PlayerLoadout', 'Ambi.Rus.Restrict', function( ePly )
    return false
end )

hook.Add( 'PlayerSpawnProp', 'Ambi.Rus.Restrict', function( ePly )
    if ( ePly:GetLevel() > 3 ) then return end
    if timer.Exists( 'FloodProps:'..ePly:SteamID() ) then ePly:ChatPrint( 'Flood canceled!' ) return false end
end )

hook.Add( 'PlayerSpawnedProp', 'Ambi.Rus.Restrict', function( ePly )
    if ( ePly:GetLevel() > 3 ) then return end
    
    timer.Create( 'FloodProps:'..ePly:SteamID(), 0.52, 1, function() end )
end )

hook.Add( 'OnPhysgunReload', 'Ambi.Rus.PropDefense', function( _, ePly)
    if ( ePly:GetLevel() < 3 ) then ePly:ChatPrint( 'Доступно с 3+ уровня!' ) return false end
end )