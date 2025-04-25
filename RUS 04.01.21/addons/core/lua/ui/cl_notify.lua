local w = ScrW()
local h = ScrH()

local tabs_mdls = {

    [1] = {
        'models/player/Group01/male_09.mdl',
        'models/player/Group01/male_07.mdl',
        'models/player/Group01/male_08.mdl',
        'models/player/Group01/male_02.mdl',
        'models/player/Group01/male_04.mdl',
        'models/player/Group01/male_03.mdl',
        'models/player/Group01/male_01.mdl',
        'models/player/Group01/male_05.mdl'
    },

    [2] = {
        'models/player/Group01/female_01.mdl',
        'models/player/Group01/female_02.mdl',
        'models/player/Group01/female_03.mdl',
        'models/player/Group01/female_04.mdl'
    },

    [3] = {
        'models/player/Group01/male_09.mdl',
        'models/player/Group01/male_07.mdl',
        'models/player/Group01/male_08.mdl',
        'models/player/Group01/male_02.mdl',
        'models/player/Group01/male_04.mdl',
        'models/player/Group01/male_03.mdl',
        'models/player/Group01/male_01.mdl',
        'models/player/Group01/male_05.mdl',
        'models/player/Group01/female_01.mdl',
        'models/player/Group01/female_02.mdl',
        'models/player/Group01/female_03.mdl',
        'models/player/Group01/female_04.mdl'
    }

}

local nationes = {

    [ 'Русский' ] = true,
    [ 'Американец' ] = true,
    [ 'Чеченец' ] = true,
    [ 'Украинец' ] = true,
    [ 'Немец' ] = true,
    [ 'Итальянец' ] = true,
    [ 'Японец' ] = true,
    [ 'Индус' ] = true

}

local genders = {

    [ 'Мужчина' ] = true,
    [ 'Женщина' ] = true,
    [ 'Трансгендер' ] = true,
    [ 'Андрогин' ] = true,
    [ 'Гендерфлюид' ] = true,
    [ 'Пангендер' ] = true,
    [ 'Вертокрыл' ] = true,
    [ 'Демигендер' ] = true,
    [ 'Третий Пол' ] = true

}

local COLOR_PANEL = Color( 0, 0, 0, 200 )
local skins


-- DEFINES
local ply_name1     = ''
local ply_name2     = ''
local ply_nation    = ''
local ply_gender    = ''
local ply_skin      = ''
--

local function CollectData( name1, name2, nation, gender, skin )

    print( name1 )
    print( name2 )
    print( nation )
    print( gender )
    print( skin )

end

local function ValidationNames( first_name, sur_name )

    if ( utf8.len( first_name ) > 2 and utf8.len( first_name ) <= 12 and utf8.len( sur_name ) > 2 and utf8.len( sur_name ) <= 16 ) then return true end
    return false

end

local function ValidationNation( nation )

    return nationes[ nation ]

end

local function ValidationSkin( mdl )

    if ( #mdl > 2 ) then return true end
    return false

end

local function ValidationGenders( gender )

    return genders[ gender ]

end

local function main( bHeader )

    local frame = vgui.Create( 'DFrame' )
    frame:SetSize( w/2, h )
    frame:SetPos( w/4, 0 )
    frame:MakePopup()
    frame:SetTitle( '' )
    frame:ShowCloseButton( true )
    frame.Paint = function( self, w, h )

        draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_SMALL_BLACK )
        draw.RoundedBox( 0, 0, 0, w, h/28, AMB_COLOR_AMBITION)
        if ( bHeader) then draw.SimpleText( 'Добро пожаловать на PhonexRP!', 'ambFont32', w/2, h/10, AMB_COLOR_AMBITION, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP ) end

    end

    return frame

end

local function ShowCloseSkinMenu( frame, tabs )
    
    if ( ValidPanel( skins ) ) then skins:Remove() end

    skins = vgui.Create( 'DScrollPanel', frame )
    skins:SetSize( frame:GetWide()/2, frame:GetTall()/2.6 )
    skins:SetPos( frame:GetWide()/4, frame:GetTall()/2.6 )
    skins.Paint = function( self, w, h )
    end

    local list_skins = vgui.Create( 'DGrid', skins )
    list_skins:SetCols( 4 )
    list_skins:SetColWide( 84 )
    list_skins:SetRowHeight( 84 )

    local temp_panel

    for k, mdl in pairs( tabs ) do

        local icon = vgui.Create( 'ModelImage' )
        icon:SetSize( list_skins:GetColWide() - 8, list_skins:GetRowHeight() - 8 )
        icon:SetModel( mdl )
        icon.color = COLOR_PANEL
        icon.Paint = function( self, w, h )

            draw.RoundedBox( 6, 0, 0, w, h, icon.color )
    
        end
        list_skins:AddItem( icon )

        local btn_icon = vgui.Create( 'DButton', icon )
        btn_icon:SetSize( icon:GetWide(), icon:GetTall() )
        btn_icon:SetText( '' )
        btn_icon.Paint = function( self, w, h ) end
        btn_icon.DoClick = function( self )

            if ( temp_panel ) then temp_panel.color = COLOR_PANEL end

            temp_panel = self:GetParent()
            temp_panel.color = AMB_COLOR_AMBITION
            ply_skin = mdl

        end
    
    end

