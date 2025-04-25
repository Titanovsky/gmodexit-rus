local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local W, H = ScrW(), ScrH()
local C_BACK = Color( 20, 20, 20, 235 )
local C_HEADER = Color( 12, 197, 27)
local C_ALL = Color( 15, 215, 75)
local C_PANEL = Color( 0, 0, 0, 100 ) 

function Ambi.Rus.ShowTab()
    local all_players, max_players = #player.GetAll(), game.MaxPlayers()
    local main_color = Color( 0, 0, 0 )

    local panel = GUI.DrawPanel( nil, W / 2, H / 1.1, 0, 0, function( self, w, h ) 
        --Draw.Box( w, h, 0, 0, C_BACK )
        Draw.SimpleText( w / 2, 6, '❄ С наступающим ❄', UI.SafeFont( '54 Ambi' ), main_color, 'top-center', 1, C.ABS_BLACK )
        Draw.SimpleText( w - 2, 6 + 50, all_players..'/'..max_players, UI.SafeFont( '18 Ambi' ), C.ABS_WHITE, 'top-right', 1, C.ABS_BLACK )
        Draw.SimpleText( 2, 6 + 38, os.date( '%X', os.time() - 60 * 60 * 2 ), UI.SafeFont( '34 Ambi' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )

        main_color = HSVToColor( ( CurTime() * 16 ) % 360, 1, 1 )
    end )
    panel:Center()

    local subpanel = GUI.DrawPanel( panel, panel:GetWide(), panel:GetTall() - 72, 0, 72, function( self, w, h ) 
        Draw.Box( w, 2, 0, 0, main_color )
        Draw.Box( w, 2, 0, h - 2, main_color )

        Draw.Box( 2, h, 0, 0, main_color )
        Draw.Box( 2, h, w - 2, 0, main_color )
    end )

    local players = GUI.DrawScrollPanel( subpanel, subpanel:GetWide() - 4, subpanel:GetTall() - 4, 2, 2, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C_BACK )
    end )

    players:GetVBar():SetSize( 0 )

    local tab_players = player.GetAll()
    for i, ply in ipairs( tab_players ) do
        if ply == LocalPlayer() then
            tab_players[ 1 ], tab_players[ i ] = tab_players[ i ], tab_players[ 1 ]

            break
        end
    end

    local actions = {}
    for i, ply in ipairs( tab_players ) do
        local panel = GUI.DrawPanel( players, players:GetWide(), 66, 0, 66 * ( i - 1 ), function( self, w, h ) 
            if not IsValid( ply ) then self:Remove() return end

            Draw.Box( w, 2, 0, h - 2, main_color )
            Draw.Box( 2, h, 64, 0, main_color )

            if ply:IsBot() then
                Draw.Box( 64, 64, 0, 0, C.ABS_WHITE )
                Draw.SimpleText( 4, h / 2, '( ͡° ͜ʖ ͡°)', UI.SafeFont( '26 Ambi' ), C.ABS_BLACK, 'center-left' )
            end
        end )

        local id, name, team_name, team_color = ply:EntIndex(), ply:Name(), ply:TeamName(), ply:TeamColor()
        local info = GUI.DrawButton( panel, panel:GetWide() - 66, panel:GetTall() - 2, 66, 0, nil, nil, nil, function( self )
            ----------------------------------------------------------------------------------------------------------
        end, function( self, w, h ) 
            if not IsValid( ply ) then self:Remove() return end

            Draw.SimpleText( 2, 2, '['..id..'] '..name, UI.SafeFont( '20 Ambi' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )
            Draw.SimpleText( 2, 22, team_name, UI.SafeFont( '16 Ambi' ), team_color, 'top-left', 1, C.ABS_BLACK )

            Draw.SimpleText( w - 22, 4, 'Ping', UI.SafeFont( '12 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )
            Draw.SimpleText( w - 23, 20, ply:Ping(), UI.SafeFont( '15 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )

            Draw.SimpleText( w - 22 - 40, 4, 'Frags', UI.SafeFont( '12 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )
            Draw.SimpleText( w - 23 - 40, 20, ply:Frags(), UI.SafeFont( '15 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )

            Draw.SimpleText( w - 22 - 40 * 2, 4, 'Deaths', UI.SafeFont( '12 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )
            Draw.SimpleText( w - 23 - 40 * 2, 20, ply:Deaths(), UI.SafeFont( '15 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )

            if not ply:Alive() then Draw.SimpleText( w / 2, 4, 'Мертв!', UI.SafeFont( '18 Ambi' ), C.ABS_RED, 'top-center', 1, C.ABS_BLACK ) end

            if ply:IsBot() then return end

            Draw.SimpleText( 2, 34, 'Level: '..tostring( ply.nw_Level ), UI.SafeFont( '16 Ambi' ), C.AMBI_PURPLE, 'top-left', 1, C.ABS_BLACK )
            Draw.SimpleText( 2, 48, 'XP: '..tostring( ply.nw_XP )..' / '..tostring( ply:GetNextXP() ), UI.SafeFont( '16 Ambi' ), C.AMBI, 'top-left', 1, C.ABS_BLACK )
            Draw.SimpleText( w / 2, h / 2, ply:GetStatus(), UI.SafeFont( '24 Ambi' ), ply:GetStatusColor(), 'center', 1, C.ABS_BLACK )

            if not ply.nw_IsRusAuth then Draw.SimpleText( w / 2, 4, 'Не Авторизован!', UI.SafeFont( '18 Ambi' ), C.AMBI_YELLOW, 'top-center', 1, C.ABS_BLACK ) end
        end )

        GUI.OnCursor( info, function()
            info:SetCursor( 'arrow' )

            if ( #actions > 0 ) then
                for i, panel in ipairs( actions ) do panel:Remove() end
            end
            actions = {}

            local goto_btn = GUI.DrawButton( info, 54, 24, info:GetWide() - 54 - 4, info:GetTall() - 24 - 4, nil, nil, nil, function( self )
                LocalPlayer():ConCommand( 'ulx goto "'..ply:Name()..'"' )
            end, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C_PANEL, 6 )
                Draw.SimpleText( w / 2, h / 2, 'Goto', UI.SafeFont( '16 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
            end )
            actions[ #actions + 1 ] = goto_btn

            local offset_x = goto_btn:GetWide() + 2
            local bring_btn = GUI.DrawButton( info, 54, 24, info:GetWide() - 54 - 4 - offset_x, info:GetTall() - 24 - 4, nil, nil, nil, function( self )
                LocalPlayer():ConCommand( 'ulx bring "'..ply:Name()..'"' )
            end, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C_PANEL, 6 )
                Draw.SimpleText( w / 2, h / 2, 'Bring', UI.SafeFont( '16 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
            end )
            actions[ #actions + 1 ] = bring_btn

            local offset_x = offset_x + bring_btn:GetWide() + 2
            local return_btn = GUI.DrawButton( info, 54, 24, info:GetWide() - 54 - 4 - offset_x, info:GetTall() - 24 - 4, nil, nil, nil, function( self )
                LocalPlayer():ConCommand( 'ulx return "'..ply:Name()..'"' )
            end, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C_PANEL, 6 )
                Draw.SimpleText( w / 2, h / 2, 'Return', UI.SafeFont( '16 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
            end )
            actions[ #actions + 1 ] = return_btn

            local offset_x = offset_x + return_btn:GetWide() + 2
            local kick_btn = GUI.DrawButton( info, 54, 24, info:GetWide() - 54 - 4 - offset_x, info:GetTall() - 24 - 4, nil, nil, nil, function( self )
                LocalPlayer():ConCommand( 'ulx kick "'..ply:Name()..'" "!"' )
            end, function( self, w, h ) 
                Draw.Box( w, h, 0, 0, C_PANEL, 6 )
                Draw.SimpleText( w / 2, h / 2, 'Kick', UI.SafeFont( '16 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
            end )
            actions[ #actions + 1 ] = kick_btn

            if ( ply != LocalPlayer() ) then
                offset_x = offset_x + kick_btn:GetWide() + 2
                local gag = GUI.DrawButton( info, 54, 24, info:GetWide() - 54 - 4 - offset_x, info:GetTall() - 24 - 4, nil, nil, nil, function()
                    if ply:IsMuted() then
                        ply:SetMuted( false )
                    else
                        ply:SetMuted( true )
                    end
                end, function( self, w, h ) 
                    if not IsValid( ply ) then self:Remove() return end
    
                    Draw.Box( w, h, 0, 0, C_PANEL, 6 )
                    Draw.SimpleText( w / 2, h / 2, ply:IsMuted() and 'UnGag' or 'Gag', UI.SafeFont( '16 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
                end )

                actions[ #actions + 1 ] = gag
            end
        end )

        -- Actions ----------------------------------------------
        ---------------------------------------------------------

        if ply:IsBot() then continue end

        local avatar = GUI.DrawAvatar( panel, 64, 64, 0, 0, 64, ply )
        local avatar_button = GUI.DrawButton( avatar, avatar:GetWide(), avatar:GetTall(), 0, 0, nil, nil, nil, function()
            ply:ShowProfile()

            chat.AddText( C.ABS_WHITE, 'https://steamcommunity.com/profiles/'..ply:SteamID64() )
        end, function( self, w, h ) 
        end )

        local sid = ply:SteamID()
        avatar_button.DoRightClick = function() 
            chat.AddText( C.ABS_WHITE, sid )
            SetClipboardText( sid ) 
        end
    end

    Ambi.Rus.tab = panel
end

hook.Add( 'ScoreboardShow', 'Ambi.Rus.Tab', function()
    Ambi.Rus.ShowTab()
    gui.EnableScreenClicker( true ) 

	return false
end )

hook.Add( 'ScoreboardHide', 'Ambi.Rus.Tab', function()
    if Ambi.Rus.tab then Ambi.Rus.tab:Remove() end
    gui.EnableScreenClicker( false )
    
	return false
end )