Ambi.Base.HUD = Ambi.Base.HUD or {}
Ambi.Base.HUD.huds = Ambi.Base.HUD.huds or {}

local convar = CreateClientConVar( Ambi.Base.Config.hud_command, 3, true )

function Ambi.Base.HUD.Add( nID, sName, sAuthor, fDraw )
    Ambi.Base.HUD.huds[ nID ] = {
        name = sName or '',
        author = sAuthor or 'Ambi',
        Draw = fDraw or function() end
    }
end

function Ambi.Base.HUD.GetAll()
    return Ambi.Base.HUD.huds
end

hook.Add( 'HUDShouldDraw', 'Ambi.Base.HUD.DontDrawHL2HUD', function( sElement ) return not Ambi.Base.Config.hud_block[ sElement ] end )
hook.Add( 'HUDDrawTargetID', 'Ambi.Base.HUD.DontDrawTargetID', function() return not Ambi.Base.Config.hud_disable_target_id end )
hook.Add( 'HUDPaint', 'Ambi.Base.HUD.DrawCustomHUD', function()
    if ( Ambi.Base.Config.hud_enable == false ) then return end
    
    local HUD = Ambi.Base.HUD.huds[ convar:GetInt() ]
    if ( HUD == nil ) then HUD = Ambi.Base.HUD.huds[ 1 ] end

    HUD.Draw()  
end )