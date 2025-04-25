local propsMax = 250
local vk = "https://vk.com/ambgmod"
local discord = "https://discord.gg/G4vzxrq"
local steam = "http://steamcommunity.com/groups/ambitiongmod"

local COLOR_BRACKET = Color( 196, 196, 196 )
local COLOR_SUPERADMIN = Color( 196, 57, 57 )
local COLOR_VIP = Color( 224, 209, 0 )
local COLOR_USER = Color( 54, 195, 227 )
local COLOR_OFFICER = Color(243, 156, 18)
local COLOR_ADMIN = Color(46, 204, 113)
local COLOR_AVK = Color(155, 89, 182)
local COLOR_TEXT = Color( 255, 255, 255 )
local COLOR_TITANOVSKY = Color(255, 159, 243)


hook.Add( "OnPlayerChat", "rus_tags_chat", function( ply, text)
	if ply==nil or ply == Entity(-1) then
		local C= Color(255,255,255)
		chat.AddText( COLOR_BRACKET, "[", C, "UNKNOW", COLOR_BRACKET, "]", COLOR_TEXT, " "..text )
	else
		local C= team.GetColor(ply:Team())
		chat.AddText( COLOR_BRACKET, "[", C, ply:Nick(), COLOR_BRACKET, "]", COLOR_TEXT, " "..text )
	end


	return true
end)


function ru_showCmds( n )
	local ply = LocalPlayer()
	local props = ply:GetCount("props")

	if n == 1 then

		chat.AddText( Color( 255, 255, 0 ), "\n      Статистика:" )
		chat.AddText( Color( 255, 255, 0 ), "-----------------------" )
		chat.AddText( Color( 255, 255, 0 ), "[1] Кошелёк: "..ply:GetNWInt("rub").." Рубаксов" )
		chat.AddText( Color( 255, 255, 0 ), "[2] Уровень: "..ply:GetNWInt("lvl") )
		chat.AddText( Color( 255, 255, 0 ), "[3] EXP: "..ply:GetNWInt("exp").."/"..ply:GetNWInt("next_exp") )
		chat.AddText( Color( 255, 255, 0 ), "[4] E2 Эксеса: "..ply:GetNWInt("e2ac") )
		chat.AddText( Color( 255, 255, 0 ), "[5] Props: "..props.."/"..propsMax )
		chat.AddText( Color( 255, 255, 0 ), "-----------------------" )

	 elseif n == 2 then
		chat.AddText( Color( 255, 255, 255 ), "\n[RU's]-", Color(0, 255, 97), " Сандбокс сервер:", Color(58, 53, 53), " PVP,", Color(0, 191, 255), " Build,", Color(255, 0, 0), " Coding" )
		chat.AddText( Color( 255, 255, 255 ), "Узнать статистику:", Color(255, 197, 74), " /stats", Color(22, 197, 74), " | ", Color(255, 255, 255), "Правила:", Color(255, 197, 74), " /rules" )
		chat.AddText( Color( 255, 255, 255 ), "Часто задаваемые вопросы:", Color(255, 0, 0), " /FAQ" )
		chat.AddText( Color( 255, 255, 255 ), "Все команды:", Color(255, 197, 74), " /cmd" )
		chat.AddText( Color( 255, 255, 255 ), "Донат:", Color(0, 191, 255), " /donate" )

	 elseif n == 3 then
		chat.AddText( Color( 224, 193, 108 ), '\nКоманды работают как с "!" так и со "/"' )
		chat.AddText( Color( 224, 193, 108 ), "hud | panel | wallet | logo | dev" )
		chat.AddText( Color( 224, 193, 108 ), "help | cmd | donate | rules | stats | faq" )
		chat.AddText( Color( 224, 193, 108 ), "shop | content | steam | discord | vk" )

	 elseif n == 4 then
		chat.AddText( Color( 224, 193, 108 ), "\nsteamcommunity.com/sharedfiles/filedetails/?id=2041976090" )
		gui.OpenURL( "https://steamcommunity.com/sharedfiles/filedetails/?id=2041976090" )

	 elseif n == 5 then
		ply:ConCommand("motd_open")

	 elseif n == 6 then
		chat.AddText( Color( 224, 193, 108 ), discord )
		gui.OpenURL( discord )

	 elseif n == 7 then
		chat.AddText( Color( 224, 193, 108 ), vk )
		gui.OpenURL( vk )

	 elseif n == 8 then
		chat.AddText( Color( 224, 193, 108 ), steam )
		gui.OpenURL( steam )

	 elseif n == 9 then
		chat.AddText( Color( 255, 255, 255 ), "\nЧасто задаваемые вопросы:" )
		chat.AddText( Color( 0, 191, 255 ), "-----------------------" )
		chat.AddText( Color( 255, 0, 0 ), "1. Уровень прокачивается, когда EXP достигает макс. значения." )
		chat.AddText( Color( 255, 197, 74 ), "2. Каждые 10 минут приходит Зарплата: от 800 до 5к + надбавка к уровню." )
		chat.AddText( Color( 255, 238, 255 ), "3. Каждую зарплату добавляется одна EXP." )
		chat.AddText( Color( 0, 255, 96 ), "4. Если Вам не добавилась EXP значит Вы отыграли мало времени." )
		chat.AddText( Color( 0, 191, 255 ), "5. Пропы имеют лимит, только для обычных игроков --> /stats" )
		chat.AddText( Color( 0, 134, 214 ), "6. Ентити (общие): 100 Рубаксов, Weapons (общие): 150 Рубаксов." )
		chat.AddText( Color( 0, 134, 214 ), "7. Шахта не далеко от спавна | Нужно купить кирку." )
		chat.AddText( Color( 0, 134, 214 ), "8. Продать руду: /selloreall." )
		chat.AddText( Color( 0, 191, 255 ), "-----------------------" )

	 elseif n == 10 then
		if GetConVar("ru_hud_enable"):GetInt() == 1 then
    		GetConVar("ru_hud_enable"):SetInt(0)
    	 else
    		GetConVar("ru_hud_enable"):SetInt(1)
    	end

	 elseif n == 11 then
		if GetConVar("ru_hud_wallet_enable"):GetInt() == 1 then
    		GetConVar("ru_hud_wallet_enable"):SetInt(0)
    	 else
    		GetConVar("ru_hud_wallet_enable"):SetInt(1)
    	end

     elseif n == 12 then
		if GetConVar("ru_name_enable"):GetInt() == 1 then
    		GetConVar("ru_name_enable"):SetInt(0)
    	 else
    		GetConVar("ru_name_enable"):SetInt(1)
    	end
     elseif n == 13 then
		if GetConVar("ru_admin_gui"):GetInt() == 1 then
    		GetConVar("ru_admin_gui"):SetInt(0)
    	 else
    		GetConVar("ru_admin_gui"):SetInt(1)
    	end
     elseif n == 14 then
		if GetConVar("ru_prop_gui"):GetInt() == 1 then
    		GetConVar("ru_prop_gui"):SetInt(0)
    	 else
    		GetConVar("ru_prop_gui"):SetInt(1)
    	end
     elseif n == 15 then
		if GetConVar("ru_crosshair_cvar"):GetInt() == 1 then
    		GetConVar("ru_crosshair_cvar"):SetInt(0)
    	 else
    		GetConVar("ru_crosshair_cvar"):SetInt(1)
    	end
	end
end