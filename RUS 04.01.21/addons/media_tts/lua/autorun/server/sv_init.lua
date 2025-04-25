AddCSLuaFile("autorun/client/cl_tts.lua")

util.AddNetworkString("PlayTTS")

local function SendTTS( sText, ePly )

	if not GetConVar( 'amb_rp_voice' ):GetBool() then 
	
		net.Start( 'PlayTTS' )
			net.WriteString( sText )
			net.WriteEntity( ePly )
		net.Broadcast() 
	
		return
		
	end

	for _, v in pairs( ents.FindInSphere( ePly:GetPos(), 1600 ) ) do

		if v:IsPlayer() then 
		
			net.Start( 'PlayTTS' )
			net.WriteString( sText )
			net.WriteEntity( ePly )
			net.Send( v ) 
			
		end

	end

end

hook.Add("PlayerSay","TTSdetect",function( ply,txt,team )

	if txt=="/ttson" then
		ply.ALWAYSTTS=true
	elseif txt=="/ttsoff" then
		ply.ALWAYSTTS=nil
	end


	if ( ply.ALWAYSTTS ) then
		if string.GetChar(txt, 1) == '/' then return end
		txt = txt
		if ply:GetUserGroup() ~= "user" then
			SendTTS( txt, ply )
		end
	elseif string.sub(txt,1,4) == "/tts" then
		text = txt
		txt = string.Explode(" ", txt )
		text = string.Replace( text, txt[1], '')
		if ply:GetUserGroup() ~= "user" then
			SendTTS( text, ply )
		end
	end
end)