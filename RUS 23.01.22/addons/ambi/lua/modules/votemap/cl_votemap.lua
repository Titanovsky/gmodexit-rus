local C, GUI, Draw = Ambi.General.Global.Colors, Ambi.UI.GUI, Ambi.UI.Draw
local W, H = ScrW(), ScrH()
local COLOR_PANEL = Color( 0, 0, 0, 200 )

local function ShowVoteMap()
    local maps = Ambi.VoteMap.Config.maps
    local len = 0
    for _, __ in pairs( maps ) do len = len + 1 end

    local frame = GUI.DrawFrame( nil, W, H, 0, 0, '', true, false, true, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, COLOR_PANEL, 1, 'all' )
    end )
    local panel = GUI.DrawScrollPanel( frame, frame:GetWide() - 8, frame:GetTall(), 4, 25, function() end )

    local grid_count = ( len > 4 ) and 4 or len
    local ww, hh = W / grid_count
    local height_grid = 200
    local grid = GUI.DrawGrid( panel, ww, height_grid, 0, 0, grid_count )
    for name, info in pairs( Ambi.VoteMap.Config.maps ) do
        local logo = nil

        if info.logo then 
            Ambi.Cache.CacheURL( '[ambi]/votemap/'..name..'.png', info.logo, 4, true ) 
            logo = Material( '../data/[ambi]/votemap/'..name..'.png' )
        end

        local map = GUI.DrawPanel( grid, ww - 4, height_grid - 4, 0, 0, function( self, w, h )  
            Draw.Box( w, h, 0, 0, COLOR_PANEL, 1, 'all' )
            Draw.Text( self:GetWide() / 2, 12, name, '22 Ambi', C.ABS_WHITE, 'center', 1, C.ABS_BLACK )

            if logo and not logo:IsError() then
                Ambi.UI.Draw.Material( 150, 150, w / 2 - 150 / 2, 32, logo )
            end
        end )
        grid:AddItem( map )

        local vote = GUI.DrawButton( map, map:GetWide(), map:GetTall(), 0, 0, nil, nil, nil, function()
            net.Start( Ambi.VoteMap.Config.net_receive_answer )
                net.WriteString( name )
            net.SendToServer()

            frame:Remove()
        end, function( self, w, h ) 
            Draw.Box( w, h, 0, 0, self.color, 1, 'all' )
        end )
        vote.color = Color( 0, 0, 0, 0 )

        vote.DoRightClick = function() SetClipboardText( name ) end

        GUI.OnCursor( vote, function()
            vote.color = Color( 255, 255, 255, 20 )
        end, function() 
            vote.color = Color( 0, 0, 0, 0 )
        end )
    end

    timer.Simple( Ambi.VoteMap.Config.delay_end_vote, function()
        if ValidPanel( frame ) then frame:Remove() end
    end )
end
-- concommand.Add( 'test2', ShowVoteMap ) -- debug

local function ShowVoteMapTimer()
    local time = Ambi.VoteMap.Config.delay_before_vote

    hook.Add( 'HUDPaint', 'TEMPORARY_VOTEMAP_TIMER', function()
        Draw.Text( W / 2, 20, 'Голосование на смену карты через '..math.floor( timer.TimeLeft( 'TEMPORARY_VOTEMAP_TIMER' ) )..' секунд', '32 Ambi', C.FLAT_RED, 'top-center', 1, C.ABS_BLACK )
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