AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_junk/meathook001a.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetNWBool("OnCatch", false) -- наживки нет?
	self:SetNWBool("OnBusy", false) -- наживки нет?

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
end

function ENT:TakeCatch()
	if ( self:GetNWBool("OnCatch") ) then -- поймал наживку?
		self.catch = ents.Create( "amb_fishing_catch" )
		self.catch:Spawn()
		self.catch:SetPos( self:GetPos() )
		self.catch:SetParent( self )
	end
end

function ENT:Use() -- запилил, чтобы ни только на добычку можно было нажать, но и на хук!
	if ( self:GetNWBool( "OnCatch" ) ) then
		self:SetNWBool( "OnBusy", false )
		self:SetNWBool( "OnCatch", false )
		if IsValid( self.catch ) then
			self.catch:SetParent( nil ) -- не помню
			self.catch:SetPos( self:GetPos() )
		end
	end
end

function ENT:OnRemove()
	if ( IsValid( self.catch ) ) then
		self.catch:Remove()
	end
end

