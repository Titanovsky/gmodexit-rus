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
    [2] = {
        ['vec'] = {
        	Vector(1854.109131, -1693.900757, 664),
        	Vector(2903.645752, -1871.601318, 664),
        	Vector(4192.119141, -1737.624023, 664),
        	Vector(4816.536621, -1422.598022, 664),
            Vector(1901.543823, -340.699951, 664),
            Vector(4773.788086, -680.491211, 664),
            Vector(4784.430664, 217.749390, 664),
            Vector(4712.215332, 730.384460, 664),
            Vector(4193.337891, 862.127014, 664),
            Vector(3698.961182, 760.309387, 664),
            Vector(2903.160400, 832.367493, 664),
            Vector(2281.990967, 807.432312, 664),
            Vector(4899.300293, 983.258789, 1200),
            Vector(1660.782593, 963.084290, 1200),
            Vector(1659.917358, -1992.484253, 1200),
            Vector(4897.925293, -2011.896240, 1200)
        },
        ['ang'] = {
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 0, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, -90, 0),
            Angle(0, -90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0)
        },
        ['on_noclip'] = false,
        ['on_godmode'] = false,
        ['on_damageplayer'] = true,
        ['weapons'] = {
            'weapon_crowbar',
            'weapon_pistol'
        }
    }, -- PVP

    [3] = {
    	['vec'] = {
            Vector(-3107.289551, -5507.725098, 642),
            Vector(-3106.839111, -5280.454590, 642),
            Vector(-2802.479004, -5249.385254, 642),
            Vector(-2802.479004, -5507.725098, 642)
        },
        ['ang'] = {
            Angle(0, -180, 0),
            Angle(0, -180, 0),
            Angle(0, -180, 0),
            Angle(0, -180, 0)
        },
        ['on_noclip'] = true,
        ['on_godmode'] = true,
        ['on_damageplayer'] = false,
        ['weapons'] = {
            'weapon_physcannon',
            'weapon_physgun',
            'gmod_tool',
            'gmod_camera'
        }
    }, -- Build

    [4] = {
    	['vec'] = {
            Vector(7370.079102, -2473.820068, 642),
            Vector(7380.272949, -2292.303467, 642),
            Vector(6526.848145, -2517.359863, 642),
            Vector(6523.339844, -2290.140625, 642)
        },
        ['ang'] = {
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0),
            Angle(0, 90, 0)
        },
        ['on_noclip'] = false,
        ['on_godmode'] = false,
        ['on_damageplayer'] = true,
        ['weapons'] = {
            'weapon_physcannon',
            'weapon_physgun',
            'gmod_tool',
            'gmod_camera'
        }
    } -- RP
}


function AmbStats.Players.changeStatus( ePly, status )
    if timer.Exists('AmbTeams[Delay;ID='..ePly:SteamID()..']') then AmbLib.chatSend( ePly, COLOR_RED, "[•] ", COLOR_TEXT, "Подождите "..math.Round( timer.TimeLeft('AmbTeams[Delay;ID='..ePly:SteamID()..']'), 0)..' секунд' ) return end
    for k, v in pairs( team.GetAllTeams() ) do
        if ( status == k or status == v.name ) then
            ePly:SetTeam( k )
            ePly:Spawn()
            timer.Create('AmbTeams[Delay;ID='..ePly:SteamID()..']', delay_team, 1, function() end) -- можно ли убрать function() end?
            AmbLib.chatSend( ePly, COLOR_RED, "[•] ", COLOR_TEXT, " Вы стали: "..team.GetName( ePly:Team() ) ) -- todo: change color on green!
        end
    end
end

util.AddNetworkString('amb_teams_change')
net.Receive( 'amb_teams_change', function( len )
    local ePly = net.ReadEntity()
    local id = net.ReadUInt( 3 )

    AmbStats.Players.changeStatus( ePly, id )
end )


hook.Add( 'PlayerSpawn', 'amb_0x2024', function( ply )
    --if ( ply:GetUserGroup() == 'superadmin' ) then return end -- ПОМЕНЯТЬ НА admin_mode

    if ( ply:Team() == 1 ) then -- его нет в таблице
        timer.Simple( 0, function()
            if ply:GetNWBool('amb_bad') then return end
            ply:GodDisable()
            ply:GodEnable()
            ply:StripWeapons()
            ply:Give('weapon_physgun')
            ply:Give('weapon_physcannon')
            ply:Give('gmod_tool')
        end )
    end

    if ( ply:Team() == 4 ) then -- его нет в таблице
        timer.Simple( 0, function()
        end )
    end

    for teamID, v in pairs( info_teams ) do
        if ( ply:Team() == teamID and ply:Team() > 1 ) then
            local rand = math.random(1,#v.vec)
        	ply:SetPos( v['vec'][math.random(rand)] )
            ply:SetEyeAngles( v['ang'][math.random(rand)] )
            if info_teams[ ply:Team() ].on_godmode then
                ply:GodEnable()
            end
        end
    end

    if ( ply:Team() == 2 ) then
        timer.Simple( 0, function()
            ply:StripWeapons()
            ply:Give('weapon_physgun')
            ply:Give('weapon_physcannon')
            ply:Give('gmod_tool')
            ply:Give('weapon_crowbar')
        end )
        ply:SetMaterial('models/wireframe')
        ply:GodEnable()
        timer.Create( 'AmbTimer[BodySave;ID'..ply:SteamID()..']', 6, 1, function()
            --ply:ChatPrint("DA") -- debug
            ply:GodDisable()
            ply:SetMaterial('') -- return classic material
        end)
    end
end )

hook.Add( 'PlayerChangedTeam', 'amb_0x3492', function( ePly, old_Team, new_Team )
    if old_Team == 1 or old_team == 3 or new_Team == 2 or new_Team == 4 then
        if ePly:HasGodMode() then
            ePly:GodDisable()
        end
    end
end )

hook.Add( 'PlayerLoadout', 'amb_0x3492', function( ePly )
    for id, v in pairs( info_teams ) do
        if ePly:Team() == id then
            for _, wep in pairs( v.weapons ) do
                ePly:Give( wep )
            end
        end
    end
    return false
end )

hook.Add('PlayerNoClip', 'amb_0x666', function( ePly )
    --if ( ePly:GetUserGroup() == 'superadmin' ) then return true end -- ПОМЕНЯТЬ НА head_admin
    if ePly:Team() <= 1 then return false end
    return info_teams[ ePly:Team() ].on_noclip
end)

hook.Add( "PlayerShouldTakeDamage", "amb_0x3492", function( ply, attacker )
    if ( ply:Team() == 1 ) or ( ply:Team() == 3 ) then return false end
end )

hook.Add( "EntityTakeDamage", "amb_0x3492", function( ent, damage )
    if IsValid( damage:GetAttacker() ) and damage:GetAttacker():IsPlayer() then
        if damage:GetAttacker():Team() == 1 or damage:GetAttacker():Team() == 3 then
            damage:SetDamage(0)
        end
        if timer.Exists('AmbTimer[BodySave;ID'..damage:GetAttacker():SteamID()..']') then
            damage:SetDamage( 0 )
        end
    end
end )
-- Данное творение принадлежит проекту [ Ambition ]