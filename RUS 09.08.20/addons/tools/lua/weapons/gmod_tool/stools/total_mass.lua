TOOL.Category		= "Construction"
TOOL.Name			= "#tool.total_mass.listname"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar["size"] = "48"
TOOL.ClientConVar["radius"] = "512"
TOOL.ClientConVar["unit"] = "kg"

TOOL.SelectedProps = {}

local weight = {
	["g"]  = 1000,
	["kg"] = 1,
	["t"]  = 0.001,
	["oz"] = 1 / 0.028349523125,
	["lb"] = 1 / 0.45359237,
}

if SERVER then
	util.AddNetworkString( "total_mass_indicatorpos" )
else
	language.Add( "tool.total_mass.listname", "Total Mass" )
	language.Add( "tool.total_mass.name", "Total Mass Tool" )
	language.Add( "tool.total_mass.desc", "Get the total mass and the center of gravity of a contraption" )
	language.Add( "tool.total_mass.0", "Primary: Select (+Shift to select all, +Use to area select)   Secondary: Get total mass   Reload: Clear selection" )
	
	local IndicatorEnt
	local IndicatorPos
	local IndicatorSize = 24

	cvars.AddChangeCallback( "total_mass_size", function( _, _, new )
		IndicatorSize = tonumber( new ) / 2
	end)
	
	local function inview( pos2D )
		if	pos2D.x > -ScrW() and
			pos2D.y > -ScrH() and
			pos2D.x < ScrW() * 2 and
			pos2D.y < ScrH() * 2 then
				return true
		end
		return false
	end
	
	local function GetDisplayPos()
		IndicatorEnt = net.ReadEntity()
		IndicatorPos = Vector( net.ReadFloat(), net.ReadFloat(), net.ReadFloat() )
	end
	net.Receive( "total_mass_indicatorpos", GetDisplayPos )
	
	function TOOL:DrawHUD()
		if not IsValid( IndicatorEnt ) then return end
		local point = IndicatorEnt:LocalToWorld( IndicatorPos ):ToScreen()
		if inview( point ) then
			surface.SetDrawColor( 0, 255, 0 )
			surface.DrawLine( point.x - IndicatorSize, point.y, point.x + IndicatorSize, point.y )
			surface.DrawLine( point.x, point.y + IndicatorSize, point.x, point.y - IndicatorSize )
		end
	end
	
	function TOOL.BuildCPanel( cp )
		cp:AddControl( "ComboBox", {
			Label = "Units",
			MenuButton = 0,
			Options = {
				["grams"] = { total_mass_unit = "g" },
				["kilograms (default)"] = { total_mass_unit = "kg" },
				["tonnes"] = { total_mass_unit = "t" },
				["ounces"] = { total_mass_unit = "oz" },
				["pounds"] = { total_mass_unit = "lb" }
			}
		} )
		
		cp:AddControl("Slider", {
			Label = "Auto Select Radius:", 
			Type = "integer", 
			Min = "64", 
			Max = "1024", 
			Command = "total_mass_radius"
		} )
		
		local slider = cp:AddControl("Slider", { 
			Label = "Indicator size:", 
			Type = "integer", 
			Min = "10", 
			Max = "150", 
			Command = "total_mass_size" 
		} )
		slider:SetToolTip("This value is to set how big the indicator is (in pixels)")
	end
end

function TOOL:IsPropOwner( ply, ent )
	if CPPI then
		return ent:CPPIGetOwner() == ply
	else
		for k, v in pairs( g_SBoxObjects ) do
			for b, j in pairs( v ) do
				for _, e in pairs( j ) do
					if e == ent and k == ply:UniqueID() then return true end
				end
			end
		end
	end
	return false
end

function TOOL:IsSelected( ent )
	local eid = ent:EntIndex()
	return self.SelectedProps[eid] ~= nil
end

