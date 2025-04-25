local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local W, H = ScrW(), ScrH()
local Add = Ambi.MultiHUD.Add

local COLOR_PANEL = Color( 46, 46, 46 )
local COLOR_BLOOD = Color(78,0,0)

local MAT_HEALTH_NAME, MAT_HEALTH_URL = 'health_hud1.png', 'https://i.ibb.co/xDcS9JS/health.png'
local MAT_HEALTH = Material( Ambi.Cache.GetCacheFile( MAT_HEALTH_NAME ) )

local MAT_ARMOR_NAME, MAT_ARMOR_URL = 'armor_hud1.png', 'https://i.ibb.co/GQjdY6d/armor.png'
local MAT_ARMOR = Material( Ambi.Cache.GetCacheFile( MAT_ARMOR_NAME ) )

local BLOCK_WEAPONS = {
    [ 'weapon_physcannon' ] = true,
    [ 'weapon_bugbait' ] = true,
    [ 'weapon_crowbar' ] = true,
    [ 'weapon_stunstick' ] = true,
    [ 'weapon_fists' ] = true,
    [ 'weapon_physgun' ] = true,
    [ 'gmod_tool' ] = true,
    [ 'keys' ] = true,
    [ 'lockpick' ] = true,
    [ 'stunstick' ] = true,
    [ 'arrest_stick' ] = true,
    [ 'unarrest_stick' ] = true,
    [ 'weaponchecker' ] = true,
    [ 'keypadchecker' ] = true,
}

local HP_W, HP_H = 256, 16
local ARMOR_W, ARMOR_H = 256, 16

Add( 3, 'RUS', 'Ambi', function()
    if not LocalPlayer():Alive() then return end

    local wep = LocalPlayer():GetActiveWeapon()
    if LocalPlayer():IsBuilder() then
        Draw.SimpleText( W / 2, H - 32 - 16, 'Builder', UI.SafeFont( '28 Ambi' ), C.AMBI_GREEN, 'bottom-center', 1, C.ABS_BLACK )
    elseif IsValid( wep ) and not BLOCK_WEAPONS[ wep:GetClass() ] and not LocalPlayer():IsBuilder() then 
        if ( wep:GetClass() == 'gmod_camera' ) then return end

        local clip1, ammo1, ammo2 = wep:Clip1(), LocalPlayer():GetAmmoCount( wep:GetPrimaryAmmoType() ), LocalPlayer():GetAmmoCount( wep:GetSecondaryAmmoType() )
        local ammo = clip1..' / '..ammo1
        if ammo2 and ( ammo2 > 0 ) then 
            ammo = '('..ammo2..') '..clip1..' / '..ammo1
        end

        local color = ( ammo1 == 0 and clip1 == 0 ) and C.AMBI_GRAY or C.AMBI
        Draw.SimpleText( W / 2, H - 32 - 16, ammo, UI.SafeFont( '28 Ambi' ), color, 'bottom-center', 1, C.ABS_BLACK )
    end

    if LocalPlayer():Alive() then
        local hp, max = LocalPlayer():Health(), LocalPlayer():GetMaxHealth() 
        local w = ( hp > max ) and HP_W or ( HP_W / max ) * hp
        local color = ( hp <= 30 ) and ColorAlpha( C.AMBI_RED, 200 + math.sin( 360 + CurTime() * 16 ) * 160 ) or C.AMBI_RED
        
        Draw.Box( w, HP_H, W / 2 - HP_W / 2, H - HP_H - 16, color )
        Draw.SimpleText( W / 2 - HP_W / 2 + w - 2, H - HP_H, hp, UI.SafeFont( '16 Arial' ), C.ABS_WHITE, 'bottom-right', 1, C.ABS_BLACK )

        local armor, max = LocalPlayer():Armor(), LocalPlayer():GetMaxArmor() 
        if ( armor > 0 ) then
            local w = ( armor > max ) and ARMOR_W or ( ARMOR_W / max ) * armor

            Draw.Box( w, ARMOR_H, W / 2 - ARMOR_W / 2, H - ARMOR_H - 16 * 2, C.AMBI_BLUE )
            Draw.SimpleText( W / 2 - ARMOR_W / 2 + w - 2, H - ARMOR_H - 16, armor, UI.SafeFont( '16 Arial' ), C.ABS_WHITE, 'bottom-right', 1, C.ABS_BLACK )
        end
    end
end )