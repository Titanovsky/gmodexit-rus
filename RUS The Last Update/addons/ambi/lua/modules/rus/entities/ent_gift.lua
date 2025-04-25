local RegEntity, C = Ambi.RegEntity, Ambi.General.Global.Colors
local ENT = {}

ENT.Class       = 'rus_gift'
ENT.Type	    = 'anim'

ENT.PrintName	= 'Gift'
ENT.Author		= 'RUS'
ENT.Category	= 'RUS'
ENT.Spawnable   = false

ENT.Stats = {
    type = 'Entity',
    module = 'RUS',
    date = '05.12.2021 10:16'
}

RegEntity.Register( ENT.Class, 'ents', ENT ) -- SHARED

if CLIENT then
    ENT.RenderGroup = Ambi.General.Global.Entities.RENDER

    function ENT:Initialize()
        self.OriginPos = self:GetPos()
        self.Rotate = 0
        self.RotateTime = RealTime()
    end

    function ENT:DrawTranslucent()
        self:DrawShadow( false )
        self:SetRenderOrigin(self.OriginPos + Vector(0,0,math.sin(RealTime() * 3) * 5))
        self:SetupBones()
        self:DrawModel()
        self.Rotate = (RealTime() - self.RotateTime)*90 %360
        self:SetAngles( Angle( 0, -self.Rotate, 0 ) )
    end
    
    return RegEntity.Register( ENT.Class, 'ents', ENT ) -- CLIENT
end 

function ENT:Initialize()
    RegEntity.Initialize( self, 'models/griim/christmas/present_colourable.mdl' )
    RegEntity.Physics( self, MOVETYPE_NONE, nil, nil, true, false )
    self:SetTrigger( true )
end

local SQL = Ambi.SQL
local DB = SQL.CreateTable( 'rus_gifts', 'SteamID, Gifts' )

function ENT:Use( ePly )
    if self.cant then ePly:ChatPrint( 'Подарок ещё горячий!' ) return end
    if not IsValid( ePly ) or not ePly:IsPlayer() or not ePly:Alive() then return end
    if not self.accept then self:Remove() return end
    local sid = ePly:SteamID()

    SQL.Get( DB, 'SteamID', 'SteamID', sid, function()
        local gifts = tonumber( SQL.Select( DB, 'Gifts', 'SteamID', sid ) )
    
        SQL.Update( DB, 'Gifts', gifts + 1, 'SteamID', sid )
    end, function()
        SQL.Insert( DB, 'SteamID, Gifts', '%s, %i', sid, 1 )
    end )

    local gifts = SQL.Select( DB, 'Gifts', 'SteamID', sid )
    ePly:ChatSend( C.AMBI_GREEN, '+1 Gifts ('..gifts..')' )

    self:Remove()

    for _, ply in ipairs( player.GetAll() ) do
        ply:NotifySend( Ambi.Rus.Config.notify_type, { time = 25, text = 'Подарок забрал '..ePly:Name(), color = C.AMBI, sound = 'buttons/button12.wav' } )
    end
end

RegEntity.Register( ENT.Class, 'ents', ENT ) -- SERVER