end

local function f2()

    local frame = main( false )

    local gender = vgui.Create( 'DComboBox', frame )
    gender:SetSize( frame:GetWide()/1.1, 54 )
    gender:SetPos( frame:GetWide()/22, frame:GetTall()/10 )
    gender:SetFont( 'ambFont32' )
    gender:SetSortItems( false )
    gender:SetValue( 'Выберите Гендер' )

    for sex, _ in pairs( genders ) do

        gender:AddChoice( sex )

    end

    gender.OnSelect = function( self, index, value )

        if ( index == ( 1 or 2 ) ) then 

            ShowCloseSkinMenu( frame, tabs_mdls[index] ) 

        else

            ShowCloseSkinMenu( frame, tabs_mdls[3] ) 

        end

    end

    local nation = vgui.Create( 'DComboBox', frame )
    nation:SetSize( frame:GetWide()/1.1, 54 )
    nation:SetPos( frame:GetWide()/22, frame:GetTall()/10 + gender:GetTall() + 16 )
    nation:SetFont( 'ambFont32' )
    nation:SetSortItems( false )
    nation:SetValue( 'Выберите Национальность' )

    for name_nation, _ in pairs( nationes ) do
    
        nation:AddChoice( name_nation )
        
    end

    local close = vgui.Create( 'DButton', frame )
    close:SetSize( frame:GetWide()/3, frame:GetWide()/16 )
    close:SetPos( frame:GetWide()/2 - close:GetWide()/2, frame:GetTall()/1.1 )
    close:SetFont( 'ambFont32' )
    close:SetText( 'Далее' )
    close.Paint = function( self, w, h )

        if ( self.done ) then

            draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_GREEN )
            draw.RoundedBox( 4, 2, 2, w-4, h-4, AMB_COLOR_SMALL_BLACK )

            self:SetTextColor( AMB_COLOR_GREEN )
        
        else

            draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_RED )
            draw.RoundedBox( 4, 2, 2, w-4, h-4, AMB_COLOR_SMALL_BLACK )

            self:SetTextColor( AMB_COLOR_RED )

        end

    end
    close.Think = function( self )

        self.done = ValidationNation( nation:GetValue() ) and ValidationGenders( gender:GetValue() ) and ValidationSkin( ply_skin ) 

    end
    close.DoClick = function( self )

        if ( self.done ) then

            ply_gender = gender:GetValue()
            ply_nation = nation:GetValue()
            frame:Close()
            CollectData( ply_name1, ply_name2, ply_nation, ply_gender, ply_skin )
        
        else

            surface.PlaySound( 'buttons/button8.wav' )

        end

    end

end

local function f1()

    local frame = main( true )

    local te_name1 = vgui.Create( 'DTextEntry', frame )
    te_name1:SetSize( frame:GetWide()/1.12, 64 )
    te_name1:SetPos( frame:GetWide()/21, frame:GetTall()/3 )
    te_name1:SetFont( 'ambFont32' )
    te_name1:SetValue( '[1] Напишите Имя ( кликните сюда! )' )
    te_name1.OnGetFocus = function( self )
	    self:SetValue( '' )
    end

    local te_name2 = vgui.Create( 'DTextEntry', frame )
    te_name2:SetSize( frame:GetWide()/1.12, 64 )
    te_name2:SetPos( frame:GetWide()/21, frame:GetTall()/3 - te_name1:GetTall() - 40 )
    te_name2:SetFont( 'ambFont32' )
    te_name2:SetValue( '[2] Напишите Фамилию ( кликните сюда! )' )
    te_name2.OnGetFocus = function( self )
	    self:SetValue( '' )
    end

    local close = vgui.Create( 'DButton', frame )
    close:SetSize( frame:GetWide()/3, frame:GetWide()/16 )
    close:SetPos( frame:GetWide()/2 - close:GetWide()/2, frame:GetTall()/1.1 )
    close:SetFont( 'ambFont32' )
    close.done = false
    close:SetText( 'Продолжить' )
    close.Paint = function( self, w, h )

        if ( self.done ) then

            draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_GREEN )
            draw.RoundedBox( 4, 2, 2, w-4, h-4, AMB_COLOR_SMALL_BLACK )

            self:SetTextColor( AMB_COLOR_GREEN )
        
        else

            draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_RED )
            draw.RoundedBox( 4, 2, 2, w-4, h-4, AMB_COLOR_SMALL_BLACK )

            self:SetTextColor( AMB_COLOR_RED )

        end


    end
    close.Think = function( self )

        self.done = ValidationNames( te_name1:GetValue(), te_name2:GetValue() )

    end
    close.DoClick = function( self )

        if ( self.done ) then

            ply_name1 = te_name1:GetValue()
            ply_name2 = te_name2:GetValue()
            frame:Close()
            f2()
            surface.PlaySound( 'buttons/button14.wav' )
        
        else

            surface.PlaySound( 'buttons/button8.wav' )

        end

    end

end

--f1()