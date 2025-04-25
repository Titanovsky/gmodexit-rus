AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

-- 1 до 20: nothing
-- 20 до 30: NPC
-- 30 до 40: NPC Boss
-- 40 до 50: Пушки
-- 50 до 60: Полезные ентити
-- 60 до 65: Денежный мешок
-- 65 до 99: Ентити Проп, которые исчезает
-- 99 до 100: Донат Денежный-Кейс

local model_rand = {
	"models/props_combine/breenbust.mdl",
	"models/props_lab/jar01b.mdl",
	"models/Gibs/HGIBS.mdl"
}

local COLOR_CATCH = Color( 237, 123, 205 )

function ENT:Initialize()
	self:SetModel( table.Random( model_rand ) )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetColor( COLOR_CATCH )

    local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
end

local ents_pack = {
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

local weapons_pack = {
	"gmod_camera",
	"weapon_pistol",
	"weapon_frag",
	"weapon_rpg",
	"weapon_crossbow",
	"weapon_smg1",
	"weapon_357",
	"weapon_stunstick",
	"weapon_fists"
}

local npcs = {
	"npc_monk",
	"npc_crow",
	"npc_pigeon",
	"npc_kleiner",
	"npc_fastzombie",
	"npc_headcrab",
	"npc_headcrab_black",
	"npc_headcrab_fast",
	"npc_cscanner",
	"npc_clawscanner",
	"npc_stalker",
	"npc_alyx",
	"npc_dog",
	"npc_gman",
	"npc_vortigaunt",
	"npc_antlion",
	"npc_zombie",
}

local prop_pack = {
	"models/props_junk/Shoe001a.mdl",
	"models/props_junk/MetalBucket01a.mdl",
	"models/props_lab/binderbluelabel.mdl",
	"models/props_wasteland/wheel03a.mdl",
	"models/hunter/blocks/cube8x8x8.mdl"
}

local COLOR_BOSS = Color( 162, 18, 201, 255 )

function ENT:makeCatch( ePly, nType )
	local col_npc = Color( math.random(1, 255), math.random(1, 255), math.random(1, 255) )

	if ( nType >= 1 ) and ( nType < 40 ) then
		catch = ents.Create( "prop_physics" )
		catch:SetModel( table.Random( prop_pack ) )
		catch:SetPos( self:GetPos() + Vector( 5,0,25 ) )
		catch:Spawn()
		timer.Simple( 2, function()
			if ( IsValid(catch) ) then catch:Remove() end
		end)
	elseif ( nType >= 40 ) and ( nType < 42 ) then
		ePly:Kill()
		ePly:ChatPrint("Вы поймали Banhammer-Рыбу!")
		ePly:ChatPrint("Она хотела Вас забанить! Но Titanovsky спас Вас ;3")
		ePly:ChatPrint("Аккуратно рыбачьте, есть шанс быть забаненным этой рыбкой!")
	elseif ( nType >= 42 ) and ( nType < 46 ) then
		ePly:StripWeapons()
		ePly:ChatPrint("Вы поймали Hui-Рыбу!")
		ePly:ChatPrint("Она конфисковала Ваше оружие..")
	elseif ( nType >= 46 ) and ( nType < 50 ) then
		ePly:ChatPrint("Вы поймали Золотую Рыбку!")
		ePly:ChatPrint("Введите в консоль quit admin, чтобы получить админку.")
	elseif ( nType >= 50 ) and ( nType < 55 ) then
		ePly:ChatPrint("Вы поймали Магический Денежный Мешок!")
		ePly:ChatPrint("Он появился где-то на карте, найдите его и 1 миллиард Ваш!")
	elseif ( nType >= 55 ) and ( nType < 60 ) then
		ePly:Spawn()
		ePly:ChatPrint("Вы поймали Чудо-Рыбу!")
		ePly:ChatPrint("Она загнала вас во Временную Воронку, выберетесь из неё...")
	elseif ( nType >= 60 ) and ( nType < 70 ) then
		self.catch = ents.Create( table.Random( npcs ) )
		self.catch:SetHealth( 25 )
		self.catch:SetColor( col_npc )
		self.catch:Spawn()
		self.catch:SetPos( self:GetPos() + Vector( 5,0,25 ) )
	elseif ( nType >= 70 ) and ( nType < 72 ) then
		catch = ents.Create( "npc_combine_s" )
		catch:SetPos( self:GetPos() + Vector( 5,0,35 ) )
		catch:SetHealth( 6000 )
		catch:Spawn()
		catch:SetColor( COLOR_BOSS )
		catch:SetModelScale( catch:GetModelScale() * 1.6 , 1 )
		catch:Give("weapon_ar2")
		catch:SetModel("models/Combine_Super_Soldier.mdl")
	elseif ( nType >= 72 ) and ( nType < 86 ) then
		self.catch = ents.Create( table.Random( weapons_pack ) )
		self.catch:SetPos( self:GetPos() + Vector( 5,0,25 ) )
		self.catch:Spawn()
	elseif ( nType >= 86 ) and ( nType < 98 ) then
		self.catch = ents.Create( table.Random( ents_pack ) )
		self.catch:SetPos( self:GetPos() + Vector( 5,0,25 ) )
		self.catch:Spawn()
	elseif ( nType >= 98 ) and ( nType <= 100 ) then
		self.catch = ents.Create( "amb_money" )
		self.catch:SetPos( self:GetPos() + Vector( 5,0,25 ) )
		self.catch:Spawn()
	end
end


function ENT:Use( eEnt )

	local num = math.random( 1, 100 )
	self:GetParent():SetNWBool( "OnBusy", false ) -- ?
	self:makeCatch( eEnt, num )
	self:Remove()

end