local GIFTS = {
    [ 'gm_construct' ] = {
        Vector( 707, -6, -127 ),
        Vector( -455, 726, -122 ),
        Vector( 1144, -963, -114 ),
        Vector( 1567, -263, 91 ),
        Vector( 1737, 2265, -136 ),
        Vector( -5089, 6377, -62 ),
        Vector( -4469, 5999, 451 ),
        Vector( -4470, 5247, 2521 ),
        Vector( -2769, -3310, 281 ),
        Vector( -2393, -2770, 798 ),
        Vector( -1837, -2278, 1950 ),
        Vector( -2269, -2753, 2869 ),
        Vector( -5555, -3321, 274 ),
        Vector( -5452, -2435, -119 ),
        Vector( -5220, -1106, -125 ),
        Vector( -3156, -1864, 64 ),
        Vector( -2080, -881, -482 ),
        Vector( -2202, -2001, -388 ),
        Vector( -1225, -2488, -237 ),
        Vector( 760, -1081, 172 ),
        Vector( 1450, -1178, 1338 ),
        Vector( 1342, -1592, 1163 )
    },

    [ 'gm_construct_snowy_night' ] = {
        Vector( 707, -6, -127 ),
        Vector( -455, 726, -122 ),
        Vector( 1144, -963, -114 ),
        Vector( 1567, -263, 91 ),
        Vector( 1737, 2265, -136 ),
        Vector( -5089, 6377, -62 ),
        Vector( -4469, 5999, 451 ),
        Vector( -4470, 5247, 2521 ),
        Vector( -2769, -3310, 281 ),
        Vector( -2393, -2770, 798 ),
        Vector( -1837, -2278, 1950 ),
        Vector( -2269, -2753, 2869 ),
        Vector( -5555, -3321, 274 ),
        Vector( -5452, -2435, -119 ),
        Vector( -5220, -1106, -125 ),
        Vector( -3156, -1864, 64 ),
        Vector( -2080, -881, -482 ),
        Vector( -2202, -2001, -388 ),
        Vector( -1225, -2488, -237 ),
        Vector( 760, -1081, 172 ),
        Vector( 1450, -1178, 1338 ),
        Vector( 1342, -1592, 1163 )
    },

    [ 'gm_bigcity_winter_day' ] = {
        Vector( -2060, 27, -11098 ),
        Vector( -87, -1780, -11094 ),
        Vector( 1762, -3696, -11086 ),
        Vector( 3811, -3718, -11103 ),
        Vector( 6178, -3444, -11103 ),
        Vector( 7583, -2123, -11103 ),
        Vector( 10191, -933, -11107 ),
        Vector( 10991, 1616, -11084 ),
        Vector( 10060, 3674, -11109 ),
        Vector( 10032, 5423, -11104 ),
        Vector( 11216, 6804, -11097 ),
        Vector( 11244, 6152, -10697 ),
        Vector( 12357, 4989, -10623 ),
        Vector( 12321, 11955, -11199 ),
        Vector( 9361, 13005, -10865 ),
        Vector( 7788, 9684, -10978 ),
        Vector( 7735, 9590, -10966 ),
        Vector( 4513, 12436, -10853 ),
        Vector( 3291, 13023, -11377 ),
        Vector( -884, 12479, -11103 ),
        Vector( -1491, 9791, -11087 ),
        Vector( -3473, 10150, -10796 ),
        Vector( -7157, 10386, -11093 ),
        Vector( -8810, 9269, -11089 ),
        Vector( -13161, 7899, -11095 ),
        Vector( -12108, 7749, -9169 ),
        Vector( -10202, 5349, -11094 ),
        Vector( -5231, 3586, -10626 ),
        Vector( -7879, -6983, -5712 ),
        Vector( -10867, -11745, -10201 ),
        Vector( -10221, -10919, -11098 ),
        Vector( -87, -9165, -11100 ),
        Vector( 6522, -5689, -11245 ),
    },

    [ 'gm_boreas' ] = {
        Vector( -4949, -6576, -6352 ),
        Vector( -7707, -10023, -8178 ),
        Vector( -9640, -8147, -10254 ),
        Vector( -8658, -12071, -10435 ),
        Vector( -8832, -15639, -10459 ),
        Vector( -14704, -14829, -8145 ),
        Vector( -14115, -7112, -7904 ),
        Vector( -15565, 637, -6072 ),
        Vector( -11388, 5013, -6357 ),
        Vector( -11385, 8349, -6172 ),
        Vector( -7395, 8824, -5640 ),
        Vector( -1380, 6245, -6499 ),
        Vector( -404, 5284, -5065 ),
        Vector( 946, 4410, -4682 ),
        Vector( 6286, 447, -4571 ),
        Vector( 4053, 7854, -5217 ),
        Vector( 8229, 9817, 1918 ),
        Vector( 11608, 13657, 506 ),
        Vector( 13712, 653, -2521 ),
        Vector( 8366, -4352, -5454 ),
        Vector( 1968, -14786, -6541 ),
        Vector( 878, -13960, -7963 ),
        Vector( 789, 1943, -6371 ),
        Vector( -3165, 3098, -6146 ),
        Vector( -12479, -812, -6638 ),
    },

    [ 'gm_novenka_opti' ] = {
        Vector( -93, 6399, -169 ),
        Vector( 2280, 6374, -198 ),
        Vector( 3723, 4000, -347 ),
        Vector( 9001, 6624, -352 ),
        Vector( 14781, 1240, -282 ),
        Vector( 14959, 5766, -145 ),
        Vector( 14764, 1450, 101 ),
        Vector( 14898, -7830, -211 ),
        Vector( 7033, -10848, -757 ),
        Vector( 4763, -15110, 685 ),
        Vector( -8711, -12736, -319 ),
        Vector( -10455, -3221, 33 ),
        Vector( -14020, -2054, 678 ),
        Vector( -14775, 2514, -331 ),
        Vector( -15045, 15016, -65 ),
        Vector( -5761, 15081, 686 ),
        Vector( 2490, 14486, -356 ),
        Vector( 13579, 12934, 40 ),
        Vector( 14560, 3225, -339 ),
        Vector( 11673, 3207, -358 ),
    },
}

function Ambi.Rus.SpawnGift()
    if not GIFTS[ game.GetMap() ] then return end

    local pos = table.Random( GIFTS[ game.GetMap() ] )

    local gift = ents.Create( 'rus_gift' )
    gift:SetPos( pos )

    gift.cant = true

    timer.Simple( 30, function()
        if IsValid( gift ) then gift.cant = false end
    end )

    gift:Spawn()
    gift:SetColor( ColorRand() )
    gift.accept = true
    gift:EmitSound( 'garrysmod/save_load'..math.random( 1, 4 )..'.wav', 90 )

    for _, ply in ipairs( player.GetAll() ) do
        ply:ChatSend( C.AMBI, 'Подарок появился на карте!' )
    end

    timer.Simple( 60 * 10, function()
        if not IsValid( gift ) then return end

        gift:Remove()

        for _, ply in ipairs( player.GetAll() ) do
            ply:NotifySend( Ambi.Rus.Config.notify_type, { time = 10, text = 'Подарок исчез :(', color = C.AMBI_RED } )
        end
    end )
end