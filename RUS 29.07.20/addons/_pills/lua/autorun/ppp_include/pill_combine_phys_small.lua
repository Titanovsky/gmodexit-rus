AddCSLuaFile()


pk_pills.register("cityscanner", {
    printName = "City Scanner",
    side = "hl_combine",
    type = "phys",
    model = "models/Combine_Scanner.mdl",
    default_rp_cost = 1000,
    driveType = "fly",
    driveOptions = {
        speed = 6
    },
    aim = {
        xPose = "flex_horz",
        yPose = "flex_vert",
        nocrosshair = true
    },
    pose = {
        dynamo_wheel = function(ply, ent, old) return old + 10 end,
        tail_control = function(ply, ent) return ent:GetPhysicsObject():GetVelocity().z / 6 end
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            ent:PillSound("pic")
        end
    },
    seqInit = "idle",
    health = 30,
    damageFromWater = -1,
    sounds = {
        loop_move = "npc/scanner/scanner_scan_loop1.wav",
        die = "npc/scanner/scanner_explode_crash2.wav",
        pic = "npc/scanner/scanner_photo1.wav"
    }
})

pk_pills.register("manhack", {
    printName = "Manhack",
    side = "hl_combine",
    type = "phys",
    model = "models/manhack.mdl",
    default_rp_cost = 2000,
    driveType = "fly",
    driveOptions = {
        speed = 6,
        tilt = 20
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            if not ent.blades then
                ent:PillSound("toggleBlades")
                ent:PillLoopSound("blades")
            else
                ent:PillSound("toggleBlades")
                ent:PillLoopStop("blades")
            end

            ent.blades = not ent.blades
        end
    },
    pose = {
        Panel1 = function(ply, ent, old)
            if ent.blades and old < 90 then return old + 20 end
            if not ent.blades and old > 0 then return old - 20 end
        end,
        Panel2 = function(ply, ent, old)
            if ent.blades and old < 90 then return old + 20 end
            if not ent.blades and old > 0 then return old - 20 end
        end,
        Panel3 = function(ply, ent, old)
            if ent.blades and old < 90 then return old + 20 end
            if not ent.blades and old > 0 then return old - 20 end
        end,
        Panel4 = function(ply, ent, old)
            if ent.blades and old < 90 then return old + 20 end
            if not ent.blades and old > 0 then return old - 20 end
        end
    },
    bodyGroups = {1, 2},
    seqInit = "fly",
    health = 25,
    damageFromWater = -1,
    sounds = {
        loop_move = "npc/manhack/mh_engine_loop1.wav",
        loop_blades = "npc/manhack/mh_blade_loop1.wav",
        toggleBlades = "npc/manhack/mh_blade_snick1.wav",
        cut_flesh = pk_pills.helpers.makeList("npc/manhack/grind_flesh#.wav", 3),
        cut = pk_pills.helpers.makeList("npc/manhack/grind#.wav", 5),
        die = "npc/manhack/gib.wav"
    },
    collide = function(ply, ent, collide)
        if ent.blades and collide.HitNormal.z < 0.5 and collide.HitNormal.z > -0.5 then
            local force = -collide.HitNormal
            --GTFO
            ent:GetPhysicsObject():ApplyForceCenter(force * 1000)
            --Give Damage
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(25)
            dmginfo:SetAttacker(ply)
            dmginfo:SetDamageForce(force * -10000)
            collide.HitEntity:TakeDamageInfo(dmginfo)

            if (collide.HitEntity:IsPlayer() or collide.HitEntity:IsNPC() or collide.HitEntity:GetClass() == "pill_ent_phys") then
                ent:PillSound("cut_flesh")
            else
                ent:PillSound("cut")
            end
        end
    end,
    contactForceHorizontal = true
})

pk_pills.register("cturret", {
    printName = "Combine Turret",
    side = "hl_combine",
    type = "phys",
    model = "models/combine_turrets/floor_turret.mdl",
    default_rp_cost = 2000,
    spawnOffset = Vector(0, 0, 5),
    camera = {
        offset = Vector(0, 0, 60)
    },
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch",
        attachment = "eyes"
    },
    canAim = function(ply, ent) return ent.active end,
    attack = {
        mode = "auto",
        func = pk_pills.common.shoot,
        delay = .1,
        damage = 4,
        spread = .01,
        anim = "fire",
        tracer = "AR2Tracer"
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if ent.busy then return end

            if ent.active then
                ent:PillAnim("retract")
                ent:PillSound("retract")
                ent.active = false
            else
                ent:PillAnim("deploy")
                ent:PillSound("deploy")
                ent:PillLoopSound("alarm")

                timer.Simple(1, function()
                    if not IsValid(ent) then return end
                    ent:PillLoopStop("alarm")
                end)
            end

            ent.busy = true

            timer.Simple(.2, function()
                if not IsValid(ent) then return end

                if ent:GetSequence() == ent:LookupSequence("deploy") then
                    ent.active = true
                end

                ent.busy = false
            end)
        end
    },
    diesOnExplode = true,
    damageFromWater = -1,
    sounds = {
        loop_alarm = "npc/turret_floor/alarm.wav",
        shoot = pk_pills.helpers.makeList("npc/turret_floor/shoot#.wav", 3),
        deploy = "npc/turret_floor/deploy.wav",
        retract = "npc/turret_floor/retract.wav",
        die = "npc/turret_floor/die.wav",
        auto_ping = "npc/turret_floor/ping.wav",
        auto_ping_func = function(ply, ent) return ent.active and not ent.loopingSounds["alarm"]:IsPlaying() and (not ent.lastAttack or ent.lastAttack + .2 < CurTime()), 1 end
    }
})