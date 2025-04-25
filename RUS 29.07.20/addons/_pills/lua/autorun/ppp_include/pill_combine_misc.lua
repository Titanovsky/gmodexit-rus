AddCSLuaFile()

pk_pills.register("stalker", {
    printName = "Stalker",
    type = "ply",
    model = "models/stalker.mdl",
    default_rp_cost = 8000,
    side = "hl_combine",
    health = 100,
    duckBy = 0,
    anims = {
        default = {
            idle = "idle01",
            walk = "walk_all"
        }
    },
    aim = {},
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            local target = ents.Create("info_target")
            target:SetPos(ply:GetEyeTrace().HitPos + ply:EyeAngles():Forward() * 20)
            target:SetName("laser_target_" .. ent:EntIndex() .. "_" .. os.time())
            target:Spawn()
            local beam = ents.Create("env_laser")
            beam:SetPos(ply:EyePos() + ply:EyeAngles():Forward() * 30)
            beam:SetKeyValue("texture", "materials/cable/redlaser.vmt")
            beam:SetKeyValue("damage", 100)
            beam:SetKeyValue("width", 2)
            beam:SetKeyValue("dissolvetype", 0)
            beam:SetKeyValue("LaserTarget", target:GetName())
            beam:Spawn()
            beam:Fire("turnon", "", 0)
            ply:Freeze(true)
            ent:PillLoopSound("laser")
            ent:PillSound("laser_start")

            timer.Simple(2, function()
                if IsValid(target) then
                    target:Remove()
                end

                if IsValid(beam) then
                    beam:Remove()
                end

                ply:Freeze(false)

                if IsValid(ent) then
                    ent:PillLoopStop("laser")
                end
            end)
        end
    },
    sounds = {
        loop_laser = "npc/stalker/laser_burn.wav",
        laser_start = "weapons/gauss/fire1.wav",
        step = {"npc/stalker/stalker_footstep_left1.wav", "npc/stalker/stalker_footstep_left2.wav", "npc/stalker/stalker_footstep_right1.wav", "npc/stalker/stalker_footstep_right2.wav"}
    },
    moveSpeed = {
        walk = 50,
        run = 100
    },
    jumpPower = 0
})
