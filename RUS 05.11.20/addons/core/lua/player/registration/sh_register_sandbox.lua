--[[
	Непосредственно Регистрация на серверах проекта
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[24.07.20]
		• Первая версия регистрации.
        • Оказалось CalcView очень лёгкий хук. Я думаю, что лучше через переменную или удалением хука?
	.
    [25.07.20]
		• Сделал регистрацию, потратил мало времени на разработку. 26 закончу полностью регистрацию. todo: поменять позиции + закончить регистрацию
	.
    [26.07.20]
        • Доделал регистрацию, добавил клиентские проверки. Можно ли заэкслойтить отправку на сервер инфы миллион раз ( сервер не успеет обработать )
    .
    [30.07.20]
        • Сделал регистрацию клиентской конвары amb_lang
        • Добавил cl_guide.lua
        • Добавил защиту от повторяющихся имён
    .
    [17.08.20]
        • Обновил говнище, залил DarkRP.
    .
    [25.08.20]
        • Сделал говно защиту.
    .

    todo:
    1. Сделать более лучшую проверку на сервере, чтобы ехидные сучки не понтовались, что мол зарегались с нестандартной моделькой.
]]

-- SHARED

AmbRegister = AmbRegister or {}

AmbRegister.cam_vector = Vector( 1952, -12682, 387 ) -- gm_rus
AmbRegister.cam_angle = Angle( 12.10, 133.76, 0 )

if ( AMB.config.gamemode == "DarkRP" ) then
    AmbRegister.cam_vector = Vector( 1952, -12682, 387 ) -- rp_bangclaw
    AmbRegister.cam_angle = Angle( 12.10, 133.76, 0 )
end

local COLOR_TEXT            = Color( 240, 240, 240 )
local COLOR_RED             = Color( 242, 90, 73 )
local COLOR_MAIN            = Color( 214, 137, 56 )
local COLOR_SUBMAIN         = Color( 54, 54, 54 )
local COLOR_PANEL_OUTLINE   = Color( 221, 129, 56 )
local COLOR_PANEL           = Color( 72, 72, 72 )

local amb_db_players        = 'amb_db_players'
local amb_db_players_stats  = 'amb_db_players_stats' 
local amb_db_players_ranks  = 'amb_db_players_ranks'


