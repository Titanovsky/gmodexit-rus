local tab_v = Vector( -10590, -11455, -11135 )
local tab_ang = Angle(0, 0, 0)

local rock1_v = Vector( -1915, -5156, -8165 + 64 )
local rock2_v = Vector( -1790, -5156, -8161 + 61 )
local rock_ang = Angle(0, 0, 0)

local btn_rand = Vector( -9295, -11198, -11078 )
local btn_ang = Angle( 90, -90, 180 )

local btn_event = Vector( -9187, -11198, -11078 )
local btn_event_ang = Angle( 90, -90, 180 )

local chair1_v = Vector(-2377, -2069, -8188)
local chair2_v = Vector(-2377 + 64, -2069, -8188)
local chair3_v = Vector(-2377 + 64 * 2, -2069, -8188)
local chair4_v = Vector(-2377 + 64 * 3, -2069, -8188)
local chair5_v = Vector(-2377 + 64 * 4, -2069, -8188)
local chair6_v = Vector(-2377 + 64 * 5, -2069, -8188)
local chair7_v = Vector(-2377 + 64 * 6, -2069, -8188)
local chair8_v = Vector(-2377 + 64 * 7, -2069, -8188)
local chair9_v = Vector(-2377 + 64 * 8, -2069, -8188)
local chair10_v = Vector(-2377 + 64 * 9, -2069, -8188)
local chair11_v = Vector(-2377 + 64 * 10, -2069, -8188)
local chair12_v = Vector(-2377 + 64 * 11, -2069, -8188)
local chair13_v = Vector(-2377 + 64 * 12, -2069, -8188)
local chair14_v = Vector(-2377 + 64 * 13, -2069, -8188)
local chair_ang = Angle(0, 240, 0)

local donate_v = Vector(-4452.884277, -3923.482666, -8076.307617)
local donate_ang = Angle(0,-100,0)

local entity = {
	"func_button",
	"func_brush",
	"func_reflective_glass"
}

function ru_RemoveBadEntities()
	for _, v in pairs( entity ) do
		for _, ent in pairs( ents.FindByClass( v ) ) do
			if IsValid( ent ) then ent:Remove() end
		end
	end
end

local fog_start = "500"
local fog_end = "10009"

function ru_InitFog()
	for _, fog in pairs( ents.GetAll() ) do
		if fog:GetClass() == "env_fog_controller" then
			fog:SetKeyValue( "fogenable", "true" )
			fog:SetKeyValue( "fogstart", fog_start )
			fog:SetKeyValue( "fogend", fog_end )
			fog:SetKeyValue( "farz", fog_end )
			fog:SetKeyValue( "fogcolor", "255 148 148" )
		end
	end
end

function ru_EntsInit()
	local npc_donate = ents.Create("npc_igs")
	npc_donate:SetPos( donate_v )
	npc_donate:SetAngles(donate_ang)
	npc_donate:Spawn()
	local npc_donate_phys = npc_donate:GetPhysicsObject()
    if IsValid(npc_donate_phys) then npc_donate_phys:EnableMotion( false ) end

    local inter_teleport = ents.Create("inter_teleport")
	inter_teleport:SetPos( Vector(-11071 - 36, -10559 + 12, -11077 + 50) )
	inter_teleport:Spawn()
	inter_teleport:SetAngles( Angle(0, -90,0) )

	local btn1 = ents.Create("amb_button_random")
	btn1:SetPos( btn_rand )
	btn1:Spawn()
	btn1:SetAngles( btn_ang )

	local btn2 = ents.Create("amb_button_event")
	btn2:SetPos( btn_event )
	btn2:Spawn()
	btn2:SetAngles( btn_event_ang )


	local tab = ents.Create("info_table")
	tab:SetPos( tab_v )
	tab:SetAngles(tab_ang)
	tab:DropToFloor()
	tab:Spawn()
	local tab_phys = tab:GetPhysicsObject()
    if IsValid(tab_phys) then tab_phys:EnableMotion( false ) end


	local rock1 = ents.Create("amb_mine_rock")
	rock1:SetPos( rock1_v )
	rock1:SetAngles(rock_ang)
	rock1:Spawn()

	local rock2 = ents.Create("amb_mine_rock")
	rock2:SetPos( rock2_v )
	rock2:SetAngles(rock_ang)
	rock2:Spawn()

	local chair7 = ents.Create("chair_titanovsky")
	chair7:SetPos(chair7_v)
	chair7:SetAngles(chair_ang)
	chair7:Spawn()

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
	chair10:SetAngles(chair_ang)
	chair10:Spawn()

	local chair11 = ents.Create("chair_scorpion")
	chair11:SetPos(chair11_v)
	chair11:SetAngles(chair_ang)
	chair11:Spawn()

	local chair12 = ents.Create("chair_sad")
	chair12:SetPos(chair12_v)
	chair12:SetAngles(chair_ang)
	chair12:Spawn()

	local chair13 = ents.Create("chair_combine")
	chair13:SetPos(chair13_v)
	chair13:SetAngles(chair_ang)
	chair13:Spawn()

	local chair14 = ents.Create("chair_zozda")
	chair14:SetPos(chair14_v)
	chair14:SetAngles(chair_ang)
	chair14:Spawn()

end

hook.Add("PostCleanupMap", "dont_remove_post_cleanup", function()
	ru_RemoveBadEntities()
	ru_EntsInit()
	--ru_InitFog()
end)

hook.Add("Initialize", "spawn_ent_init", function()
	timer.Simple( 10, function()
		ru_RemoveBadEntities()
		ru_EntsInit()
		--ru_InitFog()
	end)
end)


--hook.Add("CreateEntityRagdoll", "npc_remove_ragdoll", function( owner, ragdoll )
--	ragdoll:Remove()
--end)
