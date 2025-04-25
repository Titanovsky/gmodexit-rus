--[[
	Organization [ Ambition ].
	— В данном случае организации для Sandbox, они динамические (не сохраняются, легко создать).
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[24.06.20]
		• Создание организации (прошлый опыт был с Teams, он неудачный, я удалил то говно);
	.
    [23.07.20]
		• К сожалению, я не вёл учёт, но сегодня работа с организациями закончена;
        • А нет, что-то вёл:
        -- 1:47:58 столько времени потратил на логику первой версий: Создание, Удаление, Выход, Приглашение, Увольнение, команды на клиенте создания и приглашения + система анти флуда, хз зачем
        -- убрал анти флуд
        -- сделать giveSkin()
	.
    [15.08.20]
        • Пофиксил баг, что не показывался invite.
    .
    [25.08.20]
        • Добавил дерьмо защиту
    .
]]

AmbOrgs = AmbOrgs or {}

local all = "all"
local org = "amb_orgs"

local COLOR_RED     = Color( 242, 90, 73 )
local COLOR_BLUE    = Color( 90, 157, 230 )
local COLOR_ERROR   = Color( 217, 33, 9 )
local COLOR_GREEN   = Color( 13, 209, 78 )
local COLOR_TEXT    = Color( 252, 252, 252 )
local COLOR_ORANGE  = Color( 235, 155, 52 )
local COLOR_GRAY    = Color( 214, 214, 214 )

local cost_for_orgs = 24

local function plyOrg( ply )
    return tonumber( ply:GetNWInt( "amb_orgs" ) )
end


