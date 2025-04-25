OtherMod = OtherMod or {}

OtherMod.doors_classes = {
    [ 'prop_door_rotating' ] = true,
    [ 'func_door_rotating' ] = true
}

if SERVER then
    function OtherMod.SetDoorOwner( eDoor, ePly )
        if not IsValid( eDoor ) or not OtherMod.doors_classes[ eDoor:GetClass() ] then return end
        if not IsValid( ePly ) then
            eDoor:SetNWBool( 'owned', false )
            eDoor:SetNWEntity( 'owner', NULL )
            eDoor:Fire( 'Unlock', '1' )

            return
        end

        eDoor:SetNWBool( 'owned', true )
        eDoor:SetNWEntity( 'owner', ePly )

        if not ePly.doors then ePly.doors = {} end
        ePly.doors[ eDoor ] = eDoor
    end

    local COST_DOOR = 50
    function OtherMod.BuyDoor( eDoor, ePly )
        if not IsValid( eDoor ) or not IsValid( ePly ) or not OtherMod.doors_classes[ eDoor:GetClass() ] then return end
        if eDoor:GetNWBool( 'owned' ) then ePly:ChatPrint( 'Дверь уже занята' ) return end

        local bio = AmbStats.Players.getStats( ePly, '$' )
        if ( bio < COST_DOOR ) then ePly:ChatPrint( 'Не хватает Био. Эссенций ('..COST_DOOR..')' ) return end
        if not ( ePly:Team() == AMB_TEAM_RP ) then ePly:ChatPrint( 'Вы должны быть РПшником!' ) return end

        ePly:ChatPrint( 'Вы купили дверь '..tostring( eDoor ) )
        AmbStats.Players.setStats( ePly, '$', bio - COST_DOOR )
        OtherMod.SetDoorOwner( eDoor, ePly )
    end

    local RETURN_COST_DOOR = 25
    function OtherMod.SellDoor( eDoor, ePly )
        if not IsValid( eDoor ) or not IsValid( ePly ) or not OtherMod.doors_classes[ eDoor:GetClass() ] then return end
        if not ( eDoor:GetNWEntity( 'owner' ) == ePly ) then return end
        if not ( ePly:Team() == AMB_TEAM_RP ) then ePly:ChatPrint( 'Вы должны быть РПшником!' ) return end

        local bio = AmbStats.Players.getStats( ePly, '$' )
        AmbStats.Players.setStats( ePly, '$', bio + RETURN_COST_DOOR )

        eDoor:SetNWBool( 'owned', false )
        eDoor:SetNWEntity( 'owner', NULL )
        eDoor:Fire( 'Unlock', '1' )

        ePly:ChatPrint( 'Вы продали дверь '..tostring( eDoor ) )
        ePly.doors[ eDoor ] = nil
    end

    hook.Add( 'PlayerDisconnected', 'AMB.ReturnDoors', function( ePly )
        if not ePly.doors then return end

        for door, _ in pairs( ePly.doors ) do
            if IsValid( door ) then
                door:SetNWBool( 'owned', false )
                door:SetNWEntity( 'owner', NULL )
                door:Fire( 'Unlock', '1' )
            end
        end
    end )
elseif CLIENT then
    local W, H = ScrW(), ScrH()
    local COLOR_BLACK, COLOR_WHITE = Color( 0, 0, 0 ), Color( 255, 255, 255 )

    hook.Add( 'HUDPaint', 'AMB.ShowDoorInfo', function()
        local tr = LocalPlayer():GetEyeTrace()
        local ent = tr.Entity
        if not IsValid( ent ) or not OtherMod.doors_classes[ ent:GetClass() ] or ( LocalPlayer():GetPos():Distance( ent:GetPos() ) > 160 ) then return end

        local owner = ent:GetNWEntity( 'owner', nil )
        local text = 'Никто'
        if owner and IsValid( owner ) then
            text = owner:Nick()
        end

        draw.SimpleTextOutlined( 'Owner: '..text, 'Trebuchet24', W / 2, H - 100, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, COLOR_BLACK )
        draw.SimpleTextOutlined( '(Покупаются/продаются на R с помощью Ключей)', 'DermaDefault', W / 2, H - 90, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, COLOR_BLACK )
    end )
end