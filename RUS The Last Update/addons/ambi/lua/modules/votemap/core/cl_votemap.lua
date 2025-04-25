local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local W, H = ScrW(), ScrH()
local COLOR_PANEL = Color( 0, 0, 0, 220 )

file.CreateDir( '[ambi]/cache/votemap' )

local function ShowVoteMap()
    local maps = Ambi.VoteMap.Config.maps
    local len = 0
    for _, __ in pairs( maps ) do len = len + 1 end

    local frame = GUI.DrawFrame( nil, W, H, 0, 0, '', true, false, false, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, COLOR_PANEL, 1, 'all' )
    end )
    frame:SetAlpha( 0 )
    frame:AlphaTo( 255, 1, 0, function() end )

    local keep = GUI.DrawButton( frame, frame:GetWide() - 8, 64, 4, 4, nil, nil, nil, function( self )
        net.Start( Ambi.VoteMap.Config.net_receive_answer )
            net.WriteString( game.GetMap() )
        net.SendToServer()

        frame:AlphaTo( 0, 0.6, 0, function() frame:Remove() end )
    end, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, COLOR_PANEL )
        Draw.SimpleText( w / 2, h / 2, '• Оставить '..game.GetMap()..' •', UI.SafeFont( '44 Ambi' ), C.AMBI_BLUE, 'center', 1, C.ABS_BLACK )
    end )

    local panel = GUI.DrawScrollPanel( frame, frame:GetWide() - 8, frame:GetTall() - 35, 4, 4 + keep:GetTall() + 4, function() end )

    -- local grid_count = ( len > 4 ) and 4 or len
    -- local ww, hh = W / grid_count
    -- local height_grid = 200
    -- local grid = GUI.DrawGrid( panel, ww, height_grid, 0, 0, grid_count )
    local i = 0
    for name, info in pairs( Ambi.VoteMap.Config.maps ) do
        i = i + 1
        local num = i
        local logo = nil

        if info.logo then 
            Ambi.Cache.CacheURL( 'votemap/'..name..'.png', info.logo, 4, true ) 
            logo = Material( '../data/[ambi]/cache/votemap/'..name..'.png' )
        end

        local map = GUI.DrawPanel( panel, panel:GetWide() - 4, 110, 4, ( i - 1 ) * ( 110 + 4), function( self, w, h )  
            Draw.Box( w, h, 0, 0, COLOR_PANEL, 1, 'all' )
            Draw.Text( 100 + 12, h / 2, '['..num..']  '..name, UI.SafeFont( '64 Ambi' ), C.ABS_WHITE, 'center-left', 1, C.ABS_BLACK )

            if logo and not logo:IsError() then
                Ambi.UI.Draw.Material( 100, 100, 4, 4, logo )
            end
        end )
        panel:AddItem( map )

        local vote = GUI.DrawButton( map, map:GetWide(), map:GetTall(), 0, 0, nil, nil, nil, function()
            net.Start( Ambi.VoteMap.Config.net_receive_answer )
                net.WriteString( name )
            net.SendToServer()

            frame:AlphaTo( 0, 0.6, 0, function() frame:Remove() end )
            surface.PlaySound( 'buttons/button4.wav' )
        end, function( self, w, h ) 
            Draw.Box( w, h, 0, 0, self.color, 1, 'all' )
        end )
        vote.color = Color( 0, 0, 0, 0 )

        vote.DoRightClick = function() SetClipboardText( name ) end

        GUI.OnCursor( vote, function()
            vote.color = Color( 255, 255, 255, 20 )

            --surface.PlaySound( 'buttons/button24.wav' )
        end, function() 
            vote.color = Color( 0, 0, 0, 0 )
        end )
    end

    timer.Simple( Ambi.VoteMap.Config.delay_end_vote, function()
        if ValidPanel( frame ) then frame:Remove() end
    end )
end
--concommand.Add( 'test2', ShowVoteMap ) -- debug

local function ShowVoteMapTimer()
    local time = Ambi.VoteMap.Config.delay_before_vote

    hook.Add( 'HUDPaint', 'TEMPORARY_VOTEMAP_TIMER', function()
        Draw.Text( W / 2, 20, 'Голосование на смену карты через '..math.floor( timer.TimeLeft( 'TEMPORARY_VOTEMAP_TIMER' ) )..' секунд', UI.SafeFont( '32 Ambi' ), C.AMBI_BLUE, 'top-center', 1, C.ABS_BLACK )
    end )
    timer.Create( 'TEMPORARY_VOTEMAP_TIMER', time, 1, function() hook.Remove( 'HUDPaint', 'TEMPORARY_VOTEMAP_TIMER' ) end )
end

net.Receive( Ambi.VoteMap.Config.net_start_votemap, function()
    ShowVoteMapTimer()
    timer.Simple( AMB.VoteMap.Config.delay_before_vote, ShowVoteMap )
end )

file.CreateDir( '[ambi]/votemap' )

hook.Add( 'InitPostEntity', 'Ambi.VoteMap.DownloadAndCachingLogo', function()
    if not Ambi.VoteMap.Config.download_and_caching_logo then return end

    for name, info in pairs( Ambi.VoteMap.Config.maps ) do 
        if info.logo then Ambi.Cache.CacheURL( '[ambi]/votemap/'..name..'.png', info.logo, 4 )  end
    end
end )