SF.RegisterLibrary( 'ambition' )

local CLT = SF.CheckLuaType
local TH = SF.Throw
local HA = SF.hookAdd
local CHAT = AmbLib.chatSend

local max_int = 1e12
local access_id = { 

    [ 'STEAM_0:1:95303327' ] = true,
    [ 'STEAM_0:0:426598565' ] = true,
    [ 'STEAM_0:0:164590602' ] = true

}

local function GACC( instPlayer ) -- GetAccess

    local steamid = instPlayer:SteamID()
    local bool = access_id[ steamid ]

    if not bool then TH( 'Вам не доступна эта эпопея!' ) end

    return bool

end

print( '[StarFall] Update Library: Ambition' )

for k, v in pairs( player.GetHumans() ) do

    CHAT( v, AMB_COLOR_BLUE, 'Уступите дорогу, Старфольский едет!' )

    if access_id[ v:SteamID() ] then CHAT( v, AMB_COLOR_BLUE, '♦ ', AMB_COLOR_WHITE, 'Хей, пупс, тебе доступна библиотека ', AMB_COLOR_AMBITION, 'Ambition', AMB_COLOR_WHITE, ' :3' ) end

end

local function compileModule(source, path)
  local ok, init = xpcall(function() local r = (source and CompileString(source, path) or CompileFile(path)) r=r and r() return r end, debug.traceback)
    if not ok then
        ErrorNoHalt("[SF] Attempt to load bad module: " .. path .. "\n" .. init .. "\n")
        init = nil
    end
    return init
end

local function addModule(name, path, shouldrun)
    local source, init
    if SERVER then
        AddCSLuaFile(path)
        source = file.Read(path, "LUA")
        if shouldrun then
            init = compileModule(source, path)
        end
    else
        if shouldrun then
            init = compileModule(nil, path)
        end
    end
    local tbl = SF.Modules[name]
    if not tbl then tbl = {} SF.Modules[name] = tbl end
    tbl[path] = {source = source, init = init}
end

concommand.Add( 'sf_reload_amb', function()

    addModule( string.StripExtension( 'ambition.lua' ), 'starfall/libs_sv/ambition.lua', SERVER )

end )

HA( 'AcceptInput', nil, function( instance, eObj, sInput, eActivator, eCaller, anyValue )
    
    local access = access_id[ instance.player:SteamID() ]
    
    if not access then return false end

    local OW = instance.WrapObject
    return true, { OW( eObj ), sInput, OW( eActivator ), OW( eCaller ), anyValue }

end )

return function(instance)

    local OW, OUNW = instance.WrapObject, instance.UnwrapObject
    local EM, EW, EUNW = instance.Types.Entity, instance.Types.Entity.Wrap, instance.Types.Entity.Unwrap
    local AM, AW, AUNW = instance.Types.Angle, instance.Types.Angle.Wrap, instance.Types.Angle.Unwrap
    local VM, VW, VUNW = instance.Types.Vector, instance.Types.Vector.Wrap, instance.Types.Vector.Unwrap
    local CUNW = instance.Types.Color.Unwrap

    instance.Libraries.Ambition = {}
    local Ambition = instance.Libraries.Ambition

    Ambition.Entity = {}

    function Ambition.Entity.Create( sClass )

        if not GACC( instance.player ) then return end

        local ent = ents.Create( sClass )

        return EW( ent )

    end

    function Ambition.Entity.SetModel( eEnt, sModel )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        local is_valid_mdl = util.IsValidModel( sModel )
        if not is_valid_mdl then TH( 'На сервер нет '..sModel..' модели!' ) return ent end

        eEnt:SetModel( sModel )

        return eEnt

    end

    function Ambition.Entity.SetPos( eEnt, vPos )

        if not GACC( instance.player ) then return end

        eEnt, vPos = EUNW( eEnt ), VUNW( vPos )

        eEnt:SetPos( vPos )

        return eEnt

    end

    function Ambition.Entity.SetAngles( eEnt, aAngle )

        if not GACC( instance.player ) then return end

        eEnt, aAngle = EUNW( eEnt ), AUNW( aAngle )

        eEnt:SetAngles( aAngle )

        return eEnt

    end

    function Ambition.Entity.Spawn( eEnt )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:Spawn()

        return eEnt

    end

    function Ambition.Entity.SetKeyValue( eEnt, sKey, sValue )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:SetKeyValue( sKey, sValue )
    
        return eEnt

    end

    function Ambition.Entity.Fire( eEnt, sKey, sValue, nDelay )

        if not GACC( instance.player ) then return end

        nDelay = nDelay or 0
        eEnt = EUNW( eEnt )

        eEnt:Fire( sKey, sValue, nDelay)
        
        return eEnt

    end

    function Ambition.Entity.SetCPPIOwner( eEnt, ePly )

        if not GACC( instance.player ) then return end

        eEnt, ePly = EUNW( eEnt ), EUNW( ePly )

        eEnt:CPPISetOwner( ePly )

        return eEnt

    end

    function Ambition.Entity.PhysicsInit( eEnt, nType )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:PhysicsInit( nType )

        return eEnt

    end

    function Ambition.Entity.SetSolid( eEnt, nType )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:SetSolid( nType )

        return eEnt

    end

    function Ambition.Entity.SetMoveType( eEnt, nType )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        eEnt:SetMoveType( nType )

        return eEnt

    end

    function Ambition.Entity.GetPhysicsObject( eEnt )

        if not GACC( instance.player ) then return end

        eEnt = EUNW( eEnt )

        return eEnt:GetPhysicsObject()

    end

    function Ambition.Entity.EnableMotion( physObj, bEnable )

        if not GACC( instance.player ) then return end
        
        physObj:EnableMotion( bEnable or false )

        return physObj

    end

    function Ambition.Entity.Wake( physObj )

        if not GACC( instance.player ) then return end
        
        physObj:Wake()

        return physObj

    end

    function Ambition.Entity.Sleep( physObj )

        if not GACC( instance.player ) then return end
        
        physObj:Sleep()

        return physObj

    end

    Ambition.Server = {}

    function Ambition.Server.Rcon( ... )

        if not GACC( instance.player ) then return end

        local varargs = { ... }

        RunConsoleCommand( unpack( varargs ) )

    end

    function Ambition.Server.LuaRun( sStr )

        if not GACC( instance.player ) then return end

        RunString( sStr )

    end

    Ambition.RUS = {}

    function Ambition.RUS.GetMoney( ePly )
        if not GACC( instance.player ) then return end

        return math.floor( AmbStats.Players.getStats( EUNW( ePly ), '$' ) )
    end

    function Ambition.RUS.AddMoney( ePly, nCount )
        if not GACC( instance.player ) then return end
        ePly = EUNW( ePly )

        AmbStats.Players.setStats( ePly, '$', AmbStats.Players.getStats( ePly, '$' ) + math.floor( nCount ) )
    end

    function Ambition.RUS.ChatPrint( ePly, sText )
        if not GACC( instance.player ) then return end
        ePly = EUNW( ePly )

        ePly:ChatPrint( sText )
    end
end