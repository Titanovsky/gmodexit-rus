if SERVER then
    net.AddString( 'ambi_rus_soup' )
else
    net.Receive( 'ambi_rus_soup', function( len ) 
        local act = net.ReadUInt( 20 ) 
        local ePly = net.ReadEntity() 
        
        ePly:AnimRestartGesture( GESTURE_SLOT_CUSTOM, act, false ) 
    end )
    
    --Entity(1):AddVCDSequenceToGestureSlot( GESTURE_SLOT_VCD, 494, 0, true )
    --Entity(1):AnimSetGestureWeight( GESTURE_SLOT_VCD, 1 )
end