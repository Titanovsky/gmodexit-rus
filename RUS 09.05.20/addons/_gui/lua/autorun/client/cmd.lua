local propsMax = 250
local vk = "https://vk.com/ru_reborn"
local discord = "https://discord.gg/G4vzxrq"
local steam = "http://steamcommunity.com/groups/gmodserverrus"

function ru_showCmds( n )
	local ply = LocalPlayer()
	local props = ply:GetCount("props")

	if n == 1 then

		chat.AddText( Color( 255, 255, 0 ), "\n      Статистика:" )
		chat.AddText( Color( 255, 255, 0 ), "-----------------------" )
		chat.AddText( Color( 255, 255, 0 ), "[1] Кошелёк: "..ply:GetNWInt("rub").." Рубаксов" )
		chat.AddText( Color( 255, 255, 0 ), "[2] FriskCoins: "..ply:GetNWInt("friskCoins").." FC" )
		chat.AddText( Color( 255, 255, 0 ), "[3] Уровень: "..ply:GetNWInt("lvl") )
		chat.AddText( Color( 255, 255, 0 ), "[4] EXP: "..ply:GetNWInt("exp").."/"..ply:GetNWInt("next_exp") )
		chat.AddText( Color( 255, 255, 0 ), "[5] E2 Эксеса: "..ply:GetNWInt("e2ac") )
		chat.AddText( Color( 255, 255, 0 ), "[6] Props: "..props.."/"..propsMax )
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
		chat.AddText( Color( 224, 193, 108 ), "\nВременно нет [Контента]!" )

	 elseif n == 5 then
		ply:ConCommand("ulx motd")

	 elseif n == 6 then
		chat.AddText( Color( 224, 193, 108 ), "\ndiscord.gg/G4vzxrq" )
		gui.OpenURL( "https://discord.gg/G4vzxrq" )

	 elseif n == 7 then
		chat.AddText( Color( 224, 193, 108 ), "\nvk.com/ru_reborn" )
		gui.OpenURL( "https://vk.com/ru_reborn" )

	 elseif n == 8 then
		chat.AddText( Color( 224, 193, 108 ), "\nsteamcommunity.com/groups/gmodserverrus" )
		gui.OpenURL( "http://steamcommunity.com/groups/gmodserverrus" )

	 elseif n == 9 then
		сhat.AddText( Color( 255, 255, 255 ), '\nЧасто задаваемые вопросы:' )
		chat.AddText( Color( 0, 191, 255 ), "-----------------------" )
		chat.AddText( Color( 255, 0, 0 ), "1. Уровень прокачивается, когда EXP достигает макс. значения." )
		chat.AddText( Color( 255, 197, 74 ), "2. Каждые 10 минут приходит Зарплата: 12000 Рубаксов, 2 FC." )
		chat.AddText( Color( 255, 238, 255 ), "3. Также каждую Зарплату добавляется одна EXP." )
		chat.AddText( Color( 0, 255, 96 ), "4. Если Вам не добавилась EXP значит Вы отыграли мало времени." )
		chat.AddText( Color( 0, 191, 255 ), "5. Пропы имеют лимит, каждый LVL этот лимит увеличивает --> /stats" )
		chat.AddText( Color( 0, 134, 214 ), "6. Ентити (общие): 100 Рубаксов, Weapons (общие): 150 Рубаксов." )
		chat.AddText( Color( 29, 0, 255 ), "7. Если вы Минг (1 и 2 lvl) над вами можно издеваться." )
		chat.AddText( Color( 58, 53, 53 ), "7. Фриск Коины нужны для Frisk Shop ---> /shop" )
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
	end
end