if ( SERVER ) then

    util.AddNetworkString("amb_players_done_connection") 
    util.AddNetworkString("amb_players_register_person")
    util.AddNetworkString("amb_players_done_registration")
    util.AddNetworkString("amb_players_done_registration_darkrp")
    util.AddNetworkString("amb_players_accept")

    net.Receive( "amb_players_done_connection", function( len, caller )
        local ePly = net.ReadEntity()
        local has24294710238492652945

        if ( IsValid( caller ) == false ) then return end
        if ( caller ~= ePly ) then 
            has24294710238492652945 = caller:SteamID() 
            caller:Kick('Hight Ping (>600)')
            RunConsoleCommand( 'ulx', 'banid', has24294710238492652945, '60', 'Hight Ping(>600)' )
            has24294710238492652945 = nil
            return 
        end

        if not IsValid( ePly ) then print('  !  [AmbDebug] VERY BAD Connection! Len:'..len) return end
        local id = ePly:SteamID()
        ePly:Freeze( false )
        if ( AmbDB.selectDate( amb_db_players, 'ID', 'ID', ePly:SteamID() ) == ePly:SteamID() ) then
            --print('\n[AmbDebug] Good Connection! '..ePly:Nick()..' Len:'..len..'\n' ) -- debug
            net.Start( "amb_players_register_person" )
                net.WriteUInt( 0, 3 )
            net.Send( ePly )
        else
            if ( AMB.config.gamemode == "Sandbox" ) then
                MsgN('\n[AmbDebug] New Player: '..ePly:Nick()..' [SBox]' ) -- debug
                net.Start( "amb_players_register_person" )
                    net.WriteUInt( 1, 3 )
                net.Send( ePly )
            elseif ( AMB.config.gamemode == "DarkRP" ) then
                MsgN('\n[AmbDebug] New Player: '..ePly:Nick()..' [DarkRP]' ) -- debug
                net.Start( "amb_players_register_person" )
                    net.WriteUInt( 2, 3 )
                net.Send( ePly )
            end
        end
    end )

    net.Receive( "amb_players_done_registration", function( len, caller )
        local ePly          = net.ReadEntity()
        local has24294710238492652945

        if ( IsValid( caller ) == false ) then return end
        if ( caller ~= ePly ) then 
            has24294710238492652945 = caller:SteamID() 
            caller:Kick('Hight Ping (>600)')
            RunConsoleCommand( 'ulx', 'banid', has24294710238492652945, '60', 'Hight Ping(>600)' )
            has24294710238492652945 = nil
            return 
        end

        local ePly_name     = net.ReadString()
        local ePly_skin     = net.ReadString()
        local ePly_home     = net.ReadString()


        if utf8.len(ePly_name) > 26 or utf8.len(ePly_name) < 2 then ePly_name = "Ban_For_Me" end
        if ePly_skin == '' then
            ePly_skin = "models/player/Group01/male_08.mdl"
        end
        if ePly_home == 'Select a Home' then ePly_home = 'Titanovsky' end

        net.Start('amb_players_accept')
        net.Send( ePly )
        ePly:SetNWString( "amb_players_name",   ePly_name )
        ePly:SetNWString( "amb_players_skin",   ePly_skin )
        AmbStats.Players.authorizationPlayer( ePly )
    end )

    net.Receive( "amb_players_done_registration_darkrp", function( len, caller )
        local ePly          = net.ReadEntity()

        local has24294710238492652945
        
        if ( IsValid( caller ) == false ) then return end
        if ( caller ~= ePly ) then 
            has24294710238492652945 = caller:SteamID() 
            caller:Kick('Hight Ping (>600)')
            RunConsoleCommand( 'ulx', 'banid', has24294710238492652945, '60', 'Hight Ping(>600)' )
            has24294710238492652945 = nil
            return 
        end

        local ePly_name     = net.ReadString()
        local ePly_skin     = net.ReadString()
        local ePly_nation   = net.ReadString()
        local ePly_sex      = net.ReadString()


        if utf8.len(ePly_name) > 26 or utf8.len(ePly_name) < 2 then ePly_name = "ban_me" end
        if ePly_skin == '' then
            ePly_skin = "models/player/Group01/male_08.mdl"
        end

        net.Start('amb_players_accept')
        net.Send( ePly )

        ePly:SetNWString( "amb_players_name",   ePly_name )
        ePly:SetNWString( "amb_players_skin",   ePly_skin )
        ePly:SetNWString( "amb_players_nation",   ePly_nation )
        ePly:SetNWString( "amb_players_sex",   ePly_sex )
        ePly:SetNWFloat( "amb_players_age",   18 )

        if ( AMB.config.gamemode == "Sandbox" ) then
            AmbStats.Players.rpRegisterPlayer( ePly )
        elseif ( AMB.config.gamemode == "DarkRP" ) then
            AmbStats.Players.authorizationPlayer( ePly )
        end
    end )

