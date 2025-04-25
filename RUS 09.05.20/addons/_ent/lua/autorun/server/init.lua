-- -4344.64, -1051.19, 250.29

local tab_v = Vector(-4344.64, -1051.19, 250.29)
local tab_ang = Angle(0, 270, 0)

local chair1_v = Vector(-3398.96, -1055.08, 254.95)
local chair2_v = Vector(-3279.14, -1055.14, 255.16)
local chair3_v = Vector(-3159.32, -1055.21, 255.38)
local chair4_v = Vector(-3039.51, -1055.26, 255.59)
local chair5_v = Vector(-2919.68, -1055.31, 255.81)
local chair6_v = Vector(-2799.86, -1055.37, 256.02)
local chair7_v = Vector(-2680.04, -1055.43, 228.23)
local chair8_v = Vector(-2560.22, -1055.49, 256.44)
local chair9_v = Vector(-2440.40, -1055.55, 256.66)
local chair10_v = Vector(-3153, -2131, 270)
local chair11_v = Vector(-3151, -2226, 270)
local chair12_v = Vector(-2384, -1062, 240)
local chair_ang = Angle(0, 240, 0)

local btn_v = Vector(-5245.68, -1919.18, 329.5)
local btn_ang = Angle(90,0,0)

local donate_v = Vector(-4300, -2990, 252)
local donate_ang = Angle(0,90,0)

local entity = { 
	"into_table",
	"button_random",
	"chair_*",
	"npc_igs"
}


function ru_EntsInit()


	for _, v in pairs(ents.FindByClass(tostring(entity))) do
		if IsValid(v) then
			v:Remove()
		end
	end


	local tab = ents.Create("info_table")
	tab:SetPos(tab_v)
	tab:SetAngles(tab_ang)
	tab:Spawn()

	local chair1 = ents.Create("chair_spooky")
	chair1:SetPos(chair1_v)
	chair1:SetAngles(chair_ang)
	chair1:Spawn()

	local chair2 = ents.Create("chair_kona")
	chair2:SetPos(chair2_v)
	chair2:SetAngles(chair_ang)
	chair2:Spawn()

	local chair3 = ents.Create("chair_ghost")
	chair3:SetPos(chair3_v)
	chair3:SetAngles(chair_ang)
	chair3:Spawn()

	local chair4 = ents.Create("chair_aclapac")
	chair4:SetPos(chair4_v)
	chair4:SetAngles(chair_ang)
	chair4:Spawn()

	local chair5 = ents.Create("chair_extradip")
	chair5:SetPos(chair5_v)
	chair5:SetAngles(chair_ang)
	chair5:Spawn()

	local chair6 = ents.Create("chair_wet")
	chair6:SetPos(chair6_v)
	chair6:SetAngles(chair_ang)
	chair6:Spawn()

	local chair7 = ents.Create("chair_titanovsky")
	chair7:SetPos(chair7_v)
	chair7:SetAngles(chair_ang)
	chair7:Spawn()

	local chair8 = ents.Create("chair_asher")
	chair8:SetPos(chair8_v)
	chair8:SetAngles(chair_ang)
	chair8:Spawn()

	local chair9 = ents.Create("chair_frisk")
	chair9:SetPos(chair9_v)
	chair9:SetAngles(chair_ang)
	chair9:Spawn()

	local chair10 = ents.Create("chair_unicode")
	chair10:SetPos(chair10_v)
	chair10:SetAngles(Angle(0,-135,0))
	chair10:Spawn()

	local chair11 = ents.Create("chair_scorpion")
	chair11:SetPos(chair11_v)
	chair11:SetAngles(Angle(0,135,0))
	chair11:Spawn()

	local chair12 = ents.Create("chair_sad")
	chair12:SetPos(chair12_v)
	chair12:SetAngles(chair_ang)
	chair12:Spawn()

	local btn = ents.Create("button_random")
	btn:SetPos(btn_v)
	btn:SetAngles(btn_ang)
	btn:Spawn()

	local donate = ents.Create("npc_igs")
	donate:SetPos(donate_v)
	donate:SetAngles(donate_ang)
	donate:Spawn()
end

hook.Add("PostCleanupMap", "dont_remove_post_cleanup", function() 
	ru_EntsInit()
end)

hook.Add("Initialize", "spawn_ent_init", function() 
	ru_EntsInit()
end)



--hook.Add("CreateEntityRagdoll", "npc_remove_ragdoll", function( owner, ragdoll ) 
--	ragdoll:Remove()
--end)
