AmbTimeCycle = AmbTimeCycle or {}
AmbTimeCycle.times = {

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
AmbTimeCycle.time_s = 0
AmbTimeCycle.time_m = 0
AmbTimeCycle.time_h = 0
AmbTimeCycle.time_d = 1

RunConsoleCommand( 'sv_skyname', 'painted' )

function AmbTimeCycle.SetTimeEnvironment( sTime )

    sTime = string.lower( sTime )

    local tab = AmbTimeCycle.times[ sTime ]
    local light_env = AmbTimeCycle.FindLightEnvironment()
    local skypaint = AmbTimeCycle.FindEnvSkyPaint()

    if light_env then light_env:Fire( 'setpattern', tab.pattern ) end

    for k, v in pairs( tab ) do

        if ( k == 'pattern' ) then continue end

        skypaint:SetKeyValue( k, v )

    end

end

function AmbTimeCycle.FindLightEnvironment()

    for _, ent in pairs( ents.FindByClass( 'light_environment' ) ) do

        return ent

    end

    return false

end

function AmbTimeCycle.FindEnvSkyPaint()

    for _, ent in pairs( ents.FindByClass( 'env_skypaint' ) ) do
        
        return ent

    end

    local new_ent = ents.Create( 'env_skypaint' )
    new_ent:SetPos( Vector( 0, 0, 0 ) )
    new_ent:SetAngles( Angle( 0, 0, 0 ) )
    new_ent:Spawn()

    return new_ent

end

hook.Add( 'InitPostEntity', 'AmbTimeCycleSetupTimeEnvironment', function()

    AmbTimeCycle.SetTimeEnvironment( 'Day' )

    AmbTimeCycle.start_time = true

end )

local delay = 0
hook.Add( 'Think', 'AmbTimeCycleTime', function() 

    if ( delay >= CurTime() ) then return end
    if not AmbTimeCycle.start_time then return end

    delay = CurTime() + 1

    AmbTimeCycle.time_s = AmbTimeCycle.time_s + 2

    if ( AmbTimeCycle.time_s >= 60 ) then

        AmbTimeCycle.time_s = 0
        AmbTimeCycle.time_m = AmbTimeCycle.time_m + 1

    end

    if ( AmbTimeCycle.time_m >= 60 ) then

        AmbTimeCycle.time_m = 0
        AmbTimeCycle.time_h = AmbTimeCycle.time_h + 1

    end

    if ( AmbTimeCycle.time_h >= 24 ) then

        AmbTimeCycle.time_h = 0
        AmbTimeCycle.time_d = AmbTimeCycle.time_d + 1

    end
    
    if ( AmbTimeCycle.time_m >= 45 ) then AmbTimeCycle.SetTimeEnvironment( 'night' )
    elseif ( AmbTimeCycle.time_m >= 40 ) then AmbTimeCycle.SetTimeEnvironment( 'sundown' )
    elseif ( AmbTimeCycle.time_m >= 5 ) then AmbTimeCycle.SetTimeEnvironment( 'day' )
    elseif ( AmbTimeCycle.time_m >= 0 ) then AmbTimeCycle.SetTimeEnvironment( 'sundown' )
    end

end )
