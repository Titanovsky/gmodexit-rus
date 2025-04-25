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

local COLOR_CATCH = Color( 90, 237, 220 )

function ENT:Initialize()
	self:SetModel( table.Random( model_rand ) )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetColor( COLOR_CATCH )

    local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
end

local ents_pack = {
	"item_ammo_ar2",
	"combine_mine",
	"item_ammo_crossbow",
	"item_healthkit",
	"item_healthvial",
	"grenade_helicopter",
	"item_battery"
}

local weapons_pack = {
	"gmod_camera",
	"weapon_pistol",
	"weapon_smg1",
	"weapon_357",
	"weapon_stunstick",
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
	"npc_gman",
	"npc_vortigaunt",
	"npc_zombie",
}


local prop_pack = {
	"models/props_junk/Shoe001a.mdl",
	"models/props_junk/MetalBucket01a.mdl",
	"models/props_lab/binderbluelabel.mdl",
	"models/props_wasteland/wheel03a.mdl",
	"models/hunter/blocks/cube8x8x8.mdl"
}


function ENT:makeCatch( ePly, nType )

	if ( nType >= 1 ) and ( nType < 50 ) then
		catch = ents.Create( "prop_physics" )
		catch:Spawn()
		catch:SetModel( table.Random( prop_pack ) )
		catch:SetPos( self:GetPos() + Vector( 5,0,25 ) )
		timer.Simple( 2, function()
			if ( IsValid( catch ) ) then catch:Remove() end
		end)
	elseif ( nType >= 50 ) and ( nType < 100 ) then
		ePly:Kill()
		ePly:ChatPrint("Вы поймали Banhammer-Рыбу!")
		ePly:ChatPrint("Она хотела Вас забанить! Но Titanovsky спас Вас ;3")
		ePly:ChatPrint("Аккуратно рыбачьте, есть шанс быть забаненным этой рыбкой!")
	end
end


function ENT:Use( eEnt )

	local num = math.random( 1, 100 )
	self:GetParent():SetNWBool( "OnBusy", false ) -- ?
	self:makeCatch( eEnt, num )
	self:Remove()

end


