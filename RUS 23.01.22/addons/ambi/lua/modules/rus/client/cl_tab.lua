local C, GUI, Draw = Ambi.General.Global.Colors, Ambi.UI.GUI, Ambi.UI.Draw
local W, H = ScrW(), ScrH()
local C_BACK = Color( 20, 20, 20, 235 )
local C_HEADER = Color( 238, 170, 44)

function Ambi.Rus.ShowTab()
    local panel = GUI.DrawPanel( nil, W / 3, H / 1.2, 0, 0, function( self, w, h ) 
        Draw.SimpleText( w / 2, 6, 'RUS', '64 Arial', C_HEADER, 'top-center', 1, C.ABS_BLACK )
        Draw.SimpleText( w - 2, 6 + 48, #player.GetHumans()..'/'..game.MaxPlayers(), '18 Arial', C.ABS_WHITE, 'top-right', 1, C.ABS_BLACK )
    end )
    panel:Center()

    local players = GUI.DrawScrollPanel( panel, panel:GetWide(), panel:GetTall() - 72, 0, 72, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C_BACK )
        Draw.Box( w, 4, 0, 0, C.AMBI )
        Draw.Box( w, 4, 0, h - 4, C.AMBI )
        Draw.Box( 4, h, 0, 0, C.AMBI )
        Draw.Box( 4, h, w - 4, 0, C.AMBI )
    end )

    for i, ply in ipairs( player.GetAll() ) do
        local panel = GUI.DrawButton( players, players:GetWide() - 8, 42, 4, 42 * ( i - 1 ) + 4, nil, nil, nil, function()
            if ply:IsBot() then return end

            gui.OpenURL( 'https://steamcommunity.com/profiles/'..ply:SteamID64() )
        end, function( self, w, h ) 
            if not IsValid( ply ) then self:Remove() return end

            Draw.Box( w, 2, 0, h - 2, C.AMBI )
            Draw.Box( 2, h, 40, 0, C.AMBI )
            Draw.SimpleText( 46, 2, '['..ply:EntIndex()..'] '..ply:Name(), '20 Ambi', C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )

            if ply:IsBot() then
                Draw.Box( 40, 40, 0, 0, C.ABS_BLACK )
                Draw.SimpleText( 4, h / 2, '( ͡° ͜ʖ ͡°)', '16 Ambi', C.ABS_WHITE, 'center-left', 1, C.ABS_BLACK )
            else
                Draw.SimpleText( w - 16, h / 2, ply:Ping(), '20 Ambi', C.ABS_WHITE, 'center-right', 1, C.ABS_BLACK )
            end
        end )

        if ply:IsBot() then continue end

        local sid = ply:SteamID()
        panel.DoRightClick = function() 
            chat.AddText( C.ABS_WHITE, sid )
            SetClipboardText( sid ) 
        end

        local avatar = GUI.DrawAvatar( panel, 40, 40, 0, 0, 40  , ply )

        local gag = GUI.DrawButton( panel, 50, 24, panel:GetWide() - 50 - 40, 10, nil, nil, nil, function()
            if ply:IsMuted() then
                ply:SetMuted( false )
            else
                ply:SetMuted( true )
            end
        end, function( self, w, h ) 
            if not IsValid( ply ) then self:Remove() end

            Draw.Box( w, h, 0, 0, Color( 0, 0, 0, 100 ) )
            Draw.SimpleText( w / 2, h / 2, ply:IsMuted() and 'UnGag' or 'Gag', '16 Ambi', C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
        end )
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