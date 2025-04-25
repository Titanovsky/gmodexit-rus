CreateClientConVar("ru_crosshair_cvar", "0", true, false)
CreateClientConVar("ru_crosshair_cvar_type", "1", true, false)
CreateClientConVar("ru_crosshair_cvar_size", "1", true, false)
CreateClientConVar("ru_crosshair_cvar_color_r", "255", true, false)
CreateClientConVar("ru_crosshair_cvar_color_g", "255", true, false)
CreateClientConVar("ru_crosshair_cvar_color_b", "255", true, false)
CreateClientConVar("ru_crosshair_cvar_color_a", "255", true, false)

local ru_crosshair_cvar = GetConVar( "ru_crosshair_cvar" )
local ru_crosshair_cvar_type = GetConVar( "ru_crosshair_cvar_type" )
local ru_crosshair_cvar_size = GetConVar( "ru_crosshair_cvar_size" )
local ru_crosshair_cvar_color_r = GetConVar( "ru_crosshair_cvar_color_r" )
local ru_crosshair_cvar_color_g = GetConVar( "ru_crosshair_cvar_color_g" )
local ru_crosshair_cvar_color_b = GetConVar( "ru_crosshair_cvar_color_b" )
local ru_crosshair_cvar_color_a = GetConVar( "ru_crosshair_cvar_color_a" )

local w = ScrW()
local h = ScrH()


function ru_CrossHairPanel()
	spawnmenu.AddToolTab("ru_tab", "[RU] Bloha", "icon16/female.png") -- Add a new tab

	spawnmenu.AddToolCategory("ru_tab", "ru_cat", "Хз что писать") -- Add a category into that new tab

	spawnmenu.AddToolMenuOption( "ru_tab", "ru_cat", "ru_crosshair_menu", "Crosshire( Перекрестие )", "", "", 
	function( menu )
		--menu:AddControl( "listbox", { label = "Тип прицела", Options = list.Get( "RenderModes" ) } )
		local DComboBox = vgui.Create( "DComboBox", menu )
		DComboBox:SetPos( 5, 30 )
		DComboBox:SetSize( 100, 20 )
		DComboBox:SetValue( "Тип прицела" )
		DComboBox:AddChoice( "Крест" )
		DComboBox:AddChoice( "Окружность" )
		DComboBox:AddChoice( "Квадрат" )
		DComboBox.OnSelect = function( self, index, value )
			ru_crosshair_cvar_type:SetInt( index )
		end

		local DermaNumSlider = vgui.Create( "DNumSlider", menu )
		DermaNumSlider:SetPos( 5, 65 )			
		DermaNumSlider:SetSize( 220, 25 )		 
		DermaNumSlider:SetText( "Размер" )	
		DermaNumSlider:SetMin( 1 )
		DermaNumSlider:SetMax( 24 )			
		DermaNumSlider:SetDecimals( 0 )		
		DermaNumSlider:SetConVar( "ru_crosshair_cvar_size" )

		local Mixer = vgui.Create("DColorMixer", menu)
		Mixer:SetPos( 5, 125 )				-- Make Mixer fill place of Frame
		Mixer:SetPalette( false )  			-- Show/hide the palette 				DEF:true
		Mixer:SetAlphaBar( true ) 			-- Show/hide the alpha bar 				DEF:true
		Mixer:SetWangs( true ) 				-- Show/hide the R G B A indicators 	DEF:true
		Mixer:DoConVarThink( "ru_crosshair_cvar_color_r" )
		Mixer:DoConVarThink( "ru_crosshair_cvar_color_g" )
		Mixer:DoConVarThink( "ru_crosshair_cvar_color_b" )
		Mixer:DoConVarThink( "ru_crosshair_cvar_color_a" )
		Mixer:SetColor( Color( 255,255,255) ) 	-- Set the default color
		Mixer:SetConVarR( "ru_crosshair_cvar_color_r" )
		Mixer:SetConVarG( "ru_crosshair_cvar_color_g" )
		Mixer:SetConVarB( "ru_crosshair_cvar_color_b" )
		Mixer:SetConVarA( "ru_crosshair_cvar_color_a" )
	end )
end
hook.Add( "AddToolMenuTabs", "ru_bloha", ru_CrossHairPanel )


hook.Add("HUDPaint", "ru_bloha", function() 
	if ru_crosshair_cvar:GetInt() == 0 then return end

	if ru_crosshair_cvar_type:GetInt() == 2 then
		surface.DrawCircle( w/2, h/2, 1 * ru_crosshair_cvar_size:GetInt(), Color( ru_crosshair_cvar_color_r:GetInt(), ru_crosshair_cvar_color_g:GetInt(), ru_crosshair_cvar_color_b:GetInt(), ru_crosshair_cvar_color_a:GetInt() ) )
	elseif ru_crosshair_cvar_type:GetInt() == 3 then
		surface.SetDrawColor(ru_crosshair_cvar_color_r:GetInt(), ru_crosshair_cvar_color_g:GetInt(), ru_crosshair_cvar_color_b:GetInt(), ru_crosshair_cvar_color_a:GetInt())
    	surface.DrawRect(w/2 - 2 * ru_crosshair_cvar_size:GetInt()/2, h/2 - 2 * ru_crosshair_cvar_size:GetInt()/2, 2 * ru_crosshair_cvar_size:GetInt(), 2 * ru_crosshair_cvar_size:GetInt())
    elseif ru_crosshair_cvar_type:GetInt() == 1 then
    	surface.SetDrawColor(ru_crosshair_cvar_color_r:GetInt(), ru_crosshair_cvar_color_g:GetInt(), ru_crosshair_cvar_color_b:GetInt(), ru_crosshair_cvar_color_a:GetInt())
    	surface.DrawLine(w/2 - 3 * ru_crosshair_cvar_size:GetInt(), h/2, w/2 - 6 * ru_crosshair_cvar_size:GetInt(), h/2)
		surface.DrawLine(w/2 + 3 * ru_crosshair_cvar_size:GetInt(), h/2, w/2 + 6 * ru_crosshair_cvar_size:GetInt(), h/2)
	
		surface.DrawLine(w/2, h/2 - 3 * ru_crosshair_cvar_size:GetInt(), w/2, h/2 - 6 * ru_crosshair_cvar_size:GetInt())
		surface.DrawLine(w/2, h/2 + 3 * ru_crosshair_cvar_size:GetInt(), w/2, h/2 + 6 * ru_crosshair_cvar_size:GetInt())
	end
end)

hook.Add( "HUDShouldDraw", "ru_bloha", function( name )
	if ru_crosshair_cvar:GetInt() == 0 then
		if name == "CHudCrosshair" then return true end
	else
		if name == "CHudCrosshair" then return false end
	end
end )