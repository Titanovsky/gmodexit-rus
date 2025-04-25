AmbTimeCycle = AmbTimeCycle or {}

AmbTimeCycle.times = {
    Day = {
        pattern = 'r', 
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

    Night = {
        pattern = 'a', 
        topcolor = '0.00 0.00 0.00', 
        bottomcolor = '0.02 0.02 0.02',
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

    SunDown = {
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
}

function AmbTimeCycle.SetTimeEnvironment( sTime )

    local tab = AmbTimeCycle.times[ sTime ]

    local light_env = AmbTimeCycle.FindLightEnvironment()
    light_env:Fire( 'setpattern', tab.pattern )
    
    local skypaint = AmbTimeCycle.FindEnvSkyPaint()

    for k, v in pairs( tab ) do

        if ( k == 'pattern' ) then continue end

        skypaint:SetKeyValue( k, v )

    end

end

function AmbTimeCycle.FindLightEnvironment()

    for _, ent in pairs( ents.FindByClass( 'light_environment' ) ) do
        
        return ent

    end

    local new_ent = ents.Create( 'light_environment' )
    new_ent:SetPos( 0, 0, 0 )
    new_ent:Spawn()

    return new_ent

end

function AmbTimeCycle.FindEnvSkyPaint()

    for _, ent in pairs( ents.FindByClass( 'env_skypaint' ) ) do
        
        return ent

    end

    local new_ent = ents.Create( 'env_skypaint' )
    new_ent:SetPos( 0, 0, 0 )
    new_ent:Spawn()

    return new_ent

end