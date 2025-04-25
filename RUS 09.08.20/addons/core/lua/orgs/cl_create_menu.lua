--[[
	Меню создание организации.
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[26.06.20]
		• Создал файл.
	.
	[23.07.20]
		• Добавил через Think проверку у TextEntry, не знаю правильно ли это..
	.
    [30.07.20]
        • Пофиксил проверку длинны у кириллицы ( юзал utf8.len() )
    .
]]


local COLOR_MAIN	= Color( 45, 49, 48 ) -- Color( 222, 222, 222 )
local COLOR_SUBMAIN	= Color( 52, 152, 219 ) -- Color( 201, 107, 5 )
local COLOR_MENU    = Color( 59, 59, 59, 250 )
local COLOR_TEXT    = Color( 252, 252, 252 )
local COLOR_RED     = Color( 242, 90, 73 )
local COLOR_BLUE    = Color( 90, 157, 230 )
local COLOR_ERROR   = Color( 217, 33, 9 )
local COLOR_GREEN   = Color( 13, 209, 78 )

local bind_menu 	= KEY_SPACE
local w 			= ScrW()
local h 			= ScrH()

local default_list_mdl = {
    "models/player/alyx.mdl",
    "models/player/barney.mdl",
    "models/player/breen.mdl",
    "models/player/p2_chell.mdl",
    "models/player/eli.mdl",
    "models/player/gman_high.mdl",
    "models/player/magnusson.mdl",
    "models/player/combine_super_soldier.mdl",
    "models/player/soldier_stripped.mdl",
}

local default_list_names = {
    "Friskas",
    "Titanovsky Clan",
    "SM - I.23",
    "[CoreTech]",
    "USSR",
    "Shitzu inc.",
    "Extra Dipka",
    "Genocide",
    "UMBRELLA.",
}

local MENU_CREATE = {}

function MENU_CREATE:Init()
    self:SetSize( w/1.6, h/1.6 )
    self:Center()
    self:MakePopup()
    self:SetTitle(" ")
    self:SetDraggable( false )
    self:ShowCloseButton( false )
    self.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, COLOR_MAIN ) -- debug
        draw.SimpleText("Название организаций", "ambFont32", self.te_name:GetWide()/2 - 24, self.te_name:GetTall() - 12, COLOR_TEXT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("ID", "ambFont22", 24, self.te_name:GetTall() + 84, COLOR_TEXT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Модель членов", "ambFont22", 16, self.te_id:GetTall() + 102 * 1.6, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Модель лидера", "ambFont22", 16, self.te_mdl_lead:GetTall() + 102 * 2.3, COLOR_TEXT, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.btn_close = vgui.Create( "DButton", self )
    self.btn_close:SetSize( 28, 28 )
    self.btn_close:SetPos( self:GetWide() - self.btn_close:GetWide() - 4, 4)
    self.btn_close:SetFont("ambFont18")
    self.btn_close:SetColor( COLOR_MENU )
    self.btn_close:SetText("x")
    self.btn_close.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, COLOR_SUBMAIN ) -- debug
    end
    self.btn_close.DoClick = function()
        self:Remove()
    end

    self.btn_guide = vgui.Create( "DButton", self )
    self.btn_guide:SetSize( 28, 28 )
    self.btn_guide:SetPos( self:GetWide() - self.btn_close:GetWide() - self.btn_guide:GetWide() - 6, 4)
     self.btn_guide:SetFont("ambFont18")
    self.btn_guide:SetColor( COLOR_MENU )
    self.btn_guide:SetText("@")
    self.btn_guide.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, COLOR_SUBMAIN ) -- debug
    end
    self.btn_guide.DoClick = function()
        self:Remove()
        chat.AddText( COLOR_ERROR, "[•]", COLOR_TEXT, " Гайд в разработке!" )
    end

    self:setupDivs( self ) -- setup other panels
end


