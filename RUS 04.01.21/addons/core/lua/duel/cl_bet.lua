AmbDuel = AmbDuel or {}

local w = ScrW()
local h = ScrH()

local duelist = Entity( 0 ) 
local bet = 0

local function CollectInfo()

    net.Start( 'amb_bet' )
        net.WriteEntity( duelist )
        net.WriteUInt( bet, 22 )
    net.SendToServer()

end

local function FindName( sName )

    for _, v in pairs( player.GetAll() ) do

        if ( #v:GetNWString( 'amb_players_name' ) > 1 ) then

            if ( v:GetNWString( 'amb_players_name' ) == sName ) then return v end

        end

    end

    return nil

end

local function ValidationData()

    if ( duelist == LocalPlayer() ) or ( duelist:IsPlayer() == false ) then return false end
    if ( bet <= 0 ) or ( bet > AmbDuel.max_bet ) then return false end

    return true

end

function AmbDuel.OpenBet()

    if ( AmbDuel.bet == false ) then return end
    if LocalPlayer():GetNWBool( 'Duel' ) then return end

    local frame = vgui.Create( 'DFrame' )
    frame:SetSize( 460, 400 )
    frame:Center()
    frame:MakePopup()
    frame:SetTitle( '' )
    frame.Paint = function( self, w, h )

        draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_AMBITION )
        draw.RoundedBox( 4, 4, 4, w - 8, h - 8, AMB_COLOR_SMALL_BLACK )

        draw.SimpleText( 'Max bet: '..tostring( AmbDuel.max_bet )..' BE', 'ambFont32', w/2, 34, AMB_COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
    
    end

    local combo_duelist = vgui.Create( 'DComboBox', frame )
    combo_duelist:SetSize( 320, 44 )
    combo_duelist:SetPos( frame:GetWide() / 2 - combo_duelist:GetWide() / 2, 84 )
    combo_duelist:SetFont( 'ambFont22' )
    combo_duelist:SetValue( 'Choose the duelist' )
    combo_duelist.OnSelect = function( self, index, value )

        duelist = FindName( value )

    end
    for _, ply in pairs( player.GetHumans() ) do
        
        if ply:GetNWBool( 'Duel' ) then
        
            combo_duelist:AddChoice( ply:GetNWString( 'amb_players_name' ) )

        end

    end

    local te_bet = vgui.Create( 'DTextEntry', frame )
    te_bet:SetSize( 320, 44 )
    te_bet:SetPos( frame:GetWide() / 2 - te_bet:GetWide() / 2, 84 * 2 )
    te_bet:SetFont( 'ambFont22' )
    te_bet:SetValue( '' )
    te_bet:SetNumeric( true )
    te_bet.OnChange = function( self )

        bet = tonumber( te_bet:GetValue() )

    end

    local send = vgui.Create( 'DButton', frame )
    send:SetSize( 320, 44 )
    send:SetPos( frame:GetWide() / 2 - te_bet:GetWide() / 2, 84 * 4 )
    send:SetFont( 'ambFont22' )
    send:SetTextColor( AMB_COLOR_WHITE )
    send:SetText( 'To Bet' )
    send.Paint = function( self, w, h )

        draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_AMBITION )
        draw.RoundedBox( 4, 2, 2, w - 4, h - 4, AMB_COLOR_SMALL_BLACK )
    
    end
    send.DoClick = function( self )

        frame:Remove()

        if ValidationData() then

            return CollectInfo()

        end

    end

end
concommand.Add( 'amb_duel_bet', AmbDuel.OpenBet )
