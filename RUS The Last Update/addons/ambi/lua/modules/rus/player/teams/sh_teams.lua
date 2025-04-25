local C = Ambi.General.Global.Colors

RUS_TEAM_GUEST, RUS_TEAM_BUILD, RUS_TEAM_PVP, RUS_TEAM_RP = 255, 256, 257, 258

team.SetUp( 255, 'Guest', C.AMBI_GRAY )
team.SetUp( 256, 'Build', C.AMBI_GREEN )
team.SetUp( 257, 'PVP', C.AMBI_RED )
team.SetUp( 258, 'Role Play', C.AMBI_BLUE )

local PLAYER = FindMetaTable( 'Player' )

function PLAYER:IsGuest()
    return self:Team() == RUS_TEAM_GUEST
end

function PLAYER:IsBuilder()
    return self:Team() == RUS_TEAM_BUILD
end

function PLAYER:IsPVP()
    return self:Team() == RUS_TEAM_PVP
end

function PLAYER:IsRP()
    return self:Team() == RUS_TEAM_RP
end

Ambi.Rus.teams_spawns = {}
Ambi.Rus.teams_spawns[ 'gm_rus' ] = {}
Ambi.Rus.teams_spawns[ 'gm_rus' ][ RUS_TEAM_PVP ] = {
    { pos = Vector( 2635, -3667, 613 ), ang = Angle( 0, 180, 0 ) },
    { pos = Vector( 2651, -3845, 602 ), ang = Angle( 0, 180, 0 ) },
    { pos = Vector( 2669, -4121, 600 ), ang = Angle( 0, 180, 0 ) },
    { pos = Vector( 2659, -4284, 606 ), ang = Angle( 0, 180, 0 ) },
}

Ambi.Rus.teams_spawns[ 'gm_rus' ][ RUS_TEAM_RP ] = {
    { pos = Vector( 2635, -3667, 613 ), ang = Angle( 0, 180, 0 ) },
    { pos = Vector( 2651, -3845, 602 ), ang = Angle( 0, 180, 0 ) },
    { pos = Vector( 2669, -4121, 600 ), ang = Angle( 0, 180, 0 ) },
    { pos = Vector( 2659, -4284, 606 ), ang = Angle( 0, 180, 0 ) },
}

if SERVER then return end

local W, H = ScrW(), ScrH()

function Ambi.Rus.ShowPVPImmortal()
    timer.Create( 'PVPImmortal', 4, 1, function() hook.Remove( 'HUDPaint', 'Ambi.Rus.PVPShowInfoImmortal' ) end )

    hook.Add( 'HUDPaint', 'Ambi.Rus.PVPShowInfoImmortal', function() 
        if not timer.Exists( 'PVPImmortal' ) then return end

        draw.SimpleTextOutlined( 'Вы бессмертны '..math.floor( timer.TimeLeft( 'PVPImmortal' ) ), '32 Ambi', W / 2, 6, C.AMBI_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, C.AMBI_BLACK )
    end )
end