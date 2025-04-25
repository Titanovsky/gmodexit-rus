AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/maxofs2d/button_02.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:PhysicsInit( SOLID_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:EnableMotion( false )
	end
end

function ENT:Use( ePly )
	if ( ePly:IsPlayer() ) then
		ePly:ChatPrint("Эта кнопка должна делать стандарт. ивенты (Зомби, денеж. дождь)")
		ePly:ChatPrint("Но я не успел её закончить =/")
		ePly:ChatPrint("Кста, Донатик мотивирует меня делать что-либо")
		ePly:ChatPrint(">> F4")
	end
end
