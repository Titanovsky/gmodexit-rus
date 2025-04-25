AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'cl_init.lua' )

include( 'shared.lua' )

util.AddNetworkString( 'amb_f2_lm' )

function ENT:Initialize()

	self:SetModel( 'models/props_wasteland/controlroom_desk001b.mdl' )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetNWBool( 'Occupied', false )

	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then

	    phys:EnableMotion( false )

	end

	local obj = ents.Create( 'prop_physics' )
	obj:SetModel( 'models/props_industrial/winch_stern.mdl' )
	obj:SetPos( self:GetPos() + Vector( 1, 0, 16 ) )
	obj:SetAngles( self:GetAngles() )
	obj:PhysicsInit( SOLID_VPHYSICS )
	obj:SetMoveType( MOVETYPE_VPHYSICS )
	obj:Spawn()
	obj:DrawShadow( false )
	obj:SetParent( self )

	local phys = obj:GetPhysicsObject()
	if IsValid( phys ) then

	    phys:EnableMotion( false )

	end

end

function ENT:SetOccupied( bool )

	self:SetNWBool( 'Occupied', bool )

end

function ENT:WorkMachine( ePly, nFlag )

	local metal = self.flags[ nFlag ][ 'metal' ]

	if (  ePly:GetNWInt( 'Metal' ) < metal ) then return ePly:ChatPrint( 'You dont have enough metal (Need: '..metal..')' ) end

	--ply.factory_chunks = ply.factory_chunks or {}

	local time = self.flags[ nFlag ][ 'time' ]
	local chunk = self.flags[ nFlag ][ 'chunk' ]

	ePly:Freeze( true )
	ePly:ChatPrint( 'You started making '..chunk..', wait '..time..' seconds' )
	ePly:SetNWInt( 'Metal', ePly:GetNWInt( 'Metal' ) - metal )
	
	self:SetOccupied( true )

	timer.Simple( time, function()
	
		ePly:Freeze( false )
		ePly:SetNWInt( 'Workpiece_'..nFlag, ePly:GetNWInt( 'Workpiece_'..nFlag ) + 1 )
		ePly:SetNWBool( 'HaveWorkpiece', true )
		ePly:ChatPrint( 'You maked '..chunk..' | You have: '..ePly:GetNWInt( 'Workpiece_'..nFlag ) )

		self:SetOccupied( false )

	end )

end

net.Receive( 'amb_f2_lm', function( nLen, caller )

	local machine = net.ReadEntity()

	if ( machine:GetClass() ~= 'amb_factory2_lathe_machine' ) then return end
	if machine:GetNWBool( 'Occupied' ) then return end

	local chunk = net.ReadUInt( 3 )
	
	machine:WorkMachine( caller, chunk )

end )

hook.Add( 'PlayerDeath', 'LossChunkes', function( ePly ) 

	if ePly:GetNWBool( 'HaveWorkpiece' ) then

		ePly:ChatPrint( 'You have lost workpieces!' )
		ePly:SetNWBool( 'HaveWorkpiece', false )
		for i = 1, #AmbFactory2Chunks do

			ePly:SetNWInt( 'Workpiece_'..i, 0 )

		end

	end

end )

