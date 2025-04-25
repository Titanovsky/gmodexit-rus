AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local COLOR_BAIT = Color( 237, 187, 47 )

function ENT:Initialize()
	self:SetModel( "models/props_junk/watermelon01.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetNWBool( "OnLoad", false )
    self:SetColor( COLOR_BAIT )
	self:SetMaterial( "models/debug/debugwhite" )

    local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
end

function ENT:Touch( eEntity )
	if ( eEntity:GetClass() == "amb_fishing_hook" ) then
		self.hook = eEntity
		if self.hook:GetNWBool("OnBusy") == false then
			self.hook:SetNWBool("OnBusy", true) -- fix: теперь нельзя дофига наживок в один hook
			-- print("net: "..tostring( self.hook:GetNWBool("OnBusy") ) ) -- debug
			self:SetPos( self.hook:GetPos() + Vector(0,0,10) )
			constraint.Weld(
				self.hook, self, 0,
				0,
				false, false
			)
			self:SetNWBool("OnLoad", true)
		end
	end
end

function ENT:Think()
	if ( self:WaterLevel() > 2 ) and ( self:GetNWBool("OnLoad") ) then
		if not timer.Exists( "AmbFishing[timer]"..self:EntIndex() ) then -- это обязательно иначе бум бум будте
			self.hook:SetColor( Color( 255, 0, 0 ) )
			timer.Create( "AmbFishing[timer]"..self:EntIndex(), math.random( 8, 21 ), 1, function()
				self.hook:SetColor( Color( 0, 255, 0 ) )
				if ( self:WaterLevel() > 2 ) and ( self:GetNWBool("OnLoad") ) then
					local rand = math.random( 0, 1 )
					self.hook:SetNWBool( "OnCatch", true )
					if rand == 0 then
						self.hook:TakeCatch()
					else
						self:CPPIGetOwner():ChatPrint('Не повезло с рыбалочкой :(')
					end
					if IsValid( self ) then
						self:Remove()
					end
				end
			end )
		end
	end
end
