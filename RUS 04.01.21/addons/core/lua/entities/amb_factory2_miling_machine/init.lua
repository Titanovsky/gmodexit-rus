AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'cl_init.lua' )

include( 'shared.lua' )

util.AddNetworkString( 'amb_f2_mm' )

local delays = {
	2,
	2,
	3
}

function ENT:Initialize()

	self:SetModel( 'models/props_wasteland/kitchen_counter001d.mdl' )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetNWBool( 'Occupied', false )

	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then

	    phys:EnableMotion( false )

	end

	local obj = ents.Create( 'prop_physics' )
	obj:SetModel( 'models/props/cs_militia/reload_scale.mdl' )
	obj:SetPos( self:GetPos() + Vector( 1, -6, 18 ) )
	obj:SetAngles( self:GetAngles() )
	obj:PhysicsInit( SOLID_VPHYSICS )
	obj:Spawn()
	obj:DrawShadow( false )
	obj:SetParent( self )

	local obj1 = ents.Create( 'prop_physics' )
	obj1:SetModel( 'models/props/cs_militia/reloadingpress01.mdl' )
	obj1:SetPos( obj:GetPos() + Vector( -16, -8, 10 ) )
	obj1:PhysicsInit( SOLID_VPHYSICS )
	obj1:Spawn()
	obj1:DrawShadow( false )
	obj1:SetParent( self )

end

function ENT:SetOccupied( bool )

	self:SetNWBool( 'Occupied', bool )

end

function ENT:StartMachine( ePly )
	
	ePly:Freeze( true )
	ePly:ChatPrint( 'Start' )

	self:SetOccupied( true )
	self:RefinishWorkpiece( ePly )

end

function ENT:RefinishWorkpiece( ePly )

	if ( IsValid( ePly ) == false ) or ( ePly:Alive() == false ) then return self:EndMachine( false ) end

	ePly:ChatPrint( '[1/3] You refinish the workpiece' )

	timer.Simple( delays[1], function() self:PaitingWorkpiece( ePly ) end )

end

function ENT:PaitingWorkpiece( ePly )

	if ( IsValid( ePly ) == false ) or ( ePly:Alive() == false ) then self:EndMachine( false ) end

	ePly:ChatPrint( '[2/3] You paiting the workpiece' )

	timer.Simple( delays[2], function() self:MarkingWorkpiece( ePly ) end )

end

function ENT:MarkingWorkpiece( ePly )

	if ( IsValid( ePly ) == false ) or ( ePly:Alive() == false ) then self:EndMachine( false ) end

	ePly:ChatPrint( '[3/3] You marking the workpiece' )

	timer.Simple( delays[3], function() self:EndMachine( true, ePly ) end )

end

local function WorkpiecesToDetails( ePly, nType )

	if ( ePly:GetNWInt( 'Workpiece_'..nType ) <= 0 ) then return end

	ePly:SetNWInt( 'Detail_'..nType, ePly:GetNWInt( 'Detail_'..nType ) + ePly:GetNWInt( 'Workpiece_'..nType ) )
	AmbLib.chatSend( ePly, AMB_COLOR_AMBITION, '[•] ', AMB_COLOR_WHITE, 'Вы сделали деталь: ', AMB_COLOR_AMBITION, AmbFactory2Chunks[ nType ].chunk..' x'..ePly:GetNWInt( 'Detail_'..nType ) )
	ePly:SetNWInt( 'Workpiece_'..nType, 0 )

end

function ENT:EndMachine( bFlag, ePly )

	self:SetOccupied( false )
	
	if bFlag then

		ePly:Freeze( false )
		ePly:ChatPrint( 'End' )

		for k, v in pairs( AmbFactory2Chunks ) do
		
			WorkpiecesToDetails( ePly, k )

		end 

	end

end

local function CheckWorkpieces( ePly )

	for k, v in pairs( AmbFactory2Chunks ) do
		
		if ( ePly:GetNWInt( 'Workpiece_'..k ) > 0 ) then return true end

	end

	return false

end

net.Receive( 'amb_f2_mm', function( nLen, caller )

	if ( IsValid( caller ) == false ) or ( caller:Alive() == false ) then return end
	if ( CheckWorkpieces( caller ) == false ) then return end

	local warehouse = net.ReadEntity()
	
	if ( warehouse:GetClass() ~= 'amb_factory2_miling_machine' ) then return end
	if warehouse:GetNWBool( 'Occupied' ) then return end

	warehouse:StartMachine( caller )

end )
