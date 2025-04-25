local COLOR_MAIN	= Color( 45, 49, 48 )
local COLOR_SUBMAIN	= Color( 52, 152, 219 )
local COLOR_MENU    = Color( 59, 59, 59, 250 )
local COLOR_TEXT    = Color( 252, 252, 252 )
local COLOR_RED     = Color( 242, 90, 73 )
local COLOR_BLUE    = Color( 90, 157, 230 )
local COLOR_ERROR   = Color( 217, 33, 9 )
local COLOR_GREEN   = Color( 13, 209, 78 )

local bind_menu 	= KEY_SPACE
local w 			= ScrW()
local h 			= ScrH()

local result_name   = "nil"
local result_id     = 228
local result_leader = "Server"
local result_members = 0

local net = net

local MENU_CONTROLE = {}


function MENU_CONTROLE:Init()

    for k, v in pairs( player.GetAll() ) do
        if v:GetNWInt("amb_orgs") == LocalPlayer():GetNWInt("amb_orgs") then
            result_members = result_members + 1
        end
    end

    self:SetSize( w/2, h/1.8 )
	self:Center()
	self:MakePopup()
	self:SetTitle(" ")
	self:SetDraggable( false )
	self:ShowCloseButton( false )
	self.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, COLOR_MAIN ) -- debug
        draw.SimpleText("Name: "..AmbOrgs[ LocalPlayer():GetNWInt("amb_orgs") ].name, "ambFont22", self.btn_invite:GetWide() * 2.2, 20, COLOR_TEXT, 0, 0)
        draw.SimpleText("Leader: "..AmbOrgs[ LocalPlayer():GetNWInt("amb_orgs") ].leader:Nick(), "ambFont22", self.btn_invite:GetWide() * 2.2, 20 + 22, COLOR_TEXT, 0, 0)
        draw.SimpleText("Members: "..result_members, "ambFont22", self.btn_invite:GetWide() * 2.2, 20 + 22 * 2, COLOR_TEXT, 0, 0)
        draw.SimpleText("ID: "..LocalPlayer():GetNWInt("amb_orgs"), "ambFont22", self.btn_invite:GetWide() * 2.2, 20 + 22 * 3, COLOR_TEXT, 0, 0)
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

    self:setupDivs( self )
end