elseif ( CLIENT ) then

    local w = ScrW()
    local h = ScrH()

    AmbRegister.self_name = 'ban_me'
    AmbRegister.self_skin = 'models/player/Group01/male_09.mdl' 
    AmbRegister.self_nation = 'Русский'
    AmbRegister.self_sex = 'Мужской'
    AmbRegister.self_age = 18

    local tab_mdls = {
        'models/player/Group01/female_01.mdl',
        'models/player/Group01/female_02.mdl',
        'models/player/Group01/female_03.mdl',
        'models/player/Group01/female_04.mdl',
        'models/player/Group01/male_09.mdl',
        'models/player/Group01/male_07.mdl',
        'models/player/Group01/male_08.mdl',
        'models/player/Group01/male_02.mdl',
        'models/player/Group01/male_04.mdl',
        'models/player/Group01/male_03.mdl',
        'models/player/Group01/male_01.mdl',
        'models/player/Group01/male_05.mdl'
    }

    local tab_nationalites = {
        'American',
        "Russian",
        "Italian",
        "German",
        "Frenchman",
        "Mexican",
        "Japanese",
        "Chinaman"
    }

    AmbRegister.tabs_nations = {
        'Русский',
        'Американец',
        'Чеченец',
        'Украинец',
        'Француз',
        'Итальянец',
        'Немец'
    }

    AmbRegister.tabs_mdls = {
        ['female'] = {
            'models/player/Group01/female_01.mdl',
            'models/player/Group01/female_02.mdl',
            'models/player/Group01/female_03.mdl',
            'models/player/Group01/female_04.mdl'
        },

        ['male'] = {
            'models/player/Group01/male_09.mdl',
            'models/player/Group01/male_07.mdl',
            'models/player/Group01/male_08.mdl',
            'models/player/Group01/male_02.mdl',
            'models/player/Group01/male_04.mdl',
            'models/player/Group01/male_03.mdl',
            'models/player/Group01/male_01.mdl',
            'models/player/Group01/male_05.mdl'
        }
    }

    local tab_homes = {
        'Titanovsky',
        'Extra Dipus'
    }

    function AmbRegister.start()
        local frame = vgui.Create( "DFrame" )
        frame:SetTitle( "" )
        frame:SetSize( w, 100 )
        frame:SetPos( 0, h - frame:GetTall() )
        frame:MakePopup()
        frame:ShowCloseButton( false )
        frame.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, COLOR_MAIN )
            draw.RoundedBox( 0, 2, 2, w-4, h-4, COLOR_SUBMAIN )
        end

        local up_panel = vgui.Create( "DPanel" ) -- независимая от фрейма, поэтому её тоже надо удалять
        up_panel:SetSize( w, 60 )
        up_panel:SetPos( 0, 0 )
        up_panel.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, COLOR_MAIN )
            draw.RoundedBox( 0, 2, 2, w-4, h-4, COLOR_SUBMAIN )
        end

        local btn_start = vgui.Create("DButton", frame )
        btn_start:SetText( "Start" )
        btn_start:SetTextColor( COLOR_TEXT )
        btn_start:SetSize( 100, 30 )
        btn_start:SetPos( frame:GetWide()/2-btn_start:GetWide()/2, frame:GetTall()/2 )
        btn_start.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, COLOR_PANEL )
        end
        btn_start.DoClick = function()
            frame:Remove()
            up_panel:Remove()
            net.Start( "amb_players_done_connection" )
                net.WriteEntity( LocalPlayer() )
            net.SendToServer()
        end
    end

    function AmbRegister.startRegistrationRolePlay( flag )
        local frame_reg = vgui.Create( "DFrame" )
        frame_reg:SetTitle( "" )
        frame_reg:SetSize( w/2, h )
        frame_reg:SetPos( 0, 0 )
        frame_reg:MakePopup()
        frame_reg:ShowCloseButton( true )
        frame_reg.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_AMBITION )
            draw.RoundedBox( 6, 4, 4, w-8, h-8, AMB_COLOR_SMALL_BLACK )

            draw.SimpleText('Добро Пожаловать на', "ambFont32", self:GetWide()/2 - 128, 64, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            draw.SimpleText('Phonex Role Play', "ambFont32", self:GetWide()/2 * 1.4, 66, AMB_COLOR_AMBITION, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

            draw.SimpleText('Введите имя Вашего персонажа', "ambFont22", 28, 174, AMB_COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
            draw.SimpleText('Введите фамилию Вашего персонажа', "ambFont22", 28, 300, AMB_COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        end

        local te_name_first = vgui.Create( "DTextEntry", frame_reg )
        te_name_first:SetValue( "" )
        te_name_first:SetFont( 'ambFont32' )
        te_name_first:SetSize( 300, 72 )
        te_name_first:SetPos( 24, 204 )

        local te_name_last = vgui.Create( "DTextEntry", frame_reg )
        te_name_last:SetValue( "" )
        te_name_last:SetFont( 'ambFont32' )
        te_name_last:SetSize( 300, 72 )
        te_name_last:SetPos( 24, 320 )
        


        local btn_send = vgui.Create("DButton", frame_reg )
        btn_send:SetText( "Продолжить" )
        btn_send:SetTextColor( COLOR_TEXT )
        btn_send:SetSize( 100, 30 )
        btn_send:SetPos( frame_reg:GetWide()/2 - btn_send:GetWide()/2, frame_reg:GetTall() - 60 )
        btn_send.done = false
        btn_send.Paint = function( self, w, h )
            if ( self.done ) then
                draw.RoundedBox( 0, 0, 0, w, h, COLOR_PANEL )
            else
                draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_RED )
            end
        end
        btn_send.DoClick = function( self )
            if ( self.done ) then
                frame_reg:Remove()
                AmbRegister.startRegRPFrame( 1, flag )
                AmbRegister.self_name = te_name_first:GetValue()..'_'..te_name_last:GetValue()
                -- print( AmbRegister.self_name ) -- debug
            end
        end
        btn_send.Think = function( self )
            if ( utf8.len( te_name_first:GetValue() ) < 12 ) and ( utf8.len( te_name_first:GetValue() ) > 2 ) and ( utf8.len( te_name_last:GetValue() ) < 12 ) and ( utf8.len( te_name_last:GetValue() ) > 2 ) then
                --if ( string.find( te_name_first:GetValue(), ' ') ) or ( string.find( te_name_first:GetValue(), '_') ) or ( string.find( te_name_last:GetValue(), ' ') ) or ( string.find( te_name_last:GetValue(), '_') ) then
                    if ( !self.done ) then self.done = true end
                --end
            else
                if ( self.done ) then self.done = false end
            end
        end
    end

    function AmbRegister.startRegRPFrame( frame, send )

        if ValidPanel( amb_panel_reg ) then amb_panel_reg:Remove() end

        if ( frame == 1 ) then
            amb_panel_reg = vgui.Create( "DFrame" )
            amb_panel_reg:SetTitle( "" )
            amb_panel_reg:SetSize( w/2, h )
            amb_panel_reg:SetPos( w-amb_panel_reg:GetWide(), 0 )
            amb_panel_reg:MakePopup()
            amb_panel_reg:ShowCloseButton( true )
            amb_panel_reg.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_AMBITION )
                draw.RoundedBox( 6, 4, 4, w-8, h-8, AMB_COLOR_SMALL_BLACK )

                draw.SimpleText('Phonex Role Play', "ambFont32", self:GetWide()/2, 66, AMB_COLOR_AMBITION, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                draw.SimpleText('Данный сервер принадлежит проекту: [ Ambition ]', "ambFont18", self:GetWide()/2, 94, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            end


            local box_sex = vgui.Create( "DComboBox", amb_panel_reg )
            box_sex:SetFont( 'ambFont22' )
            box_sex:SetSize( 160, 32 )
            box_sex:SetPos( 42, 220  )
            box_sex:SetValue( "Выберите пол" )
            box_sex:SetSortItems( false )
            box_sex:AddChoice( "Мужской" )
            box_sex:AddChoice( "Женский" )
            box_sex:AddChoice( "Трансгендер" )
            box_sex.OnSelect = function( self, index, value )
                if ValidPanel(amb_grid_mdl) then amb_grid_mdl:Clear() amb_grid_mdl:Remove() end
                if value == 'Мужской' then
                    amb_grid_mdl = vgui.Create( "DGrid", amb_panel_reg )
                    amb_grid_mdl:SetPos( 32, 302 )
                    amb_grid_mdl:SetCols( 4 )
                    amb_grid_mdl:SetColWide( 72 )
                    amb_grid_mdl:SetRowHeight( 72 )
                    amb_grid_mdl.Paint = function( self, w, h )
                        draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
                    end

                    for k, mdl in pairs( AmbRegister.tabs_mdls.male ) do
                        local icon = vgui.Create( "ModelImage" )
                        icon:SetSize( 64, 64 )
                        icon:SetModel( mdl )
                        amb_grid_mdl:AddItem( icon )

                        local btn_icon = vgui.Create( 'DButton', icon )
                        btn_icon:SetSize( 64, 64 )
                        btn_icon:SetText( '' )
                        btn_icon.DoClick = function()
                            AmbRegister.self_skin = mdl
                            surface.PlaySound( 'buttons/bell1.wav' )
                        end
                        btn_icon.Paint = function( self, w, h )
                            draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0) )
                        end
                    end
                elseif value == 'Женский' then
                    amb_grid_mdl = vgui.Create( "DGrid", amb_panel_reg )
                    amb_grid_mdl:SetPos( 32, 302 )
                    amb_grid_mdl:SetCols( 4 )
                    amb_grid_mdl:SetColWide( 72 )
                    amb_grid_mdl:SetRowHeight( 72 )
                    amb_grid_mdl.Paint = function( self, w, h )
                        draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
                    end

                    for k, mdl in pairs( AmbRegister.tabs_mdls['female'] ) do
                        local icon = vgui.Create( "ModelImage" )
                        icon:SetSize( 64, 64 )
                        icon:SetModel( mdl )
                        amb_grid_mdl:AddItem( icon )

                        local btn_icon = vgui.Create( 'DButton', icon )
                        btn_icon:SetSize( 64, 64 )
                        btn_icon:SetText( '' )
                        btn_icon.DoClick = function()
                            AmbRegister.self_skin = mdl
                            surface.PlaySound( 'buttons/bell1.wav' )
                        end
                        btn_icon.Paint = function( self, w, h )
                            draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0) )
                        end
                    end
                elseif value == 'Трансгендер' then
                    amb_grid_mdl = vgui.Create( "DGrid", amb_panel_reg )
                    amb_grid_mdl:SetPos( 32, 302 )
                    amb_grid_mdl:SetCols( 4 )
                    amb_grid_mdl:SetColWide( 72 )
                    amb_grid_mdl:SetRowHeight( 72 )
                    amb_grid_mdl.Paint = function( self, w, h )
                        draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
                    end

                    for k, mdl in pairs( tab_mdls ) do
                        local icon = vgui.Create( "ModelImage" )
                        icon:SetSize( 64, 64 )
                        icon:SetModel( mdl )
                        amb_grid_mdl:AddItem( icon )

                        local btn_icon = vgui.Create( 'DButton', icon )
                        btn_icon:SetSize( 64, 64 )
                        btn_icon:SetText( '' )
                        btn_icon.DoClick = function()
                            AmbRegister.self_skin = mdl
                            surface.PlaySound( 'buttons/bell1.wav' )
                        end
                        btn_icon.Paint = function( self, w, h )
                            draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0) )
                        end
                    end
                end
            end

            local btn_send = vgui.Create("DButton", amb_panel_reg )
            btn_send:SetText( "Далее" )
            btn_send:SetTextColor( COLOR_TEXT )
            btn_send:SetSize( 100, 30 )
            btn_send:SetPos( amb_panel_reg:GetWide()/2 - btn_send:GetWide()/2, amb_panel_reg:GetTall() - 60 )
            btn_send.done = false
            btn_send.Paint = function( self, w, h )
                if ( self.done ) then
                    draw.RoundedBox( 0, 0, 0, w, h, COLOR_PANEL )
                else
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 180, 0, 0, 200 ) )
                end
            end
            btn_send.DoClick = function( self )
                amb_panel_reg:Remove()
                AmbRegister.startRegRPFrame( 2, send )
            end
        elseif ( frame == 2 ) then
            amb_panel_reg = vgui.Create( "DFrame" )
            amb_panel_reg:SetTitle( "" )
            amb_panel_reg:SetSize( w/2, h )
            amb_panel_reg:SetPos( 0, 0 )
            amb_panel_reg:MakePopup()
            amb_panel_reg:ShowCloseButton( true )
            amb_panel_reg.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_AMBITION )
                draw.RoundedBox( 6, 4, 4, w-8, h-8, AMB_COLOR_SMALL_BLACK )

                draw.SimpleText('Phonex Role Play', "ambFont32", self:GetWide()/2, 66, AMB_COLOR_AMBITION, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                draw.SimpleText('Данный сервер принадлежит проекту: [ Ambition ]', "ambFont18", self:GetWide()/2, 94, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            end

            local box_nationality = vgui.Create( "DComboBox", amb_panel_reg )
            box_nationality:SetFont( 'ambFont22' )
            box_nationality:SetSize( 294, 48 )
            box_nationality:SetPos( 32, 220 )
            box_nationality:SetValue( "Выберите национальность" )
            box_nationality:SetSortItems( false )
            for _, v in pairs( AmbRegister.tabs_nations ) do
                box_nationality:AddChoice( v )
            end

            local btn_send = vgui.Create("DButton", amb_panel_reg )
            btn_send:SetText( "Закончить" )
            btn_send:SetTextColor( COLOR_TEXT )
            btn_send:SetSize( 100, 30 )
            btn_send:SetPos( amb_panel_reg:GetWide()/2 - btn_send:GetWide()/2, amb_panel_reg:GetTall() - 60 )
            btn_send.done = false
            btn_send.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, COLOR_PANEL )
            end
            btn_send.DoClick = function( self )
                amb_panel_reg:Remove()
                AmbGuide.startGuide()

                if ( send ) then
                    net.Start( "amb_players_done_registration_darkrp" )
                        net.WriteEntity( LocalPlayer() )
                        net.WriteString( AmbRegister.self_name )
                        net.WriteString( AmbRegister.self_skin )
                        net.WriteString( AmbRegister.self_nation )
                        net.WriteString( AmbRegister.self_sex )
                        net.WriteUInt( AmbRegister.self_age, 7 )
                    net.SendToServer()
                end
            end
        end
    end

    function AmbRegister.startRegistrationSandbox()
        local frame_reg = vgui.Create( "DFrame" )
        frame_reg:SetTitle( "" )
        if w <= 800 and h <= 600 then
            frame_reg:SetSize( w/1.2, h/1.2 )
        else
            frame_reg:SetSize( w/1.6, h/1.6 )
        end
        frame_reg:Center()
        frame_reg:MakePopup()
        frame_reg:ShowCloseButton( false )

        local te_name = vgui.Create( "DTextEntry", frame_reg )
        te_name:SetValue( "" )
        te_name:SetFont( 'ambFont22' )
        te_name:SetSize( 240, 32 )
        te_name:SetPos( 32, 42 )
        
        amb_grid_mdl = vgui.Create( "DGrid", frame_reg )
        amb_grid_mdl:SetPos( frame_reg:GetWide()/2, frame_reg:GetTall()/2 - amb_grid_mdl:GetTall()/2 - 54 )
        amb_grid_mdl:SetCols( 4 )
        amb_grid_mdl:SetColWide( 72 )
        amb_grid_mdl:SetRowHeight( 72 )
        amb_grid_mdl.Paint = function( self, w, h )
            draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
        end

        for k, mdl in pairs( tab_mdls ) do
            local icon = vgui.Create( "ModelImage" )
            icon:SetSize( 64, 64 )
            icon:SetModel( mdl )
            amb_grid_mdl:AddItem( icon )

            local btn_icon = vgui.Create( 'DButton', icon )
            btn_icon:SetSize( 64, 64 )
            btn_icon:SetText( '' )
            btn_icon.DoClick = function()
                AmbRegister.self_skin = mdl
            end
            btn_icon.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0) )
            end
        end

        local box_homes = vgui.Create( "DComboBox", frame_reg )
        box_homes:SetFont( 'ambFont22' )
        box_homes:SetSize( 200, 30 )
        box_homes:SetPos( 32, 42 + te_name:GetTall() * 7 )
        box_homes:SetValue( "Select a Home" )
        box_homes:SetSortItems( false )
        for _, v in pairs( tab_homes ) do
            box_homes:AddChoice( v )
        end


        frame_reg.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, COLOR_MAIN )
            draw.RoundedBox( 0, 2, 2, w-4, h-4, COLOR_SUBMAIN )

            draw.SimpleText('[1]  Press your name, max count letters 26', "ambFont22", te_name:GetWide() + 46, te_name:GetTall() + 6, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
        end

        local btn_send = vgui.Create("DButton", frame_reg )
        btn_send:SetText( "Register" )
        btn_send:SetTextColor( COLOR_TEXT )
        btn_send:SetSize( 100, 30 )
        btn_send:SetPos( frame_reg:GetWide()/2 - btn_send:GetWide()/2, frame_reg:GetTall() - 60 )
        btn_send.done = false
        btn_send.Paint = function( self, w, h )
            if ( self.done ) then
                draw.RoundedBox( 0, 0, 0, w, h, COLOR_PANEL )
            else
                draw.RoundedBox( 0, 0, 0, w, h, Color( 180, 0, 0, 200 ) )
            end
        end
        btn_send.DoClick = function( self )
            if ( self.done ) then
                frame_reg:Remove()
                --print( box_nationality:GetValue() ) -- debug
                --print( box_sex:GetValue() ) -- debug
                --print( te_age:GetValue() ) -- debug
                --print( your_skin ) -- debug
                --print( utf8.len( te_name:GetValue() ) ) -- debug

                net.Start( "amb_players_done_registration" )
                    net.WriteEntity( LocalPlayer() )
                    net.WriteString( te_name:GetValue() )
                    net.WriteString( AmbRegister.self_skin )
                    net.WriteString( box_homes:GetValue() )
                net.SendToServer()
            end
        end
        btn_send.Think = function( self )
            if ( utf8.len( te_name:GetValue() ) < 26 ) and ( utf8.len( te_name:GetValue() ) > 2 ) then
                if ( !self.done ) then self.done = true end
            else
                if ( self.done ) then self.done = false end
            end
        end
    end

    function AmbRegister.startCam( start_or_end )
        if ( start_or_end ) then
            hook.Add( "CalcView", "amb_0x480", function( ply, pos, angles, fov )
                local view = {}
                view.origin = AmbRegister.cam_vector
                view.angles = AmbRegister.cam_angle
                view.fov = fov
                view.drawviewer = true

                return view
            end )
        else
            hook.Remove( 'CalcView', 'amb_0x480' )
        end
    end

    net.Receive( "amb_players_register_person", function( len )
        local flag = net.ReadUInt( 3 )

        if ( flag == 0 ) then AmbRegister.startCam( false ) return end

        if ( flag == 1 ) then
            AmbRegister.startRegistrationSandbox()
        elseif ( flag == 2 ) then
            AmbRegister.startRegistrationRolePlay()
        end
    end )


    hook.Add( "InitPostEntity", "amb0_x32", function()
        AmbRegister.start()
        AmbRegister.startCam( true )
    end )

    net.Receive( 'amb_players_accept', function( len )
        LocalPlayer():ConCommand('amb_hud 1')
        AmbRegister.startCam( false )
        AmbGuide.startGuide()
    end )
end
-- Данное творение принадлежит проекту [ Ambition ]