local Add, Give, AddPly = Ambi.Fine.Add, Ambi.Fine.Give, Ambi.Fine.AddPlayerFine

Ambi.Fine.Config.net_log = true
Ambi.Fine.Config.net_delay = 0.45
Ambi.Fine.Config.net_addtime = 0.55
Ambi.Fine.Config.net_tries = 72
Ambi.Fine.Config.net_tries_for_ban = 4


Ambi.Fine.tries_for_ban = Ambi.Fine.tries_for_ban or {}

local antinetflood = 'AntiNetFlood'
Add( antinetflood, 'Защита от флуда в net сообщениях', Ambi.Fine.Config.net_delay, Ambi.Fine.Config.net_addtime, Ambi.Fine.Config.net_tries, function( ePly )
    local gamename, steamid, steamid64, steamid64owner, ip = ePly:Gamename(), ePly:SteamID(), ePly:SteamID64(), ePly:OwnerSteamID64(), ePly:IPAddress()
    ePly:Kick( '[AntiCheat] Вы кикнуты за флуд на сервер!' )

    local tries_for_ban = Ambi.Fine.tries_for_ban[ steamid ]
    if not tries_for_ban then 

        Ambi.Fine.tries_for_ban[ steamid ] = 0
        tries_for_ban = 0
    end

    if ( ( tries_for_ban or 0 ) < Ambi.Fine.Config.net_tries_for_ban ) then
        Ambi.Fine.tries_for_ban[ steamid ] = tries_for_ban + 1
    elseif ( tries_for_ban == Ambi.Fine.Config.net_tres_for_ban ) then
        Ambi.Fine.tries_for_ban[ steamid ] = 0
        print( '\n---------- Suspect Cheater -------------' )
        print( '1. Gamename: '..gamename )
        print( '2. SteamID: '..steamid )
        print( '3. SteamID64: '..steamid64 )
        print( '4. SteamID64Owner: '..steamid64owner )
        print( '5. IP: '..ip )
        print( '6. Date: '..os.date( '%x %X', os.time() ) )
        print( '\n----------------------------------------' )
    end
end )

local function CheckNetReceiver( nLen, ePly )
    if not IsValid( ePly ) then return -1 end

    local steamid64 = ePly:SteamID64()
    if not ePly:IsAuth() then AddPly( steamid64, antinetflood, 1 ) end

    local count, tries = Ambi.Fine.GetPlayerFine( steamid64, antinetflood ), Ambi.Fine.Config.net_tries
    if ( count >= tries - 4 ) then return -1 end
    
    return 0
end

local block = {  
    [ 'TFA_Attachment_Request' ] = true,
    [ 'arccw_rqwpnnet' ] = true,
    [ 'arccw_quicknade' ] = true,
    [ 'arccw_sendattinv' ] = true,
    [ 'arccw_reloadatts' ] = true,
    [ 'arccw_togglecustomize' ] = true,
    [ 'arccw_slidepos' ] = true,
    [ 'simfphys_blockcontrols' ] = true,
    [ 'simfphys_mousesteer' ] = true,
    [ 'NetStreamRequest' ] = true,
    [ 'wire_expression2_upload' ] = true,
    [ 'starfall_upload' ] = true,
    [ 'WireLib.Paths.RequestPaths' ] = true,
    [ 'simfphys_request_ppdata' ] = true,
    [ 'properties' ] = true,
    [ 'editvariable' ] = true,
    [ 'arccw_asktoattach' ] = true,
    [ 'arccw_togglenum' ] = true,
    [ 'vj_npcmover_sv_startmove' ] = true
}

hook.Add( '[Ambi.Ambition.Network.Incoming]', 'Ambi.Fine.CheckNetMessages', function( nLen, ePly, sMessage )
    if block[ sMessage ] then return end

    Give( ePly, antinetflood )
	
    local name, steamid = ePly:IsAuth() and ePly:Gamename() or ePly:Nick()..' (NoAuth)', ePly:SteamID()
    if Ambi.Fine.Config.net_log then print( '[Receive] '..sMessage..' | '..name..' ('..steamid..') | '..Ambi.Fine.GetPlayerFine( ePly:SteamID64(), 'AntiNetFlood' )..'/64' ) end
end )