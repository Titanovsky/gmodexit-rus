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

function SWEP:PrimaryAttack()
    if not SERVER then return end

    self:SetNextPrimaryFire( CurTime() + 0.55 )

    local owner = self:GetOwner()
    local ent = owner:GetEyeTrace().Entity
    if IsValid( ent ) and OtherMod.doors_classes[ ent:GetClass() ] then
        local owner_door = ent:GetNWEntity( 'owner' )
        if IsValid( owner_door ) and ( owner_door == owner ) and ( owner:GetPos():Distance( ent:GetPos() ) <= 160 ) then
            owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)

            ent:EmitSound( 'npc/metropolice/gear'..math.random( 1, 6 )..'.wav' )
            ent:Fire( 'Lock', '1' )
        end
    end
end

function SWEP:SecondaryAttack()
    if not SERVER then return end

    self:SetNextSecondaryFire( CurTime() + 0.55 )

    local owner = self:GetOwner()
    local ent = owner:GetEyeTrace().Entity
    if IsValid( ent ) and OtherMod.doors_classes[ ent:GetClass() ] then
        local owner_door = ent:GetNWEntity( 'owner' )
        if IsValid( owner_door ) and ( owner_door == owner ) and ( owner:GetPos():Distance( ent:GetPos() ) <= 160 ) then
            owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)

            ent:EmitSound( 'npc/metropolice/gear'..math.random( 1, 6 )..'.wav' )
            ent:Fire( 'Unlock', '1' )
        end
    end
end

function SWEP:Reload()
    if CLIENT then return end
    if timer.Exists( 'PlayerWait:'..tostring( self:GetOwner() ) ) then return end
    timer.Create( 'PlayerWait:'..tostring( self:GetOwner() ), 1, 1, function() end )

    local owner = self:GetOwner()
    local ent = owner:GetEyeTrace().Entity
    if IsValid( ent ) and OtherMod.doors_classes[ ent:GetClass() ] and ( owner:GetPos():Distance( ent:GetPos() ) <= 160 ) then
        local owner_door = ent:GetNWEntity( 'owner' )
        if IsValid( owner_door ) and ( owner_door == owner ) then
            OtherMod.SellDoor( ent, owner )
        else
            OtherMod.BuyDoor( ent, owner )
        end
    end
end

function SWEP:Holster()

    return true

end

function SWEP:PreDrawViewModel()

    return true

end
