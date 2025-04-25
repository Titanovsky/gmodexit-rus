local C = Ambi.General.Global.Colors

hook.Add( 'CanTool', 'Ambi.Rus.LogTools', function( ePly, _, sTool )
    local message = '[Tools] '..ePly:Name()..' ('..ePly:SteamID()..') use '..sTool

    print( message )
    for i, v in ipairs( player.GetAll() ) do
        if not v:IsUserGroup( 'user' ) then v:SendLua( "print('"..message.."')" ) end
    end
end )


-----------------------------------------------------------------------------------
local times = {
    [ 'day' ] = {
        pattern = 'l', 
        topcolor = '0.27 0.55 0.98', 
        bottomcolor = '0.67 0.75 0.97',
        duskcolor = '0.47 0.68 0.98',
        duskscale = '1.00',
        fadebias = '1.00',
        sunsize = '0.00',
        suncolor = '0.00 0.00 0.00',
        drawstars = '0',
        startexture = 'skybox/starfield',
        starslayers = '0',
        starscale = '0.00 0.00 0.00',
        starfade = '0.00 0.00 0.00',
        starspeed = '0.00 0.00 0.00'
    },

    [ 'night' ] = {
        pattern = 'a', 
        topcolor = '0.00 0.00 0.00', 
        bottomcolor = '0.01 0.01 0.01',
        duskcolor = '0.00 0.00 0.00',
        duskscale = '1.00',
        fadebias = '0.32',
        sunsize = '0.00',
        suncolor = '0.00 0.00 0.00',
        drawstars = '1',
        startexture = 'skybox/starfield',
        starslayers = '2',
        starscale = '0.90',
        starfade = '1.50',
        starspeed = '0.01'
    },

    [ 'sundown' ] = {
        pattern = 'f', 
        topcolor = '0.69 0.53 0.45', 
        bottomcolor = '0.26 0.13 0.05',
        duskcolor = '0.63 0.27 0.04',
        duskscale = '1.24',
        fadebias = '1.00',
        sunsize = '2.00',
        suncolor = '1.00 0.56 0.00',
        drawstars = '0',
        startexture = 'skybox/starfield',
        starslayers = '2',
        starscale = '0.90',
        starfade = '1.50',
        starspeed = '0.01'
    },

    [ 'christmas' ] = {
        pattern = 'b',
        topcolor = '0.00 0.00 0.00', 
        bottomcolor = '0.00 0.00 0.02',
        duskcolor = '0.00 0.00 0.02',
        duskscale = '1.00',
        duskintensity = '1.00',
        fadebias = '1.00',
        sunsize = '0.00',
        drawstars = '1',
        startexture = 'skybox/starfield',
        starslayers = '2',
        starscale = '1.45',
        starfade = '1.45',
        starspeed = '0.01'
    }

}
local time_s = 0
local time_m = 0
local time_h = 0
local time_d = 1

function Ambi.Rus.SetTimeEnvironment( sTime )
    sTime = string.lower( sTime )

    local tab = times[ sTime ]
    local light_env = Ambi.Rus.FindLightEnvironment()
    local skypaint = Ambi.Rus.FindEnvSkyPaint()

    if light_env then light_env:Fire( 'setpattern', tab.pattern ) end

    for k, v in pairs( tab ) do
        if ( k == 'pattern' ) then continue end

        skypaint:SetKeyValue( k, v )
    end
end

function Ambi.Rus.FindLightEnvironment()
    for _, ent in pairs( ents.FindByClass( 'light_environment' ) ) do
        return ent
    end

    return false
end

function Ambi.Rus.FindEnvSkyPaint()
    for _, ent in pairs( ents.FindByClass( 'env_skypaint' ) ) do
        return ent
    end

    local new_ent = ents.Create( 'env_skypaint' )
    new_ent:SetPos( Vector( 0, 0, 0 ) )
    new_ent:SetAngles( Angle( 0, 0, 0 ) )
    new_ent:Spawn()

    return new_ent
end

--hook.Add( 'InitPostEntity', 'Ambi.Rus.SetTime', function()
    --Ambi.Rus.SetTimeEnvironment( 'Day' )

    --Ambi.Rus.start_time = true
--end )

local delay = 0

--hook.Add( 'Think', 'Ambi.Rus.SetTime', function() 
    --[[
    if ( delay >= CurTime() ) then return end
    if not AmbTimeCycle.start_time then return end

    delay = CurTime() + 2 -- 48 минут = 1 игровые сутки

    AmbTimeCycle.time_m = AmbTimeCycle.time_m + 1

    if ( AmbTimeCycle.time_m >= 60 ) then

        AmbTimeCycle.time_m = 0
        AmbTimeCycle.time_h = AmbTimeCycle.time_h + 1

    end

    if ( AmbTimeCycle.time_h >= 24 ) then

        AmbTimeCycle.time_h = 0
        AmbTimeCycle.time_d = AmbTimeCycle.time_d + 1

    end
    
    if ( AmbTimeCycle.time_h == 20 ) then AmbTimeCycle.SetTimeEnvironment( 'night' ) -- до 8 минут
    elseif ( AmbTimeCycle.time_h == 18 ) then AmbTimeCycle.SetTimeEnvironment( 'sundown' ) -- до 4 минут
    elseif ( AmbTimeCycle.time_h == 2 ) then AmbTimeCycle.SetTimeEnvironment( 'day' ) -- до 32 минут
    elseif ( AmbTimeCycle.time_h == 0 ) then AmbTimeCycle.SetTimeEnvironment( 'sundown' ) -- до 4 минут
    end
    ]]--
--end )

hook.Add( 'PlayerDisconnected', 'Ambi.Rus.ChatPrintAll', function( ePly ) 
    local time = ePly:TimeConnected()
    if ( time > 60 * 60 ) then
        time = tostring( math.floor( time / 3600 ) )..' часов'
    elseif ( time > 60 ) then
        time = tostring( math.floor( time / 60 ) )..' минут'
    else
        time = tostring( time )..' секунд'
    end

    for _, ply in ipairs( player.GetAll() ) do
        ply:ChatSend( C.AMBI_RED, '[•]', C.ABS_WHITE, ' Игрок ', C.AMBI_RED, ePly:Name(), C.ABS_WHITE, ' покинул сервер. Наиграно: '..time )
    end
end )

-- local function CreateFog()
--     for i, fog in ipairs( ents.FindByClass( 'env_fog_controller' ) ) do
--         return fog
--     end

--     local fog = ents.Create( 'env_fog_controller' )
--     fog:Spawn()

--     return fog
-- end

-- local function SetFog( eFog, nFogStart, nFogEnd, nFarZ, cFogColor, cFogColor2, bFodBlend )
--     if not IsValid( eFog ) then print( 'eFog is not valid' ) return end
--     if ( eFog:GetClass() != 'env_fog_controller' ) then print( 'eFog is not class env_fog_controller' ) return end

--     eFog:SetKeyValue( 'fogenable', '1' )
--     eFog:SetKeyValue( 'fogstart', nFogStart )
--     eFog:SetKeyValue( 'fogend', nFogEnd )
--     eFog:SetKeyValue( 'farz', nFarZ )
--     eFog:SetKeyValue( 'fogcolor', cFogColor )
--     eFog:SetKeyValue( 'fogcolor2', cFogColor2 )
--     eFog:SetKeyValue( 'fogblend', bFodBlend )
-- end

-- local fog = CreateFog()
-- SetFog( fog, '8048', '9096', '12096', '163 163 163', '163 163 163', '1' )