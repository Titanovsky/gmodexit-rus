AddCSLuaFile()


pk_pills.register("landshark", {
    parent = "ichthyosaur",
    printName = "Landshark",
    default_rp_cost = 50000,
    driveType = "hover",
    driveOptions = {
        speed = 50,
        height = 75
    }
})

pk_pills.register("turbobird", {
    parent = "bird_seagull",
    printName = "Turbobird",
    default_rp_cost = 50000,
    side = "wild",
    camera = {
        offset = Vector(0, 0, 40),
        dist = 200
    },
    hull = Vector(50, 50, 50),
    modelScale = 5,
    health = 1337,
    moveSpeed = {
        walk = 100,
        run = 300
    },
    aim = {},
    anims = {
        default = {
            fly_rate = .5,
            kaboom = "reference"
        }
    },
    sounds = {
        vocalize = "npc/metropolice/vo/dontmove.wav",
        loop_windup = "vehicles/Crane/crane_extend_loop1.wav",
        fire = pk_pills.helpers.makeList("npc/metropolice/pain#.wav", 4)
    },
    attack = {
        mode = "auto",
        func = function(ply, ent)
        end,
        delay = .3
    },
    attack2 = {
        mode = "trigger",
    }
})

pk_pills.register("melon", {
    printName = "Melon",
    type = "phys",
    side = "harmless",
    model = "models/props_junk/watermelon01.mdl",
    default_rp_cost = 800,
    health = 69,
    driveType = "roll",
    driveOptions = {
        power = 300,
        jump = 5000,
        burrow = 6
    },
    sounds = {
        jump = "npc/headcrab_poison/ph_jump1.wav",
        burrow = "npc/antlion/digdown1.wav",
        loop_move = "npc/fast_zombie/gurgle_loop1.wav"
    },
    moveSoundControl = function(ply, ent)
        local MineSpeed = ent:GetVelocity():Length()
        if MineSpeed > 50 then return math.Clamp(MineSpeed / 2, 100, 150) end
    end
})

pk_pills.register("haxman", {
    printName = "Dr. Hax",
    type = "ply",
    side = "wild",
    model = "models/breen.mdl",
    default_rp_cost = 20000,
    aim = {},
    anims = {
        default = {
            idle = "idle_angry_melee",
            walk = "walk_all",
            run = "sprint_all", --pace_all
            crouch = "Crouch_idleD",
            crouch_walk = "Crouch_walk_aLL",
            glide = "jump_holding_glide",
            jump = "jump_holding_jump",
            throw = "swing"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Head1"] = {
            scale = Vector(3, 3, 3)
        }
    },
    sounds = {
        throw = "vo/npc/male01/hacks01.wav"
    },
    moveSpeed = {
        walk = 100,
        run = 1000,
        ducked = 40
    },
    jumpPower = 1000,
    movePoseMode = "yaw",
    health = 10000,
    noFallDamage = true,
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            if not ply:OnGround() then return end
            local computer = ents.Create("pill_proj_prop")
            computer:SetModel("models/props_lab/monitor02.mdl")
            computer:SetPos(ply:EyePos() + ply:EyeAngles():Forward() * 100)
            computer:SetAngles(ply:EyeAngles())
            computer:Spawn()
            computer:SetPhysicsAttacker(ply)
            ent:PillAnim("throw", true)
            ent:PillSound("throw")
        end,
        delay = 5
    }
})

pk_pills.register("crate", {
    printName = "Crate",
    side = "harmless",
    type = "phys",
    model = "models/props_junk/wood_crate001a.mdl",
    default_rp_cost = 200,
    spawnOffset = Vector(0, 0, 30),
    health = 2
})

pk_pills.register("lamp", {
    printName = "Лампа-Ебанат",
    side = "harmless",
    type = "phys",
    model = "models/props_interiors/Furniture_Lamp01a.mdl",
    default_rp_cost = 200,
    spawnOffset = Vector(0, 0, 38),
    health = 2
})

pk_pills.register("cactus", {
    printName = "Кактус-Апельсин",
    side = "harmless",
    type = "phys",
    model = "models/props_lab/cactus.mdl",
    default_rp_cost = 200,
    spawnOffset = Vector(0, 0, 10),
    health = 2
})

pk_pills.register("cone", {
    printName = "Конь",
    side = "harmless",
    type = "phys",
    model = "models/props_junk/TrafficCone001a.mdl",
    default_rp_cost = 200,
    spawnOffset = Vector(0, 0, 25),
    health = 2
})

pk_pills.register("phantom", {
    printName = "Фантом",
    side = "harmless",
    type = "phys",
    model = "models/Gibs/HGIBS.mdl",
    default_rp_cost = 30000,
    spawnOffset = Vector(0, 0, 50),
    camera = {
        distFromSize = true
    },
    sounds = {
        swap = "weapons/bugbait/bugbait_squeeze1.wav",
        nope = "vo/Citadel/br_no.wav",
        spook = "ambient/creatures/town_child_scream1.wav"
    },
    aim = {},
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            local tr = util.QuickTrace(ent:GetPos(), ply:EyeAngles():Forward() * 1000, ent)
            local prop = tr.Entity

            if IsValid(prop) and prop:GetClass() == "prop_physics" and hook.Call("PhysgunPickup", GAMEMODE, ply, prop) then
                local mymdl = ent:GetModel()
                local mypos = ent:GetPos()
                local myangs = ent:GetAngles()
                ent:SetModel(prop:GetModel())
                ent:PhysicsInit(SOLID_VPHYSICS)
                ent:SetMoveType(MOVETYPE_VPHYSICS)
                ent:SetSolid(SOLID_VPHYSICS)
                ent:SetPos(prop:GetPos())
                ent:SetAngles(prop:GetAngles())
                ent:PhysWake()
                prop:SetModel(mymdl)
                prop:PhysicsInit(SOLID_VPHYSICS)
                prop:SetMoveType(MOVETYPE_VPHYSICS)
                prop:SetSolid(SOLID_VPHYSICS)
                prop:SetPos(mypos)
                prop:SetAngles(myangs)
                prop:PhysWake()
                ent:PillSound("swap")
            else
                ent:PillSound("nope")
            end
        end
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            ent:PillSound("spook")
        end
    },
    driveType = "fly",
    driveOptions = {
        speed = 10
    },
    health = 666
})