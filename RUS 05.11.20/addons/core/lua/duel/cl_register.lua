AmbDuel = AmbDuel or {}

local w = ScrW()
local h = ScrH()

local adversary = Entity( 1 )
local award = 16
local health = 32
local armor = 64
local gun = 'gmod_tool'

local function CollectInfo()

    net.Start( 'amb_duel' )
        net.WriteEntity( adversary )
        net.WriteUInt( award, 22 )
        net.WriteUInt( health, 22 )
        net.WriteUInt( armor, 22 )
        net.WriteString( gun )
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

    if ( adversary == LocalPlayer() ) or ( adversary:IsPlayer() == false ) then return false end
    if ( award < AmbDuel.min_award ) or ( award > AmbDuel.max_award ) then chat.AddText('2') return false end
    if ( armor < 0 ) or ( armor > 255 ) then return false end
    if ( health < 0 ) or ( health > AmbDuel.max_health ) then return false end

    return true

end

function AmbDuel.OpenRegister()

    if ( tonumber( LocalPlayer():GetNWInt( 'amb_players_level' ) ) < AmbDuel.min_level ) then chat.AddText( AMB_COLOR_RED, '[•] ', AMB_COLOR_WHITE, 'Вам необходим '..AmbDuel.min_level..' Уровень!' ) return end

    local frame = vgui.Create( 'DFrame' )
    frame:SetSize( 460, 400 )
    frame:Center()
    frame:MakePopup()
    frame:SetTitle( '' )
    frame.Paint = function( self, w, h )

        draw.RoundedBox( 4, 0, 0, w, h, AMB_COLOR_AMBITION )
        draw.RoundedBox( 4, 4, 4, w - 8, h - 8, AMB_COLOR_SMALL_BLACK )

        draw.SimpleText( '[ 0 > HP > '..AmbDuel.max_health..' ]', 'ambFont18', w / 2, 46 * 3.2, AMB_COLOR_ERROR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        draw.SimpleText( '[ Armor > 255 ]', 'ambFont18', w / 2, 46 * 3.8, AMB_COLOR_ERROR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

        draw.SimpleText( 'HP', 'ambFont22', 22, 46 * 4.5, AMB_COLOR_ERROR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        draw.SimpleText( 'Armor', 'ambFont22', 12, 46 * 5.5, AMB_COLOR_BLUE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        draw.SimpleText( '$', 'ambFont22', 28, 46 * 6.5, AMB_COLOR_GREEN, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    
    end

    local combo_adversary = vgui.Create( 'DComboBox', frame )
    combo_adversary:SetSize( 320, 44 )
    combo_adversary:SetPos( frame:GetWide() / 2 - combo_adversary:GetWide() / 2, 46 )
    combo_adversary:SetFont( 'ambFont22' )
    combo_adversary:SetValue( 'Choose the adversary' )
    combo_adversary.OnSelect = function( self, index, value )

        adversary = FindName( value )

    end
    for _, ply in pairs( player.GetHumans() ) do
        
        if ( tonumber( ply:GetNWInt( 'amb_players_level' ) ) > AmbDuel.min_level ) and ( ply ~= LocalPlayer() ) then
        
            combo_adversary:AddChoice( ply:GetNWString( 'amb_players_name' ) )

        end

    end

    local combo_gun = vgui.Create( 'DComboBox', frame )
    combo_gun:SetSize( 320, 44 )
    combo_gun:SetPos( frame:GetWide() / 2 - combo_gun:GetWide() / 2, 46 * 2 )
    combo_gun:SetFont( 'ambFont22' )
    combo_gun:SetValue( 'Choose a weapon' )
    combo_gun.OnSelect = function( self, index, value )

	    gun = value

    end
    for _, weapon in pairs( AmbDuel.access_guns ) do
        
        combo_gun:AddChoice( weapon )

    end

    local te_health = vgui.Create( 'DTextEntry', frame )
    te_health:SetSize( 320, 44 )
    te_health:SetPos( frame:GetWide() / 2 - te_health:GetWide() / 2, 46 * 4 )
    te_health:SetFont( 'ambFont22' )
    te_health:SetValue( '' )
    te_health:SetNumeric( true )
    te_health.OnChange = function( self )

        health = tonumber( te_health:GetValue() )

    end

    local te_armor = vgui.Create( 'DTextEntry', frame )
    te_armor:SetSize( 320, 44 )
    te_armor:SetPos( frame:GetWide() / 2 - te_health:GetWide() / 2, 46 * 5 )
    te_armor:SetFont( 'ambFont22' )
    te_armor:SetValue( '' )
    te_armor:SetNumeric( true )
    te_armor.OnChange = function( self )

        armor = tonumber( self:GetValue() )

    end

    local te_award = vgui.Create( 'DTextEntry', frame )
    te_award:SetSize( 320, 44 )
    te_award:SetPos( frame:GetWide() / 2 - te_health:GetWide() / 2, 46 * 6 )
    te_award:SetFont( 'ambFont22' )
    te_award:SetValue( '' )
    te_award:SetNumeric( true )
    te_award.OnChange = function( self )

        award = tonumber( self:GetValue() )

    end

    local send = vgui.Create( 'DButton', frame )
    send:SetSize( 320, 44 )
    send:SetPos( frame:GetWide() / 2 - te_health:GetWide() / 2, 46 * 7.2 )
    send:SetFont( 'ambFont22' )
    send:SetTextColor( AMB_COLOR_WHITE )
    send:SetText( 'Go Duel' )
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
concommand.Add( 'amb_duel', AmbDuel.OpenRegister )