AmbCache = AmbCache or {}
AmbCache.Picture = AmbCache.Picture or {}
AmbCache.Picture.imgs = {}

AmbCache.main_path = '[ambition]'
AmbCache.server_path = '[ambition]/phonex_rp'

local http = http
local string = string
local file = file
local timer = timer

local function checkURL( url )
    url = tostring( url )
    if string.StartWith( url, 'https://' ) or string.StartWith( url, 'http://' ) then return true end
    return false
end

local function erroris( str )
    return MsgC( AMB_COLOR_RED, '\n[AmbCache] ', AMB_COLOR_WHITE, str)
end

local function done( str )
    return MsgC( AMB_COLOR_BLUE, '\n[AmbCache] ', AMB_COLOR_WHITE, str)
end

function AmbCache.createFileComponents()

    file.CreateDir( AmbCache.main_path )
    file.CreateDir( AmbCache.server_path )
    done( 'Dir '..AmbCache.main_path..' has created.' )
end

function AmbCache.checkFileComponents()

    if file.IsDir( AmbCache.main_path, 'DATA' ) == false then
        AmbCache.createFileComponents()
    elseif file.IsDir( AmbCache.server_path, 'DATA' ) == false then
        AmbCache.createFileComponents() 
    end
end

function AmbCache.Picture.startCache( type_obj, obj )

    if ( type_obj == 'url' ) then

        if ( checkURL( obj ) == false ) then erroris('This object not a link!') return '_' end

        done('URL Link received: '..obj) -- debug

        AmbCache.checkFileComponents()

        done('Start to process PreCache')

        return AmbCache.Picture.preCachePicture( obj )
    end
    return '_'
end

function AmbCache.Picture.preCachePicture( obj )

    local name = 'amb_'..util.CRC( obj )..'.png'
    local picture_code = ''

    -- MsgN( name ) -- debug
    http.Fetch( obj, function( body, size )
        -- MsgN( size ) -- debug
        picture_code = body
    end )

    if AmbCache.Picture.checkValidFile( name ) then erroris('File: '..name..' is valid.')
        AmbCache.Picture.imgs[ name ] = Material( '../data/'..AmbCache.server_path..'/'..name ) 
        return AmbCache.Picture.endCache( name ) 
    end

    timer.Simple( 2, function()
        file.Write( AmbCache.server_path..'/'..name, picture_code )

        AmbCache.Picture.imgs[ name ] = Material( '../data/'..AmbCache.server_path..'/'..name )

        if AmbCache.Picture.checkValidFile( name ) then 
            done('File '..name..' has precached!')
            return AmbCache.Picture.endCache( name )
        else
            erroris('File dont precaches! Try again.')
            return '_'
        end
    end )
end

function AmbCache.Picture.checkValidFile( name )

    name = AmbCache.server_path..'/'..name

    if file.Exists( name, 'DATA' ) then
        if file.Size( name, 'DATA' ) > 1 then
            return true
        else
            return false
        end
    end

    return false
end

function AmbCache.Picture.endCache( name )
    return AmbCache.server_path..'/'..name
end
