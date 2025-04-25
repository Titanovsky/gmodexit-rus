local Mat, C, Draw = Ambi.General.Material, Ambi.General.Global.Colors, Ambi.UI.Draw
local Add = Ambi.Base.HUD.Add

local W, H = ScrW(), ScrH()
local COLOR_PANEL = Color( 20, 20, 20, 200 )

local BLOCK_GUNS = {
    [ 'weapon_physcannon' ] = true,
    [ 'weapon_bugbait' ] = true,
    [ 'weapon_crowbar' ] = true,
    [ 'weapon_stunstick' ] = true,
    [ 'gmod_camera' ] = true,
    [ 'weapon_fists' ] = true,
    [ 'weapon_physgun' ] = true,
    [ 'gmod_tool' ] = true,
}

Add( 2, '[RUS] Minimalistic HUD', 'Ambi', function()
    --Draw.Box( 39, 18, 4, 4, COLOR_PANEL, 4, 'all' )
    --draw.SimpleTextOutlined( 'RUS', '32 Franxurter Totally Fat', W - 4, -2, C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
    draw.SimpleTextOutlined( '❄ С НОВЫМ 2022 ГОДОМ! ❄', '21 Franxurter Totally Fat', W - 4, 4, HSVToColor(  ( CurTime() * 32 ) % 360, 1, 1 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
    
    local wep = LocalPlayer():GetActiveWeapon()
    if IsValid( wep ) and ( wep:GetClass() == 'gmod_camera' ) then return end

    local text = '['..LocalPlayer():EntIndex()..'] '..LocalPlayer():Name()
    local x = Draw.GetTextSizeX( '28 Ambi', text )
    draw.RoundedBox( 4, 4, H - 32 - 4, x+20, 32, COLOR_PANEL )
    draw.SimpleTextOutlined( text, '28 Ambi Bold', 8, H-32, C.ABS_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )

    local text = 'Health: '..LocalPlayer():Health()
    local x = Draw.GetTextSizeX( '18 Ambi', text )
    draw.RoundedBox( 4, 4, H-56, x+8, 18, COLOR_PANEL )
    draw.SimpleTextOutlined( text, '18 Ambi', 8, H-55, C.FLAT_RED, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )

    local text = 'Armor: '..LocalPlayer():Armor()
    local x = Draw.GetTextSizeX( '18 Ambi', text )
    draw.RoundedBox( 4, 4, H-56-10*2, x+8, 18, COLOR_PANEL )
    draw.SimpleTextOutlined( text, '18 Ambi', 8, H-55-10*2, C.FLAT_BLUE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )

    local text = 'Level: '..LocalPlayer():GetNWInt( 'Level' )
    local x = Draw.GetTextSizeX( '18 Ambi', text )
    draw.RoundedBox( 4, 4, H-56-10*4, x+8, 18, COLOR_PANEL )
    draw.SimpleTextOutlined( text, '18 Ambi', 8, H-55-10*4, C.AMBI, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )

    local text = 'XP: '..LocalPlayer():GetNWInt( 'XP' )..'/'..LocalPlayer():GetNWInt( 'Level' ) * 1000
    local x = Draw.GetTextSizeX( '18 Ambi', text )
    draw.RoundedBox( 4, 4, H-56-10*6, x+8, 18, COLOR_PANEL )
    draw.SimpleTextOutlined( text, '18 Ambi', 8, H-55-10*6, C.AMBI_GRAY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )

    local text = LocalPlayer():GetMoney()..' Rubaksov'
    local x = Draw.GetTextSizeX( '18 Ambi', text )
    draw.RoundedBox( 4, 4, H-56-10*8, x+8, 18, COLOR_PANEL )
    draw.SimpleTextOutlined( text, '18 Ambi', 8, H-55-10*8, C.AMBI_GREEN, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )

    local text = LocalPlayer():TeamName()
    local x = Draw.GetTextSizeX( '18 Ambi', text )
    draw.RoundedBox( 4, 4, H-56-10*10, x+8, 18, COLOR_PANEL )
    draw.SimpleTextOutlined( text, '18 Ambi', 8, H-55-10*10, LocalPlayer():TeamColor(), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
    -- 
    if not IsValid( wep ) then return end
    if BLOCK_GUNS[ wep:GetClass() ] then return end

    local clip1, ammo1, ammo2 = wep:Clip1(), LocalPlayer():GetAmmoCount( wep:GetPrimaryAmmoType() ), LocalPlayer():GetAmmoCount( wep:GetSecondaryAmmoType() )
    local ammo = clip1..' / '..ammo1
    local x = Draw.GetTextSizeX( '42 Ambi', ammo ) + 14
    if ammo2 and ( ammo2 > 0 ) then 
        ammo = '('..ammo2..') '..clip1..' / '..ammo1
        x = Draw.GetTextSizeX( '42 Ambi', ammo ) + 10
    end

    draw.RoundedBox( 4, W - x, H - 34 - 4, x - 4, 34, COLOR_PANEL )
    draw.SimpleTextOutlined( ammo, '42 Ambi', W - 8, H - 36 - 4, C.AMBI_GRAY, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
end )