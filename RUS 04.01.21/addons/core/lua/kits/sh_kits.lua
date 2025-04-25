--[[
	Система наборов.
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[ 09.08.20 ]
		• Главная таблица, интервал, выдача, сохранение.
        • Доделал систему. todo: clear code
	.
    [ 10.08.20 ]
        • Пофиксил баг, связанные с залупой по поводу проверки sql Kit.
    .
    [ 16.08.20 ]
        • Пофиксил баг с team, т.к засунул их в глобальную переменную
    .
    [28.08.20]
        • Добавил для DarkRP донатные наборы.
    .
    [22.09.20]
        • Добавил /kit vip, premium, titanium
    .
    [29.09.20]
        • Решил переписать 80% всей этой дрисни
        • Сделал адекватную архитектуру
    .
    [12.10.20]
        • Заменил проверку в sv_data.lua
    .
]]

AmbKits = AmbKits or {}

AmbKits.time_s = 1
AmbKits.time_m = AmbKits.time_s * 60
AmbKits.time_h = AmbKits.time_m * 60
AmbKits.time_d = AmbKits.time_h * 24
AmbKits.time_f = AmbKits.time_d * 2048

AmbKits.kits = {}

function AmbKits.AddKit( sName, bOnce, nInterval, fCheck, fAction )

    AmbKits.kits[ sName ] = {

        once = bOnce,
        interval = nInterval,
        check = fCheck,
        func = fAction

    }

    print( '[AmbKtis] Added kit: '..sName )

end


-- ## Kits ########################################
AmbKits.AddKit( 'test', false, AmbKits.time_m,

    function( ePly ) 
    
        return true 

    end,

    function( ePly )

        ePly:ChatPrint( 'test test' )

    end

)

AmbKits.AddKit( 'minecraft', false, AmbKits.time_m*10,

    function( ePly ) 
    
        return true
        
    end,

    function( ePly )

        ePly:Give( 'weapon_medkit' )
        ePly:ChatPrint( 'Тимурус лох, трусы в горох!' )

    end

)

-- ################################################


--[[

function AmbKits.checkKit( ePly, kit )
    for name, v in pairs( AmbKits.Kits ) do
        if kit == name then
            return v.check( ePly )
        end
    end
end

elseif ( CLIENT ) then
    function AmbKits.showKits()

        local kits = {}
        local i = 0

        for name, v in pairs( AmbKits.Kits ) do
		    kits[name] = AmbKits.checkKit( LocalPlayer(), name )
        end
		chat.AddText( AMB_COLOR_AMBITION, "=====================" )
        chat.AddText( AMB_COLOR_AMBITION, "[•] ", AMB_COLOR_WHITE, ' Вам доступны киты: ' )

        for name, access in pairs( kits ) do
            if access then
		        chat.AddText( AMB_COLOR_RED, name )
            end
        end
		chat.AddText( AMB_COLOR_AMBITION, "=====================" )
    end
end
]]

