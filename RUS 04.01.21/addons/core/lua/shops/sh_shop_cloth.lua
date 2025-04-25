--[[
	Магазин скинов.
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[10.08.20]
		• Одежда.
	.
]]

AmbShopCloth = AmbShopCloth or {}

AmbShopCloth.FemaleModels = {
    ['models/player/Group01/female_01.mdl'] = 16,
    ['models/player/Group01/female_02.mdl'] = 16,
    ['models/player/Group01/female_03.mdl'] = 16,
    ['models/player/Group01/female_04.mdl'] = 16,
    ['models/player/Group01/female_05.mdl'] = 16,
    ['models/player/Group01/female_06.mdl'] = 16,
    
    ['models/player/Group03m/female_01.mdl'] = 24,
    ['models/player/Group03m/female_02.mdl'] = 24,
    ['models/player/Group03m/female_03.mdl'] = 24,
    ['models/player/Group03m/female_04.mdl'] = 24,
    ['models/player/Group03m/female_05.mdl'] = 24,
    ['models/player/Group03m/female_06.mdl'] = 24,

    ['models/player/Group03/female_01.mdl'] = 32,
    ['models/player/Group03/female_02.mdl'] = 32,
    ['models/player/Group03/female_03.mdl'] = 32,
    ['models/player/Group03/female_04.mdl'] = 32,
    ['models/player/Group03/female_05.mdl'] = 32,
    ['models/player/Group03/female_06.mdl'] = 32,

    ['models/player/hostage/hostage_04.mdl'] = 46,

    ['models/player/mossman_arctic.mdl'] = 64,
    ['models/player/mossman.mdl'] = 64,

    ['models/player/alyx.mdl'] = 128,
    ['models/player/p2_chell.mdl'] = 128
}


AmbShopCloth.MaleModels = {
    ['models/player/Group01/male_07.mdl'] = 16,
    ['models/player/Group01/male_09.mdl'] = 16,
    ['models/player/Group01/male_02.mdl'] = 16,
    ['models/player/Group01/male_04.mdl'] = 16,
    ['models/player/Group01/male_05.mdl'] = 16,
    ['models/player/Group01/male_06.mdl'] = 16,
    ['models/player/Group01/male_01.mdl'] = 16,
    ['models/player/Group01/male_03.mdl'] = 16,
    ['models/player/Group01/male_08.mdl'] = 16,

    ['models/player/Group03m/male_07.mdl'] = 24,
    ['models/player/Group03m/male_09.mdl'] = 24,
    ['models/player/Group03m/male_02.mdl'] = 24,
    ['models/player/Group03m/male_04.mdl'] = 24,
    ['models/player/Group03m/male_05.mdl'] = 24,
    ['models/player/Group03m/male_06.mdl'] = 24,
    ['models/player/Group03m/male_01.mdl'] = 24,
    ['models/player/Group03m/male_03.mdl'] = 24,
    ['models/player/Group03m/male_08.mdl'] = 24,

    ['models/player/Group03/male_07.mdl'] = 32,
    ['models/player/Group03/male_09.mdl'] = 32,
    ['models/player/Group03/male_02.mdl'] = 32,
    ['models/player/Group03/male_04.mdl'] = 32,
    ['models/player/Group03/male_05.mdl'] = 32,
    ['models/player/Group03/male_06.mdl'] = 32,
    ['models/player/Group03/male_01.mdl'] = 32,
    ['models/player/Group03/male_03.mdl'] = 32,
    ['models/player/Group03/male_08.mdl'] = 32,

    ['models/player/hostage/hostage_01.mdl'] = 46,
    ['models/player/hostage/hostage_02.mdl'] = 46,
    ['models/player/hostage/hostage_03.mdl'] = 46,

    ['models/player/barney.mdl'] = 64,
    ['models/player/eli.mdl'] = 64,
    ['models/player/kleiner.mdl'] = 64,
    ['models/player/monk.mdl'] = 64,
    ['models/player/odessa.mdl'] = 64,
    ['models/player/magnusson.mdl'] = 64,

    ['models/player/gman_high.mdl'] = 128,
    ['models/player/breen.mdl'] = 128
}

