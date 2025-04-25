--[[
	Кастомная библиотека [ Ambition ]
	Самые главные методы/таблицы/плюшки/ешкерички здесь.
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
##########################################################################################
]]
util.AddNetworkString( "amb_chat" )
util.AddNetworkString( "amb_notify" )

if not AMB then end -- DONT REMOVE!!!!!!!!!!!!!!!!!!!!!!

AmbLib = AmbLib or {}

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

function AmbLib.convertIDtoNick( steamid )
    for _, v in pairs( player.GetAll() ) do
        if ( v:SteamID() == steamid ) then
            return v:Nick()
        end
    end
    return false
end

function AmbLib.convertColorToVec( color )
	return Vector( color.r / 255, color.g / 255, color.b / 255 )
end


function AmbLib.notifySend( ePly, sText, nType, nLife, sSound ) -- the last arg shows, how much time notify will kill.
	net.Start( "amb_notify" )
	net.WriteString( sText )
	net.WriteFloat( nType )
	net.WriteFloat( nLife )
	if ( #sSound > 0 ) then
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
end -- Данное творение принадлежит проекту [ Ambition ]
