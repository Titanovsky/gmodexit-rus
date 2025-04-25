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

props[ 'Киндер' ] = {
    Model = {
        'models/various/kinder_ueberraschung.mdl',
    'models/various/kinder_ueberraschung_inner.mdl',
    'models/various/kinder_ueberraschung_egg.mdl',
    'models/various/kinder_ueberraschung_inner_half.mdl',
    }
}

props[ '• Happy New Year 2023 •' ] = {
    Model = {
        'models/models_kit/xmas/xmastree.mdl',
        'models/models_kit/xmas/xmastree_mini.mdl',
        'models/christmas_gift_boxes/christmas_gift_box_1.mdl',
        'models/christmas_gift_boxes/christmas_gift_box_2.mdl',
        'models/christmas_gift_boxes/christmas_gift_box_3.mdl',
        'models/christmas_gift_boxes/christmas_gift_box_4.mdl',
        'models/christmas_gift_boxes/snow_reindeer_box.mdl',
        'models/christmas_gift_boxes/snow_reindeer_box_(box).mdl',
        'models/christmas_gift_boxes/snow_reindeer_box_(top).mdl',
    }
}

props[ 'Домики' ] = {
    Model = {
        'models/kunoszeug/wohnblock.mdl',
        'models/kunoszeug/traumwohnung-stein.mdl',
        'models/kunoszeug/towerb.mdl',
        'models/kunoszeug/towerb.mdl',
        'models/kunoszeug/kunohaus_neu.mdl',
        'models/kunoszeug/bunkerhaus.mdl',
        'models/kunoszeug/altkunohaus.mdl',
        'models/housepack2/house1.mdl',
        'models/erikszeug/gebaeude/eriksvilla.mdl',
    }
}

props[ 'Различные пропы' ] = {
    Model = {
        'models/gm_bigcity/bridge.mdl',
        'models/props/big_picture.mdl',
        'models/props/blendrockdirt.mdl',
        'models/props/blendrockdirt.mdl',
        'models/props/heart.mdl',
        'models/props/hinged_metal_platform.mdl',
        'models/props/metal_fastening.mdl',
        'models/props/metal_mounting_for_current_supply.mdl',
        'models/props/platform_with_stairs.mdl',
        'models/props/platform_with_stairs_2.mdl',
        'models/props/platform_with_stairs_3.mdl',
        'models/props/stand_of_metal_platforms.mdl',
        'models/props/c17_road/hut.mdl',
        'models/props/shooting_gallery/target.mdl',
        'models/props_black_mesa/transition_bridge.mdl',
        'models/props_building/destroyed_building_22.mdl',
        'models/props_building/unfinished_building.mdl',
        'models/props_building/unfinished_building_2.mdl',
        'models/props_c17/billboard.mdl',
        'models/props_c17/container_for_gas_station.mdl',
        'models/props_camp/barn.mdl',
        'models/props_city/column.mdl',
        'models/props_city/house_with_yard.mdl',
        'models/props_city/small_house.mdl',
        'models/props_forest/dilapidated_building.mdl',
        'models/props_gamer/poster_01.mdl',
        'models/props_house/wooden_stand.mdl',
        'models/props_resistance/stairs.mdl',
        'models/props_stock/metal_cage.mdl',
        'models/props_stock/metal_cage_open.mdl',
        'models/props_town/abandoned_house.mdl',
        'models/props_village/country_house.mdl',
        'models/props_village/design.mdl',
        'models/props_work_zone/shelf.mdl',
        'models/props_work_zone/small_metal_bridge.mdl',
        'models/props_workshop/lodge.mdl',
        'models/props_yard/wooden_fence.mdl',
        'models/props_yard/wooden_fence_medium.mdl',
        'models/props_workshop/lodge_window.mdl',
        'models/props/candelabrum.mdl',
        'models/props/metal_construction_with_roof.mdl',
        'models/props_break/wood_construction_54343.mdl',
        'models/props_port/metal_bridge.mdl',
        'models/props_city/signboard.mdl',
        'models/props_old/big_arch.mdl',
        'models/props_old/stand_346135.mdl',
        'models/props_park/road_arch.mdl',
        'models/props_port/metal_stand.mdl',
        'models/props_torture/cage.mdl',
        'models/props_training/fence.mdl',
        'models/props_yard/big_arbor.mdl',
        'models/props_yard/fence.mdl',
        'models/winter_2018/big_snowball.mdl',
        'models/winter_2018/big_snowman_hat.mdl',
        'models/winter_2018/big_snowman_head.mdl',
        'models/winter_2018/big_snowman_head_with_hat.mdl',
        'models/winter_2018/chair.mdl',
        'models/winter_2018/gift.mdl',
        'models/winter_2018/house.mdl'
    }
}

