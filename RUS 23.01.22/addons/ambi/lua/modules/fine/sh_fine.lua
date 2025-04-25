Ambi.Fine.players = Ambi.Fine.players or {}

local C, SND, A = Ambi.General.Global.Colors, Ambi.General
-- ## SDK #####################
function Ambi.Fine.Add( sName, sDescription, nDelay, nAddTime, nMaxTries, fPunishment )
    if not fPunishment or not isfunction( fPunishment ) then A.Error( 'Fine', 'fPunishment in '..tostring( sName )..' not selected!' ) return end

    local id = #Ambi.Fine.Config.fines + 1

    for i, v in ipairs( Ambi.Fine.Config.fines ) do
        id = ( v.name == sName ) and i or id
    end

    Ambi.Fine.Config.fines[ id ] = {
        name = sName or 'TEST',
        desc = sName or 'DESCRIPTION',
        delay = nDelay or 1,
        addtime = nAddTime or 0.05,
        tries = nMaxTries or 2,
        punishment = fPunishment
    }

    print( '[Fine] Added fine: '..sName..' ('..id..')' )
end

function Ambi.Fine.Get( sName )
    for i, v in ipairs( Ambi.Fine.Config.fines ) do
        if ( v.name == sName ) then return v end
    end
end

-- ## Players ###################
function Ambi.Fine.SetPlayerFine( sSteamID64, sName, nCount )
    Ambi.Fine.players[ sSteamID64 ][ sName ] = nCount
end

function Ambi.Fine.AddPlayerFine( sSteamID64, sName, nCount )
    Ambi.Fine.players[ sSteamID64 ][ sName ] = Ambi.Fine.GetPlayerFine( sSteamID64, sName ) + nCount
end

function Ambi.Fine.GetPlayerFine( sSteamID64, sName )
    return Ambi.Fine.players[ sSteamID64 ][ sName ] or 0
end

-- ## Controller ###################
local TCreate, TRemove, TExists, TGetTime = timer.Create, timer.Remove, timer.Exists, function( sName ) return math.Round( timer.TimeLeft( sName ), 2 ) end

function Ambi.Fine.Give( ePly, sName )
    if not IsValid( ePly ) then return end

    local fine = Ambi.Fine.Get( sName or '' )
    if not fine then return end

    local steamid64 = ePly:SteamID64()
    local timer_name = 'Fine:'..sName..':'..steamid64
    if TExists( timer_name ) then Ambi.Fine.Up( ePly, sName, 1 ) return end
    
    Ambi.Fine.SetPlayerFine( steamid64, sName, 1 )
    TCreate( timer_name, fine.delay, 1, function() Ambi.Fine.SetPlayerFine( steamid64, sName, 0 ) end )
end

function Ambi.Fine.Up( ePly, sName, nTries )
    if not IsValid( ePly ) then return end

    local steamid64 = ePly:SteamID64()
    local timer_name = 'Fine:'..sName..':'..steamid64
    if not TExists( timer_name ) then return end

    local fine = Ambi.Fine.Get( sName or '' )
    if not fine then return end

    TCreate( timer_name, TGetTime( timer_name ) + fine.addtime, 1, function() Ambi.Fine.SetPlayerFine( steamid64, sName, 0 ) end )

    Ambi.Fine.AddPlayerFine( steamid64, sName, 1 )

    local count = Ambi.Fine.GetPlayerFine( steamid64, sName )

    local try1, try2, try3, try4 = fine.tries - 4, fine.tries - 3, fine.tries - 2, fine.tries - 1
    if ( count == try1 ) or ( count == try2 ) or ( count == try3 ) or ( count == try4 ) then ePly:ChatSend( C.AMBI_GRAY, 'Пожалуйста, подождите..' ) end

    if ( count >= fine.tries ) then
        TRemove( timer_name )
        Ambi.Fine.Punish( ePly, sName )
    end
end

function Ambi.Fine.Punish( ePly, sName )
    if not IsValid( ePly ) then return end

    local fine = Ambi.Fine.Get( sName or '' )
    if not fine then return end

    local name = ePly:IsAuth() and ePly:GetGamename()..' ('..ePly:SteamID()..')' or '(NoAuth) '..ePly:Nick()..' ('..ePly:SteamID()..')'
    print( '[Fine] Player '..name..' got a punishment '..sName..' ['..Ambi.Fine.GetPlayerFine( ePly:SteamID64(), sName )..'/'..fine.tries..']' )

    fine.punishment( ePly )

    local sid64 = ePly:SteamID64()
    timer.Simple( 2, function()
        Ambi.Fine.SetPlayerFine( sid64, sName, 0 )
    end )
end

hook.Add( 'PlayerInitialSpawn', 'Ambi.Fine.AddTableForAllPlayers', function( ePly ) 
    if ePly:IsBot() then return end

    Ambi.Fine.players[ ePly:SteamID64() ] = Ambi.Fine.players[ ePly:SteamID64() ] or {} 
end )