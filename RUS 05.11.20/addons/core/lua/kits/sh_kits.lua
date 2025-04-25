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
    [ 16.08.29 ]
        • Пофиксил баг с team, т.к засунул их в глобальную переменную
    .
]]

AmbKits = AmbKits or {}

local s = 1
local m = 60
local h = 3600
local d = 86400

local amb_db_kits = 'amb_db_kits'

AmbKits.Kits = {

    ['starter'] = {
        once = false, 
        interval = m*25,
        check = function( ePly ) return true end,
        func = function( ePly )
            AmbStats.Players.addStats( ePly, "$", 40 )
            if ( ePly:Team() == AMB_TEAM_PVP ) or ( ePly:Team() == AMB_TEAM_RP ) then
                ePly:Give('arccw_awm')
                ePly:Give('arccw_m107')
                ePly:Give('arccw_rpg7')
                ePly:Give('weapon_stunstick')
                ePly:SetHealth( 150 )
            end
            return true
        end 
    },

    ['titan'] = { 
        once = true, 
        interval = m*2,
        check = function( ePly ) return true end,
        func = function( ePly )
            ePly:ChatPrint('999999999999999999999999')
            return true
        end  
    },

    ['minecraft'] = { 
        once = false, 
        interval = m,
        check = function( ePly ) if ePly:Team() == AMB_TEAM_PVP then return true end end,
        func = function( ePly )
            if ePly:Team() == AMB_TEAM_RP then
                ePly:Give('weapon_fists')
                return true
            end
            return false
        end  
    },

    ['kermit'] = {
        once = false,
        interval = m*40,
        check = function( ePly ) return true end,
        func = function( ePly )
            ePly:SetModel( 'models/player/pyroteknik/kermit.mdl' )
            ePly:ChatPrint( 'You becam a Kermit!')
        end
    },

    ['home'] = { 
        once = false, 
        interval = m-30,
        check = function( ePly ) return true end,
        func = function( ePly )
            if ( ePly:Team() == AMB_TEAM_RP ) or ( ePly:Team() == AMB_TEAM_PVP )  then
                ePly:Give('weapon_fists')
                local home = ents.Create('prop_physics')
                ePly:ChatPrint( 'You give a LargeBox' )
                home:SetModel( 'models/galaxy/rust/wood_largebox.mdl' )
                home:SetPos( ePly:GetPos() + Vector( 45, 45, 25 ) )
                home:CPPISetOwner( ePly )
                home:PhysicsInit( SOLID_VPHYSICS )
                home:SetMoveType( MOVETYPE_VPHYSICS )
                --local phys = home:GetPhysicsObject()
                --if IsValid( phys ) then phys:Wake() end
                timer.Simple( 4, function() if IsValid(home) then home:Remove() end end )
                return true
            end
            return false
        end  
    },
}

function AmbKits.checkKit( ePly, kit )
    for name, v in pairs( AmbKits.Kits ) do
        if kit == name then
            return v.check( ePly )
        end
    end
end

if ( SERVER ) then

    local function initDataBase()
        AmbDB.createDataBase( amb_db_kits, [[ 
            'ID' varchar(255),
            'Diff_Time' bigint,
            'Kit' varchar(255)]] 
        )
    end
    initDataBase()

    function AmbKits.saveDate( ePly, kit, time )
        if ( AmbDB.selectDate( amb_db_kits, 'ID', 'ID', ePly:SteamID() ) == ePly:SteamID() ) and ( AmbDB.selectDate( amb_db_kits, 'ID', 'Kit', kit ) == ePly:SteamID() ) then
            --ePly:ChatPrint('5 step | saveDate | update')
            --ePly:ChatPrint( AmbDB.selectDate( amb_db_kits, 'ID', 'ID', ePly:SteamID() )..' | '..AmbDB.selectDate( amb_db_kits, 'ID', 'Kit', kit ) == ePly:SteamID() )
            sql.Query( 'UPDATE amb_db_kits SET Diff_Time='..sql.SQLStr(time)..' WHERE ID='..sql.SQLStr(ePly:SteamID())..' AND Kit='..sql.SQLStr(kit) )
        else
            --ePly:ChatPrint('5 step | saveDate | insert')
            --ePly:ChatPrint( AmbDB.selectDate( amb_db_kits, 'ID', 'ID', ePly:SteamID() )..' | '..AmbDB.selectDate( amb_db_kits, 'ID', 'Kit', kit ) == ePly:SteamID() )
            AmbDB.insertDate( amb_db_kits, "ID, Diff_Time, Kit", " "..sql.SQLStr( ePly:SteamID() )..", "..time..", "..sql.SQLStr( kit ).." " )
        end
    end

    function AmbKits.updateKit( ePly, kit )
        local forever = os.time() * d * 2048
        ePly:ChatPrint('4 step | updateKit | '..kit) -- debug
        for name, v in pairs( AmbKits.Kits ) do
            if ( kit == name ) then
                --ePly:ChatPrint('4.1 step | '..kit..' == '..name) -- debug
                if ( v.once ) then
                    -- ePly:ChatPrint('4.2 step | once') -- debug
                    AmbKits.saveDate( ePly, kit, forever )
                else
                    local time = os.time() + v.interval
                    -- ePly:ChatPrint( tostring( time ) ) -- debug
                    print( os.date( '%c', time ) )
                    -- ePly:ChatPrint('4.2 ALTER step | not once') -- debug
                    AmbKits.saveDate( ePly, kit, time )
                end
            end
        end
    end

    function AmbKits.giveKit( ePly, kit )
        --ePly:ChatPrint('1 step | giveKit: '..kit)
        for name, v in pairs( AmbKits.Kits ) do
            if ( kit == name ) then
                -- ePly:ChatPrint('2 step | kit == name')
                local interval = sql.QueryValue("SELECT Diff_Time from amb_db_kits WHERE ID="..sql.SQLStr( ePly:SteamID() ).." AND Kit="..sql.SQLStr( kit ))
                -- ePly:ChatPrint( tostring( interval ) )
                if ( interval ) then
                    local today = os.time()
                    -- ePly:ChatPrint('3 step | interval')
                    if ( os.time() >= tonumber( interval ) ) then
                        --ePly:ChatPrint('3.1 step | Finish | '..kit)
                        AmbKits.updateKit( ePly, kit )
                        if ( v.func( ePly ) ) then
                            --ePly:ChatPrint('Final step | OK')
                        else
                            --ePly:ChatPrint('Final step | NOT')
                        end
                    else
                        -- ePly:ChatPrint('3.1 ALTER step | Delay')
                        if v.once then
                            return ePly:ChatPrint( 'Кит был единоразовым' )
                        else
                            return ePly:ChatPrint( 'Ожидайте до '..tostring( os.date('%c', interval) ) )
                        end
                    end
                else
                    -- ePly:ChatPrint('3 ALTER step | not interval')
                    AmbKits.updateKit( ePly, kit )
                    v.func( ePly )
                end
            end
        end
    end
    concommand.Add('kit', function( ply, cmd, args ) 
        AmbKits.giveKit( ply, tostring( args[1] ) )
    end )
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