local C, Cache = Ambi.Packages.Out( 'colors, cache' )
local Material, CRC, Fetch = Material, util.CRC, http.Fetch
local temp_mats_for_cached = {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local function CheckFile( sName, sURL ) 
    local tab = temp_mats_for_cached[ sName ]
    if not tab then return false end

    if file.Exists( tab.path, 'DATA' ) and ( tab.hash == tab.url_hash ) then return true end
end

function Ambi.ContentLoader.DownloadMaterial( sName, sNameFile, sURL, nTries )
    if ( nTries <= 0 ) then return end

    if Ambi.ChatCommands.Config.log then MsgC( C.PURPLE, '\n[ContentLoader] ', C.WHITE, 'Prepare to download: ', C.PURPLE, sName ) end

    if not temp_mats_for_cached[ sName ] then temp_mats_for_cached[ sName ] = {} end
    temp_mats_for_cached[ sName ].file = sNameFile

    Fetch( sURL, function( sBody, nSize ) 
        local path = 'ambi/cache/'..sNameFile

        if file.Exists( path, 'DATA' ) then 
            local url_hash, hash = CRC( sBody ), CRC( file.Read( path, 'DATA' ) )

            temp_mats_for_cached[ sName ].hash = hash
            temp_mats_for_cached[ sName ].url_hash = url_hash
            temp_mats_for_cached[ sName ].url = sURL
            temp_mats_for_cached[ sName ].path = path
            temp_mats_for_cached[ sName ].file = sNameFile

            if ( hash == url_hash ) then 
                if Ambi.ChatCommands.Config.log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Material is ready: ', C.AMBI_SOFT_YELLOW, sName ) end

                if temp_mats_for_cached[ sName ].material and not temp_mats_for_cached[ sName ].material:IsError() and Ambi.ChatCommands.Config.log then  
                    MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Material created: ', C.AMBI_SOFT_YELLOW, sName )
                end
                
                return 
            end

            file.Delete( path )

            if Ambi.ChatCommands.Config.log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Material deleted: ', C.AMBI_SOFT_YELLOW, sName ) end
        end

        file.Write( path, sBody )

        if Ambi.ChatCommands.Config.log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Material is downloading: ', C.AMBI_SOFT_YELLOW, sName ) end
    end )
end

function Ambi.ContentLoader.Material( sName, sNameFile, sURL )
    local tab = temp_mats_for_cached[ sName ]
    if tab and tab.material and tab.url and ( tab.url == sURL ) and not tab.material:IsError() then return tab.material end

    if Ambi.ChatCommands.Config.log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Prepare to create: ', C.AMBI_SOFT_YELLOW, sName ) end

    local mat = Material( Cache.GetCacheFile( sNameFile ) )

    Ambi.ContentLoader.DownloadMaterial( sName, sNameFile, sURL, 1 )

    temp_mats_for_cached[ sName ].material = mat

    return mat
end

function Ambi.ContentLoader.Try( sName, matImage )
    local tab = temp_mats_for_cached[ sName ]
    if not tab then return end
    if tab and tab.material and not tab.material:IsError() then return end

    matImage = Ambi.ContentLoader.Material( sName, tab.file, tab.url )
end