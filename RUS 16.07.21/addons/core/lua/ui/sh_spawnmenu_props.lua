AmbSpawnMenu = AmbSpawnMenu or {}

if SERVER then return end

local props = {}

props[ 'Блоки' ] = { 
    
    Model = { 

        "models/hunter/blocks/cube025x025x025.mdl",
        "models/hunter/blocks/cube025x05x025.mdl",
        "models/hunter/blocks/cube025x075x025.mdl",
        "models/hunter/blocks/cube025x125x025.mdl",
        "models/hunter/blocks/cube025x1x025.mdl",
        "models/hunter/blocks/cube025x2x025.mdl",
        "models/hunter/blocks/cube025x3x025.mdl",
        "models/hunter/blocks/cube025x4x025.mdl",
        "models/hunter/blocks/cube05x05x025.mdl",
        "models/hunter/blocks/cube05x05x05.mdl",
        "models/hunter/blocks/cube05x075x025.mdl",
        "models/hunter/blocks/cube05x105x05.mdl",
        "models/hunter/blocks/cube05x1x025.mdl",
        "models/hunter/blocks/cube05x1x05.mdl",
        "models/hunter/blocks/cube05x2x025.mdl",
        "models/hunter/blocks/cube05x2x05.mdl",
        "models/hunter/blocks/cube05x3x025.mdl",
        "models/hunter/blocks/cube05x3x05.mdl",
        "models/hunter/blocks/cube05x4x05.mdl",
        "models/hunter/blocks/cube05x5x025.mdl",
        "models/hunter/blocks/cube05x5x05.mdl",
        "models/hunter/blocks/cube075x075x025.mdl",
        "models/hunter/blocks/cube075x075x075.mdl",
        "models/hunter/blocks/cube075x1x025.mdl",
        "models/hunter/blocks/cube075x1x075.mdl",
        "models/hunter/blocks/cube075x1x1.mdl",
        "models/hunter/blocks/cube075x2x025.mdl",
        "models/hunter/blocks/cube075x2x1.mdl",
        "models/hunter/blocks/cube075x3x025.mdl",
        "models/hunter/blocks/cube075x3x075.mdl",
        "models/hunter/blocks/cube075x3x1.mdl",
        "models/hunter/blocks/cube075x4x025.mdl",
        "models/hunter/blocks/cube075x4x075.mdl",
        "models/hunter/blocks/cube075x5x075.mdl",
        "models/hunter/blocks/cube075x6x025.mdl",
        "models/hunter/blocks/cube3x3x025.mdl",
        "models/hunter/blocks/cube3x3x05.mdl",
        "models/hunter/blocks/cube3x4x025.mdl",
        "models/hunter/blocks/cube3x4x025.mdl",
        "models/hunter/blocks/cube3x8x025.mdl",
        "models/hunter/blocks/cube4x4x05.mdl"

    } 
}

props[ 'House Pack' ] = { 
    
    Model = { 

        'models/housepack2/house3backdoor.mdl',
        'models/housepack2/house4slidingdoor.mdl',
        'models/housepack2/house3garagedoorduo.mdl',
        'models/housepack2/house2garagedoorsduo.mdl',
        'models/housepack2/house4garagedoor.mdl',
        'models/erikszeug/gebaeude/eriksvilla.mdl',
        'models/housepack2/house1.mdl',
        'models/housepack2/house2.mdl',
        'models/housepack2/house3.mdl',
        'models/housepack2/house4.mdl',
        'models/kunoszeug/altkunohaus.mdl',
        'models/kunoszeug/bunkerhaus.mdl',
        'models/kunoszeug/kunohaus_neu.mdl',
        'models/kunoszeug/towerb.mdl',
        'models/kunoszeug/traumwohnung-stein.mdl',
        'models/kunoszeug/wohnblock.mdl',
        'models/megalomaniac/megahouse.mdl'

    } 
}

