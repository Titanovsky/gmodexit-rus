AddCSLuaFile()

if CLIENT then

    SWEP.PrintName = 'Ключи'
    SWEP.Slot = 1
    SWEP.SlotPos = 0
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false

end

SWEP.Author = 'A M B I T I O N'

SWEP.WorldModel = ''
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.Category = '[ AMB ] Role Play'
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ''

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ''

function SWEP:Initialize()

    self:SetHoldType( 'normal')

end

function SWEP:Deploy()

    if CLIENT or not IsValid( self:GetOwner() ) then return true end

    self:GetOwner():DrawWorldModel(false)

    return true

end

function SWEP:Holster()

    return true

end

function SWEP:PreDrawViewModel()

    return true

end
