local C = Ambi.General.Global.Colors

Ambi.Randomizer.list = Ambi.Randomizer.list or {}

function Ambi.Randomizer.Add( sClass, sName, sType, sDescription, fAction )
    if not sClass then return end
    
    Ambi.Randomizer.list[ sClass ] ={
        name = sName or '',
        type = sType or 'Other',
        description = sDescription or '',
        Action = fAction
    }

    return Ambi.Randomizer.list[ sClass ]
end

function Ambi.Randomizer.GetRandom()
    local tab = {}

    for name, _ in pairs( Ambi.Randomizer.list ) do
        tab[ #tab + 1 ] = name
    end

    return tab[ math.random( 1, #tab ) ]
end

function Ambi.Randomizer.Call( ePly, sClass )
    local feature = Ambi.Randomizer.list[ sClass or '' ]
    if not feature then return end

    local Action = feature.Action
    if not Action then return end

    if not ePly or not ePly:IsPlayer() then return end
    if timer.Exists( 'AmbiRusRandomizerDelay['..ePly:SteamID()..']' ) and not ePly:IsSuperAdmin() then ePly:ChatPrint( 'Вам осталось: '..math.floor( timer.TimeLeft( 'AmbiRusRandomizerDelay['..ePly:SteamID()..']' ) )..' секунд' ) return end

    if Action( ePly ) then
        timer.Create( 'AmbiRusRandomizerDelay['..ePly:SteamID()..']', 60 * 3, 1, function() end )

        for _, ply in ipairs( player.GetAll() ) do
            ply:ChatSend( C.AMBI_ORANGE, '[Random] ', C.ABS_WHITE, 'Игрок ', C.FLAT_RED, ePly:Nick(), C.ABS_WHITE, ' получил ', C.FLAT_RED, feature.name )
        end
    else
        Ambi.Randomizer.Call( ePly, Ambi.Randomizer.GetRandom() )
    end
end