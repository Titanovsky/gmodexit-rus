local SQL, C = Ambi.SQL, Ambi.General.Global.Colors
local PLAYER = FindMetaTable( 'Player' )

-- -----------------------------------------------------------------------------------------------------------
function PLAYER:IsRusAuth()
    return self.nw_IsRusAuth
end

-- -----------------------------------------------------------------------------------------------------------
net.AddString( 'ambi_rus_auth' )
net.Receive( 'ambi_rus_auth', function( _, ePly ) 
    if ePly.nw_IsRusAuth then ePly:Kick( 'Вы уже авторизованы!' ) return end

    ePly.nw_IsRusAuth = true
    ePly:Freeze( false )

    local bNewPlayer = false
    SQL.Get( 'rus_players', 'Name', 'SteamID', ePly:SteamID(), function()
    end, function()
        bNewPlayer = true
    end )

    local text = bNewPlayer and ' впервые авторизовался' or ' авторизовался'
    for _, ply in ipairs( player.GetHumans() ) do
        ply:ChatSend( C.AMBI, '[RUS] ', C.ABS_WHITE, 'Игрок ', C.FLAT_BLUE, ePly:Name(), C.ABS_WHITE, text )
    end

    hook.Call( '[Ambi.RUS.Authorization]', nil, ePly )
end )

-- -----------------------------------------------------------------------------------------------------------
hook.Add( 'PlayerInitialSpawn', 'Ambi.Rus.Auth', function( ePly ) 
    if ePly:IsBot() then ePly.nw_IsRusAuth = true return end

    ePly:Freeze( true )
end )

hook.Add( 'PlayerSay', 'Ambi.Rus.RestrictAuth', function( ePly ) 
    if not ePly:IsRusAuth() then ePly:Kick( 'Авторизуйтесь!' ) return '' end
end )

hook.Add( 'PlayerSpray', 'Ambi.Rus.RestrictAuth', function( ePly ) 
    if not ePly:IsRusAuth() then ePly:Kick( 'Авторизуйтесь!' ) return false end
end )

hook.Add( 'PlayerSpawnObject', 'Ambi.Rus.RestrictAuth', function( ePly ) 
    if not ePly:IsRusAuth() then ePly:Kick( 'Авторизуйтесь!' ) return false end
end )

hook.Add( 'PlayerSpawnSENT', 'Ambi.Rus.RestrictAuth', function( ePly ) 
    if not ePly:IsRusAuth() then ePly:Kick( 'Авторизуйтесь!' ) return false end
end )

hook.Add( 'PlayerSpawnSWEP', 'Ambi.Rus.RestrictAuth', function( ePly ) 
    if not ePly:IsRusAuth() then ePly:Kick( 'Авторизуйтесь!' ) return false end
end )

hook.Add( 'PlayerGiveSWEP', 'Ambi.Rus.RestrictAuth', function( ePly ) 
    if not ePly:IsRusAuth() then ePly:Kick( 'Авторизуйтесь!' ) return false end
end )

hook.Add( 'PlayerSpawnVehicle', 'Ambi.Rus.RestrictAuth', function( ePly ) 
    if not ePly:IsRusAuth() then ePly:Kick( 'Авторизуйтесь!' ) return false end
end )

hook.Add( 'PlayerSpawnNPC', 'Ambi.Rus.RestrictAuth', function( ePly ) 
    if not ePly:IsRusAuth() then ePly:Kick( 'Авторизуйтесь!' ) return false end
end )

hook.Add( 'PlayerCanHearPlayersVoice', 'Ambi.Rus.RestrictAuth', function( eListener, eTalker ) 
    if not eTalker:IsRusAuth() then return false end
end )