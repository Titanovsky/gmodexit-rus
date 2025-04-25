--[[
	Менюшка у NPC работодателя, зачем, хз =/
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[31.07.20]
		• The first blood!
	.
]]

local w = ScrW()
local h = ScrH()

local COLOR_MAIN    = Color( 0, 0, 0, 245 )
local COLOR_BOX_PLY = Color( 5, 5, 5, 150)

local function CalcTeam( nInt )

    if ( nInt == AMB_TEAM_CITIZEN ) then return '/citizen'
    elseif ( nInt == AMB_TEAM_PVP ) then return '/pvp'
    elseif ( nInt == AMB_TEAM_BUILD ) then return '/build'
    elseif ( nInt == AMB_TEAM_RP ) then return '/rp'
    end

end

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
        if ( k == AMB_TEAM_CITIZEN ) or ( k == AMB_TEAM_BUILD ) or ( k == AMB_TEAM_PVP ) or ( k == AMB_TEAM_RP ) then

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
                LocalPlayer():ConCommand( 'say '..CalcTeam( k ) )
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
                LocalPlayer():ConCommand('mode '..tostring(k) )
                job_frames:Remove()
            end
        end
    end
end

hook.Add( 'HUDPaint', 'AmbTeamsHUD', function() 

    if ( LocalPlayer():Team() ~= AMB_TEAM_CITIZEN ) then return end

    draw.SimpleTextOutlined( 'Чтобы начать играть, введите в чат', 'DermaLarge', w/2, 36, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, AMB_COLOR_BLACK )

    draw.SimpleTextOutlined( '/build', 'ambFont22', w/2 - 124, 46 + 32 * 1, AMB_COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, team.GetColor( AMB_TEAM_BUILD ) )
    draw.SimpleTextOutlined( '- стать Строителем', 'ambFont22', w/2 - 68, 46 + 32 * 1, AMB_COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, AMB_COLOR_BLACK )

    draw.SimpleTextOutlined( '/rp', 'ambFont22', w/2 - 100, 46 + 32 * 2, AMB_COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, team.GetColor( AMB_TEAM_RP ) )
    draw.SimpleTextOutlined( '- стать Ролевым Игроком', 'ambFont22', w/2 - 68, 46 + 32 * 2, AMB_COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, AMB_COLOR_BLACK )

    draw.SimpleTextOutlined( '/pvp', 'ambFont22', w/2 - 115, 46 + 32 * 3, AMB_COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, team.GetColor( AMB_TEAM_PVP ) )
    draw.SimpleTextOutlined( '- стать Уничтожителем', 'ambFont22', w/2 - 68, 46 + 32 * 3, AMB_COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, AMB_COLOR_BLACK )

end )