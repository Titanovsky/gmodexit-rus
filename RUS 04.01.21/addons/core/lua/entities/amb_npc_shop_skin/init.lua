AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local NPC_MDL = "models/mossman.mdl" -- моделька

function ENT:Initialize()
	self:SetModel( NPC_MDL )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:CapabilitiesAdd( CAP_TURN_HEAD )
	self:DropToFloor()
	self:SetUseType( SIMPLE_USE )

	local ph = self:GetPhysicsObject()
	if ( IsValid( ph ) ) then
		ph:EnableMotion( false )
	end
end

function ENT:Use( ePly )
	ePly:SendLua( "AmbShopCloth.openShop()" ) -- а почему бы и нет?)
end