--[[
	Менюшка у NPC работодателя, зачем, хз =/
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[31.07.20]
		• The first blood!
	.
]]

local COLOR_MAIN    = Color( 0, 0, 0, 245 )
local COLOR_BOX_PLY = Color( 5, 5, 5, 150)

function AmbTeams_openMenu()

    job_frames = vgui.Create( "DFrame" )
    job_frames:SetTitle( "" )
    job_frames:SetSize( 520, 600 )
    job_frames:Center()
    job_frames:MakePopup()
    job_frames:SetDraggable( false )
    job_frames.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, COLOR_MAIN )
    end

    local panellist = vgui.Create( "DScrollPanel", job_frames )
    panellist:Dock( FILL )

    for k, v in pairs( team.GetAllTeams() ) do
        if ( k == 1 ) or ( k == 2 ) or ( k == 3 ) or ( k == 4 ) then

            local panel_job = panellist:Add( "DPanel" )
            panel_job:Dock( TOP )
            panel_job:DockMargin( 0, 0, 0, 5 )
            panel_job:SetSize( 0, 80 )
            panel_job.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, COLOR_BOX_PLY )

                --draw.SimpleText( v.name, "Trebuchet24", 105, 20, Color(255, 255,0), 0, 1 )
            end

            local mdl_job = vgui.Create( "ModelImage", panel_job )
            mdl_job:SetPos( 2, 0 )
            mdl_job:SetSize( 80, 80 )
            mdl_job:SetModel( 'models/Lamarr.mdl' )

            local button = vgui.Create( "DButton", panel_job )
            button:SetSize( 220, 30 )
            button:SetPos( 105, 20 )
            button:SetFont("Trebuchet24")
            button:SetText( v.Name )
            button:SetTextColor( Color( 255, 255, 255 ) )
            button.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 150, 0, 0 ) )
            end

            button.DoClick = function()
                LocalPlayer():ConCommand('mode '..tostring(k))
                job_frames:Remove()
            end

            local button_icon = vgui.Create( "DButton", panel_job ) -- костылина
            button_icon:SetPos( 2, 0 )
            button_icon:SetSize( 80, 80 )
            button_icon:SetText( "" )
            button_icon.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
            end

            button_icon.DoClick = function()
                LocalPlayer():ConCommand('mode '..tostring(k))
                job_frames:Remove()
            end
        end
    end
end