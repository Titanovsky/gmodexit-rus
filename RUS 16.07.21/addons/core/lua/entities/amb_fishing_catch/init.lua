AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

local COLOR_CATCH = Color( 90, 237, 220 )

function ENT:Initialize()
	self:SetModel( 'models/Items/item_item_crate.mdl' )
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


local weapons_pack = {
	'arccw_deagle357',
	'arccw_aug',
	'arccw_m4a1',
	'arccw_m14',
	'arccw_makarov',
	'arccw_m1014',
	'arccw_deagle50',
	'arccw_ruger',
	'arccw_pradit1911',
	'arccw_minigun',
	'arccw_rpg7',
	'arccw_sg552',
	'arccw_fml_tec9',
	'arccw_db_sawnoff',
	'arccw_fml_python'
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
	"npc_zombie"
}


local prop_pack = {
	"models/props_junk/Shoe001a.mdl",
	"models/props_junk/MetalBucket01a.mdl",
	"models/props_lab/binderbluelabel.mdl",
	"models/props_wasteland/wheel03a.mdl",
	"models/hunter/blocks/cube8x8x8.mdl"
}

function ENT:makeCatch( ePly, nType )

	if ( nType >= 1 and nType < 20 ) then

		ePly:ChatPrint( 'Вы ничего не поймали!' )

	elseif ( nType >= 20 and nType < 50 ) then

		catch = ents.Create( 'prop_physics' )
		catch:SetModel( table.Random( prop_pack ) )
		catch:SetPos( self:GetPos() + Vector( 6, 0, 28 ) )
		catch:PhysicsInit( 6 )
		catch:Spawn()

		timer.Simple( math.random( 2, 8 ), function()
			if ( IsValid( catch ) ) then catch:Remove() end
		end )

	elseif ( nType == 50 ) then

		ePly:Spawn()
		ePly:ChatPrint( 'Вы поймали Banhammer-Рыбу!' )
		ePly:ChatPrint( 'Она хотела Вас забанить! Но Titanovsky спас Вас ;3' )
		ePly:ChatPrint( 'Аккуратно рыбачьте, есть шанс быть забаненным этой рыбкой!' )

	elseif ( nType == 51 ) then

		ePly:SetPos( VectorRand() )
		ePly:ChatPrint( 'Вы поймали Телепортатора-Рыбу' )
		ePly:ChatPrint( 'Она посчитала вас своим кормом и вы попали во Временную Ловушку!' )

	elseif ( nType == 52 ) then

		ePly:SetVelocity( Vector( math.random( 20, 400 ), math.random( 20, 400 ), math.random( 20,400 ) ) )
		ePly:ChatPrint( 'Вы поймали Дура-Рыбу!' )
		ePly:ChatPrint( 'Она потревожила Вас!' )

	elseif ( nType == 53 ) then

		AmbStats.Players.addStats( ePly, '$', 100 )
		ePly:ChatPrint( 'Вы поймали Денежную-Рыбу!' )

	elseif ( nType == 54 ) then

		ePly:ChatPrint( 'Вы поймали Рыбу!' )
		ePly:ChatPrint( 'И сожрали её..' )

	elseif ( nType == 55 ) then

		ePly:ChatPrint( 'Вы поймали Шоколадис-Рыбу!' )
		ePly:ChatPrint( 'И схрумкали её..' )

	elseif ( nType == 56 ) then

		ePly:Kill()
		ePly:ChatPrint( 'Вы поймали Суицид-Рыбу!' )

	elseif ( nType == 57 ) then

		ePly:SetPos( Vector( 0, 0, 0 ) )
		ePly:ChatPrint( 'Вы поймали Хохла-Рыбу!' )
		ePly:ChatPrint( 'Она отправила вас вна Украину' )

	elseif ( nType == 58 ) then

		ePly:Give( table.Random( weapons_pack ) )
		ePly:ChatPrint( 'Вы поймали Рыбу-Опустошителя!' )
		ePly:ChatPrint( 'У вас появились кучу пушек!' )

	elseif ( nType == 59 ) then

		if IsValid( self.hook ) then self.hook:SetColor( 255, 0, 0 ) end
		ePly:ChatPrint( 'Крючок немного повредился!' )

	elseif ( nType >= 60 ) and ( nType < 70 ) then

		AmbStats.Players.addStats( ePly, '$', math.random( 8, 64 ) )

	elseif ( nType >= 70 ) and ( nType < 100 ) then

		local npc = ents.Create( table.Random( npcs ) )
		npc:SetPos( self:GetPos() + Vector( 5, 0, 40 ) )
		npc:Spawn()
		undo.Create( 'NPC from fishing: '..npc:GetModel() )
			undo.AddEntity( npc )
			undo.SetPlayer( ePly )
		undo.Finish()

	elseif ( nType == 100 ) then

		ePly:ChatPrint( "Вы поймали ВСЁ СРАЗУ!" )

	end

end


function ENT:Use( eEnt )

	local num = math.random( 1, 100 )
	self:GetParent():SetNWBool( 'OnBusy', false )
	self:makeCatch( eEnt, num )
	self:Remove()
end


