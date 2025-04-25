local w = ScrW()
local h = ScrH()

local speakers = {}
for i = 1, 12 do speakers[ i ] = false end

local function GetLastFreeIndex()

    for i, v in ipairs( speakers ) do

        if not v then return i end

    end

end

local avatars = {}
local function DrawChebupelya( ePly, nOffsetY )

    if not ePly or not IsValid( ePly ) then return end
    
    local index = GetLastFreeIndex()
    speakers[ index ] = ePly

    surface.SetFont( '40 Ambition' )
    local name_x, _ = surface.GetTextSize( ePly:GetNWString( 'amb_players_name' ) )

    local ava = vgui.Create( 'AvatarImage' )
	ava:SetSize( 32, 32 )
	ava:SetPos( w - 32 - name_x - 22, h - 36 - ( 40 * index - 1 ) )
	ava:SetPlayer( ePly, 32 )
    avatars[ ePly ] = ava

    hook.Add( 'HUDPaint', 'AmbVoiceHUD:'..tostring( ePly ), function() 
    
        draw.SimpleTextOutlined( ePly:GetNWString( 'amb_players_name' ), '40 Ambition', w - 16, h - ( 40 * index - 1 ), AMB_COLOR_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, AMB_COLOR_BLACK )

    end )

end

local function RemoveChebupelya( ePly )

    hook.Remove( 'HUDPaint', 'AmbVoiceHUD:'..tostring( ePly ) )
    avatars[ ePly ]:Remove()
    for i, v in ipairs( speakers ) do

        if ( v == ePly ) then speakers[ i ] = false end

    end
    
end

hook.Add( 'PlayerStartVoice', 'AmbCustomVoice', function( ePly ) 

    DrawChebupelya( ePly )
    
end )
hook.Add( 'PlayerEndVoice', 'AmbCustomVoice', function( ePly ) RemoveChebupelya( ePly ) end )

local PANEL1 = {}
function PANEL1:Init()

	self:Remove()

end

function PANEL1:Setup( ply )


end

function PANEL1:Paint( w, h )

end

function PANEL1:Think()
	


end

function PANEL1:FadeOut( anim, delta, data )
	


end
derma.DefineControl( "VoiceNotify", "", PANEL1, "DPanel" )