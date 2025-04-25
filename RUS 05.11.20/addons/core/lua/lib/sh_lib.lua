--[[
	Кастомная библиотека для серверов.
	Самые главные методы/функции здесь здесь.
	Сервер находится в подчинений проекта: [ Ambition ]


	[19.04.20]
		• [15:58] Первая версия библиотеки. Отправка в чат + notify.
	.
	[26.04.20]
		• [19:50] Добавил отправку всем + отредактировал названия.
		• [20:50] Переделал всё под одну фукнцию.
	.
	[27.04.20]
		• [11:59] Добавил аргумент sSound.
	.
	[07.05.20]
		• Добавил два способа рендера окружности.
	.
	[18.06.20]
		• Добавил конверт AmbLib.convertColortoVec( color )
		• Думаю может всё в один sh файл замутить..
	.
	[01.08.20]
		• Пофиксил звук у notify.
	.
    [09.09.20]
        • Занёс в shared.
    .
##########################################################################################
]]

-- ( SHARED )

if ( AMB == false ) then return end -- Don't remove, please!

AmbLib = AmbLib or {}

function AmbLib.convertIDtoNick( steamid )
    for _, v in pairs( player.GetAll() ) do
        if ( v:SteamID() == steamid ) then
            return v:Nick()
        end
    end
    return false
end

function AmbLib.convertNicktoID( nick )
    for _, v in pairs( player.GetAll() ) do
        if ( v:Nick() == nick ) then
            return v:SteamID()
        end
    end
    return false
end

function AmbLib.convertNametoID( name )
    for _, v in pairs( player.GetAll() ) do
        if ( v:GetNWString('amb_players_name') == name ) then
            return v:SteamID()
        end
    end
    return false
end

function AmbLib.convertColorToVec( color )
    return Vector( color.r / 255, color.g / 255, color.b / 255 )
end

function rgb( r, g, b, a )
    if ( a ) then
        return Color( r, g, b, a )
    else
        return Color( r, g, b, 255 )
    end
end

if ( SERVER ) then
    util.AddNetworkString( "amb_chat" )
    util.AddNetworkString( "amb_notify" )

    function AmbLib.chatSend( ePly, ... )

        local args = { ... } -- varargs
        net.Start( "amb_chat" )
        net.WriteTable( args )
        if ePly == "all" then -- sending all
            net.Broadcast()
        elseif IsValid( ePly ) and ePly:IsPlayer() then -- send only one player
            net.Send( ePly )
        else
            return
        end
    end


    function AmbLib.notifySend( ePly, sText, nType, nLife, sSound ) -- the last arg shows, how much time notify will kill.
        net.Start( "amb_notify" )
        net.WriteString( sText )
        net.WriteFloat( nType )
        net.WriteFloat( nLife )
        if ( sSound ) then
            net.WriteString( sSound )
        else
            net.WriteString( '' )
        end
        if ePly == "all" then -- sending all
            net.Broadcast()
        elseif IsValid( ePly ) and ePly:IsPlayer() then -- send only one player
            net.Send( ePly )
        else
            return
        end
    end
elseif ( CLIENT ) then 
    net.Receive( "amb_chat", function( len )
        local msg = net.ReadTable()
        chat.AddText( unpack( msg ) )
    end)

    net.Receive( "amb_notify", function()
        local text = net.ReadString()
        local type_notify = net.ReadFloat()
        local life = net.ReadFloat()
        local snd = net.ReadString() -- sounds
        notification.AddLegacy( text, type_notify, life)
        if ( snd ) and ( #snd > 0 ) then -- generic, лампочка
            surface.PlaySound( snd )
        end
    end)

    function draw.Circle( x, y, radius, seg )
        local cir = {}

        table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
        for i = 0, seg do
            local a = math.rad( ( i / seg ) * -360 )
            table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
        end

        local a = math.rad( 0 ) -- This is needed for non absolute segment counts
        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

        surface.DrawPoly( cir )
    end

    function draw.CircleCustom( x, y, w, h, ang, color, x0, y0 )
        for i=0,ang do
            local c = math.cos(math.rad(i))
            local s = math.sin(math.rad(i))
            local newx = y0 * s - x0 * c
            local newy = y0 * c + x0 * s

            draw.NoTexture()
            surface.SetDrawColor(color)
            surface.DrawTexturedRectRotated(x + newx,y + newy,w,h,i)
        end
    end   
end

-- Данное творение принадлежит проекту [ Ambition ]