props[ 'Foliage' ] = { 
    
    Model = { 

        'models/props_foliage/ac_appletree01.mdl',
        'models/props_foliage/ac_appletree02.mdl',
        'models/props_foliage/ah_apple_tree_single001.mdl',
        'models/props_foliage/ah_ash_tree001.mdl',
        'models/props_foliage/ah_ash_tree002.mdl',
        'models/props_foliage/ah_ash_tree_cluster1.mdl',
        'models/props_foliage/ah_ash_tree_lg.mdl',
        'models/props_foliage/ah_ash_tree_med.mdl',
        'models/props_foliage/ah_ash_tree_small001.mdl',
        'models/props_foliage/ah_hawthorn_sm_static.mdl',
        'models/props_foliage/ah_large_pine.mdl',
        'models/props_foliage/ah_medium_pine.mdl',
        'models/props_foliage/ah_small_pine.mdl',
        'models/props_foliage/ah_super_large_pine002.mdl',
        'models/props_foliage/ah_super_pine001.mdl',
        'models/props_foliage/appletree01.mdl',
        'models/props_foliage/ash01.mdl',
        'models/props_foliage/ash02_skybox.mdl',
        'models/props_foliage/ash03.mdl',
        'models/props_foliage/poplar01.mdl',
        'models/props_foliage/poplar02.mdl',
        'models/props_foliage/r_hedge_trees1.mdl',
        'models/props_foliage/rd_ash01.mdl',
        'models/props_foliage/rd_tree01a.mdl',
        'models/props_foliage/small-tree01.mdl',
        'models/props_foliage/tree_cliff_01a.mdl',
        'models/props_foliage/tree_cliff_02a.mdl',
        'models/props_foliage/tree_deciduous_01a-lod.mdl',
        'models/props_foliage/tree_deciduous_01a.mdl',
        'models/props_foliage/tree_deciduous_02a.mdl',
        'models/props_farm/ah_hay_pile001.mdl',
        'models/props_farm/ah_rect_hay_bale001.mdl',
        'models/props_farm/ah_rect_hay_bale_lg001.mdl',
        'models/props_farm/ah_round_hay_bale001.mdl',
        'models/props_foliage/r_maple1.mdl',
        'models/props_farm/cider_applecrusher_01.mdl',
        'models/props_farm/cider_squisher_01.mdl',
        'models/props_farm/cow_dead2_hornless.mdl',
        'models/props_farm/db_table1.mdl',
        'models/props_farm/db_tub.mdl',
        'models/props_farm/kr_table01.mdl',
        'models/props_farm/m_chickencoop.mdl',
        'models/props_farm/r_chopwood.mdl',
        'models/props_farm/r_ladder1.mdl',
        'models/props_farm/woodpile.mdl',

    }

}

props[ 'Stalker' ] = {
    Model = {
        'models/black1dez/olr/dez_tv_1.mdl',
        'models/black1dez/olr/dez_tumba_4_a.mdl',
        'models/black1dez/olr/dez_tumba_2b.mdl',
        'models/black1dez/olr/dez_tumba_1c.mdl',
        'models/black1dez/olr/dez_stol_7.mdl',
        'models/black1dez/olr/dez_stol_8.mdl',
        'models/black1dez/olr/dez_stol_8a.mdl',
        'models/black1dez/olr/dez_stol_8b.mdl',
        'models/black1dez/olr/dez_stol_obedenniy.mdl',
        'models/black1dez/olr/dez_taburet_wood_01.mdl',
        'models/black1dez/olr/dez_stul_wood_01.mdl',
        'models/black1dez/olr/dez_lavochka_02.mdl',
        'models/black1dez/olr/dez_divan_01.mdl',
        'models/black1dez/olr/dez_bottle_bar_1.mdl',
        'models/black1dez/olr/dez_bottle_bar_stakan.mdl',
        'models/black1dez/olr/dez_butilka_1.mdl',
        'models/black1dez/olr/dez_butilka_2.mdl',
        'models/black1dez/olr/dez_butilka_2b.mdl',
        'models/black1dez/olr/dez_butilka_vodka_01.mdl',
        'models/black1dez/olr/dez_drink_nonstop_old.mdl',
        'models/black1dez/olr/dez_conserv1.mdl',
        'models/black1dez/olr/dez_konserva_kukuruza.mdl',
        'models/black1dez/olr/dez_konserva_olives.mdl',
        'models/black1dez/olr/dez_konserva_orehi.mdl',
        'models/black1dez/olr/dez_konserva_sardina.mdl',
        'models/black1dez/olr/dez_konserva_tushenka.mdl',
        'models/black1dez/olr/dez_konserva_yantar.mdl',
        'models/black1dez/olr/dez_kitchen_bludo.mdl',
        'models/black1dez/olr/dez_kitchen_kastrula.mdl',
        'models/black1dez/olr/dez_kitchen_krujka.mdl',
        'models/black1dez/olr/dez_kitchen_lojka.mdl',
        'models/black1dez/olr/dez_kitchen_miska.mdl',
        'models/black1dez/olr/dez_kitchen_tarelka1.mdl',
        'models/black1dez/olr/dez_kitchen_tarelka2.mdl',
        'models/black1dez/olr/dez_gasmask1.mdl',
        'models/black1dez/olr/dez_gasmask2.mdl',
        'models/black1dez/olr/dez_gasmask3.mdl',
        'models/black1dez/olr/dez_sign_radiation.mdl',
        'models/black1dez/olr/dez_krovat_02.mdl',
        'models/black1dez/olr/dez_lampa_01_on.mdl',
        'models/black1dez/olr/dez_komp_block.mdl',
        'models/black1dez/olr/dez_komp_klava.mdl',
        'models/black1dez/olr/dez_komp_monitor.mdl',
        'models/black1dez/olr/dez_freezer.mdl',
        'models/black1dez/olr/dez_door_trader.mdl',
        'models/black1dez/olr/dez_door_darkvaley_nedostroika_01.mdl',
        'models/black1dez/olr/dez_door_darkvale_01.mdl',
        'models/black1dez/olr/dez_item_book_01.mdl',
        'models/black1dez/olr/dez_item_book_02.mdl',
        'models/black1dez/olr/dez_item_book_03.mdl',
        'models/black1dez/olr/dez_item_book_open_01.mdl',
        'models/black1dez/olr/dez_item_datchik0.mdl',
        'models/black1dez/olr/dez_item_datchik1.mdl',
        'models/black1dez/olr/dez_item_datchik2.mdl',
        'models/black1dez/olr/dez_item_datchik3.mdl',
        'models/black1dez/olr/dez_item_delo.mdl',
        'models/black1dez/olr/dez_item_merger.mdl',
        'models/black1dez/olr/dez_item_pda.mdl',
    }
}

