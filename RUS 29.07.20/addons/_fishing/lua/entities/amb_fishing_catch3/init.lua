AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

local COLOR_CATCH = Color( 191, 54, 54 )

function ENT:Initialize()
	self:SetModel( "models/Gibs/HGIBS.mdl" )
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
	"item_ammo_crossbow",
	"item_healthkit",
	"item_healthvial",
	"item_ammo_pistol_large",
	"item_ammo_smg1_large",
	"item_rpg_round",
	"item_battery"
}

local weapons_pack = {
	"weapon_frag",
	"weapon_rpg",
	"weapon_crossbow",
}

local npcs = {
	"npc_fastzombie",
	"npc_headcrab",
	"npc_headcrab_black",
	"npc_headcrab_fast",
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

	if ( nType >= 1 ) and ( nType < 30 ) then
		catch = ents.Create( "prop_physics" )
		catch:SetModel( table.Random( prop_pack ) )
		catch:SetPos( self:GetPos() + Vector( 5,0,25 ) )
		catch:Spawn()
		timer.Simple( 2, function()
			if ( IsValid(catch) ) then catch:Remove() end
		end)
	elseif ( nType >= 30 ) and ( nType < 32 ) then
		ePly:Kill()
		ePly:ChatPrint("Вы поймали Suicide-Рыбу!")
	elseif ( nType >= 32 ) and ( nType < 34 ) then
		ePly:StripWeapons()
		ePly:ChatPrint("Пока Вы мастурбировали, какой-то игрок украл Ваш улов и вещи!")
	elseif ( nType >= 34 ) and ( nType < 44 ) then
		catch = ents.Create( "npc_antlionguard" )
		catch:SetPos( self:GetPos() + Vector( 5,0,35 ) )
		catch:SetHealth( 8000 )
		catch:Spawn()
		catch:SetColor( COLOR_BOSS )
		catch:SetModelScale( catch:GetModelScale() * 2 , 1 )
	elseif ( nType >= 44 ) and ( nType < 65 ) then
		self.catch = ents.Create( table.Random( weapons_pack ) )
		self.catch:SetPos( self:GetPos() + Vector( 5,0,25 ) )
		self.catch:Spawn()
	elseif ( nType >= 65 ) and ( nType < 90 ) then
		self.catch = ents.Create( table.Random( ents_pack ) )
		self.catch:SetPos( self:GetPos() + Vector( 5,0,25 ) )
		self.catch:Spawn()
	elseif ( nType >= 90 ) and ( nType <= 100 ) then
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


