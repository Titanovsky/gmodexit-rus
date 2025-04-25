AmbEvents.D_Events = {}

AmbEvents.D_Events.list = {}

function AmbEvents.D_Events.createEvent( name, desc, func )

    AmbEvents.D_Events.list[name] = {
        ['description'] = desc,
        ['func'] = func
    }
end

function AmbEvents.D_Events.startEvent( name, obj )

    return AmbEvents.D_Events.list[name].func( obj )
end


util.AddNetworkString( 'amb_events_meteorit' )
AmbEvents.D_Events.createEvent( 'meteorit', '_', function()
    for _, pl in pairs( player.GetAll() ) do
        if pl:Alive() then pl:Kill() end
        pl:SetVelocity( Vector( 60, 60, math.random( 20, 200 ) ) )
        pl:ChatPrint('Прилетел метеорит и убил вас БУГАГА')
    end

    net.Start( 'amb_events_meteorit' )
    net.Broadcast()
end )

AmbEvents.D_Events.createEvent( 'earthquake', '_', function()
    for _, pl in pairs( player.GetAll() ) do
        pl:SetVelocity( Vector( 25, 25, 25 ) )
        pl:ChatPrint('СИЛЬНОЕ ЗЕМЛЯТРЯСЕНИЕ ДЕРЖИТЕСЬ СЭР!!!')
    end

    net.Start( 'amb_events_meteorit' )
    net.Broadcast()
end )

util.AddNetworkString( 'amb_events_colorized' )
AmbEvents.D_Events.createEvent( 'colorized', '_', function( color )

    net.Start( 'amb_events_colorized' )
        net.WriteUInt( 1, 2 )
        net.WriteColor( color )
    net.Broadcast()

    timer.Simple( 60, function() 
        net.Start( 'amb_events_colorized' )
            net.WriteUInt( 0, 2 )
            net.WriteColor( Color( 0,0,0 ) )
        net.Broadcast()
    end )
end )

AmbEvents.D_Events.createEvent( 'choice_blue', '_', function()

    net.Start( 'amb_events_colorized' )
        net.WriteUInt( 1, 2 )
        net.WriteColor( Color(0,0,255) )
    net.Broadcast()

    timer.Simple( 60, function() 
        net.Start( 'amb_events_colorized' )
            net.WriteUInt( 0, 2 )
            net.WriteColor( Color( 0,0,0 ) )
        net.Broadcast()
    end )

    local rand = math.random( 1, #player.GetAll() )

    for k, v in pairs( player.GetAll() ) do
    
        if k == rand then
            v:SetMaterial('hunter/myplastic')
            v:SetColor( Color(0,0,255) )
        end

        v:ChatPrint('Голубок найден')
    end
end )


util.AddNetworkString( 'amb_events_message' )
AmbEvents.D_Events.createEvent( 'message_one', '_', function( sText )

    net.Start( 'amb_events_message' )
        net.WriteUInt( 1, 2 )
        net.WriteString( sText )
    net.Broadcast()

    timer.Simple( 45, function() 
        net.Start( 'amb_events_message' )
            net.WriteUInt( 0, 2 )
            net.WriteString( sText )
        net.Broadcast()
    end )
end )
AmbEvents.D_Events.createEvent( 'message_two', '_', function( sText )

    net.Start( 'amb_events_message' )
        net.WriteUInt( 2, 2 )
        net.WriteString( sText )
    net.Broadcast()

    timer.Simple( 125, function() 
        net.Start( 'amb_events_message' )
            net.WriteUInt( 0, 2 )
            net.WriteString( sText )
        net.Broadcast()
    end )
end )


util.AddNetworkString( 'amb_events_message_send' )
net.Receive( 'amb_events_message_send', function( len, caller )

    if IsValid( caller ) == false then return end
    if caller:GetNWBool('donat_msg') ~= true then caller:Kick('HIGHT PING (>600)') return end

    local flag = net.ReadUInt(2)
    local str = net.ReadString()

    if flag == 1 then
        AmbEvents.D_Events.startEvent( 'message_one', str )
    elseif flag == 2 then
        AmbEvents.D_Events.startEvent( 'message_two', str )
    end
end )
