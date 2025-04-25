-- TODO: Rewrite
local C, GUI, Draw = Ambi.General.Global.Colors, Ambi.UI.GUI, Ambi.UI.Draw
local HUD = Ambi.Base.HUD

local W, H = ScrW(), ScrH()

HUD.Add( 1, 'Official Ambition HUD', 'Ambi', function()
    Draw.Text( W / 2, H / 2, 'HUD IS \nBROKEN', '42 Ambi', C.ERROR, 'center', 1, C.ABS_BLACK )
    Draw.Text( W / 2, H / 2 + 100, 'ambi_hud_'..Ambi.Config.prefix..' 2', '28 Ambi', C.FLAT_GREEN, 'center', 1, C.ABS_BLACK )
end )
