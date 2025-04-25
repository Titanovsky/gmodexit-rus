AddCSLuaFile( "shared.lua" ) -- Данное творение принадлежит проекту [.ambition]

SWEP.PrintName      = "Adv. Кирка" -- Данное творение принадлежит проекту [.ambition]
SWEP.Category       = "[.ambition] Шахта"
SWEP.Author         = "[.ambition]"
SWEP.Instructions   = "(ЛКМ) - добыть"
SWEP.Spawnable      = true
SWEP.AdminSpawnable = true

SWEP.HoldType       = "melee" -- Данное творение принадлежит проекту [.ambition]
SWEP.ViewModelFOV   = 70 -- Данное творение принадлежит проекту [.ambition]
SWEP.ViewModel      = Model("models/weapons/v_crowbar.mdl") -- Данное творение принадлежит проекту [.ambition]
SWEP.WorldModel     = Model("models/weapons/w_crowbar.mdl") -- Данное творение принадлежит проекту [.ambition]


SWEP.FiresUnderwater        = false
SWEP.Primary.Damage         = 0
SWEP.base                   = "crowbar" -- Данное творение принадлежит проекту [.ambition]
SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "none" -- Данное творение принадлежит проекту [.ambition]
SWEP.Primary.Delay          = 0.5


SWEP.Weight          = 5
SWEP.AutoSwitchTo    = false
SWEP.AutoSwitchFrom  = false

SWEP.Slot            = 1 -- Данное творение принадлежит проекту [.ambition]
SWEP.SlotPos         = 1
SWEP.DrawAmmo        = false
SWEP.DrawCrosshair   = true -- Данное творение принадлежит проекту [.ambition]

function SWEP:Initialize() -- Данное творение принадлежит проекту [.ambition]
   if ( SERVER ) then
      self:SetHoldType( self.HoldType )
      self.hp = AmbMine.Config.AdvAxeHP
   end
end

function SWEP:SecondaryAttack()  -- Данное творение принадлежит проекту [.ambition]
end

function SWEP:Think() -- Данное творение принадлежит проекту [.ambition]
end

function SWEP:PrimaryAttack()

   local owner = self.Owner
    self:SetNextPrimaryFire( CurTime() + 1.2 )

    
      self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )

 -- кусок хз чего, не мой, взял у француза
   if SERVER then 
      owner:SetAnimation( PLAYER_ATTACK1 )
      self.hp = self.hp - 1

      if ( self.hp <= 0 ) then 
         self.Owner:StripWeapon( self:GetClass() )
         -- print("da") -- debug
      end
   end

   local trace = owner:GetEyeTrace()

   if trace.HitPos:Distance( owner:GetShootPos() ) <= 64 then

    bullet = {}
    bullet.Num    = 1
    bullet.Src    = self.Owner:GetShootPos()
    bullet.Dir    = self.Owner:GetAimVector()
    bullet.Spread = Vector(0, 0, 0)
    bullet.Tracer = 0
    bullet.Force  = 3
    bullet.Damage = 0

    owner:DoAttackEvent()
    owner:FireBullets(bullet) 
    self.Weapon:EmitSound("Weapon_Crowbar.Melee_Hit")
   else
   self.Weapon:EmitSound("Zombie.AttackMiss")

   owner:DoAttackEvent()
end

end
 
function SWEP:Deploy()
   if SERVER then
      self:SetColor(Color(255,0,0,255))
      self:SetMaterial("models/shiny")
      local vm = self.Owner:GetViewModel()
      if not IsValid(vm) then return end
      vm:ResetSequence(vm:LookupSequence("idle01"))
   end
   return true
end

function SWEP:Holster() -- Данное творение принадлежит проекту [.ambition]
   return true
end

-- Данное творение принадлежит проекту [.ambition]