local PANEL = {}

    function PANEL:Init()
        self.PanelList = vgui.Create( "DPanelList", self )
        self.PanelList:SetPadding( 4 )
        self.PanelList:SetSpacing( 2 )
        self.PanelList:EnableVerticalScrollbar( true )
        self:ToBuildPanels()
    end

    function PANEL:ToBuildPanels()
        self.PanelList:Clear()
        local Categorised = {}

        for k, v in pairs( props )  do
            v.Category = k
            Categorised[v.Category] = Categorised[v.Category] or {}
            table.insert(Categorised[v.Category], v)
        end

        for CategoryName, v in SortedPairs(Categorised) do
            local Category = vgui.Create("DCollapsibleCategory", self)
            self.PanelList:AddItem( Category )
            Category:SetExpanded( false )
            Category:SetLabel( CategoryName )
            Category:SetCookieName("EntitySpawn." .. CategoryName)
            local Content = vgui.Create( "DPanelList" )
            Category:SetContents( Content )
            Content:EnableHorizontal( true )
            Content:SetDrawBackground( false )
            Content:SetSpacing(2)
            Content:SetPadding(2)
            Content:SetAutoSize(true)
            num = 1

            for k, v in SortedPairs( props[CategoryName].Model ) do
              
                local Icon = vgui.Create("SpawnIcon", self)
                local Model = props[CategoryName].Model[num]

                if ( props[CategoryName].Model[num] ~= nil ) then
                    Icon:SetModel( props[CategoryName].Model[num] )
                else
                    Icon:SetModel("models/error.mdl")
                end

                Icon.DoClick = function()
                    RunConsoleCommand("gm_spawn", Model)
                end

                Icon.DoRightClick = function()
                    SetClipboardText( Model )
                end

                local lable = vgui.Create( "DLabel", Icon )
                lable:SetFont( "DebugFixedSmall" )
                lable:SetTextColor( color_black )
                lable:SetText( Model )
                lable:SetContentAlignment( 5 )
                lable:SetWide( self:GetWide() )
                lable:AlignBottom( -42 )
                Content:AddItem( Icon )
                num = num + 1
            end
        end

        self.PanelList:InvalidateLayout()
    end

function PANEL:PerformLayout()
    self.PanelList:StretchToParent( 0, 0, 0, 0 )
end
local CreationSheet = vgui.RegisterTable( PANEL, "Panel" )

local function CreateContentPanel()
    local ctrl = vgui.CreateFromTable(CreationSheet) 
    return ctrl
end
 
spawnmenu.AddCreationTab( 'Кастомные Пропсы', CreateContentPanel, "icon16/tux.png", 1 )