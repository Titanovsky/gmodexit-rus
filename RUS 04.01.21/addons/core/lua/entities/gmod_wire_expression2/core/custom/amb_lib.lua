local VERY_EASY = 64
local EASY = 128
local MEDIUM = 512
local HARD = 1024
local VERY_HARD = 2048
local TERRIBLE = 8192


__e2setcost( VERY_EASY )
e2function void entity:ambPosUp( number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end

    this:SetPos( this:GetPos() + Vector( 0, 0, units ) )
end

e2function void entity:ambPosDown( number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end

    this:SetPos( this:GetPos() + Vector( 0, 0, -units ) )
end

e2function void entity:ambPosFront( number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end

    this:SetPos( this:GetPos() + Vector( 0, -units, 0 ) )
end

e2function void entity:ambPosBehind( number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end

    this:SetPos( this:GetPos() + Vector( 0, units, 0 ) )
end

e2function void entity:ambPosRight( number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end

    this:SetPos( this:GetPos() + Vector( -units, 0, 0 ) )
end

e2function void entity:ambPosLeft( number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end

    this:SetPos( this:GetPos() + Vector( units, 0, 0 ) )
end




e2function void entity:ambPrintColor1x1( vector color, string text )
	if !E2Access( 2, self.player ) then return end
    if !this:IsPlayer() then return end
	if !IsValid( this ) then return end
    color = Color( color[1], color[2], color[3] )
    AmbLib.chatSend( this, color, text )
end
e2function void entity:ambPrintColor2x2( vector color, string text, vector color2, string text2 )
	if !E2Access( 2, self.player ) then return end
    if !this:IsPlayer() then return end
	if !IsValid( this ) then return end
    color = Color( color[1], color[2], color[3] )
    color2 = Color( color2[1], color2[2], color2[3] )
    AmbLib.chatSend( this, color, text, color2, text2 )
end
e2function void entity:ambPrintColor4x4( vector color, string text, vector color2, string text2, vector color3, string text3, vector color4, string text4 )
	if !E2Access( 2, self.player ) then return end
    if !this:IsPlayer() then return end
	if !IsValid( this ) then return end
    color = Color( color[1], color[2], color[3] )
    color2 = Color( color2[1], color2[2], color2[3] )
    color3 = Color( color3[1], color3[2], color3[3] )
    color4 = Color( color4[1], color4[2], color4[3] )
    AmbLib.chatSend( this, color, text, color2, text2, color3, text3, color4, text4 )
end
e2function void entity:ambPrintColor8x8( vector color, string text, vector color2, string text2, vector color3, string text3, vector color4, string text4, vector color5, string text5, vector color6, string text6, vector color7, string text7, vector color8, string text8 )
	if !E2Access( 2, self.player ) then return end
    if !this:IsPlayer() then return end
	if !IsValid( this ) then return end
    color = Color( color[1], color[2], color[3] )
    color2 = Color( color2[1], color2[2], color2[3] )
    color3 = Color( color3[1], color3[2], color3[3] )
    color4 = Color( color4[1], color4[2], color4[3] )
    color5 = Color( color5[1], color5[2], color5[3] )
    color6 = Color( color6[1], color6[2], color6[3] )
    color7 = Color( color7[1], color7[2], color7[3] )
    color8 = Color( color8[1], color8[2], color8[3] )
    AmbLib.chatSend( this, color, text, color2, text2, color3, text3, color4, text4, color5, text5, color6, text6, color7, text7, color8, text8 )
end


e2function void entity:ambPropFreeze( number freeze )
	if !E2Access( 3, self.player ) then return end
	if !IsValid( this ) then return end

    local phys = this:GetPhysicsObject()
    if IsValid( phys ) then if freeze == 1 then phys:EnableMotion( false ) else phys:EnableMotion( true ) end end
end



e2function void entity:ambDoorOpen()
	if !E2Access( 4, self.player ) then return end
	if !IsValid( this ) then return end
    if this:GetClass() ~= 'prop_door_rotating' then return end

    this:Fire( 'open', '1' )
end

e2function void entity:ambDoorClose()
	if !E2Access( 4, self.player ) then return end
	if !IsValid( this ) then return end
    if this:GetClass() ~= 'prop_door_rotating' then return end

    this:Fire( 'close', '1' )
end

e2function void entity:ambDoorLock()
	if !E2Access( 4, self.player ) then return end
	if !IsValid( this ) then return end
    if this:GetClass() ~= 'prop_door_rotating' then return end

    this:Fire( 'lock', '1' )
end

e2function void entity:ambDoorUnlock()
	if !E2Access( 4, self.player ) then return end
	if !IsValid( this ) then return end
    if this:GetClass() ~= 'prop_door_rotating' then return end

    this:Fire( 'unlock', '1' )
end


-- фукнциональщина
e2function void ambPosUp( entity ent, number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( ent ) then return end

    ent:SetPos( ent:GetPos() + Vector( 0, 0, units ) )
end
e2function void ambPosDown( entity ent, number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( ent ) then return end

    ent:SetPos( ent:GetPos() + Vector( 0, 0, -units ) )
end
e2function void ambPosFront( entity ent, number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( ent ) then return end

    ent:SetPos( ent:GetPos() + Vector( 0, -units, 0 ) )
end
e2function void ambPosBehind( entity ent, number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( ent ) then return end

    ent:SetPos( ent:GetPos() + Vector( 0, units, 0 ) )
end
e2function void ambPosRight( entity ent, number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( ent ) then return end

    ent:SetPos( ent:GetPos() + Vector( -units, 0, 0 ) )
end
e2function void ambPosLeft( entity ent, number units )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( ent ) then return end

    ent:SetPos( ent:GetPos() + Vector( units, 0, 0 ) )
end


e2function array ambPairsEntity( string class )
	if !E2Access( 2, self.player ) then return end
    local entities = {}
    local i = 0

    for k, v in pairs( ents.FindByClass( class ) ) do
        i = i + 1
        entities[i] = v
    end


    return entities
end

-- ## AmbStats ###############################

__e2setcost( EASY )
e2function number entity:ambGetMoney()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    return AmbStats.Players.getStats( this, '$' )
end

e2function number entity:ambGetLevel()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    return AmbStats.Players.getStats( this, '!' )
end

-- Teams

e2function number entity:ambIsPVP()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    if this:Team() == AMB_TEAM_PVP then
        return 1
    else
        return 0
    end
end

e2function number entity:ambIsBuilder()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    if this:Team() == AMB_TEAM_BUILD then
        return 1
    else
        return 0
    end
end

e2function number entity:ambIsRolePlayer()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    if this:Team() == AMB_TEAM_RP then
        return 1
    else
        return 0
    end
end

e2function number entity:ambIsCitizen()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    if this:Team() == AMB_TEAM_CITIZEN then
        return 1
    else
        return 0
    end
end

--

-- RP

e2function number entity:ambGetAge()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    return tonumber( this:GetNWFloat('amb_players_age') )
end

e2function string entity:ambGetNation()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    return this:GetNWString('amb_players_nation') 
end

e2function string entity:ambGetSkin()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    return this:GetNWString('amb_players_skin')
end

e2function number entity:ambGetName()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    return this:GetNWString('amb_players_name')
end

--

e2function number entity:ambGetExp()
	if !E2Access( 1, self.player ) then return end
	if !IsValid( this ) then return end
    if !this:IsPlayer() then return end

    return AmbStats.Players.getStats( this, 'exp' )
end
-- фукнциональщина
e2function number ambGetMoney( entity receiver )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( receiver ) then return end
    if !receiver:IsPlayer() then return end

    return AmbStats.Players.getStats( receiver, '$' )
end
e2function number ambGetLevel( entity receiver )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( receiver ) then return end
    if !receiver:IsPlayer() then return end

    return AmbStats.Players.getStats( receiver, '!' )
end
e2function number ambGetExp( entity receiver )
	if !E2Access( 1, self.player ) then return end
	if !IsValid( receiver ) then return end
    if !receiver:IsPlayer() then return end

    return AmbStats.Players.getStats( receiver, 'exp' )
end
-- фукнциональщина




e2function number entity:ambSendMoney( number count )
	if !E2Access( 2, self.player ) then return 0 end
	if !IsValid( this ) then return 0 end
    if !this:IsPlayer() then return 0 end
    if ( count <= 0 ) then return 0 end
    if ( AmbStats.Players.getStats( self.player, '$' ) < count ) then return 0 end
    count = math.Round( count )

    AmbStats.Players.addStats( self.player, '$', -count )
    AmbStats.Players.addStats( this, '$', count )
    return 1
end

-- фукнциональщина
e2function number ambSendMoney( entity receiver, number count )
	if !E2Access( 2, self.player ) then return 0 end
	if !IsValid( receiver ) then return 0 end
    if !receiver:IsPlayer() then return 0 end
    count = math.Round( count )
    if ( tonumber( count ) <= 0 ) then return 0 end
    if ( AmbStats.Players.getStats( self.player, '$' ) < count ) then return 0 end

    AmbStats.Players.addStats( self.player, '$', -count )
    AmbStats.Players.addStats( receiver, '$', count )
    return 1
end
-- фукнциональщина

e2function number entity:ambHasAuthorized()
	if !E2Access( 2, self.player ) then return 0 end
	if !IsValid( this ) then return 0 end
    if !this:IsPlayer() then return 0 end

    if #AmbStats.Players.getStats( this, 'name' ) > 0 then
        return 1
    else
        return 0
    end
end
-- фукнциональщина
e2function number ambHasAuthorized( entity receiver )
	if !E2Access( 2, self.player ) then return 0 end
	if !IsValid( receiver ) then return 0 end
    if !receiver:IsPlayer() then return 0 end

    if ( #AmbStats.Players.getStats( receiver, 'name' ) > 0 ) then
        return 1
    else
        return 0
    end
end
-- фукнциональщина

local extras_names = {

    'Dip',
    'Mingus',
    'Dipus',
    'Mandarinus',
    'Jingles',
    'Pringles',
    'Bibus',
    'Movitus',
    'Couitus',
    'Satanus',
    'Barbituratus',
    'Narkomanus',
    'Devalvasus',
    'Cvidus',
    'Machinus',
    'Bitus',
    'Ficus',
    'Vaginus',
    'Titanus',
    'Chlenix',
    'Yebanus',
    'Marcipanus',
    'Anus',
    'Popus',
    'Africanus',
    'Elduza',
    'Snus',
    'Bibonus',
    'Doldobus',
    'Xui',
    'ДАЙ ПОСРАТЬ'

}

e2function string ambExtraRandom()
	
    return 'Extra '..table.Random( extras_names )

end

e2function void entity:ambKill()

	if not E2Access( 3, self.player ) then return end
	if not IsValid( this ) then return end
    if not this:IsPlayer() then return end

    if this:Alive() then 

        this:Kill() 
        this:ChatPrint( 'Вас убил: '..tostring( self.player ) )

    end

end

e2function string entity:ambIPAdress()

	if not E2Access( 6, self.player ) then return end
	if not IsValid( this ) then return end
    if not this:IsPlayer() then return end

    return this:IPAddress()

end

-- ###########################################

