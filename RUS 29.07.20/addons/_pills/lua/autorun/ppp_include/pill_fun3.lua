AddCSLuaFile()

pk_pills.register("parakeet", {
    parent = "bird_pigeon",
    printName = "ЛЯГУШКА",
    visColorRandom = true,
    reload = function(ply, ent)
        local egg = ents.Create("prop_physics")
        egg:SetModel("models/props_phx/misc/egg.mdl")
        local ang = ply:EyeAngles()
        ang.p = 0
        egg:SetPos(ply:EyePos() + ang:Forward() * 30)
        egg:Spawn()
        local phys = egg:GetPhysicsObject()

        if IsValid(phys) then
            phys:SetVelocity(ply:GetVelocity() + ply:EyeAngles():Forward() * 800 + (ply:IsOnGround() and Vector(0, 0, 600) or Vector()))
        end

        egg:Fire("FadeAndRemove", nil, 10)
    end,
    sounds = {
        vocalize = pk_pills.helpers.makeList("ambient/levels/canals/swamp_bird#.wav", 6)
    }
})

pk_pills.register("error", {
    printName = "/content",
    side = "harmless",
    type = "ply",
    model = "models/error.mdl",
    noragdoll = true,
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 25),
        dist = 100
    },
    hull = Vector(80, 80, 80),
    anims = {},
    moveSpeed = {
        walk = 200,
        run = 400
    },
    jumpPower = 55,
    health = 2^3
})
