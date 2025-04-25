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

	if string.sub(txt,1,4) == "/tts" then

		if ply:IsUserGroup( 'user' ) then return end

		text = txt
		txt = string.Explode(" ", txt )
		text = string.Replace( text, txt[1], '')
		SendTTS( text, ply )

	end

end)

local voices = {

	'http://tts.voicetech.yandex.net/tts?speaker=oksana&text=',
	'https://translate.google.com/translate_tts?ie=UTF-8&tl=ru&client=tw-ob&q=',
	'http://tts.voicetech.yandex.net/tts?speaker=zahar&text='

}

hook.Add( 'PlayerInitialSpawn', 'AmbTTSChoiceVoice', function( ePly ) 

	ePly:SetNWString( 'TTSVoice', table.Random( voices ) )

end )