function MENU_CONTROLE:setupDivs( self )
    self.select_ply = vgui.Create( "DComboBox", self )
    self.select_ply:SetPos( 24, 24 )
    self.select_ply:SetSize( 262, 42 )
    self.select_ply:SetFont("ambFont22")
    self.select_ply:SetValue( "Игрок" )

    for k, v in pairs( player.GetAll() ) do
        if v ~= LocalPlayer() then
            self.select_ply:AddChoice( v:Nick() )
        end
    end
    --self.select_ply.OnSelect = function( self, index, value )
	--    print( value .." was selected at index " .. index )
    --end

    local x, y = self.select_ply:GetPos()

    self.btn_invite = vgui.Create( "DButton", self )
    self.btn_invite:SetSize( 142, 32 )
	self.btn_invite:SetPos( x, y + 64)
    self.btn_invite:SetFont("ambFont22")
    self.btn_invite:SetColor( COLOR_MENU )
    self.btn_invite:SetText("Invite")
    self.btn_invite.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, COLOR_SUBMAIN ) -- debug
	end
    self.btn_invite.DoClick = function()
        LocalPlayer():ConCommand( "org_invite "..string.format( "%q", self.select_ply:GetValue() ) )
    end

    x, y = self.btn_invite:GetPos()

    self.btn_uninvite = vgui.Create( "DButton", self )
    self.btn_uninvite:SetSize( 142, 32 )
	self.btn_uninvite:SetPos( x, y + 42)
    self.btn_uninvite:SetFont("ambFont22")
    self.btn_uninvite:SetColor( COLOR_MENU )
    self.btn_uninvite:SetText("Uninvite")
    self.btn_uninvite.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, COLOR_SUBMAIN ) -- debug
	end
    self.btn_uninvite.DoClick = function()
        LocalPlayer():ConCommand( "org_uninvite "..string.format( "%q", self.select_ply:GetValue() ).." "..self.te_uninvite:GetValue() )
    end

    x, y = self.btn_uninvite:GetPos()

    self.te_uninvite = vgui.Create( "DTextEntry", self ) -- Text Entry (te)
    self.te_uninvite:SetSize( 182, 32 )
    self.te_uninvite:SetPos( x + self.btn_uninvite:GetWide() * 1.1, y )
    self.te_uninvite:SetFont("ambFont22")
    self.te_uninvite:SetValue( "reason" )
    self.te_uninvite:SetAllowNonAsciiCharacters( true )
    self.te_uninvite.OnEnter = function()
        --self:Remove()
    end
    self.te_uninvite.Paint = function(self)
        surface.SetDrawColor( COLOR_TEXT )
        surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
        self:DrawTextEntryText( COLOR_MAIN, COLOR_MAIN, COLOR_MAIN )
    end

    self.btn_give_skin = vgui.Create( "DButton", self )
    self.btn_give_skin:SetSize( 142, 32 )
	self.btn_give_skin:SetPos( x, y + 42)
    self.btn_give_skin:SetFont("ambFont22")
    self.btn_give_skin:SetColor( COLOR_MENU )
    self.btn_give_skin:SetText("Give Skin")
    self.btn_give_skin.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, COLOR_SUBMAIN ) -- debug
	end
    self.btn_give_skin.DoClick = function()
        LocalPlayer():ConCommand( "org_skin "..string.format( "%q", self.select_ply:GetValue() ).." "..self.te_give_skin:GetValue() )
        self:Remove()
    end

    x, y = self.btn_give_skin:GetPos()

    self.te_give_skin = vgui.Create( "DTextEntry", self ) -- Text Entry (te)
    self.te_give_skin:SetSize( 182, 32 )
    self.te_give_skin:SetPos( x + self.btn_give_skin:GetWide() * 1.1, y )
    self.te_give_skin:SetFont("ambFont22")
    self.te_give_skin:SetValue( "path of model" )
    self.te_give_skin:SetAllowNonAsciiCharacters( true )
    self.te_give_skin.OnEnter = function()
        --self:Remove()
    end
    self.te_give_skin.Paint = function(self)
        surface.SetDrawColor( COLOR_TEXT )
        surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
        self:DrawTextEntryText( COLOR_MAIN, COLOR_MAIN, COLOR_MAIN )
    end

    self.btn_warn = vgui.Create( "DButton", self )
    self.btn_warn:SetSize( 142, 32 )
	self.btn_warn:SetPos( x, y + 42)
    self.btn_warn:SetFont("ambFont22")
    self.btn_warn:SetColor( COLOR_MENU )
    self.btn_warn:SetText("Warn")
    self.btn_warn.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, COLOR_SUBMAIN ) -- debug
	end
    self.btn_warn.DoClick = function()
        LocalPlayer():ConCommand( 'ulx psay "'..self.select_ply:GetValue()..'" "Я слежу за тобой!"' )
    end

    x, y = self.btn_warn:GetPos()


    self.btn_leave = vgui.Create( "DButton", self )
    self.btn_leave:SetSize( 142, 32 )
	self.btn_leave:SetPos( x, y + 42)
    self.btn_leave:SetFont("ambFont22")
    self.btn_leave:SetColor( COLOR_MENU )
    self.btn_leave:SetText("Leave")
    self.btn_leave.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, COLOR_SUBMAIN ) -- debug
	end
    self.btn_leave.DoClick = function()
        self:Remove()
        LocalPlayer():ConCommand( 'org_leave' )
    end
end

function MENU_CONTROLE:OnKeyCodePressed( bind )
    if ( bind == bind_menu ) then
    	AmbOrgs_createMenuControle()
    end
end
vgui.Register( "AmbOrgs_MenuControle", MENU_CONTROLE, "DFrame" )

function AmbOrgs_createMenuControle()
    if ValidPanel( amb_menu_orgs_ctrl ) then
        amb_menu_orgs_ctrl:Remove()
        return
    end

    if tonumber( LocalPlayer():GetNWInt( "amb_orgs" ) ) > 0 then
        amb_menu_orgs_ctrl = vgui.Create( "AmbOrgs_MenuControle")
    else
        chat.AddText("Вы не состоите в организации")
    end
end
concommand.Add("org_menu", AmbOrgs_createMenuControle )