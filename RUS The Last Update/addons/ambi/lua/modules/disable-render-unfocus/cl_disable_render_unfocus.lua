local C, GUI, Draw, UI, Lang = Ambi.Packages.Out( '@d, language' )
local Render = UI.Render
local W, H = ScrW(), ScrH()
local HasFocus = system.HasFocus
local convar = CreateClientConVar( 'ambi_disable_render_unfocus', 1, true )

-- --------------------------------------------------------------------------------------------------------------------------------------------
Lang.SimpleAdd( 'disable_render_unfocus_text', 'Во избежаний нагрузки на видеокарту - Рендер отключен!', 'To avoid the heavy load, the server is turned off!' )
local font = UI.SimpleAddFont( 'Arial', 'Arial', 'Usual', 32 )

-- --------------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'HUDPaint', 'Ambi.DisableRenderUnfocused', function()
    if not convar:GetBool() then return end

    if HasFocus() then
        if ( Render.IsEnabled() == false ) then Render.Enable() end
    else
        Render.Disable()

        Draw.Box( W, H, 0, 0, C.ABS_BLACK )
        Draw.SimpleText( W / 2, H / 2, Lang.Get( 'disable_render_unfocus_text' ), font, C.ABS_WHITE, 'center' )
    end
end )