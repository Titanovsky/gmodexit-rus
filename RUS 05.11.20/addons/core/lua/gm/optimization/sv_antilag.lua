--[[
	АнтиЛаг система ( Базовая )

	[15.08.20]
		• Переписал АнтиЛаг и дал Ямирусу.
	.
]]

AmbLags = AmbLags or {}


-- ## Config ########################
local last_diff = 9999
local delta_diff = 0
local _debug = false 

AmbLags.level_lag = 0.6 -- level lag
AmbLags.delay_origin = 1.32 -- сама задержка

-- ##################################

PrintTable( AmbLags )
local function debugAntiLag( sys, last, delta, type )
	if ( _debug ) then
		MsgN( '=======###===========' )
		MsgN( 'Time['..tostring( type)..']: ' .. sys )
		MsgN( 'Last['..tostring( type)..']: ' .. last )
		MsgN( 'Delta['..tostring( type)..']: ' .. delta )
	end
end


function AmbLags.lagRemove()
	MsgN( '[AmbLags] AntiLag Work | '..os.date('%c', os.time() ) )
	for _, ply in pairs( player.GetHumans() ) do
		ply:ChatPrint("\n[AmbLags] AntiLag Work")
		ply:ChatPrint("All props has frozen!")
	end

	for _, v in pairs( ents.FindByClass("prop_physics") ) do
		if not v:IsVehicle() then
			local phys = v:GetPhysicsObject()
			phys:EnableMotion( false )
		end
	end
end

function AmbLags.lagDetecting()

	local sys_diff = SysTime() - CurTime()
	debugAntiLag( sys_diff, last_diff, delta_diff, 1 )

	delta_diff = sys_diff - last_diff -- 1 step
	debugAntiLag( sys_diff, last_diff, delta_diff, 2 )

	last_diff = sys_diff -- 2 step
	debugAntiLag( sys_diff, last_diff, delta_diff, 3 )

	if ( delta_diff >= AmbLags.level_lag ) then
		AmbLags.lagRemove()
		return true
	end

	return false 
end

local delay = 0

hook.Add( 'Think', 'amb_0x2048', function()
	if ( delay > CurTime() ) then return end

	AmbLags.lagDetecting()
	delay = CurTime() + AmbLags.delay_origin
end )