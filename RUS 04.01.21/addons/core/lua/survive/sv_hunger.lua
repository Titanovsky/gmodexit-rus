AmbSurvive = AmbSurvive or {}
AmbSurvive.Hunger = AmbSurvive.Hunger or {}

AmbSurvive.Hunger.foods = { 

    [ 'Тортик' ]    = { mdl = 'models/cake/cake.mdl', value = 60 },
    [ 'Бургер' ]    = { mdl = 'models/food/hotdog.mdl', value = 40 },
    [ 'Хотдог' ]    = { mdl = 'models/food/burger.mdl', value = 30 },
    [ 'Пицца' ]     = { mdl = 'models/pizz/pizz.mdl', value = 25 },
    [ 'Шаверма' ]   = { mdl = 'models/shawa/shawa.mdl', value = 20 },
    [ 'Тушёнка' ]   = { mdl = 'models/can/can.mdl', value = 15 },
    [ 'Фасоль' ]    = { mdl = 'models/spitball_large.mdl', value = 5 }

}

function AmbSurvive.Hunger.SatisfyHunger( ePly, sFood )

    if not AmbSurvive.Hunger.foods[ sFood ] then return end

    local satisfy_hunger = AmbSurvive.Hunger.foods[ sFood ].value
    local ply_hunger = ePly:GetNWInt( 'Hunger' )

    if ( ply_hunger < satisfy_hunger ) then ePly:SetNWInt( 'Hunger', 0 ) return end

    ePly:SetNWInt( 'Hunger', ply_hunger - satisfy_hunger )

end

function AmbSurvive.Hunger.AddHunger( ePly, iValue )

    if not ePly:Alive() then return end

    local ply_hunger = ePly:GetNWInt( 'Hunger' )

    if ( ply_hunger + iValue > 100 ) then 
    
        ePly:SetNWInt( 'Hunger', 100 )
        ePly:SetHealth( ePly:Health() - math.random( 1, 2 ) )
        ePly:SendLua( 'surface.PlaySound("ambient/voices/cough"..tostring(math.random(1,3))..".wav")' )

        if ( ePly:Health() <= 0 ) then 
        
            ePly:Kill() 
            ePly:SetNWInt( 'Hunger', 20 )
            
        end
        
        return 
    
    end

    ePly:SetNWInt( 'Hunger', ply_hunger + iValue )

end

local delay = 0

hook.Add( 'Think', 'AmbSurviveHunger', function()

    if ( CurTime() > delay ) then

        delay = CurTime() + 12

        for _, ply in pairs( player.GetHumans() ) do

            if ( ply:Team() ~= AMB_TEAM_RP ) then continue end

            AmbSurvive.Hunger.AddHunger( ply, math.random( 1, 3 ) )

        end

    end

end )