function TOOL:Select( ent )
	if IsValid( ent ) and not self:IsSelected( ent ) then
		self.SelectedProps[ent:EntIndex()] = ent:GetColor()
		ent:SetColor( Color( 100, 0, 0, 100 ) )
		ent:SetRenderMode( RENDERMODE_TRANSALPHA )
	end
end

function TOOL:Deselect( ent )
	if IsValid( ent ) and self:IsSelected( ent ) then
		local eid = ent:EntIndex()
		ent:SetColor( self.SelectedProps[eid] )
		self.SelectedProps[eid] = nil
	end
end

function TOOL:LeftClick( trace )
	local ply = self:GetOwner()
	local ent = trace.Entity
	if not ply:KeyDown( IN_USE ) and ( ent:IsWorld() or ent:IsPlayer() ) then return false end
	if CLIENT then return true end
	
	if ply:KeyDown( IN_USE ) then -- Area select function
		local Radius = math.Clamp( self:GetClientNumber( "radius" ), 64, 1024 )
		for k, v in pairs( ents.FindInSphere( trace.HitPos, Radius ) ) do
			if IsValid( v ) and self:IsPropOwner( ply, v ) then
				self:Select( v )
			end
		end
	elseif ply:KeyDown( IN_SPEED ) then -- Select all constrained entities
		for k, v in pairs( constraint.GetAllConstrainedEntities( ent ) ) do
			self:Select( v )
		end
	elseif self:IsSelected( ent ) then -- Ent is already selected, deselect it
		self:Deselect( ent )
	else -- Select single entity
		self:Select( ent )
	end
	
	return true
end

function TOOL:RightClick( trace )
	if table.Count( self.SelectedProps ) < 1 then
		if IsValid( trace.Entity ) then -- auto-select all constrained ents if there is no selection
			if CLIENT then return true end
			for k, v in pairs( constraint.GetAllConstrainedEntities( trace.Entity ) ) do
				self:Select( v )
			end
		else
			return false
		end
	end
	
	if CLIENT then return true end
	
	local mass = 0
	local physmass = 0
	local gravcenter = Vector(0)
	
	for eid, col in pairs( self.SelectedProps ) do
		local ent = Entity( eid )
		if IsValid( ent ) then
			local phys = ent:GetPhysicsObject()
			if IsValid( phys ) then
				local entmass = phys:GetMass()
				-- Calculate total mass
				mass = mass + entmass
				
				-- Calculate physical mass
				if not IsValid( ent:GetParent() ) then
					physmass = physmass + entmass
				end
				
				-- Calculate center of gravity
				gravcenter = gravcenter + ent:LocalToWorld( phys:GetMassCenter() ) * entmass
			end
			self:Deselect( ent )
		end
	end
	
	self.SelectedProps = {}
	
	local unit = self:GetClientInfo("unit")
	if not weight[unit] then unit = "kg" end
	
	mass = mass * weight[unit]
	physmass = physmass * weight[unit]
	
	local totalstr = tostring( math.Round( mass, 2 ) ) .. unit
	local physstr = tostring( math.Round( physmass, 2 ) ) .. unit
	local parstr = tostring( math.Round( mass - physmass, 2 ) ) .. unit
	
	self:GetOwner():PrintMessage( HUD_PRINTTALK, "Total Mass is: " .. totalstr .. " (" .. 
		physstr .. " physical, " .. parstr .. " parented)" )
	
	gravcenter = trace.Entity:WorldToLocal( gravcenter / physmass )
	
	net.Start( "total_mass_indicatorpos" )
		net.WriteEntity( trace.Entity )
		net.WriteFloat( gravcenter.x )
		net.WriteFloat( gravcenter.y )
		net.WriteFloat( gravcenter.z )
	net.Send( self:GetOwner() )
	
	return true
end

function TOOL:Reload( trace )
	if CLIENT then return false end
	
	-- Clear entire selection
	for eid, col in pairs( self.SelectedProps ) do
		local ent = Entity( eid )
		if IsValid( ent ) then 
			self:Deselect( ent )
		end
	end
	self.SelectedProps = {}
	
	return false
end