AmbShopCloth.SpecModels = {
    ['models/player/arctic.mdl'] = 256,
    ['models/player/guerilla.mdl'] = 256,
    ['models/player/phoenix.mdl'] = 256,
    ['models/player/leet.mdl'] = 256,

    ['models/player/riot.mdl'] = 288,
    ['models/player/swat.mdl'] = 288,
    ['models/player/urban.mdl'] = 288,
    ['models/player/gasmask.mdl'] = 288,

    ['models/player/dod_american.mdl'] = 376,
    ['models/player/dod_german.mdl'] = 376,

    ['models/player/soldier_stripped.mdl'] = 512,
    ['models/player/police_fem.mdl'] = 512,
    ['models/player/police.mdl'] = 512,
    ['models/player/combine_soldier.mdl'] = 512,
    ['models/player/combine_soldier_prisonguard.mdl'] = 512,
    ['models/player/combine_soldier_prisonguard.mdl'] = 512,
    ['models/player/combine_super_soldier.mdl'] = 512,

    ['models/player/corpse1.mdl'] = 1024,
    ['models/player/zombie_classic.mdl'] = 1024,
    ['models/player/zombie_fast.mdl'] = 1024,
    ['models/player/zombie_soldier.mdl'] = 1024,

    ['models/player/charple.mdl'] = 2048,
    ['models/player/skeleton.mdl'] = 2048
}

if ( SERVER ) then
    util.AddNetworkString('amb_shop_cloth_buy')

    net.Receive('amb_shop_cloth_buy', function( len )
        local ePly = net.ReadEntity()
        local mdl = net.ReadString()

        AmbEconomic.buy( ePly, mdl, 'skin' )
    end )

