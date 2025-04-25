AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_junk/cardboard_box001a.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetNWInt( "donate", 0 )
end

function ENT:Use( ent )
	if ent == self:CPPIGetOwner() then
		ent:ChatPrint( "Вы собрали:"..self:GetNWInt("donate") )
		ent:RUB_add( tonumber( self:GetNWInt("donate") ) )
		self:SetNWInt( "donate", 0 )
		return
	end
	if ent:GetNWInt("rub") > 500 and IsValid( self:CPPIGetOwner() ) then
		ent:RUB_minus( 500 )
		ent:ChatPrint("Вы пожертвовали: 500 рубаксов")
		self:SetNWInt( "donate", self:GetNWInt("donate") + 500 )
	end
end
