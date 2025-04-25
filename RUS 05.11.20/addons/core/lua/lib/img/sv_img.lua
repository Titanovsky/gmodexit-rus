util.AddNetworkString("rus_send_img")

local function rus_SendToClientImg( ply, text )

	if ( ply:IsSuperAdmin() ) and ( string.sub( text, 1, 19) == "https://i.imgur.com") then
		net.Start("rus_send_img")
		net.WriteString( text )
		net.Broadcast()
		return false
	end
end

hook.Add( "PlayerSay", "rus_hook_x128", rus_SendToClientImg )


