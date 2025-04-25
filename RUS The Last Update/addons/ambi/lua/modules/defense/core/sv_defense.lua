function Ambi.Defense.Punish( ePly, nType, sReason, sDescription )
    ePly:ChatPrint( sReason )

    print( sDescription )

    if ( nType == 2 ) then
        if IsValid( ePly ) then ePly:Kick( sReason ) end
    end
end