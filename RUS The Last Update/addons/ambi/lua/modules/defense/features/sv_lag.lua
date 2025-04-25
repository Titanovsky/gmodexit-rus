local C = Ambi.Packages.Out( 'colors' )
local last_diff = 9999
local delta_diff = 0

local function GetDeltaDiff()
	local sys_diff = SysTime() - CurTime()
	delta_diff = sys_diff - last_diff
	last_diff = sys_diff

	return delta_diff
end

timer.Create( 'DefenseCheckLag', 1, 0, function() 
    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.lag_enable == false ) then return end

    local delta = GetDeltaDiff()
    local levels = Config.lag_levels

    if ( delta >= levels[ 3 ] ) then
        if Config.lag_send_to_chat then
            for _, ply in ipairs( player.GetHumans() ) do
                ply:ChatSend( C.AMBI_BLUE, 'Лаг 3 уровня обнаружен!' )
            end
        end

        for _, obj in ipairs( ents.GetAll() ) do
            if ( obj:GetClass() == 'gmod_wire_expression2' ) or ( obj:GetClass() == 'starfall_processor' ) then obj:Remove() continue end
            if obj:IsRagdoll() or obj:IsNPC() then obj:Remove() end

            local phys = obj:GetPhysicsObject()
            if IsValid( phys ) then
                if ( phys:GetStress() >= 2 or phys:IsPenetrating() ) then 
                    obj:Remove()
                else
                    phys:EnableMotion( false )
                end
            end
        end
    elseif ( delta >= levels[ 2 ] ) then
        for _, ply in ipairs( player.GetHumans() ) do
            ply:ChatSend( C.AMBI_BLUE, 'Лаг 2 уровня обнаружен!' )
        end

        for _, obj in ipairs( ents.GetAll() ) do
            local phys = obj:GetPhysicsObject()
            if IsValid( phys ) then
                if ( phys:GetStress() >= 2 or phys:IsPenetrating() ) then 
                    obj:Remove()
                else
                    phys:EnableMotion( false )
                end
            end
        end
    elseif ( delta >= levels[ 1 ] ) then
        for _, ply in ipairs( player.GetHumans() ) do
            ply:ChatSend( C.AMBI_BLUE, 'Лаг 1 уровня обнаружен!' )
        end

        for _, obj in ipairs( ents.GetAll() ) do
            local phys = obj:GetPhysicsObject()
            if IsValid( phys ) then
                if ( phys:GetStress() >= 2 or phys:IsPenetrating() ) then 
                    phys:EnableMotion( false )
                end
            end
        end
    end
end )
