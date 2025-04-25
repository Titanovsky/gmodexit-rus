--[[
	Основная информация про игрока.
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[30.07.20]
		• Перенёс сюда teams.
	.
    [31.07.20]
        • Добавил конфигурацию, надеюсь сработает (godmode, should_damage, noclip).
    .
]]

local COLOR_TEXT            = Color( 240, 240, 240 )
local COLOR_RED             = Color( 242, 90, 73 )

local delay_team    = 12

local info_teams = {

    [ AMB_TEAM_PVP ] = {

        ['vec'] = {
        	Vector( -6768, -12382, 609 ),
            Vector( -6768, -12382 - 200, 609 ),
            Vector( -6768, -12382 - 200 * 2, 609 ),
            Vector( -6768, -12382 - 200 * 3, 609 ),
            Vector( -6768, -12382 - 200 * 4, 609 ),
            Vector( -6768, -12382 - 200 * 5, 609 ),
            Vector( -6768, -12382 - 200 * 6, 609 ),

            Vector( -9760, -12288, 609 ),
            Vector( -9760, -12288 - 200 * 2, 609 ),
            Vector( -9760, -12288 - 200 * 3, 609 ),
            Vector( -9760, -12288 - 200 * 4, 609 ),
            Vector( -9760, -12288 - 200 * 5, 609 ),
            Vector( -9760, -12288 - 200 * 6, 609 ),

            Vector( -9858, -14844, 1108 ),
            Vector( -6631, -14851, 1100 ),
            Vector( -6639, -11878, 1091 ),
            Vector( -9866, -11906, 1111 ),

            Vector( -8257, -13343, 924 ),
            Vector( -8269, -13143, 749 ),
            Vector( -8269, -13721, 760 ),
            Vector( -8399, -13255, 600 ),
            Vector( -8256, -13580, 760 )
        },

        ['ang'] = {
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),

            Angle(0, 0, 0),
            Angle(0, 0, 0),
            Angle(0, 0, 0),
            Angle(0, 0, 0),
            Angle(0, 0, 0),
            Angle(0, 0, 0),

            Angle(0, 45, 0),
            Angle(0, 135, 0),
            Angle(0, -135, 0),
            Angle(0, -45, 0),

            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, -90, 0),
            Angle(0, 180, 0),
            Angle(0, 0, 0),

            Angle(0, 0, 0),
            Angle(0, 90, 0),
            Angle(0, -180, 0),
            Angle(0, -90, 0),
        },

        ['on_noclip'] = false,
        ['on_godmode'] = true,
        ['on_damageplayer'] = true,
        ['walk_speed'] = 200,
        ['run_speed'] = 350,

        ['weapons'] = {
            'weapon_crowbar',
            'weapon_pistol',
            'gmod_camera'
        }
    },

    [ AMB_TEAM_BUILD ] = {

    	['vec'] = {
            Vector(-6798.920410, -8755.924805, 746.814026),
        },

        ['ang'] = {
            Angle( 0, -180, 0 ),
        },

        ['on_noclip'] = true,
        ['on_godmode'] = true,
        ['on_damageplayer'] = false,
        ['walk_speed'] = 200,
        ['run_speed'] = 350,

        ['weapons'] = {
            'weapon_physcannon',
            'weapon_physgun',
            'gmod_tool',
            'gmod_camera'
        }
    },

    [ AMB_TEAM_RP ] = {

    	['vec'] = {
            Vector( 4682, -2999, 625 ),
            Vector( 4771, -3011, 625 ),
            Vector( 4680, -3103, 625 ),
            Vector( 4759, -3109, 625 ),
            Vector( 4678, -3218, 625 ),
            Vector( 4764, -3201, 625 ),
            Vector( 4783, -3349, 625 ),
            Vector( 4684, -3338, 625 ),
            Vector( 4686, -3441, 625 ),
            Vector( 4790, -3451, 625 )
        },

        ['ang'] = {
            Angle( 0, -180, 0 ),
            Angle( 0, -180, 0 ),
            Angle( 0, -180, 0 ),
            Angle( 0, -180, 0 ),
            Angle( 0, -180, 0 ),
            Angle( 0, -180, 0 ),
            Angle( 0, -180, 0 ),
            Angle( 0, -180, 0 ),
            Angle( 0, -180, 0 ),
            Angle( 0, -180, 0 )
        },

        ['on_noclip'] = false,
        ['on_godmode'] = false,
        ['on_damageplayer'] = true,
        ['walk_speed'] = 200,
        ['run_speed'] = 350,

        ['weapons'] = {
            'weapon_physcannon',
            'weapon_physgun',
            'gmod_tool',
            'gmod_camera',
            'weapon_empty_hands'
        }
    }
}


