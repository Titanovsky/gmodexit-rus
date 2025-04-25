local is_chat = false

CreateClientConVar( 'amb_bhop', 0, true )
hook.Add( 'Think', 'AMB.Bhop', function()
	if is_chat or ( LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP ) then return end
	local bhop = GetConVar( 'amb_bhop' ):GetBool()

	if bhop then
		if input.IsKeyDown( KEY_SPACE ) then
			if LocalPlayer():IsOnGround() then
				RunConsoleCommand("+jump")
				HasJumped = 1
			else
				RunConsoleCommand("-jump")
				HasJumped = 0
			end
		elseif bhop and LocalPlayer():IsOnGround() then
			if HasJumped == 1 then
				RunConsoleCommand("-jump")
				HasJumped = 0
			end
		end
	end
end)

local CRED, CGREEN = Color( 255, 0, 0 ), Color( 0, 255, 0 )
cvars.AddChangeCallback( 'amb_bhop', function( _, sOldValue, sNewValue )
	if ( sNewValue == '1' ) then chat.AddText( CGREEN, 'Auto BHOP is turned on' )
	elseif ( sNewValue == '0' ) then chat.AddText( CRED, 'Auto BHOP is turned off' )
	end
end )

hook.Add( 'StartChat', 'AMB.BlockJumpOnChat', function()
	is_chat = true
end )

hook.Add( 'FinishChat', 'AMB.BlockJumpOnChat', function()
	is_chat = false
end )