props[ 'Stockplus' ] = {
    Model = {
        'models/okxapack/stockplus/hunter/misc/platehole6x6.mdl',
        'models/okxapack/stockplus/hunter/misc/platehole8x8.mdl',
        'models/okxapack/stockplus/hunter/misc/stair_radial_1x1x1_ccw.mdl',
        'models/okxapack/stockplus/hunter/misc/stair_radial_1x1x2_ccw.mdl',
        'models/okxapack/stockplus/hunter/misc/stair_radial_1x1x2_cw.mdl',
        'models/okxapack/stockplus/hunter/misc/stair_round_1x1_inside.mdl',
        'models/okxapack/stockplus/hunter/misc/stair_round_1x1_outside.mdl',
        'models/okxapack/stockplus/hunter/pipes/pipe025.mdl',
        'models/okxapack/stockplus/hunter/pipes/pipe05.mdl',
        'models/okxapack/stockplus/hunter/pipes/pipe075.mdl',
        'models/okxapack/stockplus/hunter/pipes/pipe1.mdl',
        'models/okxapack/stockplus/hunter/pipes/pipe2.mdl',
        'models/okxapack/stockplus/hunter/pipes/pipe4.mdl',
        'models/okxapack/stockplus/hunter/pipes/pipe8.mdl',
        'models/okxapack/stockplus/hunter/pipes/pipebend1.mdl',
        'models/okxapack/stockplus/hunter/pipes/pipecap.mdl',
        'models/okxapack/stockplus/hunter/plates/plate_window_1x1.mdl',
        'models/okxapack/stockplus/hunter/plates/plate_window_1x2.mdl',
        'models/okxapack/stockplus/hunter/plates/plate_window_1x3.mdl',
        'models/okxapack/stockplus/hunter/plates/plate_window_1x4.mdl',
        'models/okxapack/stockplus/hunter/plates/plate_window_narrow_1x1.mdl',
        'models/okxapack/stockplus/hunter/plates/plate_window_narrow_1x2.mdl',
        'models/okxapack/stockplus/hunter/plates/plate_window_narrow_1x3.mdl',
        'models/okxapack/stockplus/hunter/plates/plate_window_narrow_1x4.mdl',
        'models/okxapack/stockplus/hunter/tubes/circle_window_2x2.mdl',
        'models/okxapack/stockplus/hunter/tubes/circle_window_narrow_2x2.mdl',
        'models/okxapack/stockplus/hunter/tubes/tube_window_2x2x1.mdl',
        'models/okxapack/stockplus/hunter/tubes/tube_window_2x2x2.mdl',
        'models/okxapack/stockplus/hunter/tubes/tube_window_narrow_2x2x1.mdl',
        'models/okxapack/stockplus/hunter/tubes/tube_window_narrow_2x2x2.mdl',
        'models/okxapack/stockplus/hunter/tubes/tubecap_window_2x2.mdl',
        'models/okxapack/stockplus/hunter/tubes/tubecap_window_narrow_2x2.mdl',
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