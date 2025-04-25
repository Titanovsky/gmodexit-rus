--[[
	F4Menu для сервера DarkRP.
	Сервер находится в полном подчинений проекта: [ Ambition ]

	steamcommunity.com/groups/ambitiongmod -- steam
	vk.com/ambitiongmod -- vk

	[11.08.20]
		• Первая версия F4Menu (DarkRP).
	.
]]


surface.CreateFont( "amb_breach32", {
	font = "Calibri", 
	size = 32,
})

surface.CreateFont( "amb_breach22", {
	font = "Calibri", 
	size = 22,
})

-- ## DEFINES #########################
local COLOR_MAIN	= Color( 45, 49, 48 ) -- Color( 222, 222, 222 )
local COLOR_SUBMAIN	= Color( 52, 152, 219 ) -- Color( 201, 107, 5 )
local COLOR_TEXT	= Color( 255, 255, 255 ) -- Color( 0, 0, 0 )
local bind_menu 	= KEY_F3
local w 			= ScrW()
local h 			= ScrH()
local logo_text 	= "DarkRP"
local a,_			= surface.GetTextSize( logo_text )
local speed_anim	= 0.24

local url_rule 		= "https://steamcommunity.com/id/titanovsky/"
local url_vk 		= "https://steamcommunity.com/id/titanovsky/"
local url_steam		= "https://steamcommunity.com/id/titanovsky/"
local url_discord 	= "https://steamcommunity.com/id/titanovsky/"

local AmbF4Menu = {}
local has_f4menu = false -- существует ли?

local btns_menu = {
	['Инфо'] = { AMB_COLOR_RED, AMB_COLOR_WHITE },
	['Магазин'] = { AMB_COLOR_GREEN, AMB_COLOR_WHITE },
	['Оружия'] = { AMB_COLOR_BLUE, AMB_COLOR_WHITE },
	['Помощь'] = { AMB_COLOR_AMETHYST, AMB_COLOR_WHITE },
	['Донат'] = { AMB_COLOR_SMALL_BLACK, AMB_COLOR_WHITE }
}
-- ####################################

