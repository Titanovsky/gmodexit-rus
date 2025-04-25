function Ambi.Kit.Add( sName, sDescription, bOnce, nDelay, fAction )
    if not sName then return end

    Ambi.Kit.Config.kits[ sName or '' ] = {
        desc = sDescription or '',
        once = bOnce,
        delay = nDelay or 1,
        action = fAction or function() end
    }
end

function Ambi.Kit.Get( sName )
    return Ambi.Kit.Config.kits[ sName or '' ]
end