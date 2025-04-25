AmbEvents.Effects = {}

local w = ScrW()
local h = ScrH()

function AmbEvents.Effects.colorized( flag, color )

    local color = color:ToTable()

    if flag == 1 then
        chat.AddText('Эффект пришёл.')
        hook.Add( 'RenderScreenspaceEffects', 'amb_effects_1', function()
            DrawColorModify( {
                ["$pp_colour_addr"] = color[1],
                ["$pp_colour_addg"] = color[2],
                ["$pp_colour_addb"] = color[3],
                ["$pp_colour_brightness"] = 0,
                ["$pp_colour_contrast"] = 1,
	            ["$pp_colour_colour"] = 1,
            } )
        end )
    else
        hook.Remove('RenderScreenspaceEffects', 'amb_effects_1' )
        chat.AddText('Эффект ушёл.')
    end
end

function AmbEvents.Effects.message( flag, sText )

    if flag == 1 then
        hook.Add( 'HUDPaint', 'amb_hud_msg', function()
            draw.SimpleTextOutlined( sText, 'ambFont22', w/2, h/2 - 200, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )
        end )
    elseif flag == 2 then
        hook.Add( 'HUDPaint', 'amb_hud_msg', function()
            draw.SimpleTextOutlined( sText, 'ambFont32', w/2, h/2 - 200, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, AMB_COLOR_BLACK )
        end )
        surface.PlaySound('ambient/creatures/town_child_scream1.wav')
    else
        hook.Remove( 'HUDPaint', 'amb_hud_msg' )
    end
end

net.Receive( 'amb_events_colorized', function()

    local flag = net.ReadUInt( 2 )
    local color = net.ReadColor()

    AmbEvents.Effects.colorized( flag, color )
end )

net.Receive( 'amb_events_meteorit', function()

    util.ScreenShake( Vector(0,0,0), 32, 50, 60, 0 )
    surface.PlaySound('ambient/creatures/town_child_scream1.wav')
end )


net.Receive( 'amb_events_message', function()

    local flag = net.ReadUInt( 2 )
    local sText = net.ReadString()


    AmbEvents.Effects.message( flag, sText )
end )


function AmbEvents.openMenuMessage( flag )
    flag = tonumber( flag )

    local frame = vgui.Create( "DFrame" )
    frame:SetSize(620, 110)
    frame:SetPos( w/2 - frame:GetWide()/2, h/2 - frame:GetTall()/2 )
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton( false )
    frame.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, AMB_COLOR_AMBITION )
        draw.RoundedBox( 0, 4, 4, w-8, h-8, AMB_COLOR_SMALL_BLACK )

        draw.SimpleText( 'Напишите сообщение!', "ambFont22", frame:GetWide()/2, 32, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    local te_reason = vgui.Create( "DTextEntry", frame )
    te_reason:SetSize( frame:GetWide() - 20, 32 )
    te_reason:SetPos( 10, frame:GetTall() - te_reason:GetTall() - 10 )
    te_reason:SetValue( "" )
    te_reason:SetAllowNonAsciiCharacters(true)
    te_reason.OnEnter = function( self )
        net.Start('amb_events_message_send')
            net.WriteUInt( flag, 2 )
            net.WriteString( tostring( self:GetValue() ) )
        net.SendToServer()
        frame:Remove()
    end
end




--[[ не забыть кусок кода

local function CameraStart( camera_pos, camera_angle )

    hook.Add( 'CalcView', 'CameraStart', function( ply, pos, angles, fov )

        local view = {

            origin = camera_pos,
            angles = camera_angle,
            fov = fov,
            drawviewer = true

        }

        return view

    end )

end

local function CameraEnd()

    hook.Remove( 'CalcView', 'CameraStart' )

end

local function f2()

    CameraStart( Vector( 6692, -2865, 615 ), Angle( -2, 52, 0 ) )

    local obj = ents.CreateClientProp( 'models/xqm/jetbody3_s3.mdl' )
    obj:SetPos( Vector( 7060, -1703, 593 ) )
    obj:SetAngles( Angle( 0, 0, 3 ) )
    obj:Spawn()

    hook.Add( 'Think', 'a25', function()
    
        obj:SetPos( obj:GetPos() + Vector( 0, -5, 0 ) )
    
    end )

    timer.Simple( 2.8, function() 
    
        hook.Remove( 'Think', 'a25' ) 
        obj:Remove() 
        chat.AddText( 'frame 2' )
        surface.PlaySound( 'buttons/button14.wav' )

        CameraEnd()
        
    end )

end


local function f1()

    CameraStart( Vector( 6374, 139, 1412.663086 ), Angle( -16, 35, 0 ) )

    local obj = ents.CreateClientProp( 'models/xqm/jetbody3_s3.mdl' )
    obj:SetPos( Vector( 7099, 1355, 2144 ) )
    obj:SetAngles( Angle( 2, 0, 30 ) )
    obj:Spawn()

    hook.Add( 'Think', 'a24', function()
    
        obj:SetPos( obj:GetPos() + Vector( 0, -2, -2 ) )
    
    end )

    timer.Simple( 3, function() 
    
        hook.Remove( 'Think', 'a24' ) 
        obj:Remove() 
        chat.AddText( 'frame 1' ) 
        surface.PlaySound( 'buttons/lever5.wav' )
        CameraEnd()

        f2()

    end )

end


f1()
]]