function AmbF4Menu:Init()
	self.active = true -- выполнялась бы анимация + построение новой строки?
	if ( has_f4menu ) then
		self.active = false
		self:Close() 
		has_f4menu = false 
		return 
	end
	self:SetSize( w/1.8, h/1.4 )
	self:SetPos( w/2-self:GetWide()/2, h/2-self:GetTall()/8 )
	self:MakePopup()
	self:SetTitle( '' )
	self:SetDraggable( false )
	self:ShowCloseButton( false )
	self.Paint = function( self, w, h )
		surface.SetFont("amb_breach22")
		draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0) ) -- debug
	end
	has_f4menu = true

    self.btns = vgui.Create( 'DGrid', self )
    self.btns:SetPos( 0, 0 )
    --self.btns:SetSize( 0, 200 )
    self.btns:SetCols( 5 )
    self.btns:SetColWide( self:GetWide()/5+1 )
    self.btns:SetRowHeight( 74 )
    self.btns.Paint = function( self, w, h )
		surface.SetFont("amb_breach22")
		draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_RED ) -- debug
	end

	self.menu = vgui.Create( 'DPanel', self )
	self.menu:SetPos( 0, self.btns:GetRowHeight() )
	self.menu:SetSize( 0, 0 )
	self.menu.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_WHITE )
	end

    for name, v in SortedPairsByMemberValue( btns_menu ) do
        local but = vgui.Create( "DButton" )
		but:SetFont('ambFont18')
        but:SetText('')
        but:SetSize( self.btns:GetColWide(), self.btns:GetRowHeight() )
        self.btns:AddItem( but )
        but.DoClick = function()
            --self:Remove()
			self:setUpDivs( name, v[1] )
        end
		but.origfont = 'ambFont18'
		but.font = 'ambFont18'
		but.origcolor = v[1]
		but.color = v[1]
		but.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, self.color )
			draw.SimpleText( name, self.font, self:GetWide()/2, self:GetTall()/2 + 20, v[2], TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		but.OnCursorEntered = function( self )
			self.font = 'ambFont22'
			--self.color = Color(255,0,0)
		end
		but.OnCursorExited = function( self )
			self.font = self.origfont
			--self.color = self.origcolor
		end
    end

    /*
	self.logo = vgui.Create( "DPanel", self )
	self.logo:SetSize( a*1.8, 42)
	self.logo:SetPos( self:GetWide()/2-a, 8 )
	self.logo.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, COLOR_SUBMAIN )
		draw.RoundedBox( 0, 2, 2, w-4, h-2, COLOR_MAIN )
		draw.SimpleText( logo_text, "amb_breach22", 
		w/2, h/2, 
		COLOR_TEXT, 
		TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
    */
end

function AmbF4Menu:setUpDivs( menu, col )
	if !(self) then return end
	local x_main, y_main = self:GetPos()
	if self.active then
		self:MoveTo( x_main, y_main - self:GetTall()/2.6, 0.24, 0, -1, function() 
			self.menu:SizeTo( self:GetWide(), self:GetTall(), 0.24, 0, -1, function() self:setUpMenu( menu, col ) end ) 
		end )
		--self:SizeTo( self:GetWide(), h/1.6, 0.4, 0, -1, function() end )
		self.active = false
	else
		self:setUpMenu( menu, col )
	end
end

function AmbF4Menu:setUpMenu( menu, col )
	if ValidPanel( self.menu_info ) then self.menu_info:Remove() end
	if ValidPanel( self.menu_shop ) then self.menu_shop:Remove() end
	if ValidPanel( self.menu_weapons ) then self.menu_weapons:Remove() end
	if ValidPanel( self.menu_help ) then self.menu_help:Remove() end
	if ValidPanel( self.menu_donate ) then self.menu_donate:Remove() end
	
	if ( menu == 'Инфо' ) then
		self.menu_info = vgui.Create( 'DPanel', self.menu )
		self.menu_info:SetSize( self.menu:GetWide(), self.menu:GetTall() )
		self.menu_info:SetPos( 0, 0 )
		self.menu_info.Paint = function( self, w, h )
			draw.DrawText( LocalPlayer():GetNWString('amb_players_name'), 'ambFont32', 168, 24, AMB_COLOR_BLACK, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

			draw.DrawText( 'Ник: ', 'ambFont22', 162, 64, AMB_COLOR_BLACK, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			draw.DrawText( LocalPlayer():Nick(), 'ambFont22', 164 * 1.6, 64, AMB_COLOR_AMBITION, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

			draw.DrawText( 'SteamID: ', 'ambFont22', 162, 64*1.4, AMB_COLOR_BLACK, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			draw.DrawText( LocalPlayer():SteamID(), 'ambFont22', 162 * 1.6, 64*1.4, AMB_COLOR_AMBITION, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

			draw.DrawText( 'Кошелёк: ', 'ambFont22', 162, 64*1.8, AMB_COLOR_BLACK, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			draw.DrawText( LocalPlayer():GetNWFloat('amb_players_money')..' $', 'ambFont22', 162 * 1.6, 64*1.8, AMB_COLOR_GREEN, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end

		local panel_avatar = vgui.Create( 'DPanel', self.menu_info )
		panel_avatar:SetPos( 24, 24 )
		panel_avatar:SetSize( 132, 132 )
		panel_avatar.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_AMBITION )
		end

		local avatar = vgui.Create( 'AvatarImage', panel_avatar )
		avatar:SetSize( 124, 124 )
		avatar:SetPos( 4, 4 )
		avatar:SetPlayer( LocalPlayer(), 124 )

		local btn_rules = vgui.Create( 'DButton', self.menu_info )
		btn_rules:SetSize( 94, 32 )
		btn_rules:SetPos( self.menu_info:GetWide() - btn_rules:GetWide() - 12, 24 )
		btn_rules:SetFont( 'ambFont22' )
		btn_rules:SetTextColor( AMB_COLOR_AMBITION )
		btn_rules:SetText('Правила')
		btn_rules.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_AMBITION )
			draw.RoundedBox( 2, 2, 2, w-4, h-4, AMB_COLOR_SMALL_BLACK )
		end
		btn_rules.DoClick = function()
			gui.OpenURL( 'https://steamcommunity.com/groups/ambitiongmod' )
		end

		local btn_steam = vgui.Create( 'DButton', self.menu_info )
		btn_steam:SetSize( 94, 32 )
		btn_steam:SetPos( self.menu_info:GetWide() - btn_rules:GetWide() - 12, 24*2.6 )
		btn_steam:SetFont( 'ambFont22' )
		btn_steam:SetTextColor( AMB_COLOR_AMBITION )
		btn_steam:SetText('Steam')
		btn_steam.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_AMBITION )
			draw.RoundedBox( 2, 2, 2, w-4, h-4, AMB_COLOR_SMALL_BLACK )
		end
		btn_steam.DoClick = function()
			gui.OpenURL( 'https://steamcommunity.com/groups/ambitiongmod' )
		end

		local btn_steam = vgui.Create( 'DButton', self.menu_info )
		btn_steam:SetSize( 82, 32 )
		btn_steam:SetPos( self.menu_info:GetWide() - btn_rules:GetWide() - 2, 24*4.2 )
		btn_steam:SetFont( 'ambFont22' )
		btn_steam:SetTextColor( AMB_COLOR_AMBITION )
		btn_steam:SetText('VK')
		btn_steam.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_AMBITION )
			draw.RoundedBox( 2, 2, 2, w-4, h-4, AMB_COLOR_SMALL_BLACK )
		end
		btn_steam.DoClick = function()
			gui.OpenURL( 'https://vk.com/ambgmod' )
		end

		local btn_steam = vgui.Create( 'DButton', self.menu_info )
		btn_steam:SetSize( 82, 32 )
		btn_steam:SetPos( self.menu_info:GetWide() - btn_rules:GetWide() - 104, 24 )
		btn_steam:SetFont( 'ambFont22' )
		btn_steam:SetTextColor( AMB_COLOR_BLUE )
		btn_steam:SetText('Discord')
		btn_steam.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_BLUE )
			draw.RoundedBox( 2, 2, 2, w-4, h-4, AMB_COLOR_SMALL_BLACK )
		end
		btn_steam.DoClick = function()
			gui.OpenURL( 'discord.gg/G4vzxrq' )
		end

	elseif ( menu == 'Оружия' ) then
		self.menu_shop = vgui.Create( 'DPanel', self.menu )
		self.menu_shop:SetSize( self.menu:GetWide(), self.menu:GetTall() )
		self.menu_shop:SetPos( 0, 0 )

		local panels_list = vgui.Create("DScrollPanel", self.menu_shop )
		panels_list:SetSize( 432, 396 )
		panels_list:SetPos( 12, 32 )
		--panels_list:EnableVerticalScrollbar(true)
		panels_list.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_GRAY )
		end

		local grid = vgui.Create( "DGrid", panels_list )
		grid:SetPos( 0, 0 )
		grid:SetCols( 2 )
		grid:SetColWide( panels_list:GetWide()/2-4 )
		grid:SetRowHeight( 64 )
		
		for i = 1, 30 do
			local panel = vgui.Create( "DPanel" )
			panel:SetSize( 220, 64 )
			grid:AddItem( panel )
			panel.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_BLACK )
				draw.RoundedBox( 0, 2, 2, w-4, h-4, AMB_COLOR_BLUE )
			end
		end

		local panels_list_shipments = vgui.Create("DScrollPanel", self.menu_shop )
		panels_list_shipments:SetSize( 236, 396 )
		panels_list_shipments:SetPos( self.menu_shop:GetWide()-panels_list_shipments:GetWide()-12, 32 )
		--panels_list:EnableVerticalScrollbar(true)
		panels_list_shipments.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_GRAY )
		end

		local grid_shipments = vgui.Create( "DGrid", panels_list_shipments )
		grid_shipments:SetPos( 0, 0 )
		grid_shipments:SetCols( 1 )
		grid_shipments:SetColWide( panels_list_shipments:GetWide() )
		grid_shipments:SetRowHeight( 64 )
		
		for i = 1, 30 do
			local panel = vgui.Create( "DPanel" )
			panel:SetSize( 220, 64 )
			grid_shipments:AddItem( panel )
			panel.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_BLACK )
				draw.RoundedBox( 0, 2, 2, w-4, h-4, AMB_COLOR_BLUE )
			end
		end

	elseif ( menu == 'Магазин' ) then
		self.menu_shop = vgui.Create( 'DPanel', self.menu )
		self.menu_shop:SetSize( self.menu:GetWide(), self.menu:GetTall() )
		self.menu_shop:SetPos( 0, 0 )

		local text = vgui.Create('DLabel', self.menu_shop )
		text:SetPos( self.menu_shop:GetTall()/2-#menu, 6 )
		text:SetTextColor( AMB_COLOR_BLACK )
		text:SetFont('ambFont32')
		text:SetText('Оружия')
		text:SizeToContents()
	elseif ( menu == 'Помощь' ) then
		self.menu_shop = vgui.Create( 'DPanel', self.menu )
		self.menu_shop:SetSize( self.menu:GetWide(), self.menu:GetTall() )
		self.menu_shop:SetPos( 0, 0 )

		local text = vgui.Create('DLabel', self.menu_shop )
		text:SetPos( self.menu_shop:GetTall()/2-#menu, 6 )
		text:SetTextColor( AMB_COLOR_BLACK )
		text:SetFont('ambFont32')
		text:SetText('Оружия')
		text:SizeToContents()
	elseif ( menu == 'Донат' ) then
		self.menu_shop = vgui.Create( 'DPanel', self.menu )
		self.menu_shop:SetSize( self.menu:GetWide(), self.menu:GetTall() )
		self.menu_shop:SetPos( 0, 0 )

		local text = vgui.Create('DLabel', self.menu_shop )
		text:SetPos( self.menu_shop:GetTall()/2-#menu, 6 )
		text:SetTextColor( AMB_COLOR_AMBITION )
		text:SetFont('ambFont32')
		text:SetText('Донатик сюды)')
		text:SizeToContents()
	end
end


function AmbF4Menu:OnRemove()
	if ( has_f4menu ) then 
		has_f4menu = false
	end
end

function AmbF4Menu:OnKeyCodePressed( bind )
    if ( bind == bind_menu ) then
    	self:Init()
    end
end
vgui.Register("AMBf4menu", AmbF4Menu, "DFrame")

function AmbF4Menu.CreateF4Menu()
	f4_menu = vgui.Create( "AMBf4menu")
end
concommand.Add( "amb_f4menu_open", AmbF4Menu.CreateF4Menu)

hook.Add("PlayerBindPress", "amb_f4menu_bind", function( ply, bind )
	if input.IsKeyDown( bind_menu ) then
		AmbF4Menu.CreateF4Menu()
	end
end )