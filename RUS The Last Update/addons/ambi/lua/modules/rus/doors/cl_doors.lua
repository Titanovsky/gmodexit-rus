local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local W, H = ScrW(), ScrH()
local CLASSES = {
    [ 'func_door' ] = true,
    [ 'prop_door_rotating' ] = true
}

local function GetOwners( eDoor )
    if eDoor.nw_IsOwned then return 'Занята' end

    return 'Продаётся 45$'
end

local function GetTitle( eDoor )
    return eDoor.nw_Title or 'Дверь №'..eDoor:EntIndex()
end

hook.Add( 'HUDPaint', 'Ambi.Rus.DrawInfoDoors', function()
    local door = LocalPlayer():GetEyeTrace().Entity

    if IsValid( door ) and CLASSES[ door:GetClass() ] and ( LocalPlayer():GetPos():Distance( door:GetPos() ) <= 150 ) then
        draw.SimpleTextOutlined( GetTitle( door ), UI.SafeFont( '26 Ambi' ), W / 2, H / 2, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
        draw.SimpleTextOutlined( GetOwners( door ), UI.SafeFont( '20 Ambi' ), W / 2, H / 2 + 26, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
    end
end )