if ( SERVER ) then
    AmbOrgs_func = AmbOrgs_func or {}

    --AmbOrgs_func.createOrganization( 2, "UMBRELLA", 0, "as", Color(255,255,255), "a", "a" )

    util.AddNetworkString("a_o_r_c") -- amb_orgs_replication_client

    function AmbOrgs_func.createOrganization( id, sName, pLeader, sDescription, vColor, sSkin_memb, sSkin_lead )
        if pLeader:GetNWBool('amb_bad') or pLeader:Team() == AMB_TEAM_CITIZEN or pLeader:Team() == AMB_TEAM_BUILD then
            return AmbLib.chatSend( pLeader, AMB_COLOR_RED, "[•] ", COLOR_TEXT, "Вам нельзя создать организацию" )
        end
        if id == 0 then id = 1 end
        if id < 0 then math.abs(id) end
        if id > 63 then return AmbLib.chatSend( pLeader, COLOR_RED, "[•] ", COLOR_TEXT, "ID не должен быть больше 63." ) end
        if pLeader ~= 0 then
            if tonumber( pLeader:GetNWFloat('amb_players_money') ) < cost_for_orgs then
                AmbLib.chatSend( pLeader, AMB_COLOR_RED, "[•] ", COLOR_TEXT, "У вас не хватает: "..cost_for_orgs.." BE" )
                return
            else
                AmbStats.Players.addStats( pLeader, "$", -cost_for_orgs )
            end
        end

        for k, _ in pairs( AmbOrgs ) do
            if k == id then
                return AmbLib.chatSend( pLeader, COLOR_RED, "[•] ", COLOR_TEXT, "ID Занят." ) -- fix
            end
        end

        if !util.IsValidModel( sSkin_memb ) then
            sSkin_memb = "models/player/Kleiner.mdl"
        end

        if !util.IsValidModel( sSkin_lead ) then
            sSkin_memb = "models/player/Kleiner.mdl"
        end

        AmbOrgs[ id ] = {
            name = sName,
            leader = pLeader,
            descript = sDescription,
            color = vColor,
            skin1 = sSkin_memb,
            skin2 = sSkin_lead
        }
        net.Start( "a_o_r_c" )
            net.WriteTable( AmbOrgs[id] )
            net.WriteUInt( id, 6 )
        net.Broadcast()

        print( "[AmbOrgs] Organization created: " .. id ) -- logs

        if pLeader == 0 then
            AmbOrgs[id].leader = "[Server]"
        else
            pLeader:SetNWInt( "amb_orgs", id )
            pLeader:SetNWInt( "amb_orgs_lead", id )
            pLeader:Spawn()
            AmbLib.chatSend( all, AMB_COLOR_AMBITION, "[•] ", COLOR_TEXT, "Появилась организация: ", AMB_COLOR_GRAY, sName )
        end
    end

    function AmbOrgs_func.inviteToOrganization( id, ePly )
        if ePly:GetNWBool('amb_bad') or ePly:Team() == AMB_TEAM_CITIZEN or ePly:Team() == AMB_TEAM_BUILD then
            AmbLib.chatSend( ePly, AMB_COLOR_ERROR, "[•] ", COLOR_TEXT, "Вы не можете присоединиться в организацию!" )
            return false
        end
        ePly:SetNWInt( "amb_orgs", id ) -- сделаем проверку на PVP он или Role Play
        AmbOrgs_func.setPlayer( ePly )

        for k, v in pairs( player.GetAll() ) do
            if ( plyOrg( v ) == plyOrg( ePly ) ) then
                AmbLib.chatSend( v, AMB_COLOR_AMBITION, "[•] ", AMB_COLOR_GRAY, ePly:Nick(), COLOR_TEXT, " Присоединился в организацию." )
            end
        end
    end

    function AmbOrgs_func.setPlayer( ePly )

        local id = plyOrg( ePly )

        ePly:SetPlayerColor( AmbLib.convertColorToVec( AmbOrgs[ id ].color ) )

        if ( ePly:GetNWString( "amb_orgs_lead" ) == id ) then
            ePly:SetModel( AmbOrgs[ id ].skin2 )
            if ( ePly:GetNWString( "amb_orgs_skin" ) ) then
                ePly:SetModel( ePly:GetNWString( "amb_orgs_skin" ) )
            else
                ePly:SetModel( AmbOrgs[ id ].skin1 )
            end
        else
            if ( #ePly:GetNWString( "amb_orgs_skin" ) > 0 ) then
                ePly:SetModel( ePly:GetNWString( "amb_orgs_skin" ) )
                print( ePly:GetNWString( "amb_orgs_skin" ) )
            else
                -- print( ' DA') -- debug
                ePly:SetModel( AmbOrgs[ id ].skin1 )
            end
        end
    end

    function AmbOrgs_func.uninviteFromOrganization( ePly, sReason )
        AmbLib.chatSend( ePly, "Лидер уволил тебя по причине: "..sReason )
        ePly:SetNWInt( "amb_orgs", 0 )
        ePly:Spawn()
    end

    function AmbOrgs_func.leaveFromOrganization( ePly )
        if !plyOrg( ePly ) or plyOrg( ePly ) == 0 then
            return AmbLib.chatSend( ePly, "Ты не можешь уволиться" )
        end

        for _, ply in pairs( player.GetAll() ) do
            if plyOrg( ply ) == plyOrg( ePly ) then
            	AmbLib.chatSend( ply, AMB_COLOR_ERROR, "[•] ", AMB_COLOR_GRAY, ePly:Nick(), COLOR_TEXT, " Лидер распустил организацию." )
            end
        end

        if tonumber( ePly:GetNWInt( "amb_orgs_lead" ) ) == plyOrg( ePly ) then
            local org = plyOrg( ePly )
            for _, ply in pairs( player.GetAll() ) do
                if plyOrg( ply ) == org then
                    ply:SetNWInt( "amb_orgs", 0 )
                    ply:SetNWInt( "amb_orgs_lead", 0 )
                    ply:Spawn()
                    --AmbLib.chatSend( ply, AMB_COLOR_ERROR, "[•] ", AMB_COLOR_GRAY, ePly:Nick(), COLOR_TEXT, " Лидер распустил организацию." )
                end
            end
            MsgN( "[AmbOrgs] Organization remove: "..org )
            AmbOrgs[ org ] = nil
            return
        end

        ePly:SetNWInt( "amb_orgs", 0 )
        ePly:Spawn()
    end

    function AmbOrgs_func.giveSkin( ePly, sSkin )
        AmbLib.chatSend( ePly, "Лидер выдал тебе скин" ) -- nate
        if !util.IsValidModel( sSkin ) then
            sSkin = "models/player/Kleiner.mdl"
        end
        ePly:SetNWString( "amb_orgs_skin", sSkin )
        ePly:SetModel( sSkin )
    end


    --PrintTable( AmbOrgs ) -- debdug

    -- ======================== HOOKS =======================================
    hook.Add( "PlayerSpawn", "amb_0x209", function( ePly )
        timer.Simple( 0.2, function()
            if ( plyOrg( ePly ) > 0 ) then
               AmbOrgs_func.setPlayer( ePly )
            end
        end )
    end )

    hook.Add( "PlayerDisconnected", "amb0x311", function( ePly )
        if ( ePly:GetNWString( "amb_orgs_lead" ) == plyOrg( ePly ) ) then
            AmbOrgs_func.leaveFromOrganization( ePly )
        end
    end )

    hook.Add( 'PlayerInitialSpawn', 'amb0x9090', function( ePly )
        timer.Simple( 1, function()
            --print('da') -- debug
            for k, _ in pairs( AmbOrgs ) do
                net.Start( "a_o_r_c" )
                    net.WriteTable( AmbOrgs[k] )
                    net.WriteUInt( k, 6 )
                net.Send( ePly )
            end
        end )
    end )

    -- =====================================================================

    util.AddNetworkString("a_o_c_o") -- amb_orgs_create_org
    net.Receive( "a_o_c_o", function( len, caller )
        local ply = net.ReadEntity()

        if ( IsValid( caller ) == false ) then return end -- shit-validation
        if ( caller ~= ply ) then caller:Kick('HIGHT PING (>800)') return end -- shit-validation
        if ( timer.Exists( 'AmbSecurity:a_o_c_o'..caller:SteamID() ) ) then caller:Kick( 'Hight Ping (>800)' ) return end -- shit-validation

        local args = net.ReadTable()

        timer.Create( 'AmbSecurity:a_o_c_o'..caller:SteamID(), 0.75, 1, function() end ) -- shit-validation

        if plyOrg( ply ) == 0 then
            AmbOrgs_func.createOrganization( tonumber( args[1] ), args[2], ply, "Обычная организейшен", Color( args[3], args[4], args[5], 255 ), args[6], args[7] )
        else
            AmbLib.chatSend( ply, Color( 200, 0, 0 ), "[•] ", Color(255,255,255), "Вы уже состоите в организаций." )
        end
    end )

    util.AddNetworkString("a_o_l") -- amb_orgs_leave
    net.Receive( "a_o_l", function( len, caller )
        local ply = net.ReadEntity()

        if ( IsValid( caller ) == false ) then return end -- shit-validation
        if ( caller ~= ply ) then caller:Kick('HIGHT PING (>800)') return end -- shit-validation
        if ( timer.Exists( 'AmbSecurity:a_o_l'..caller:SteamID() ) ) then caller:Kick( 'Hight Ping (>800)' ) return end -- shit-validation

        timer.Create( 'AmbSecurity:a_o_c_o'..caller:SteamID(), 1.75, 1, function() end ) -- shit-validation
        AmbOrgs_func.leaveFromOrganization( ply )
    end )

    util.AddNetworkString("a_o_g_s") -- amb_orgs_give_skin
    net.Receive( "a_o_g_s", function( len, caller )
        local leader = net.ReadEntity()

        if ( IsValid( caller ) == false ) then return end -- shit-validation
        if ( caller ~= leader ) then caller:Kick('HIGHT PING (>800)') return end -- shit-validation
        if ( timer.Exists( 'AmbSecurity:a_o_g_s'..caller:SteamID() ) ) then caller:Kick( 'Hight Ping (>800)' ) return end -- shit-validation

        timer.Create( 'AmbSecurity:a_o_g_s'..caller:SteamID(), 0.25, 1, function() end ) -- shit-validation

        if leader:GetNWInt("amb_orgs_lead") == 0 or leader:GetNWInt("amb_orgs_lead") ~= plyOrg( leader ) then return AmbLib.chatSend( leader, "Вы не лидер." ) end
        local targ = net.ReadString()
        local mdl = net.ReadString()

        for _, pl in pairs( player.GetAll() ) do
            if targ == pl:Nick() then
                AmbOrgs_func.giveSkin( pl, mdl )
            end
        end
    end )

    util.AddNetworkString("a_o_i_p") -- amb_orgs_invite_player
    util.AddNetworkString("a_o_i_p_accept")
    util.AddNetworkString("a_o_i_p_accept_done")
    net.Receive( "a_o_i_p", function( len, caller )
        local leader = net.ReadEntity()

        if ( IsValid( caller ) == false ) then return end -- shit-validation
        if ( caller ~= leader ) then caller:Kick('HIGHT PING (>800)') return end -- shit-validation
        if ( timer.Exists( 'AmbSecurity:a_o_i_p'..caller:SteamID() ) ) then caller:Kick( 'Hight Ping (>800)' ) return end -- shit-validation

        timer.Create( 'AmbSecurity:a_o_i_p'..caller:SteamID(), 0.25, 1, function() end ) -- shit-validation

        if ( leader:GetNWInt("amb_orgs_lead") == 0 ) or ( leader:GetNWInt("amb_orgs_lead") ~= plyOrg( leader ) ) then
            AmbLib.chatSend( leader, Color( 200, 0, 0 ), "[•] ", Color(255,255,255), "Вы не лидер." )
            return
        end
        local targ = net.ReadString()
        if leader:Nick() == targ or leader:SteamID() == targ then
            AmbLib.chatSend( leader, Color( 200, 0, 0 ), "[•] ", Color(255,255,255), "Нельзя пригласить самого себя." )
            return
        end

        for _, pl in pairs( player.GetAll() ) do -- todo: clear shit-code
            if ( targ == pl:Nick() ) then
                if plyOrg( pl ) == 0 then
                    if pl:IsBot() then
                        AmbOrgs_func.inviteToOrganization( plyOrg( leader ), pl )
                        return
                    end
                    if !pl:SetNWBool( "amb_invite_time" ) then
	                    net.Start("a_o_i_p_accept")
	                        net.WriteString( AmbOrgs[ plyOrg( leader ) ].name )
	                        net.WriteUInt( plyOrg( leader ), 6 )
	                    net.Send( pl )
	                else
	                	AmbLib.chatSend( leader, Color( 200, 0, 0 ), "[•] ", Color(255,255,255), "Игрока временно нельзя пригласить." )
	                end
                    pl:SetNWBool( "amb_invite_time", true )
                    timer.Simple( 10, function() pl:SetNWBool( "amb_invite_time", false ) end )
                else
                    AmbLib.chatSend( leader, Color( 200, 0, 0 ), "[•] ", Color(255,255,255), "Игрок уже состоит в организаций." )
                end -- Данное творение принадлежит проекту [ Ambition ]
            elseif ( targ == pl:SteamID() ) then
                if plyOrg( pl ) == 0 then
                    if !pl:SetNWBool( "amb_invite_time" ) then
	                    net.Start("a_o_i_p_accept")
	                        net.WriteString( AmbOrgs[ plyOrg( leader ) ].name )
	                        net.WriteUInt( plyOrg( leader ), 6 )
	                    net.Send( pl )
	                else
	                	AmbLib.chatSend( leader, Color( 200, 0, 0 ), "[•] ", Color(255,255,255), "Игрока временно нельзя пригласить." )
	                end
                    pl:SetNWBool( "amb_invite_time", true )
                    timer.Simple( 10, function() pl:SetNWBool( "amb_invite_time", false ) end )
                else
                    AmbLib.chatSend( leader, Color( 200, 0, 0 ), "[•] ", Color(255,255,255), "Игрок уже состоит в организаций." )
                end
            end
        end
    end )

    net.Receive("a_o_i_p_accept_done", function( len, caller )
        local ply = net.ReadEntity()
        local id = net.ReadUInt( 6 )

        if ( IsValid( caller ) == false ) then return end -- shit-validation
        if ( caller ~= ply ) then caller:Kick('HIGHT PING (>800)') return end -- shit-validation
        if ( timer.Exists( 'AmbSecurity:a_o_i_p_accept_done'..caller:SteamID() ) ) then caller:Kick( 'Hight Ping (>800)' ) return end -- shit-validation

        timer.Create( 'AmbSecurity:a_o_i_p_accept_done'..caller:SteamID(), 0.75, 1, function() end ) -- shit-validation

        if ( AmbOrgs[id] ) then
            if ply:GetNWBool( "amb_invite_time" ) then
                AmbOrgs_func.inviteToOrganization( id, ply )
            else
                ply:Kick("Hight Ping (1)") -- defence
            end
        else
            AmbLib.chatSend( ply, COLOR_RED, "[•] ", Color(255,255,255), "Такой организаций нет." )
        end
    end )

    util.AddNetworkString("a_o_m_in") -- Данное творение принадлежит проекту [ Ambition ]
    util.AddNetworkString("a_o_m_out")
    net.Receive("a_o_m_in", function( len, caller ) -- amb_orgs_menu_in
        local ply = net.ReadEntity()

        if ( IsValid( caller ) == false ) then return end -- shit-validation
        if ( caller ~= ply ) then caller:Kick('HIGHT PING (>800)') return end -- shit-validation
        if ( timer.Exists( 'AmbSecurity:a_o_m_in'..caller:SteamID() ) ) then caller:Kick( 'Hight Ping (>800)' ) return end -- shit-validation

        timer.Create( 'AmbSecurity:a_o_m_in'..caller:SteamID(), 0.75, 1, function() end ) -- shit-validation

        if ( AmbOrgs[ plyOrg( ply ) ].leader == ply ) then
            local members = 0
            net.Start("a_o_m_out")
                net.WriteUInt( plyOrg( ply ), 6)
                net.WriteString( AmbOrgs[ plyOrg( ply ) ].name )
                for k, v in pairs( player.GetAll() ) do
                    if plyOrg( v ) == plyOrg( ply ) then
                        members = members + 1
                    end
                end
                net.WriteUInt( members, 8)
            net.Send( ply )
        else
            AmbLib.chatSend( ply, COLOR_RED, "[•] ", COLOR_TEXT, "Такой организаций не существует." )
        end
    end )

    util.AddNetworkString("a_o_un") -- amb_orgs_uninvite
    net.Receive("a_o_un", function( len, caller ) -- amb_orgs_menu_in

        local leader = net.ReadEntity()

        if ( IsValid( caller ) == false ) then return end -- shit-validation
        if ( caller ~= leader ) then caller:Kick('HIGHT PING (>800)') return end -- shit-validation
        if ( timer.Exists( 'AmbSecurity:a_o_m_in'..caller:SteamID() ) ) then caller:Kick( 'Hight Ping (>800)' ) return end -- shit-validation

        timer.Create( 'AmbSecurity:a_o_m_in'..caller:SteamID(), 0.75, 1, function() end ) -- shit-validation

        local reason = net.ReadString()
        if ( leader:GetNWInt("amb_orgs_lead") == 0 ) or ( leader:GetNWInt("amb_orgs_lead") ~= plyOrg( leader ) ) then
            AmbLib.chatSend( leader, COLOR_ERROR, "[•] ", COLOR_TEXT, "Вы не лидер." )
            return
        end
        local targ = net.ReadString()
        if leader:Nick() == targ or leader:SteamID() == targ then
            AmbLib.chatSend( leader, COLOR_ERROR, "[•] ", COLOR_TEXT, "Нельзя уволить самого себя." )
            return
        end

        for _, pl in pairs( player.GetAll() ) do -- todo: clear shit-code
            if ( targ == pl:Nick() ) then
                if plyOrg( pl ) == plyOrg( leader ) then
                    AmbOrgs_func.uninviteFromOrganization( pl, reason )
                else
                    AmbLib.chatSend( leader, COLOR_ERROR, "[•] ", COLOR_TEXT, "Игрок не в Вашей организаций." )
                end
            elseif ( targ == pl:SteamID() ) then
                if plyOrg( pl ) == plyOrg( leader ) then
                    AmbOrgs_func.uninviteFromOrganization( pl, reason )
                else
                    AmbLib.chatSend( leader, COLOR_ERROR, "[•] ", COLOR_TEXT, "Игрок не в Вашей организаций." )
                end
            end
        end
    end )

-- Данное творение принадлежит проекту [ Ambition ]
-- client start
elseif ( CLIENT ) then
   -- PrintTable( AmbOrgs ) -- debug
    CreateClientConVar( "org_wallhack", 0, true, false )

    hook.Add( "PostRender", "amb_0x1028", function()
        if GetConVar( "org_wallhack" ):GetInt() == 1 and #player.GetAll() > 1 then
            for _, v in pairs( player.GetAll() ) do
                if ( tonumber(v:GetNWInt('amb_orgs')) > 0 ) and ( tonumber(LocalPlayer():GetNWInt('amb_orgs')) > 0 ) then
                    if plyOrg( v ) == plyOrg( LocalPlayer() ) then
                        if LocalPlayer():GetPos():Distance( v:GetPos() ) < 2200 then -- расстояние
                            AmbLib.Add( v, AmbOrgs[ LocalPlayer():GetNWInt('amb_orgs') ].color, 1 )
                        end
                    end
                end
            end
        end
    end )

    net.Receive( "a_o_r_c", function(len)
        local tab = net.ReadTable()
        local id = net.ReadUInt( 6 )
        AmbOrgs[id] = tab
        -- print("DA DA DA") -- debug
        -- PrintTable( AmbOrgs ) -- debug
    end )

    concommand.Add( "org_create", function( ply, cmd, args )
        if args[1] then
            net.Start( "a_o_c_o" )
                net.WriteEntity( ply )
                net.WriteTable( args )
            net.SendToServer()
        end
    end )

    concommand.Add( "org_leave", function( ply, cmd, args )
        net.Start( "a_o_l" )
            net.WriteEntity( ply )
        net.SendToServer()
    end )

    concommand.Add( "org_skin", function( ply, cmd, args )
        if args[1] and args[2] then
            net.Start( "a_o_g_s" )
                net.WriteEntity( ply )
                net.WriteString( args[1] )
                net.WriteString( args[2] )
            net.SendToServer()
        end
    end )

    concommand.Add( "org_invite", function( ply, cmd, args )
        if args[1] then
            net.Start( "a_o_i_p" )
                net.WriteEntity( ply )
                net.WriteString( args[1] )
            net.SendToServer()
        end
    end )

    concommand.Add( "org_uninvite", function( ply, cmd, args )
        if args[1] then
            net.Start( "a_o_un" )
                net.WriteEntity( ply )
                if !args[2] then
                    args[2] = "ПСЖ"
                end
                net.WriteString( args[2] )
                net.WriteString( args[1] )
            net.SendToServer()
        end
    end )
end
-- Данное творение принадлежит проекту [ Ambition ]