local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )

hook.Add( 'PostPlayerDraw', 'Ambi.Rus.Render3D2DPlayers', function( ePly )
    if not IsValid( ePly ) then return end
    if ( LocalPlayer():GetPos():Distance( ePly:GetPos() ) > 600 ) then return end
    if ( ePly == LocalPlayer() ) then return end
    if not ePly:Alive() then return end

    local _,max = ePly:GetRotatedAABB( ePly:OBBMins(), ePly:OBBMaxs() )
    local rot = ( ePly:GetPos() - EyePos() ):Angle().yaw - 90
    local head_bone = ePly:LookupBone( 'ValveBiped.Bip01_Head1' ) or 1
    local head = (ePly:GetBonePosition( head_bone ) and ePly:GetBonePosition( head_bone ) + Vector( 0, 0, 14 ) or nil ) or ePly:LocalToWorld( ePly:OBBCenter() ) + Vector( 0, 0, 24 )

    local hp = ( ePly:Health() >= 100 ) and 100 or ePly:Health()
    local wep = IsValid( ePly:GetActiveWeapon() ) and ePly:GetActiveWeapon():GetClass() or 'none'
    
    cam.Start3D2D( head, Angle( 0, rot, 90 ), 0.1 )
        draw.SimpleTextOutlined( ePly:Name(), UI.SafeFont( '32 Ambi' ), 4, 24, C.AMBI_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.AMBI_BLACK )
    cam.End3D2D()
end )
