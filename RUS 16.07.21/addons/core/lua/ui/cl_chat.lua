AmbChat = AmbChat or {}
AmbChat.ignores = AmbChat.ignores or {}

local COLOR_WHITE	= Color(255,255,255)
local COLOR_BRACKET = Color( 196, 196, 196 )
local COLOR_TEXT 	= Color( 244, 244, 244 )
local COLOR_GRAY 	= Color( 200, 200, 200 )

function AmbChat.SetIgnore( ePly )

	if not IsValid( ePly ) then return end
	if not ePly:IsPlayer() then return end

	if not AmbChat.ignores[ ePly:EntIndex() ] then

		AmbChat.ignores[ ePly:EntIndex() ] = true
		chat.AddText( AMB_COLOR_AMBITION, '[•] ', COLOR_TEXT, 'Вы стали игнорировать игрока '..ePly:GetNWString('amb_players_name') )

		return true

	end

	AmbChat.ignores[ ePly:EntIndex() ] = nil
	chat.AddText( AMB_COLOR_AMBITION, '[•] ', COLOR_TEXT, 'Вы перестали игнорировать игрока '..ePly:GetNWString('amb_players_name') )

	return false

end

local function GetColor( ePly )

	if not IsValid( ePly ) then return AMB_COLOR_RED end
	if ePly:IsSuperAdmin() then return AMB_COLOR_AMETHYST end

	return team.GetColor( ePly:Team() )

end

hook.Add( 'OnPlayerChat', 'AmbChatOnClientMessage', function( ePly, sText )

	if AmbChat.ignores[ ePly:EntIndex() ] then return true end

	local name = not ePly and 'UNKNOW' or ePly:GetNWString('amb_players_name')
	local index = not ePly and '-1' or '['..ePly:EntIndex()..']'
	local color = not ePly and COLOR_GRAY or GetColor( ePly )

	chat.AddText( COLOR_TEXT, index, color, ' '..name..' ', COLOR_TEXT, sText )

	return true

end )