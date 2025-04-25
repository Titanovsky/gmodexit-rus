AddCSLuaFile()

pk_pills.register("giraffe", {
    printName = "Жирафик",
    side = "harmless",
    type = "ply",
    model = "models/mossman.mdl",
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 220),
        dist = 400
    },
    hull = Vector(50, 50, 230),
    duckBy = 150,
    modelScale = 2,
    anims = {
        default = {
            idle = "man_gun",
            walk = "walk_holding_package_all",
            run = "run_aiming_p_all",
            crouch = "coverlow_l",
            crouch_walk = "crouchrunall1",
            glide = "sit_chair",
            jump = "cower"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Head1"] = {
            pos = Vector(50, 25, 0),
            scale = Vector(2, 2, 2)
        }
    },
    moveSpeed = {
        walk = 300,
        run = 900
    },
    movePoseMode = "yaw",
    jumpPower = 400,
    health = 100
})

pk_pills.register("hula", {
    printName = "Игрушка",
    side = "harmless",
    type = "ply",
    model = "models/props_lab/huladoll.mdl",
    noragdoll = true,
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 5),
        dist = 80
    },
    hull = Vector(5, 5, 6),
    anims = {
        default = {
            idle = "idle",
            shake = "shake"
        }
    },
    attack = {
        mode = "auto",
        delay = .2,
        func = function(ply, ent)
            ent:PillAnim("shake")
        end
    },
    moveSpeed = {
        walk = 40,
        run = 100
    },
    health = 5
})

pk_pills.register("wheelbarrow", {
    printName = "Мешок для картошки",
    side = "harmless",
    type = "phys",
    model = "models/props_junk/Wheebarrow01a.mdl",
    default_rp_cost = 3000,
    camera = {
        dist = 120
    },
    driveType = "hover",
    driveOptions = {
        speed = 5,
        height = 40
    },
    health = 5
})

pk_pills.register("baby", {
    printName = "Дитё",
    side = "harmless",
    type = "phys",
    model = "models/props_c17/doll01.mdl",
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 5),
        dist = 80
    },
    driveType = "hover",
    driveOptions = {
        speed = 3,
        height = 20
    },
    health = 2
})

pk_pills.register("facepunch", {
    printName = "Гарри Ньюман",
    side = "wild",
    type = "phys",
    camera = {
        dist = 300
    },
    default_rp_cost = 18000,
    model = "models/props_phx/facepunch_logo.mdl",
    driveType = "fly",
    driveOptions = {
        speed = 60,
        rotation2 = 90
    },
    sounds = {
        fire = "physics/metal/metal_box_impact_hard2.wav"
    },
    health = 25
})

pk_pills.register("sawblade", {
    printName = "Saw Blade",
    side = "wild",
    type = "phys",
    default_rp_cost = 9000,
    model = "models/props_junk/sawblade001a.mdl",
    driveType = "fly",
    driveOptions = {
        speed = 10,
        spin = 200
    },
    sounds = {
        loop_move = "vehicles/v8/third.wav",
        cut = "physics/metal/sawblade_stick1.wav"
    },
    collide = function(ply, ent, collide)
        if collide.HitNormal.z < 0.5 and collide.HitNormal.z > -0.5 then
            local force = -collide.HitNormal
            --GTFO
            ent:GetPhysicsObject():ApplyForceCenter(force * 20000)
            --Give Damage
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(100)
            dmginfo:SetAttacker(ply)
            dmginfo:SetDamageForce(force * -10000)
            collide.HitEntity:TakeDamageInfo(dmginfo)
            ent:PillSound("cut")
        end
    end,
    contactForceHorizontal = true,
    health = 10
})

pk_pills.register("carousel", {
    printName = "Каруселус",
    side = "wild",
    type = "phys",
    camera = {
        dist = 300
    },
    default_rp_cost = 12000,
    model = "models/props_c17/playground_carousel01.mdl",
    driveType = "fly",
    driveOptions = {
        speed = 20,
        spin = 100
    },
    health = 10
})

pk_pills.register("chopper", {
    printName = "Chopper",
    side = "wild",
    type = "phys",
    camera = {
        dist = 300
    },
    default_rp_cost = 12000,
    model = "models/props_c17/TrapPropeller_Blade.mdl",
    driveType = "fly",
    driveOptions = {
        speed = 20,
        spin = -300
    },
    health = 15
})

pk_pills.register("propeller", {
    printName = "Пропелка",
    side = "wild",
    type = "phys",
    camera = {
        dist = 200
    },
    default_rp_cost = 8000,
    options = function()
        return {
            {
                model = "models/props_phx/misc/propeller2x_small.mdl"
            },
            {
                model = "models/props_phx/misc/propeller3x_small.mdl"
            }
        }
    end,
    driveType = "fly",
    driveOptions = {
        speed = 20,
        spin = -300
    },
    health = 25
})

pk_pills.register("turbine", {
    printName = "Турбина",
    side = "wild",
    type = "phys",
    camera = {
        dist = 200
    },
    default_rp_cost = 8000,
    options = function()
        return {
            {
                model = "models/props_phx/misc/paddle_small.mdl"
            },
            {
                model = "models/props_phx/misc/paddle_small2.mdl"
            }
        }
    end,
    driveType = "fly",
    driveOptions = {
        speed = 20,
        spin = -300
    },
    health = 600
})

pk_pills.register("dorf", {
    printName = "Капитан Ебучая Мышь",
    side = "harmless",
    type = "ply",
    model = "models/Eli.mdl",
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 40),
        dist = 60
    },
    hull = Vector(20, 20, 50),
    modelScale = .5,
    anims = {
        default = {
            idle = "lineidle01",
            walk = "walk_all",
            run = "run_all_panicked",
            jump = "jump_holding_jump"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Pelvis"] = {
            scale = Vector(2, 2, 2)
        },
        ["ValveBiped.Bip01_Spine"] = {
            scale = Vector(2, 2, 2)
        },
        ["ValveBiped.Bip01_Spine1"] = {
            scale = Vector(2, 2, 2)
        },
        ["ValveBiped.Bip01_Spine2"] = {
            scale = Vector(2, 2, 2)
        },
        ["ValveBiped.Bip01_Spine4"] = {
            scale = Vector(2, 2, 2)
        },
        ["ValveBiped.Bip01_Head1"] = {
            scale = Vector(4, 4, 4)
        },
        ["ValveBiped.Bip01_L_Clavicle"] = {
            pos = Vector(0, 0, 10)
        },
        ["ValveBiped.Bip01_R_Clavicle"] = {
            pos = Vector(0, 0, -10)
        }
    },
    moveSpeed = {
        walk = 60,
        run = 150
    },
    movePoseMode = "yaw",
    jumpPower = 800,
    health = 40
})

pk_pills.register("babyguardian", {
    printName = "Бабка-Ёжка",
    parent = "antlion_guard",
    side = "harmless",
    type = "ply",
    default_rp_cost = 15000,
    camera = {
        offset = Vector(0, 0, 20),
        dist = 60
    },
    hull = Vector(30, 30, 30),
    modelScale = .25,
    moveSpeed = {
        walk = 90,
        run = 90
    },
    attack = {
        range = 50,
        dmg = 25
    },
    charge = {
        vel = 300,
        dmg = 50
    },
    movePoseMode = "yaw",
    jumpPower = 500,
    health = 25
})
