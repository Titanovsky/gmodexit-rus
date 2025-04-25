local w = ScrW()
local h = ScrH()

AmbChemistry = AmbChemistry or {}

AmbChemistry.skins = {
    'models/player/corpse1.mdl',
    'models/player/zombie_classic.mdl',
    'models/player/zombie_fast.mdl',
    'models/player/zombie_soldier.mdl',
    'models/player/soldier_stripped.mdl',
    'models/player/skeleton.mdl',
    'models/player/charple.mdl',
    'models/psycedelicum/sh5/nurse/sh5nurse.mdl',
    'models/player/alma/alma.mdl',
    'models/player/biohazard/biohazard.mdl',
    'models/player/fatty/fatty.mdl',
    'models/player/ffxtidus/tidus.mdl',
    'models/player/hellknight/hellknight.mdl',
    'models/player/hidden/hidden.mdl',
    'models/player/horror/horror.mdl',
    'models/player/lycanwerewolf/lycanwerewolf.mdl',
    'models/player/undead/undead.mdl',
    'models/player/verdugo/verdugo.mdl'
}

function AmbChemistry.openMenu( eLab )
    if ( LocalPlayer():Team() ~= Tchemic1 ) then chat.AddText( AMB_COLOR_RED, '[•] ', AMB_COLOR_WHITE, ' Вы не Химик!') return end

    eLab = Entity( eLab )

    local name = ''
    local model = ''
    local run = 420
    local jump = 200
    local hp = 100

    local frame = vgui.Create('DFrame')
    frame:SetSize( 540, 540 )
    frame:Center()
    frame:MakePopup()
    frame:SetTitle( tostring( eLab ) )
    frame.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_AMBITION )
        draw.RoundedBox( 0, 4, 4, w-8, h-8, AMB_COLOR_SMALL_BLACK )
    end

    local te_name = vgui.Create( 'DTextEntry', frame )
    te_name:SetSize( 200, 40 )
    te_name:SetPos( 24, 0 + 64 * 1 )

    local panel_mdls = vgui.Create( 'DScrollPanel', frame )
    panel_mdls:SetSize( 278, 290 )
    panel_mdls:SetPos( 24 + te_name:GetWide() + 24, 0 + 64 * 1 )
    panel_mdls.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_WHITE )
    end

    local mdls_grid = vgui.Create( 'DGrid', panel_mdls )
    mdls_grid:SetPos( 0, 0 )
    mdls_grid:SetColWide( 68 )
    mdls_grid:SetRowHeight( 68 )

    for _, v in SortedPairs( AmbChemistry.skins ) do
        local panel_mdl = vgui.Create( 'DPanel' )
        panel_mdl:SetSize( 64, 64 )
        mdls_grid:AddItem( panel_mdl )

        local avatar = vgui.Create( 'ModelImage', panel_mdl )
        avatar:SetSize( 64, 64 )
        avatar:SetModel( v )

        local btn = vgui.Create( 'DButton', panel_mdl )
        btn:SetSize( 64, 64 )
        btn:SetText( '' )
        btn.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
        end
        btn.DoClick = function()
            surface.PlaySound( 'ui/buttonclick.wav' )
            model = v
        end
    end

    local slider_run = vgui.Create( "DNumSlider", frame )
    slider_run:SetPos( 16, 0 + 64 * 1.6 )		
    slider_run:SetSize( 244, 32 )
    slider_run:SetText( "Скорость бега" )
    slider_run:SetMin( 320 )			
    slider_run:SetMax( 320*2 )
    slider_run:SetValue( 320 )	
    slider_run:SetDecimals( 0 )				
    slider_run.OnValueChanged = function( self, value )
        run = value
    end

    local slider_jump = vgui.Create( "DNumSlider", frame )
    slider_jump:SetPos( 16, 0 + 64 * 2.2 )		
    slider_jump:SetSize( 244, 32 )
    slider_jump:SetText( "Сила прыжка" )
    slider_jump:SetMin( 200 )			
    slider_jump:SetMax( 200*3 )
    slider_jump:SetValue( 200 )	
    slider_jump:SetDecimals( 0 )				
    slider_jump.OnValueChanged = function( self, value )
        jump = value
    end

    local slider_hp = vgui.Create( "DNumSlider", frame )
    slider_hp:SetPos( 16, 0 + 64 * 2.6 )		
    slider_hp:SetSize( 244, 32 )
    slider_hp:SetText( "Здоровье" )
    slider_hp:SetMin( 100 )			
    slider_hp:SetMax( 100*5 )
    slider_hp:SetValue( 100 )	
    slider_hp:SetDecimals( 0 )				
    slider_hp.OnValueChanged = function( self, value )
        hp = value
    end

    local btn_synthesis = vgui.Create( 'DButton', frame )
    btn_synthesis:SetSize( 160, 60 )
    btn_synthesis:SetPos( frame:GetWide()/2 - btn_synthesis:GetWide()/2, frame:GetTall() - btn_synthesis:GetTall() - 20 )
    btn_synthesis:SetText( 'Синтезировать ('..AmbChemistry.cost_synthesize_virus..'$)' )
    btn_synthesis:SetTextColor( AMB_COLOR_WHITE )
    btn_synthesis.DoClick = function()
        frame:Remove()

        if ( LocalPlayer():Team() ~= Tchemic1 ) then return end -- shit-validation

        net.Start( 'amb_chemistry_accept_virus' )
            net.WriteEntity( LocalPlayer() )
            net.WriteEntity( eLab )

            net.WriteString( te_name:GetValue() )
            net.WriteString( model )
            net.WriteUInt( run, 10 )
            net.WriteUInt( jump, 10 )
            net.WriteUInt( hp, 10 )
        net.SendToServer()

        model = nil
        run = nil
        jump = nil
        hp = nil
    end
    btn_synthesis.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_AMBITION )
        draw.RoundedBox( 0, 2, 2, w-4, h-4, AMB_COLOR_SMALL_BLACK )
    end
end