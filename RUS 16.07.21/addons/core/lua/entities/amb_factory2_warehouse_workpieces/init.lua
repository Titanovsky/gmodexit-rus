AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'cl_init.lua' )

include( 'shared.lua' )

util.AddNetworkString( 'amb_f2_ww' )

function ENT:Initialize()

	self:SetModel( 'models/props/cs_militia/shelves_wood.mdl' )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then

	    phys:EnableMotion( false )

	end

	for k, v in pairs( AmbFactory2Chunks ) do
		
		self:SetNWInt( 'Workpiece_'..tostring(k), 0 )

	end

end

local function CalcMoney( nType )

	local money = math.random( 2, 6 )

	return money

end

function ENT:PutWorkpiece( nType, ePly )

	local workpiece = ePly:GetNWInt( 'Workpiece_'..tostring( nType ) )

	if ( workpiece == 0 ) then return end

	local money = CalcMoney( nType ) * workpiece

	AmbStats.Players.addStats( ePly, '$', money  )
	AmbLib.chatSend( ePly, AMB_COLOR_GREEN, '[•] ', AMB_COLOR_WHITE, 'Вы получили ', AMB_COLOR_GREEN, money..' BE', AMB_COLOR_WHITE, ' за ', AMB_COLOR_GRAY, AmbFactory2Chunks[ nType ].chunk )
	ePly:SetNWInt( 'Workpiece_'..nType, 0 )
	ePly:SetNWBool( 'HaveWorkpiece', false )

	self:SetNWInt( 'Workpiece_'..nType, self:GetNWInt( 'Workpiece_'..tostring( nType ) ) + workpiece )

end

net.Receive( 'amb_f2_ww', function( nLen, caller )

	local warehouse = net.ReadEntity()
	
	if ( warehouse:GetClass() ~= 'amb_factory2_warehouse_workpieces' ) then return end

	local flag = net.ReadBit()

	if ( flag == 0 ) then

		for i = 1, #AmbFactory2Chunks do

			warehouse:PutWorkpiece( i, caller )

		end
	
	else

		for i = 1, #AmbFactory2Chunks do

			warehouse:TakeWorkpiece( i, 1, caller )

		end

	end

end )