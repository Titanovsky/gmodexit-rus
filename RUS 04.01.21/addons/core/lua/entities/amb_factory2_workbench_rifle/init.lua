AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'cl_init.lua' )

include( 'shared.lua' )

util.AddNetworkString( 'amb_f2_wr' )

local delay = 24

function ENT:Initialize()

	self:SetModel( 'models/props/cs_militia/table_shed.mdl' )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then

	    phys:EnableMotion( false )

	end

end

function ENT:CraftRifle( ePly )

	for k, v in pairs( AmbFactory2Chunks ) do
		
		ePly:SetNWInt( 'Detail_'..k, ePly:GetNWInt( 'Detail_'..k ) - 1 )

	end

	ePly:Freeze( true )
	AmbLib.notifySend( ePly, 'Вы начали делать AK-47, подождите '..delay..' секунд', 0, delay )

	timer.Simple( delay, function() 
	
		ePly:Freeze( false )
		AmbStats.Players.addStats( ePly, '$', math.random( 64, 256 ) )
	
	end )

end

local function CheckDetails( ePly )

	for k, v in pairs( AmbFactory2Chunks ) do
		
		if ( ePly:GetNWInt( 'Detail_'..k ) == 0 ) then return false end

	end

	return true

end

net.Receive( 'amb_f2_wr', function( nLen, caller ) 

	if ( IsValid( caller ) == false ) or ( caller:Alive() == false ) then return end
	if ( CheckDetails( caller ) == false ) then return end

	local workbench = net.ReadEntity()
	
	if ( workbench:GetClass() ~= 'amb_factory2_workbench_rifle' ) then return end

	workbench:CraftRifle( caller )

end )
