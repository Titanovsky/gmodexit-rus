--[[
	Основные переменные и таблицы для серверов на проекте [ Ambition ].
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[09.08.20]
		• Давно надо было это сделать.
	.
	[13.08.20]
		• Добавил из инета удаление регдола клиенсткого после смерти
		• Оказалось разрабы доступили баг, что у ply:Team() с 1-4 дамаг не проходит, =/ Записал здесь тимы		
	.
##########################################################################################
]]

-- ## Colors ###########
AMB_COLOR_WHITE         = rgb( 245, 245, 245 )
AMB_COLOR_BLACK         = rgb( 5, 5, 5 )
AMB_COLOR_SMALL_BLACK   = rgb( 56, 56, 56 )
AMB_COLOR_SILVER        = rgb( 189, 195, 199 )
AMB_COLOR_GRAY          = rgb( 143, 143, 143 )
AMB_COLOR_WIZARD_GREY   = rgb( 83, 92, 104 )
AMB_COLOR_CLOUDS        = rgb( 236, 240, 241 )
AMB_COLOR_RED           = rgb( 231, 76, 60 )
AMB_COLOR_GREEN         = rgb( 46, 204, 113 )
AMB_COLOR_BLUE          = rgb( 52, 152, 219 )
AMB_COLOR_AMBITION      = rgb( 230, 126, 34 ) -- #e67e22
AMB_COLOR_ORANGE        = rgb( 250, 165, 6 )
AMB_COLOR_AMETHYST      = rgb( 155, 89, 182 )
AMB_COLOR_ERROR         = AMB_COLOR_RED
AMB_COLOR_OK            = AMB_COLOR_GREEN
AMB_COLOR_NEWS          = AMB_COLOR_AMBITION
-- #####################


-- ## Teams ###########
AMB_TEAM_CITIZEN 	= 200
AMB_TEAM_PVP 		= 201
AMB_TEAM_BUILD 		= 202
AMB_TEAM_RP 		= 203
-- ####################


if ( CLIENT ) then
	function RemoveDeadRag( ent )
		if (ent == NULL) or (ent == nil) then 
			return 
		end 

		if (ent:GetClass() == "class C_ClientRagdoll") then 
			if ent:IsValid() and !(ent == NULL) then
				SafeRemoveEntityDelayed( ent, 1 ) 
			end
		end
	end
	hook.Add("OnEntityCreated", "RemoveDeadRag", RemoveDeadRag)
	
end