local CLASSES = {
    [ 'func_door' ] = true,
    [ 'prop_door_rotating' ] = true
}

function Ambi.Rus.SetDoorOwners( eDoor, tPlayers )
    if not IsValid( eDoor ) or not CLASSES[ eDoor:GetClass() ] then return end
    if eDoor.nw_IsBlocked then return end
    if not tPlayers then return end

    for ply, _ in pairs( tPlayers ) do 
        if not ply:IsPlayer() then tPlayers[ ply ] = nil end
    end
    if not tPlayers then return end -- После проверки на наличие игроков, таблица может опустеть и уничтожится сборщиком мусора

    eDoor.owners = tPlayers
    eDoor.nw_IsOwned = true
end

function Ambi.Rus.AddDoorOwner( eDoor, ePly )
    if not IsValid( eDoor ) or not CLASSES[ eDoor:GetClass() ] then return end

    eDoor.owners[ ePly ] = true

    eDoor.nw_IsOwned = true
end

function Ambi.Rus.RemoveDoorOwner( eDoor, ePly )
    if not IsValid( eDoor ) or not CLASSES[ eDoor:GetClass() ] then return end
    eDoor.owners[ ePly ] = nil

    local count = 0
    for i, _ in pairs( eDoor.owners ) do
        count = count + 1
    end

    if ( count == 0 ) then eDoor.nw_IsOwned = false end
end

function Ambi.Rus.RemoveDoorOwners( eDoor )
    if not IsValid( eDoor ) or not CLASSES[ eDoor:GetClass() ] then return end
    eDoor.owners = {}

    eDoor.nw_IsOwned = false
end

function Ambi.Rus.CheckDoorOwner( eDoor, ePly )
    if not IsValid( eDoor ) or not CLASSES[ eDoor:GetClass() ] then return end
    if not eDoor.owners then eDoor.owners = {} end

    return eDoor.owners[ ePly ]
end

--------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------

hook.Add( 'ShowTeam', 'Ambi.Rus.BuySellDoors', function( ePly ) 
    local owner = ePly
    if timer.Exists( 'AmbiDarkRPKeysReload:'..owner:SteamID() ) then return end
    timer.Create( 'AmbiDarkRPKeysReload:'..owner:SteamID(), 0.45, 1, function() end )

    local door = owner:GetEyeTrace().Entity
    if not IsValid( door ) or not CLASSES[ door:GetClass() ] then return end
    if ( owner:GetPos():Distance( door:GetPos() ) > 78 ) then return end

    if Ambi.Rus.CheckDoorOwner( door, owner ) then
        Ambi.Rus.RemoveDoorOwner( door, owner )
        owner:ChatPrint('Продали')

        door.nw_Title = 'Дверь №'..door:EntIndex()
    else
        for ply, _ in pairs( door.owners ) do 
            if ply then ePly:ChatPrint( 'Дверь куплена!' ) return end
        end

        owner:ChatPrint('Купили')
        Ambi.Rus.AddDoorOwner( door, owner )

        door.nw_Title = owner:Nick()
    end
end )