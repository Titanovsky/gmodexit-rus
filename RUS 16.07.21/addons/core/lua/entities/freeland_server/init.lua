AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()

    self:SetModel( "models/props_lab/partsbin01.mdl" )
    self:SetAngles(Angle(90,0,0))
    self:SetMaterial("phoenix_storms/metalfloor_2-3")


	self:SetMoveType( MOVETYPE_VPHYSICS )

	self:PhysicsInit( SOLID_VPHYSICS )
	
end