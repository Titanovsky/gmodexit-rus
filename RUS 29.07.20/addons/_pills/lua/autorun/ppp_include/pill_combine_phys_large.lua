AddCSLuaFile()

pk_pills.register("hunter_chopper", {
    printName = "Hunter-Chopper",
    side = "hl_combine",
    type = "phys",
    model = "models/Combine_Helicopter.mdl",
    default_rp_cost = 20000,
    spawnOffset = Vector(0, 0, 200),
    camera = {
        offset = Vector(80, 0, 0),
        dist = 1000
    },
    driveType = "fly",
    driveOptions = {
        speed = 20,
        tilt = 20
    },
    seqInit = "idle",
    aim = {
        xPose = "weapon_yaw",
        yPose = "weapon_pitch",
        yInvert = true,
        attachment = "Muzzle"
    },
    attack = {
        mode = "auto",
        func = pk_pills.common.shoot,
        delay = .02,
        damage = 10,
        spread = .05,
        tracer = "HelicopterTracer"
    },
    attack2 = {
        mode = "auto",
        func = function(ply, ent)
        end,
        delay = .5
    },
    reload = function(ply, ent)
        if ent.lastrocket and ent.lastrocket + 1 > CurTime() then return end
        ent:PillSound("rocket")
        local rocket = ents.Create("rpg_missile")
        rocket:SetPos(ent:LocalToWorld(Vector(0, 80, -80)))
        rocket:SetAngles(ply:EyeAngles())
        rocket:SetSaveValue("m_flDamage", 200)
        rocket:SetOwner(ply)
        rocket:SetVelocity(ent:GetVelocity())
        rocket:Spawn()
        rocket = ents.Create("rpg_missile")
        rocket:SetPos(ent:LocalToWorld(Vector(0, -80, -80)))
        rocket:SetAngles(ply:EyeAngles())
        rocket:SetSaveValue("m_flDamage", 200)
        rocket:SetOwner(ply)
        rocket:SetVelocity(ent:GetVelocity())
        rocket:Spawn()
        ent.lastrocket = CurTime()
    end,
    health = 5600,
    damageFromWater = -1,
    sounds = {
        loop_move = "npc/attack_helicopter/aheli_rotor_loop1.wav",
        loop_attack = "npc/attack_helicopter/aheli_weapon_fire_loop3.wav",
        dropBomb = "npc/attack_helicopter/aheli_mine_drop1.wav",
        die = pk_pills.helpers.makeList("ambient/explosions/explode_#.wav", 9),
        rocket = "weapons/grenade_launcher1.wav"
    }
})

pk_pills.register("strider", {
    printName = "Strider",
    side = "hl_combine",
    type = "phys",
    model = "models/combine_strider.mdl",
    default_rp_cost = 20000,
    camera = {
        dist = 750
    },
    seqInit = "Idle01",
    driveType = "strider",
    aim = {
        xInvert = true,
        xPose = "minigunYaw",
        yPose = "minigunPitch",
        attachment = "MiniGun",
        fixTracers = true,
        simple = true,
        overrideStart = Vector(80, 0, -40)
    },
    attack = {
        mode = "auto",
        func = pk_pills.common.shoot,
        delay = .2,
        damage = 30,
        spread = .02,
        tracer = "HelicopterTracer"
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if ent.usingWarpCannon then return end
            local tr = util.QuickTrace(ent:LocalToWorld(Vector(80, 0, -40)), ply:EyeAngles():Forward() * 99999, ent)
            local effectdata = EffectData()
            effectdata:SetEntity(ent)
            effectdata:SetOrigin(tr.HitPos)
            util.Effect("warp_cannon", effectdata, true, true)
            ent:PillSound("warp_charge")

            timer.Simple(1.2, function()
                if not IsValid(ent) then return end
                ent:PillSound("warp_fire")
                util.BlastDamage(ent, ply, tr.HitPos, 200, 1000)

                if IsValid(tr.Entity) then
                    local phys = tr.Entity:GetPhysicsObject()

                    if IsValid(phys) then
                        phys:ApplyForceCenter(ply:EyeAngles():Forward() * 9 ^ 7)
                    end
                end
            end)

            ent.usingWarpCannon = true

            timer.Simple(2.4, function()
                if not IsValid(ent) then return end
                ent.usingWarpCannon = nil
            end)
        end
    },
    renderOffset = function(ply, ent)
        local h = ent:GetPoseParameter("body_height") * 500

        return Vector(0, 0, 500 - h)
    end,
    health = 7,
    onlyTakesExplosiveDamage = true,
    sounds = {
        step = pk_pills.helpers.makeList("npc/strider/strider_step#.wav", 6),
        shoot = "npc/strider/strider_minigun.wav",
        warp_charge = "npc/strider/charging.wav",
        warp_fire = "npc/strider/fire.wav"
    }
})