function MENU_CREATE:setupDivs( self ) -- установка панелек
    self.te_name = vgui.Create( "DTextEntry", self ) -- Text Entry (te)
    self.te_name:SetSize( 360, 38 )
    self.te_name:SetPos( 16, 54 )
    self.te_name:SetFont("ambFont22")
    self.te_name:SetValue( table.Random(default_list_names) )
    self.te_name:SetAllowNonAsciiCharacters( true ) -- allow cyrilic aphavite
    -- self.te_name:SetDrawBorder( false )
    self.te_name.Think = function( )
        if ( utf8.len( self.te_name:GetValue() ) > 22 ) then
            if !ValidPanel( self.text_mistake ) then
                self.text_mistake = vgui.Create( "DPanel", self )
                self.text_mistake:SetPos( self.te_name:GetWide() + 32, 54 + 6 )
                self.text_mistake:SetSize( 24, 24 )
                self.text_mistake.Paint = function( self, w, h )
                    draw.RoundedBox( 4, 0, 0, w, h, COLOR_ERROR )
                end
            end
        else
            if ValidPanel( self.text_mistake ) then
                self.text_mistake:Remove()
            end
        end
    end
    self.te_name.OnEnter = function()
        self:collectData()
        self:Remove()
    end
    self.te_name.Paint = function(self)
        surface.SetDrawColor( COLOR_SUBMAIN ) -- bug: миксер перекрашивает, если не ставить это!
        surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
        self:DrawTextEntryText( COLOR_TEXT, COLOR_MAIN, Color(0, 0, 255) )
    end

    self.te_id = vgui.Create( "DTextEntry", self ) -- Text Entry (te)
    self.te_id:SetSize( 52, 24 )
    self.te_id:SetPos( 16, self.te_name:GetTall() + 102 )
    self.te_id:SetFont("ambFont22")
    self.te_id:SetValue( math.random( 1, 63 ) )
    self.te_id:SetNumeric( true )
    self.te_id.Think = function( )
        if #self.te_id:GetValue() > 0 and self.te_id:GetValue() ~= '-' and ( tonumber( self.te_id:GetValue() ) > 63 ) then
            if !ValidPanel( self.text_mistake ) then
                self.text_mistake = vgui.Create( "DPanel", self )
                self.text_mistake:SetPos( self.te_id:GetWide() + 32, self.te_name:GetTall() + 102 )
                self.text_mistake:SetSize( 24, 24 )
                self.text_mistake.Paint = function( self, w, h )
                    draw.RoundedBox( 4, 0, 0, w, h, COLOR_ERROR )
                end
            end
        else
            if ValidPanel( self.text_mistake ) then
                self.text_mistake:Remove()
            end
        end
    end
    self.te_id.OnEnter = function()
        self:collectData()
        self:Remove()
    end
    self.te_id.Paint = function(self)
        surface.SetDrawColor( COLOR_SUBMAIN ) -- bug: миксер перекрашивает, если не ставить это!
        surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
        self:DrawTextEntryText( COLOR_TEXT, COLOR_MAIN, Color(0, 0, 255) )
    end

    self.te_mdl = vgui.Create( "DTextEntry", self ) -- Text Entry (te)
    self.te_mdl:SetSize( 360, 28 )
    self.te_mdl:SetPos( 16, self.te_id:GetTall() + 102 * 1.8 )
    self.te_mdl:SetFont("ambFont22")
    self.te_mdl:SetValue( table.Random( default_list_mdl ) )
    self.te_mdl:SetAllowNonAsciiCharacters( false )
    self.te_mdl.OnEnter = function()
        self:collectData()
        self:Remove()
    end
    self.te_mdl.Paint = function(self)
        surface.SetDrawColor( COLOR_SUBMAIN ) -- bug: миксер перекрашивает, если не ставить это!
        surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
        self:DrawTextEntryText( COLOR_TEXT, COLOR_MAIN, Color(0, 0, 255) )
    end

    self.te_mdl_lead = vgui.Create( "DTextEntry", self ) -- Text Entry (te)
    self.te_mdl_lead:SetSize( 360, 28 )
    self.te_mdl_lead:SetPos( 16, self.te_mdl:GetTall() + 102 * 2.5 )
    self.te_mdl_lead:SetFont("ambFont22")
    self.te_mdl_lead:SetValue( table.Random( default_list_mdl ) )
    self.te_mdl_lead:SetAllowNonAsciiCharacters( false )
    self.te_mdl_lead:SetPlaceholderColor( COLOR_RED )
    self.te_mdl_lead.OnEnter = function()
        self:collectData()
        self:Remove()
    end
    self.te_mdl_lead.Paint = function(self)
        surface.SetDrawColor( COLOR_SUBMAIN ) -- bug: миксер перекрашивает, если не ставить это!
        surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
        self:DrawTextEntryText( COLOR_TEXT, COLOR_MAIN, Color(0, 0, 255) )
    end

    self.mixer = vgui.Create( "DColorMixer", self )
    self.mixer:SetSize( 164, 104 )
    self.mixer:SetPos( 16, self:GetTall() - self.mixer:GetTall() - 16 )
    self.mixer:SetPalette( false )
    self.mixer:SetAlphaBar( false )
    self.mixer:SetWangs( true )
    self.mixer:SetColor( COLOR_SUBMAIN )
end

function MENU_CREATE:OnKeyCodePressed( bind )
    if ( bind == bind_menu ) then
        AmbOrgs_createMenuCreate()
    end
end

function MENU_CREATE:collectData()
    local ply = LocalPlayer()
    local id = self.te_id:GetValue()
    local name = self.te_name:GetValue()
    local color = self.mixer:GetColor()
    local mdl = self.te_mdl:GetValue()
    local mdl_lead = self.te_mdl_lead:GetValue()

    if tonumber( id ) < 1 then
        chat.AddText( COLOR_ERROR, "[•] ", COLOR_TEXT, "ID может быть только положительным!" )
        return
    end

    if tonumber( id ) > 63 then
        chat.AddText( COLOR_ERROR, "[•] ", COLOR_TEXT, "ID от 1 до 63" )
        return
    end

    if ( #name > 22 ) then
        chat.AddText( COLOR_ERROR, "[•] ", COLOR_TEXT, "Имя слишком длинное!" )
        return
    end

    --print( ply ) -- debug
    --print( id ) -- debug
    --print( name ) -- debug
    --print( color ) -- debug
    --print( mdl ) -- debug
    --print( mdl_lead ) -- debug

    LocalPlayer():ConCommand( "org_create "..id.." "..string.format("%q", name ).." "..color.r.." "..color.g.." "..color.b.." "..mdl.." "..mdl_lead )
end
vgui.Register( "AmbOrgs_MenuCreate", MENU_CREATE, "DFrame" )

function AmbOrgs_createMenuCreate()
    if ValidPanel( amb_menu_orgs ) then
        amb_menu_orgs:Remove()
        return
    end

    amb_menu_orgs = vgui.Create( "AmbOrgs_MenuCreate")
end
concommand.Add("org_register", AmbOrgs_createMenuCreate )
-- Данное творение принадлежит проекту [ Ambition ]