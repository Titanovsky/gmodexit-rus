AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'cl_init.lua' )

include( 'shared.lua' )

util.AddNetworkString( 'amb_f2_wm' )

local delay_reload = 480
local metals = 150

function ENT:Initialize()

	self:SetModel( 'models/props/cs_militia/boxes_garage_lower.mdl' )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetNWInt( 'Metal', metals )

	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then

	    phys:EnableMotion( false )

	end

end

function ENT:GetMetal()

	return tonumber( self:GetNWInt( 'Metal' ) )

end

function ENT:SetDelayReload( ePly, nDelay )

	timer.Create( 'AmbFactory2ReloadMetals'..self:EntIndex(), nDelay, 1, function() 

		if IsValid( self ) then self:SetNWInt( 'Metal', metals ) end
		

	end )

	for k, v in pairs( player.GetAll() ) do

		v:SendLua( 'timer.Create("AmbFactory2ReloadMetals'..self:EntIndex()..'", '..tostring( nDelay )..', 1, function() end)' )

	end

end

function ENT:TakeMetal( nCount, ePly )

	if ( self:GetMetal() <= 0 ) then return end
	if ( self:GetMetal() <= 1 ) then self:SetDelayReload( ePly, delay_reload ) end
	if ( ePly:GetNWInt( 'Metal' ) >= 5 ) then return ePly:ChatPrint( 'You have a lot of metal!' ) end

	self:SetNWInt( 'Metal', self:GetMetal() - nCount )

	ePly:SetNWInt( 'Metal', ePly:GetNWInt( 'Metal' ) + nCount )
	ePly:ChatPrint( 'You have: '..ePly:GetNWInt( 'Metal' )..' metals' )

end

net.Receive( 'amb_f2_wm', function( nLen, caller )

	local warehouse = net.ReadEntity()
	
	if ( warehouse:GetClass() ~= 'amb_factory2_warehouse_metal' ) then return end

	warehouse:TakeMetal( 1, caller )

end )

hook.Add( 'PlayerDeath', 'LossMetal', function( ePly ) 

	if ( ePly:GetNWInt( 'Metal' ) > 0 ) then ePly:SetNWInt( 'Metal', 0 ) end

end )