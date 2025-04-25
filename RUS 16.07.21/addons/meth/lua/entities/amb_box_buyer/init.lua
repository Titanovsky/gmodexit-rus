AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_junk/wood_crate001a.mdl" )
    self:SetMoveType(MOVETYPE_NONE)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetNWBool( "IsActive", false )

    local phys = self:GetPhysicsObject()
    if ( IsValid( phys ) ) then phys:EnableMotion(false) end
end

function ENT:Use( ent )
    local sum = math.random( 24, 800 )
    if ( self:GetNWBool("IsActive") ) then
        AmbStats.Players.addStats( ent, '$', sum )
        ent:ChatPrint( "Вы выйграли: "..sum )
        self:Remove()
    else
        ent:ChatPrint("Положите в ящик покупателя наркотиков удовлетворённого")
    end
end

function ENT:Touch( ent )
	-- print( ent ) -- debug
    if ( ent:GetClass() == "eml_buyer" ) and ( ent:GetNWBool("IsSmile") ) and ( ent:GetNWBool("IsActive") == false ) then
        ent:Remove()
        self:SetNWBool( "IsActive", true )
    end
end

