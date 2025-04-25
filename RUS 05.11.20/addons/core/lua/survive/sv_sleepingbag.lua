if ( AMB.config.module_survive == false ) then return end

AmbPointsSpawn = {}

local function debugTab()
    PrintTable( AmbPointsSpawn )
end

local function spawnOnSleepingBag( ePly )
    if ( ePly:GetNWBool('amb_survive_sleeping_bag') ) then
        timer.Simple( 0.3, function()
            --ePly:ChatPrint('Your spawned on Sleeping Bag') -- debug
            ePly:SetPos( AmbPointsSpawn[ePly:SteamID()] )
        end )
    end
end
hook.Add('PlayerSpawn', 'amb_0x388', spawnOnSleepingBag )