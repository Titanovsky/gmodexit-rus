function AmbCases.spawnCase( ePlayer, nType )
    local pos = ePlayer:GetEyeTrace().HitPos


    local case = ents.Create( 'amb_cases_case' )
    case:Spawn()
    case:SetPos( ePlayer:GetShootPos() + ePlayer:GetAimVector() * 36 )
    --case:DropToFloor()

    case:SetNWInt('type', nType)
    case:SetNWString('name', AmbCases.cases[nType].name )
    
    -- ePlayer:ChatPrint( tostring( case ) ) -- debug
    -- ePlayer:ChatPrint( ePlayer:GetPos():Distance() ) -- debug
end