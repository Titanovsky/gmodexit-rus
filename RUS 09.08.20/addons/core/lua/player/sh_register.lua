--[[
	Непосредственно Регистрация на сервер [RUs].
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

    todo:
    1. Сделать более лучшую проверку на сервере, чтобы ехидные сучки не понтовались, что мол зарегались с нестандартной моделькой.
]]

-- SHARED


local COLOR_TEXT            = Color( 240, 240, 240 )
local COLOR_RED             = Color( 242, 90, 73 )
local COLOR_MAIN            = Color( 214, 137, 56 )
local COLOR_SUBMAIN         = Color( 54, 54, 54 )
local COLOR_PANEL_OUTLINE   = Color( 221, 129, 56 )
local COLOR_PANEL           = Color( 72, 72, 72 )


if ( CLIENT ) then

    CreateClientConVar( 'amb_lang', 'en', true, false )


    local w = ScrW()
    local h = ScrH()
    local your_skin = '' -- тут 100% можно эксплойтнуть, но можно и пофиксить) Простоо на сервере сделать проверку на скины стандартные
    local your_skin_id = ''

    local tab_mdl_female = {
        'models/player/Group01/female_01.mdl',
        'models/player/Group01/female_02.mdl',
        'models/player/Group01/female_03.mdl',
        'models/player/Group01/female_04.mdl'
    }

    local tab_mdl_male = {
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

    local tab_homes = {
        'Titanovsky',
        'Extra Dipus',
        'Shitzu'
    }

    local function AmbRegister_startCam(ply, pos, angles, fov)
        local view = {}
        view.origin = Vector( 1952, -12682, 387 )
        view.angles = Angle( 12.10, 133.76, 0)
        view.fov = fov
        view.drawviewer = true

        return view
    end
    hook.Add( "CalcView", "amb_0x418", AmbRegister_startCam ) -- !!!!!!!!!!!!!!!!!!!!!!!!!

    local function AmbRegister_startMenu()
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
            local ply = LocalPlayer()
            frame:Remove()
            up_panel:Remove()
            net.Start( "amb_players_done_connection_" )
                net.WriteEntity( ply )
            net.SendToServer()
        end
    end

    net.Receive( "amb_players_register_person", function( len )
        local flag = net.ReadUInt( 3 )

        if ( flag == 0 ) then hook.Remove( "CalcView", "amb_0x418" ) return end

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

        local te_age = vgui.Create( "DTextEntry", frame_reg )
        te_age:SetValue( 18 )
        te_age:SetFont( 'ambFont22' )
        te_age:SetNumeric( true )
        te_age:SetSize( 64, 32 )
        te_age:SetPos( 32, 42 + te_name:GetTall() + te_age:GetTall() )
        te_age.Think = function( self )
            if #self:GetValue() > 1 then
                if tonumber( self:GetValue() ) < 16 then te_age:SetValue( 16 ) end
                if tonumber( self:GetValue() ) > 99 then te_age:SetValue( 99 ) end
            end
        end

        local box_sex = vgui.Create( "DComboBox", frame_reg )
        box_sex:SetFont( 'ambFont22' )
        box_sex:SetSize( 160, 32 )
        box_sex:SetPos( 32, 42 + te_name:GetTall() + te_age:GetTall() * 3  )
        box_sex:SetValue( "Select a sex" )
        box_sex:SetSortItems( false )
        box_sex:AddChoice( "Male" )
        box_sex:AddChoice( "Female" )
        box_sex.OnSelect = function( self, index, value )
            if ValidPanel(amb_grid_mdl) then amb_grid_mdl:Clear() amb_grid_mdl:Remove() end
            your_skin = ''
	        if value == 'Male' then
                amb_grid_mdl = vgui.Create( "DGrid", frame_reg )
                amb_grid_mdl:SetPos( frame_reg:GetWide()/2, frame_reg:GetTall()/2 - amb_grid_mdl:GetTall()/2 - 54 )
                amb_grid_mdl:SetCols( 4 )
                amb_grid_mdl:SetColWide( 72 )
                amb_grid_mdl:SetRowHeight( 72 )
                amb_grid_mdl.Paint = function( self, w, h )
                    draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
                end

                for k, mdl in pairs( tab_mdl_male ) do
                    local icon = vgui.Create( "ModelImage" )
                    icon:SetSize( 64, 64 )
                    icon:SetModel( mdl )
                    amb_grid_mdl:AddItem( icon )

                    local btn_icon = vgui.Create( 'DButton', icon )
                    btn_icon:SetSize( 64, 64 )
                    btn_icon:SetText( '' )
                    btn_icon.DoClick = function()
                        your_skin = mdl
                        your_skin_id = k
                    end
                    btn_icon.Paint = function( self, w, h )
                        draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0) )
                    end
                end
            elseif value == 'Female' then
                amb_grid_mdl = vgui.Create( "DGrid", frame_reg )
                amb_grid_mdl:SetPos( frame_reg:GetWide()/2, frame_reg:GetTall()/2 - amb_grid_mdl:GetTall()/2 - 54 )
                amb_grid_mdl:SetCols( 4 )
                amb_grid_mdl:SetColWide( 72 )
                amb_grid_mdl:SetRowHeight( 72 )
                amb_grid_mdl.Paint = function( self, w, h )
                    draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
                end

                for k, mdl in pairs( tab_mdl_female ) do
                    local icon = vgui.Create( "ModelImage" )
                    icon:SetSize( 64, 64 )
                    icon:SetModel( mdl )
                    amb_grid_mdl:AddItem( icon )

                    local btn_icon = vgui.Create( 'DButton', icon )
                    btn_icon:SetSize( 64, 64 )
                    btn_icon:SetText( '' )
                    btn_icon.DoClick = function()
                        your_skin = mdl
                        your_skin_id = k
                    end
                    btn_icon.Paint = function( self, w, h )
                        draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0) )
                    end
                end
            end
        end

        local box_nationality = vgui.Create( "DComboBox", frame_reg )
        box_nationality:SetFont( 'ambFont22' )
        box_nationality:SetSize( 200, 30 )
        box_nationality:SetPos( 32, 42 + te_name:GetTall() + te_age:GetTall() * 5 )
        box_nationality:SetValue( "Select a nationality" )
        box_nationality:SetSortItems( false )
        for _, v in pairs( tab_nationalites ) do
            box_nationality:AddChoice( v )
        end

        local box_homes = vgui.Create( "DComboBox", frame_reg )
        box_homes:SetFont( 'ambFont22' )
        box_homes:SetSize( 200, 30 )
        box_homes:SetPos( 32, 42 + te_name:GetTall() + te_age:GetTall() * 7 )
        box_homes:SetValue( "Select a Home" )
        box_homes:SetSortItems( false )
        for _, v in pairs( tab_homes ) do
            box_homes:AddChoice( v )
        end


        frame_reg.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, COLOR_MAIN )
            draw.RoundedBox( 0, 2, 2, w-4, h-4, COLOR_SUBMAIN )

            draw.SimpleText('[1]  Press your name, max count letters 26', "ambFont22", te_name:GetWide() + 46, te_name:GetTall() + 6, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
            draw.SimpleText('[2]  Press your age, min - 16, max - 99', "ambFont22", te_age:GetWide() + 46, 42 + te_name:GetTall() * 2, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
            draw.SimpleText('Your skin: '..your_skin_id, "ambFont22", 32, 42 + te_name:GetTall() + te_age:GetTall() * 9, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
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
                    net.WriteString( box_sex:GetValue() )
                    net.WriteString( box_nationality:GetValue() )
                    net.WriteUInt( te_age:GetValue(), 7 )
                    net.WriteString( your_skin )
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
    end )


    hook.Add( "InitPostEntity", "amb0_x32", function()
        AmbRegister_startMenu()
    end )

    net.Receive( 'amb_players_accept', function( len )
        LocalPlayer():ConCommand('amb_hud 1')
        hook.Remove( "CalcView", "amb_0x418" )
        AmbRegister_guide()
    end )
end
-- Данное творение принадлежит проекту [ Ambition ]