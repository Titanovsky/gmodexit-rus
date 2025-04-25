local RegEnt = Ambi.RegEntity

local SWEP = {}
SWEP.Class = 'keys'
SWEP.PrintName = 'Ключи'
SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Author = 'Ambi'
SWEP.WorldModel = ''
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.Category = '[RUS]'

SWEP.Primary = {}
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ''

SWEP.Secondary = {}
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ''

local CLASSES = {
    [ 'func_door' ] = true,
    [ 'prop_door_rotating' ] = true
}

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

function SWEP:Reload()
    if not IsFirstTimePredicted() then return end
    if CLIENT then return end
    
    -- local owner = self.Owner
    -- if timer.Exists( 'AmbiDarkRPKeysReload:'..owner:SteamID() ) then return end
    -- timer.Create( 'AmbiDarkRPKeysReload:'..owner:SteamID(), 0.45, 1, function() end )

    -- local door = owner:GetEyeTrace().Entity
    -- if not IsValid( door ) or not CLASSES[ door:GetClass() ] then return end
    -- if ( owner:GetPos():Distance( door:GetPos() ) > 78 ) then return end

    -- if Ambi.Rus.CheckDoorOwner( door, owner ) then
    --     Ambi.Rus.RemoveDoorOwner( door, owner )
    --     owner:ChatPrint('Продали')

    --     door.nw_Title = 'Дверь №'..door:EntIndex()
    -- else
    --     -- TODO: Money check

    --     owner:ChatPrint('Купили')
    --     Ambi.Rus.AddDoorOwner( door, owner )

    --     door.nw_Title = owner:Nick()
    -- end
end

if SERVER then 
    net.AddString( 'ambi_rus_animation_keys' )
else
    net.Receive( 'ambi_rus_animation_keys', function()
        local ply = Entity( net.ReadUInt( 8 ) )
        if not IsValid( ply ) or not ply:IsPlayer() then return end

        local anim = ( net.ReadBit() == 1 ) and ACT_GMOD_GESTURE_ITEM_PLACE or ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST

        ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, anim, true)
    end )
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end
    self:SetNextPrimaryFire( CurTime() + 0.35 )

    if CLIENT then return end
    
    local owner = self.Owner
    local door = owner:GetEyeTrace().Entity
    if not IsValid( door ) or not CLASSES[ door:GetClass() ] then return end
    if ( owner:GetPos():Distance( door:GetPos() ) > 78 ) then return end

    if Ambi.Rus.CheckDoorOwner( door, owner ) then
        door:Fire( 'Lock', '1' )
        owner:EmitSound( 'npc/metropolice/gear'..math.random( 1, 6 )..'.wav' )
        owner:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true )

        net.Start( 'ambi_rus_animation_keys' )
            net.WriteUInt( owner:EntIndex(), 8 )
            net.WriteBit( true )
        net.Broadcast()
    else
        owner:EmitSound( 'physics/wood/wood_crate_impact_hard2.wav', 100, math.random( 90, 110 )  )
        owner:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
        self:SetNextPrimaryFire( CurTime() + 1.25 )

        net.Start( 'ambi_rus_animation_keys' )
            net.WriteUInt( owner:EntIndex(), 8 )
            net.WriteBit( false )
        net.Broadcast()
    end
end

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end
    self:SetNextSecondaryFire( CurTime() + 0.35 )

    if CLIENT then return end
    
    local owner = self.Owner
    local door = owner:GetEyeTrace().Entity
    if not IsValid( door ) or not CLASSES[ door:GetClass() ] then return end
    if ( owner:GetPos():Distance( door:GetPos() ) > 78 ) then return end

    if Ambi.Rus.CheckDoorOwner( door, owner ) then
        door:Fire( 'Unlock', '1' )
        owner:EmitSound( 'npc/metropolice/gear'..math.random( 1, 6 )..'.wav' )
        owner:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true )

        net.Start( 'ambi_rus_animation_keys' )
            net.WriteUInt( owner:EntIndex(), 8 )
            net.WriteBit( true )
        net.Broadcast()
    end
end

RegEnt.Register( SWEP.Class, 'weapons', SWEP )