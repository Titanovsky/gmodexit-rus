local Notify = Ambi.UI.Notify
local C, GUI, UT = Ambi.General.Global.Colors, Ambi.UI.GUI, Ambi.General.Utility

local w = ScrW()
local h = ScrH()

local now_notify = {}
for i = 1, 20 do now_notify[ i ] = false end
local chars = {
    [ 0 ] = '❖',
    [ 1 ] = '☓',
    [ 2 ] = '✓',
    [ 3 ] = '✪',
    [ 4 ] = 'ⓘ',
    [ 5 ] = '➜',
    [ 6 ] = '➞',
    [ 7 ] = '➤',
    [ 8 ] = '☠',
    [ 9 ] = '☢',
    [ 10 ] = '☣',
    [ 11 ] = '☯',
    [ 12 ] = '✞',
    [ 13 ] = '✠',
    [ 14 ] = '✭',
    [ 15 ] = '✧',
    [ 16 ] = '$'
}

local function GetLastFreePos()
    for i, v in ipairs( now_notify ) do
        if not v then return i end
    end
end

local COLOR_PANEL = Color( 20, 20, 20, 200 )

Notify.Add( 4, 'Official Capture Of Terra Notify', 'Ambi', function( tVars )
    local id            = GetLastFreePos()
    local type          = tVars.type or 0
    local time          = tVars.time or 1
    local text          = tVars.text or ''
    local color         = tVars.color or C.ABS_WHITE
    local textcolor     = tVars.color_text or C.ABS_WHITE
    local sound         = tVars.sound
    local textw         = UT.GetTextSizeX( text, '20 Ambi' )

    if sound then AMB.UI.Sound.Play( sound ) end
    Notify.AddLog( text )
    
    if id then
        now_notify[ id ] = true

        local y = ( h / 2 ) + 32 - ( 32 + 4 ) * ( id - 3 )

        local notify = GUI.DrawPanel( nil, 12 + textw, 32, w + 28, y, function( self, w, h ) 
            draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )

            draw.RoundedBoxEx( 6, 0, 0, w, 2, color, true, true ) -- top
            draw.RoundedBoxEx( 0, 0, 2, 2, h, color ) -- right
            draw.RoundedBoxEx( 0, w - 2, 2, 2, h, color ) -- left
            draw.RoundedBoxEx( 6, 0, h - 2, w, 2, color, false, false, true, true ) -- bottom

            draw.SimpleTextOutlined( text, '20 Ambition', w - 6, h / 2, textcolor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
        end )

        local icon = GUI.DrawPanel( nil, 28, 32, w, y, function( self, w, h )
            draw.RoundedBox( 6, 0, 0, w, h, C.AMB_PANEL )

            draw.RoundedBox( 6, 0, 0, w, 2, color, true, true, true, true ) -- top
            draw.RoundedBox( 6, 0, 2, 2, h, color, false, true ) -- right
            draw.RoundedBox( 6, w - 2, 2, 2, h, color, true ) -- left
            draw.RoundedBox( 6, 0, h - 2, w, 2, color, true, true, true, true ) -- bottom

            draw.SimpleTextOutlined( chars[ type ], '26 Ambition', w / 2 - 1, h / 2, textcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
        end )

        icon:MoveTo( w - 12 - textw - 4 - 28 - 3, y, 0.76, 0, -1, function() end )
        notify:MoveTo( w - 12 - textw - 4, y, 0.76, 0, -1, function() 
            timer.Simple( time, function() 
                if notify then 
                    notify:MoveTo( w + 28, y, 0.76, 0, -1, function() notify:Remove() end ) 
                end

                if icon then 
                    icon:MoveTo( w, y, 0.76, 0, -1, function() icon:Remove() end ) 
                end

                if id then now_notify[ id ] = false end
            end )
        end )
    end
end )