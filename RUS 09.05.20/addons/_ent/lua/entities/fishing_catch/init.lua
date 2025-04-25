AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/maxofs2d/companion_doll.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetColor(Color(255,10,0))

    local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end
end

--[[
function ENT:SetCatch(n)

	local ents = {
			"item_ammo_ar2",
			"item_ammo_ar2_altfire",
			"combine_mine",
			"item_ammo_crossbow",
			"item_healthkit",
			"item_healthvial",
			"grenade_helicopter",
			"item_ammo_pistol_large",
			"item_ammo_smg1_large",
			"item_rpg_round",
			"item_battery"
		}

	local npc = {
			"npc_monk",
			"npc_crow",
			"npc_pigeon",
			"npc_kleiner",
			"npc_fastzombie",
			"npc_headcrab",
			"npc_headcrab_black",
			"npc_headcrab_fast",
			"npc_antlionguard"
		}

	if n <= 70 then
		print("da")
		self.more = ents.Create("item_rpg_round")
		self.more:SetPos(self:GetPos() + Vector(0,0,25))
		self.more:Spawn()
	end

	 if n > 70 then
	 	print("net")
		local col = Color( math.random( 0, 255 ), math.random( 0, 255 ), math.random( 0, 255 ), 255 )

		self.fake = ents.Create("npc_headcrab_fast")
		self.fake:SetPos(self:GetPos() + Vector(0,0,15))
		self.fake:SetHealth(250)
		self.fake:SetColor(col)
		self.fake:Spawn()
	end
	self:Remove()
end
]]--

function ENT:Use(ent)

	local col = Color( math.random( 0, 255 ), math.random( 0, 255 ), math.random( 0, 255 ), 150 )

	local entities = {
		"item_ammo_ar2",
		"item_ammo_ar2_altfire",
		"combine_mine",
		"item_ammo_crossbow",
		"item_healthkit",
		"item_healthvial",
		"grenade_helicopter",
		"item_ammo_pistol_large",
		"item_ammo_smg1_large",
		"item_rpg_round",
		"item_battery",
		"breadfish_weap"
	}

	local npc = {
		"npc_monk",
		"npc_crow",
		"npc_pigeon",
		"npc_kleiner",
		"npc_fastzombie",
		"npc_headcrab",
		"npc_headcrab_black",
		"npc_headcrab_fast",
		"npc_antlionguard"
	}

	local n = math.random(1, 2)


	if n == 1 then
		self.catch = ents.Create(table.Random(entities))
		self.catch:Spawn()
		self.catch:SetPos(self:GetPos())
	end
	if n == 2 then
		self.catch = ents.Create(table.Random(npc))
		self.catch:SetPos(self:GetPos() + Vector(0,0,15))
		self.catch:SetHealth(250)
		self.catch:SetColor(col)
		self.catch:Spawn()
	end
	self:Remove()
end