elseif ( CLIENT ) then

    local w = ScrW()
    local h = ScrH()

    function AmbShopCloth.openShop()
        local frame = vgui.Create( "DFrame" )
        frame:SetTitle( "" )
        frame:SetSize( 512,256 )
        frame:Center()			
        frame:MakePopup()
        frame:ShowCloseButton( false )
        frame.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_AMBITION )
            draw.RoundedBox( 0, 4, 4, w-8, h-8, AMB_COLOR_BLACK )
        end

        local btn_close = vgui.Create( "DButton", frame )
        btn_close:SetSize( 18, 18 )
        btn_close:SetTextColor( AMB_COLOR_RED )
        btn_close:SetPos( frame:GetWide() - btn_close:GetWide() - 6, 6 )
        btn_close:SetText('X')
        btn_close.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_RED )
            draw.RoundedBox( 0, 2, 2, w-4, h-4, AMB_COLOR_BLACK )
        end
        btn_close.DoClick = function( self )
            frame:Remove()
        end
                
        local panels_female = vgui.Create( "DScrollPanel", frame )
        panels_female:SetPos(6,6)
        panels_female:SetSize( 160, 240)

        for name, cost in SortedPairsByValue( AmbShopCloth.FemaleModels ) do
            local panel_mdl = panels_female:Add( "DPanel" )
            panel_mdl:SetText( name)
            panel_mdl:SetSize( 0, 72 )
            panel_mdl:Dock( TOP )
            panel_mdl:DockMargin( 4, 4, 4, 4 )
            panel_mdl.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_WHITE )
                draw.RoundedBox( 0, 2, 2, w-4, h-4, AMB_COLOR_BLACK )

                draw.SimpleText("Cost: "..cost, "ambFont18", 126, 28, AMB_COLOR_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
            end

            local icon_mdl = vgui.Create( 'ModelImage', panel_mdl )
            icon_mdl:SetSize( 68, 68 )
            icon_mdl:SetPos( 2, 2 )
            icon_mdl:SetModel( name )
            icon_mdl.DoClick = function( self )
                frame:Remove()
            end

            local btn_buy = vgui.Create( 'DButton', panel_mdl )
            btn_buy:SetSize( 42, 24 )
            btn_buy:SetPos( 78, 42 )
            btn_buy:SetTextColor( AMB_COLOR_WHITE )
            btn_buy:SetText('Buy')
            btn_buy.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_WHITE )
                draw.RoundedBox( 0, 2, 2, w-4, h-4, AMB_COLOR_BLACK )
            end
            btn_buy.DoClick = function( self )
                net.Start('amb_shop_cloth_buy')
                    net.WriteEntity(LocalPlayer())
                    net.WriteString(name)
                net.SendToServer()
                frame:Remove()
            end
        end

        local panels_male = vgui.Create( "DScrollPanel", frame )
        panels_male:SetPos(6 + panels_female:GetWide(), 6 )
        panels_male:SetSize( 160, 240)
        for name, cost in SortedPairsByValue( AmbShopCloth.MaleModels ) do
            local panel_mdl = panels_male:Add( "DPanel" )
            panel_mdl:SetText( name)
            panel_mdl:SetSize( 0, 72 )
            panel_mdl:Dock( TOP )
            panel_mdl:DockMargin( 4, 4, 4, 4 )
            panel_mdl.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_WHITE )
                draw.RoundedBox( 0, 2, 2, w-4, h-4, AMB_COLOR_BLACK )

                draw.SimpleText("Cost: "..cost, "ambFont18", 126, 28, AMB_COLOR_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
            end

            local icon_mdl = vgui.Create( 'ModelImage', panel_mdl )
            icon_mdl:SetSize( 68, 68 )
            icon_mdl:SetPos( 2, 2 )
            icon_mdl:SetModel( name )
            icon_mdl.DoClick = function( self )
                frame:Remove()
            end

            local btn_buy = vgui.Create( 'DButton', panel_mdl )
            btn_buy:SetSize( 42, 24 )
            btn_buy:SetPos( 78, 42 )
            btn_buy:SetTextColor( AMB_COLOR_WHITE )
            btn_buy:SetText('Buy')
            btn_buy.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_WHITE )
                draw.RoundedBox( 0, 2, 2, w-4, h-4, AMB_COLOR_BLACK )
            end
            btn_buy.DoClick = function( self )
                net.Start('amb_shop_cloth_buy')
                    net.WriteEntity(LocalPlayer())
                    net.WriteString(name)
                net.SendToServer()
                frame:Remove()
            end
        end

        local panels_spec = vgui.Create( "DScrollPanel", frame )
        panels_spec:SetPos(6 + panels_female:GetWide() + panels_spec:GetWide() * 2.5, 6 )
        panels_spec:SetSize( 160, 240)
        for name, cost in SortedPairsByValue( AmbShopCloth.SpecModels ) do
            local panel_mdl = panels_spec:Add( "DPanel" )
            panel_mdl:SetText( name)
            panel_mdl:SetSize( 0, 72 )
            panel_mdl:Dock( TOP )
            panel_mdl:DockMargin( 4, 4, 4, 4 )
            panel_mdl.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_AMETHYST )
                draw.RoundedBox( 0, 2, 2, w-4, h-4, AMB_COLOR_BLACK )

                draw.SimpleText("Cost: "..cost, "ambFont18", 126, 28, AMB_COLOR_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
            end

            local icon_mdl = vgui.Create( 'ModelImage', panel_mdl )
            icon_mdl:SetSize( 68, 68 )
            icon_mdl:SetPos( 2, 2 )
            icon_mdl:SetModel( name )
            icon_mdl.DoClick = function( self )
                frame:Remove()
            end

            local btn_buy = vgui.Create( 'DButton', panel_mdl )
            btn_buy:SetSize( 42, 24 )
            btn_buy:SetPos( 78, 42 )
            btn_buy:SetTextColor( AMB_COLOR_WHITE )
            btn_buy:SetText('Buy')
            btn_buy.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_AMETHYST )
                draw.RoundedBox( 0, 2, 2, w-4, h-4, AMB_COLOR_BLACK )
            end
            btn_buy.DoClick = function( self )
                frame:Remove()
                net.Start('amb_shop_cloth_buy')
                    net.WriteEntity(LocalPlayer())
                    net.WriteString(name)
                net.SendToServer()
            end
        end

    end
end