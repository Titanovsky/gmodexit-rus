-- E2Power by [G-moder]FertNoN

if !E2Power then
	timer.Simple( 10, wire_expression2_reload)
	E2Power = {}
	E2Power.FirstLoad = true
else
	if E2Power.FirstLoad then
		E2Power.FirstLoad = nil
		return
	end
end


local PlyAccess = {}

local function checkPly(ply)
	if !IsValid(ply) then return true end
	if ply:IsSuperAdmin() then return true end
end

local function PlyHasAccess(ply)
	return PlyAccess[ply]
end

function hasAccess(self)
	return PlyAccess[self.player]
end

function E2Access( num, ply ) -- ?
	if tonumber( ply:GetNWFloat('amb_players_e2') ) >= num then return true end
	AmbLib.notifySend( ply, 'Access denied! Need access: '..num, 1, 4, 'buttons/button10.wav' )
	return false
end

function E2Lib.E2Access( num, ply )
	if tonumber( ply:GetNWFloat('amb_players_e2') ) >= num then return true end
	AmbLib.notifySend( ply, 'Access denied! Need access: '..num, 1, 4, 'buttons/button10.wav' )
	return false
end



function isNan(var)
	return tostring(var) == "nan"
end

