local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local W, H = ScrW(), ScrH()

function Ambi.Rus.ShowAuthorizationMenu()
    local frame = GUI.DrawFrame( nil, W, H, 0, 0, '', true, false, false, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C.AMBI_WHITE )
        Draw.SimpleText( w / 2, 6, 'RUS', UI.SafeFont( '72 Ambi Bold' ), C.AMBI_RED, 'top-center' )

        Draw.SimpleText( 24, 120, '• Самое главное --> никому не мешай!', UI.SafeFont( '38 Ambi' ), C.AMBI_RED, 'top-left' )
        Draw.SimpleText( 24, 120 + 40 * 1, '• Строй и Убивай других через /build и /pvp', UI.SafeFont( '38 Ambi' ), C.AMBI_RED, 'top-left' )
        Draw.SimpleText( 24, 120 + 40 * 2, '• Заработать уровень просто - всего лишь играй', UI.SafeFont( '38 Ambi' ), C.AMBI_RED, 'top-left' )
        Draw.SimpleText( 24, 120 + 40 * 3, '• Все подробности в /discord', UI.SafeFont( '38 Ambi' ), C.AMBI_RED, 'top-left' )
    end )

    local info = GUI.DrawButton( frame, frame:GetWide() / 4, 80, frame:GetWide() / 2 - ( frame:GetWide() / 4 ) / 2, frame:GetTall() - 124 - 16, nil, nil, nil, function( self )
        self:Remove()
        
        frame:AlphaTo( 0, 1.2, 0, function() 
            frame:Remove()
        end )

        net.Start( 'ambi_rus_auth' )
        net.SendToServer()
    end, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C.AMBI_RED, 4 )
        Draw.SimpleText( w / 2, h / 2, 'Играть', UI.SafeFont( '64 Ambi' ), C.AMBI_WHITE, 'center', 1, C.ABS_BLACK )
    end )
end

hook.Add( 'InitPostEntity', 'Ambi.Rus.Auth', Ambi.Rus.ShowAuthorizationMenu )