function AmbStats.Players.changeTeam( ePly, status )

    if ( ePly:GetNWBool('amb_bad') ) then return end
    if timer.Exists('AmbTeams[Delay;ID='..ePly:SteamID()..']') then AmbLib.chatSend( ePly, COLOR_RED, "[•] ", COLOR_TEXT, "Подождите "..math.Round( timer.TimeLeft('AmbTeams[Delay;ID='..ePly:SteamID()..']'), 0)..' секунд' ) return end
    
    if info_teams[status] then

        ePly:SetTeam( status )
        ePly:Spawn()
        timer.Create('AmbTeams[Delay;ID='..ePly:SteamID()..']', delay_team, 1, function() end) -- можно ли убрать function() end?
        AmbLib.chatSend( ePly, AMB_COLOR_AMBITION, "[•] ", COLOR_TEXT, " Вы стали: "..team.GetName( ePly:Team() ) ) 

    end
end

function AmbStats.Players.loadWeapons( ePly )
    if info_teams[ ePly:Team() ] then
        ePly:StripWeapons()
        for _, guns in SortedPairs( info_teams[ ePly:Team() ]['weapons'] ) do
            ePly:Give( guns )
        end
    end
end

util.AddNetworkString('amb_teams_change')
net.Receive( 'amb_teams_change', function( len )
    local ePly = net.ReadEntity()
    local id = net.ReadUInt( 3 )

    AmbStats.Players.changeTeam( ePly, id )
end )


hook.Add( 'PlayerSpawn', 'amb_0x2024', function( ply )
    --if ( ply:GetUserGroup() == 'superadmin' ) then return end -- ПОМЕНЯТЬ НА admin_mode

    if ( ply:Team() == AMB_TEAM_CITIZEN ) then -- его нет в таблице
        timer.Simple( 0, function()
            if ply:GetNWBool('amb_bad') then ply:StripWeapons() return end
            ply:StripWeapons()
        end )
    end

    for teamID, features in pairs( info_teams ) do
        if ( ply:Team() == teamID and ply:Team() ~= AMB_TEAM_CITIZEN ) then

            local rand = math.random(1,#features.vec)
        	ply:SetPos( features['vec'][rand] )
            ply:SetEyeAngles( features['ang'][rand] )
            ply:SetRunSpeed( features['run_speed'] )
            ply:SetWalkSpeed( features['walk_speed'] )
            if info_teams[ ply:Team() ].on_godmode then
                ply:GodEnable()
            end
        end
    end

    if ( ply:Team() == AMB_TEAM_PVP ) then
        ply:SetMaterial( 'models/wireframe' )
        ply:SendLua( "timer.Create('AmbTimer[Body]"..ply:SteamID().."', 3, 1, function() end )" )
        timer.Create( 'AmbTimer[BodySave;ID'..ply:SteamID()..']', 3, 1, function()
            ply:GodDisable()
            ply:SetMaterial( '' ) -- return standart material
        end)
    end
end )

hook.Add( 'PlayerLoadout', 'amb_0x3492', function( ePly )

    AmbStats.Players.loadWeapons( ePly )
    return false
    
end )

hook.Add('PlayerNoClip', 'amb_0x666', function( ePly )
    --if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
    if ePly:Team() <= AMB_TEAM_CITIZEN then return false end
    return info_teams[ ePly:Team() ].on_noclip
end)

hook.Add( "PlayerShouldTakeDamage", "amb_0x3492", function( ply, attacker )
    if ( ply:Team() == AMB_TEAM_CITIZEN ) or ( ply:Team() == AMB_TEAM_BUILD ) then return false end
end )

hook.Add( "EntityTakeDamage", "amb_0x3492", function( ent, damage )
    if IsValid( damage:GetAttacker() ) and damage:GetAttacker():IsPlayer() then

        if damage:GetAttacker():Team() == AMB_TEAM_CITIZEN or damage:GetAttacker():Team() == AMB_TEAM_BUILD then
            damage:SetDamage(0)
        end

        if timer.Exists('AmbTimer[BodySave;ID'..damage:GetAttacker():SteamID()..']') then
            damage:SetDamage( 0 )
        end
    end
end )
