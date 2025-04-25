local C, SND = Ambi.General.Global.Colors, Ambi.General.Global.Sounds

Ambi.Rus.randomizer_features = {}

local SCALE, DEF_SCALE = Vector( 2, 2, 2 ), Vector( 1, 1, 1 )
Ambi.Rus.randomizer_features[ 'Big Head' ] = function( ePly )
    local bone = ePly:LookupBone( 'ValveBiped.Bip01_Head1' )
    if not bone or ( bone < 0 ) then return false end

    ePly:ManipulateBoneScale( bone, SCALE )
    ePly:ChatSend( C.AMBI_ORANGE, '[Random] ', C.ABS_WHITE, 'Вы на 2 минуты стали Яйцеголовым!' )
    ePly:RunCommand( 'act forward' )

    timer.Simple( 120, function()
        if IsValid( ePly ) then 
            ePly:ManipulateBoneScale( bone, DEF_SCALE ) 
            ePly:RunCommand( 'act forward' )
        end
    end )

    return true
end

Ambi.Rus.randomizer_features[ 'Small Size Body' ] = function( ePly )
    ePly:SetModelScale( 0.6, 1 )
    ePly:ChatSend( C.AMBI_ORANGE, '[Random] ', C.ABS_WHITE, 'Вы на 3 минуты стали маленькими!' )
    ePly:RunCommand( 'act salute' )

    timer.Simple( 180, function()
        if IsValid( ePly ) then 
            ePly:SetModelScale( 1, 1 ) 
            ePly:RunCommand( 'act salute' )
        end
    end )

    return true
end

Ambi.Rus.randomizer_features[ 'Immortal' ] = function( ePly )
    ePly:GodEnable()
    ePly:ChatSend( C.AMBI_ORANGE, '[Random] ', C.ABS_WHITE, 'Вы на минуту стали бессмертными!' )

    timer.Simple( 60, function()
        if IsValid( ePly ) then ePly:GodDisable() end
    end )

    return true
end

Ambi.Rus.randomizer_features[ '666' ] = function( ePly )
    ePly:SetHealth( 666 )

    ePly:ChatSend( C.AMBI_ORANGE, '[Random] ', C.ABS_WHITE, 'Вы получили 666 HP' )
    
    return true
end

Ambi.Rus.randomizer_features[ '666 All' ] = function( ePly )
    local rand = math.random( 0, 1 )
    if ( rand == 0 ) then return false end

    for _, ply in ipairs( player.GetAll() ) do 
        ply:ChatSend( C.AMBI_ORANGE, '[Random] ', C.ABS_WHITE, 'Вы получили 666 HP' )
        ply:SetHealth( 666 ) 
    end

    return true
end

local COLOR = Color( 255, 0, 0 )
Ambi.Rus.randomizer_features[ '666 HardCore' ] = function( ePly )
    ePly:SetHealth( 666 )
    ePly:AddXP( 666 )
    ePly:SetColor( COLOR )
    ePly:SetRunSpeed( ePly:GetRunSpeed() + 500 )
    ePly:SetWalkSpeed( ePly:GetWalkSpeed() + 400 )

    ePly:ChatSend( C.AMBI_ORANGE, '[Random] ', C.ABS_WHITE, 'Вы получили Хардкорный Набор: Здоровье, Броня, Скорость!' )

    return true
end

Ambi.Rus.randomizer_features[ 'Random XP' ] = function( ePly )
    local xp = math.random( 1, 2000 )

    ePly:AddXP( xp )
    ePly:ChatSend( C.AMBI_ORANGE, '[Random] ', C.ABS_WHITE, 'Вы получили ', C.AMBI, xp, C.ABS_WHITE, ' XP' )

    return true
end

local RAND_PHRASES = {
    'Я гей и что?',
    'Я гей',
    'Я путяшка',
    'Люблю сосать свежие жождунцы',
    'Пердолёт!',
    'Боже.. я обожаю нюхать собственные пуки',
    'Ты Моя Сосиска Или Да?)',
    'bloxwich',
    'shall we',
    '/me Понюхал свой пук',
    'Я дрочу каждый день по 4 раза',
}
Ambi.Rus.randomizer_features[ 'Random Say' ] = function( ePly )
    ePly:Say( table.Random( RAND_PHRASES ) )

    return true
end

Ambi.Rus.randomizer_features[ 'Bucket' ] = function( ePly )
    local hp = math.random( 1, 255 )
    ePly:SetHealth( ePly:Health() + math.random( 1, 255 ) ) 
    ePly:ChatSend( C.AMBI_ORANGE, '[Random] ', C.ABS_WHITE, 'Вы получили ', C.AMBI_GREEN, '+'..hp, C.ABS_WHITE, ' Здоровья' )

    return true
end

Ambi.Rus.randomizer_features[ 'Kick' ] = function( ePly )
    local rand = math.random( 0, 1 )
    if ( rand == 0 ) then return false end

    ePly:Kick( 'Random Hacker' )

    return true
end