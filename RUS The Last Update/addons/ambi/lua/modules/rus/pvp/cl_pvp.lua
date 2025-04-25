local C, GUI, Draw = Ambi.Packages.Out( '@design' )
local W, H = ScrW(), ScrH()
local COLOR_PANEL = Color( 0, 0, 0, 230 )

hook.Add( 'HUDPaint', 'Ambi.Rus.PVP', function() 
    if not LocalPlayer():IsPVP() then return end

    Draw.Box( 140, 100, W - 140 - 8, H / 2 - 140 / 2, COLOR_PANEL )

    Draw.SimpleText( W - 140, H / 2 - 56, 'Frags: '..tostring( LocalPlayer().nw_AllFrags ), '20 Ambi', C.ABS_WHITE, 'center-left', 1, C.ABS_BLACK )
    Draw.SimpleText( W - 140, H / 2 - 34, 'Deaths: '..tostring( LocalPlayer().nw_AllDeaths ), '20 Ambi', C.ABS_WHITE, 'center-left', 1, C.ABS_BLACK )
    Draw.SimpleText( W - 140, H / 2 - 12, 'Domin: '..tostring( LocalPlayer().nw_AllDominaties ), '20 Ambi', C.AMBI_RED, 'center-left', 1, C.ABS_BLACK )
    Draw.SimpleText( W - 140, H / 2 + 10, 'Bots: '..tostring( LocalPlayer().nw_AllBots ), '20 Ambi', C.ABS_WHITE, 'center-left', 1, C.ABS_BLACK )
end )