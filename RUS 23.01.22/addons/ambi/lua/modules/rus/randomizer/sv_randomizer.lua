local C = Ambi.General.Global.Colors

function Ambi.Rus.GetRandomizer()
    local tab = {}

    for name, _ in pairs( Ambi.Rus.randomizer_features ) do
        tab[ #tab + 1 ] = name
    end

    return tab[ math.random( 1, #tab ) ]
end

function Ambi.Rus.CallRandomizer( ePly, sFeature )
    local Action = AMB.Rus.randomizer_features[ sFeature or '' ]
    if not Action then return end
    if not ePly or not ePly:IsPlayer() then return end
    if timer.Exists( 'AmbiRusRandomizerDelay['..ePly:SteamID()..']' ) and not ePly:IsSuperAdmin() then ePly:ChatPrint( 'Вам осталось: '..math.floor( timer.TimeLeft( 'AmbiRusRandomizerDelay['..ePly:SteamID()..']' ) )..' секунд' ) return end

    if Action( ePly ) then
        timer.Create( 'AmbiRusRandomizerDelay['..ePly:SteamID()..']', 60 * 3, 1, function() end )

        for _, ply in ipairs( player.GetAll() ) do
            ply:ChatSend( C.AMBI_ORANGE, '[Random] ', C.ABS_WHITE, 'Игрок ', C.FLAT_RED, ePly:Gamename(), C.ABS_WHITE, ' получил ', C.FLAT_RED, sFeature )
        end
    else
        Ambi.Rus.CallRandomizer( ePly, Ambi.Rus.GetRandomizer() )
    end
end