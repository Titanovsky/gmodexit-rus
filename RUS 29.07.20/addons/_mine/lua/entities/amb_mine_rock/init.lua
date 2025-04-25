AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel( AmbMine.Config.ModelRock ) -- Данное творение принадлежит проекту [.ambition]
    self:SetMoveType( MOVETYPE_NONE )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
    self:DropToFloor()

    local phys = self:GetPhysicsObject()
    if IsValid( phys ) then 
        phys:EnableMotion( false ) 
    end
end

util.AddNetworkString("send_notify")

local function sendNotify( ePly, sText, nAmount )
    net.Start("send_notify")
        net.WriteString( sText )
    net.Send( ePly )
end


function ENT:OnTakeDamage( tDmg )
	local ply = tDmg:GetAttacker()
	if not ply:IsValid() then return end

    -- todo: подумать как можно сделать clean code, ибо без трёх бутылок охоты тут не разобраться
	if IsValid( ply ) and ( ply:GetActiveWeapon():GetClass() == "amb_pickaxe") then
        local chance = math.random( 1, 100 )
        if ( chance >= AmbMine.Config.FrequencyOre0[1] ) and ( chance < AmbMine.Config.FrequencyOre0[2] ) then
            sendNotify( ply, "• Вы ничего не добыли" )
        elseif ( chance >= AmbMine.Config.FrequencyOre1[1] ) and ( chance < AmbMine.Config.FrequencyOre1[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre1 * AmbMine.Config.ModifySimpleAxe ) )
            AmbMine.AddOre( ply, 1, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[1].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre2[1] ) and ( chance < AmbMine.Config.FrequencyOre2[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre2 * AmbMine.Config.ModifySimpleAxe ) )
            AmbMine.AddOre( ply, 2, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[2].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre3[1] ) and ( chance < AmbMine.Config.FrequencyOre3[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre3 * AmbMine.Config.ModifySimpleAxe ) )
            AmbMine.AddOre( ply, 3, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[3].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre4[1] ) and ( chance < AmbMine.Config.FrequencyOre4[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre4 * AmbMine.Config.ModifySimpleAxe ) )
            AmbMine.AddOre( ply, 4, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[4].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre5[1] ) and ( chance < AmbMine.Config.FrequencyOre5[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre5 * AmbMine.Config.ModifySimpleAxe ) )
            AmbMine.AddOre( ply, 5, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[5].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre6[1] ) and ( chance < AmbMine.Config.FrequencyOre6[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre6 * AmbMine.Config.ModifySimpleAxe ) )
            AmbMine.AddOre( ply, 6, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[6].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre7[1] ) and ( chance < AmbMine.Config.FrequencyOre7[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre7 * AmbMine.Config.ModifySimpleAxe ) )
            AmbMine.AddOre( ply, 7, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[7].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre8[1] ) and ( chance <= AmbMine.Config.FrequencyOre8[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre8 * AmbMine.Config.ModifySimpleAxe ) )
            AmbMine.AddOre( ply, 8, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[8].." ("..chance_ore..")" )
        end
        -- ply:ChatPrint( chance ) -- debug
    elseif ( ply:GetActiveWeapon():GetClass() == "amb_advpickaxe") then
        local chance = math.random( 1, 100 )
        if ( chance >= AmbMine.Config.FrequencyOre0[1] ) and ( chance < AmbMine.Config.FrequencyOre0[2] ) then
            sendNotify( ply, "• Вы ничего не добыли" )
        elseif ( chance >= AmbMine.Config.FrequencyOre1[1] ) and ( chance < AmbMine.Config.FrequencyOre1[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre1 * AmbMine.Config.ModifyAdvAxe ) )
            AmbMine.AddOre( ply, 1, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[1].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre2[1] ) and ( chance < AmbMine.Config.FrequencyOre2[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre2 * AmbMine.Config.ModifyAdvAxe ) )
            AmbMine.AddOre( ply, 2, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[2].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre3[1] ) and ( chance < AmbMine.Config.FrequencyOre3[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre3 * AmbMine.Config.ModifyAdvAxe ) )
            AmbMine.AddOre( ply, 3, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[3].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre4[1] ) and ( chance < AmbMine.Config.FrequencyOre4[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre4 * AmbMine.Config.ModifyAdvAxe ) )
            AmbMine.AddOre( ply, 4, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[4].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre5[1] ) and ( chance < AmbMine.Config.FrequencyOre5[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre5 * AmbMine.Config.ModifyAdvAxe ) )
            AmbMine.AddOre( ply, 5, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[5].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre6[1] ) and ( chance < AmbMine.Config.FrequencyOre6[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre6 * AmbMine.Config.ModifyAdvAxe ) )
            AmbMine.AddOre( ply, 6, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[6].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre7[1] ) and ( chance < AmbMine.Config.FrequencyOre7[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre7 * AmbMine.Config.ModifyAdvAxe ) )
            AmbMine.AddOre( ply, 7, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[7].." ("..chance_ore..")" )
        elseif ( chance >= AmbMine.Config.FrequencyOre8[1] ) and ( chance <= AmbMine.Config.FrequencyOre8[2] ) then
            local chance_ore = math.random( 1, math.floor( AmbMine.Config.ExtractOre8 * AmbMine.Config.ModifyAdvAxe ) )
            AmbMine.AddOre( ply, 8, chance_ore )
            sendNotify( ply, "• "..AmbMine.Config.Names[8].." ("..chance_ore..")" )
        end
    else
	end
end
-- Данное творение принадлежит проекту [.ambition]