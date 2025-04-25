--[[-------------------------------------------------------------------------
	Обязательные методы:
		:SetPrice()
		:SetDescription()

	Популярные:
		:SetTerm()
		:SetStackable()
		:SetCategory()
		:SetIcon()
		:SetOnActivate()
		:SetNetworked()
		:SetHidden()
		:SetHighlightColor()
		:SetDiscountedFrom()

	Подробнее и все остальные:
		gm-donate.ru/docs
--]]

local cats = { '• Аддоны •', '• Ранги •', '• Кастомизация •', '• События •', '• Карта •', '• Скиллы •', '• Kits •' }

	IGS( "PlayerModel", "addon_plymodel" )
:SetPrice( 75 )
:SetTerm( 0 )
:SetCategory( cats[1] )
:SetDescription([[ Приобрести разрешение на установку
	PlayerModel аддона из Workshop
	• Аддон не должен весить больше 32 мб в..
	Распакованном виде
	• Модель будет удалена, если донатер попадёт в Bad Entity]])
:SetIcon( "models/weapons/w_crossbow.mdl", true )
:SetOnActivate( function( ePly )
	ePly:Kill()
end )

	IGS( "Аддон", "addon_script" )
:SetPrice( 149 )
:SetTerm( 0 )
:SetCategory( cats[1] )
:SetDescription([[ Приобрести разрешение на установку
	Скрипта из Workshop
	• Аддон не должен весить больше 32 мб в..
	Распакованном виде
	• Скрипт будет удалён, если донатер попадёт в Bad Entity]])
:SetIcon( "models/weapons/w_crossbow.mdl", true )
:SetOnActivate( function( ePly )
	ePly:Kill()
end )

	IGS( "Твой Script", "addon_custom" )
:SetPrice( 250 )
:SetTerm( 0 )
:SetCategory( cats[1] )
:SetDescription([[ Заказать собственный скрипт:
	• По урегулированию требований надо обратиться к Titanovsky
	• Скрипт может быть индивидуальным для Вас, так и доступен для всех
	• Titanovsky имеет право отказать в услуге (возврата денег не будет)
	♦ Скрипт остаётся навсегда и может обновляться!]])
:SetIcon( "models/weapons/w_crossbow.mdl", true )
:SetOnActivate( function( ePly )
	ePly:Kill()
end )





--## RANKS ##############################

	IGS( "V.I.P (30 Дней)", "rank_vip" )
:SetPrice( 49 )
:SetTerm( 0 )
:SetCategory( cats[2] )
:SetDescription([[ Чуть попозже описуха будте)!]])
:SetIcon( "models/alyx.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'vip','30' )
end )
	IGS( "V.I.P (Навсегда)", "rank_vip_f" )
:SetPrice( 125 )
:SetTerm( 0 )
:SetCategory( cats[2] )
:SetDescription([[ Чуть попозже описуха будте)!]])
:SetIcon( "models/alyx.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'vip','4000' )
end )


	IGS( "Helper (30 Дней)", "rank_helper" )
:SetPrice( 75 )
:SetTerm( 0 )
:SetCategory( cats[2] )
:SetDescription([[ Чуть попозже описуха будте)!]])
:SetIcon( "models/alyx.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'helper','30' )
end )
	IGS( "Helper (Навсегда)", "rank_helper_f" )
:SetPrice( 145 )
:SetTerm( 0 )
:SetCategory( cats[2] )
:SetDescription([[ Чуть попозже описуха будте)!]])
:SetIcon( "models/alyx.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'vip','4000' )
end )


	IGS( "D-Officer (30 Дней)", "rank_d_officer" )
:SetPrice( 199 )
:SetTerm( 0 )
:SetCategory( cats[2] )
:SetDescription([[ Чуть попозже описуха будте)!]])
:SetIcon( "models/alyx.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'donate_officer','30' )
end )
	IGS( "D-Officer (Навсегда)", "rank_d_officer_f" )
:SetPrice( 249 )
:SetTerm( 0 )
:SetCategory( cats[2] )
:SetDescription([[ Чуть попозже описуха будте)!]])
:SetIcon( "models/alyx.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'd_officer','4000' )
end )


	IGS( "Officer (30 Дней)", "rank_officer" )
:SetPrice( 275 )
:SetTerm( 0 )
:SetCategory( cats[2] )
:SetDescription([[ Чуть попозже описуха будте)!]])
:SetIcon( "models/alyx.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'officer','30' )
end )
	IGS( "Officer (Навсегда)", "rank_officer_f" )
:SetPrice( 345 )
:SetTerm( 0 )
:SetCategory( cats[2] )
:SetDescription([[ Чуть попозже описуха будте)!]])
:SetIcon( "models/alyx.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'officer','4000' )
end )


	IGS( "D-Admin (30 Дней)", "rank_d_admin" )
:SetPrice( 385 )
:SetTerm( 0 )
:SetCategory( cats[2] )
:SetDescription([[ Чуть попозже описуха будте)!]])
:SetIcon( "models/alyx.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'd_admin','30' )
end )
	IGS( "D-Admin (Навсегда)", "rank_d_admin_f" )
:SetPrice( 500 )
:SetTerm( 0 )
:SetCategory( cats[2] )
:SetDescription([[ Чуть попозже описуха будте)!]])
:SetIcon( "models/alyx.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'd_admin','4000' )
end )








-- todo: попробовать :SetPerm() !!!
	IGS( "Картинка в TAB (30 дней)", "custom_tab" )
:SetPrice( 399 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Картинка в TAB Меню

	• Ваша собственная картинка!
	• На Ваш вкус и цвет.
	• Ограничения только на: эротику, порнографию, расчленёнку,
	пиар других серверов.]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky!')
end )

	IGS( "Картинка в TAB (Навсегда)", "custom_tab_f" )
:SetPrice( 600 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Картинка в TAB Меню

	• Ваша собственная картинка!
	• На Ваш вкус и цвет.
	• Ограничения только на: эротику, порнографию, расчленёнку,
	пиар других серверов.]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky!')
end )

	IGS( "Изменить имя", "custom_name" )
:SetPrice( 15 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Поменять игровое имя ]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Изменить модель [Outfitter]", "custom_outfitter" )
:SetPrice( 45 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Возможность пользоваться Outfitter
	• Точнее, выбрать модель в Outfitter (включить его может любой)
	• Данная возможность выдаётся навсегда ]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Снять Предупреждение", "custom_cancel_warn" )
:SetPrice( 75 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Снять Предупреждение
	• Данная возможность снимает один Warn! ]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Rainbow Color Model", "custom_rainbow" )
:SetPrice( 165 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Радужная Модель Игрока
	• Окрашивает Вашу модель в радужный цвет
	• Цвет переливается каждую секунду ]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Стать Королём Сервера (14 дней)", "custom_king" )
:SetPrice( 300 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Король Сервера
	• Вы (независимо на сервере находитесь или нет) автоматом собираете дань с каждого Пейдея
	• Если у игрока 5 уровень или больше, он платит Вам дань в размере 12 Био. Эссенций
	• Если у игрока 8 уровень или больше, он платит Вам дань в размере 21 Био. Эссенция
	• Вы появляетесь с 200 ХП и 50 Armor в PVP-статусе!]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Вызвать Миньона", "custom_bots" )
:SetPrice( 12 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Миньоны:
	• Призываете Миньона, которые будут добывать вам Био. Энергию.
	• У него будет 1200 HP. Он не умеет сражаться.
	• Каждую 60 секунд добывает Вам по 3 Био. Энергии
	• Био. Энергию можно переработать в Био. Эссенцию, либо создать NPC
	]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	RunConsoleCommand('bot', '')
end )

	IGS( "Био. Эссенция", "custom_case_money" )
:SetPrice( 45 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Кейс:
	• Выдаёт случайную сумму денег
	• У него будет 1200 HP. Он не умеет сражаться
	• Каждую 60 секунд добывает Вам по 3 Био. Энергии
	• Био. Энергию можно переработать в Био. Эссенцию, либо создать NPC или Редкую Пушку
	]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )


	IGS( "Био. Эссенция [Мешочек]", "custom_money1" )
:SetPrice( 35 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Био. Эссенция - Валюта Сервера [RUs]:
	• Выдаёт 60 Био. Эссенций
	]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Био. Эссенция [Коробка]", "custom_money2" )
:SetPrice( 95 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Био. Эссенция - Валюта Сервера [RUs]:
	• Выдаёт 180 Био. Эссенций
	]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Био. Эссенция [Ящик]", "custom_money3" )
:SetPrice( 175 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Био. Эссенция - Валюта Сервера [RUs]:
	• Выдаёт 500 Био. Эссенций
	]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Био. Эссенция [Сейф]", "custom_money4" )
:SetPrice( 250 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Био. Эссенция - Валюта Сервера [RUs]:
	• Выдаёт 1200 Био. Эссенций
	]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Кейс [Денежный]", "custom_case_money" )
:SetPrice( 75 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Кейс:
	• Выдаёт случайную сумму денег [60 | 1500]
	• Для открытия нужен ключ
	• Каждую 60 секунд добывает Вам по 3 Био. Энергии
	• Био. Энергию можно переработать в Био. Эссенцию, либо создать NPC
	]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Кейс [Оружейный]", "custom_case_weapons" )
:SetPrice( 10 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Кейс:
	• Выдаёт случайные Редкие Пушки + Патроны
	• Выдаёт 350 HP и 100 Armor
	• Для открытия НЕ нужен ключ
	• Пока вы не отключились от сервера, вы можете раз в 500 секунд спавнить этот кейс
	]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Кейс [Fun]", "custom_case_fun" )
:SetPrice( 10 )
:SetTerm( 0 )
:SetCategory( cats[3] )
:SetDescription([[ Кейс:
	• Выдаёт Случайные События ( 20 событий )
	• Для открытия нужен ключ
	• Например: Во время сессии (пока не отключились) Вам будет выдаваться 1337 HP
	• Ваша Моделька будет меняться от Птицы до Золотого Унитаза
	• Призвать Смерть, которая убьёт всех игроков в PVP и RP статусе
	• Заспавнить мешочек с Био. Эссенции (600)
	• И прочее.. Ни только игровые моменты, но и донат.
	• Ни только с Вами, но и со всем сервером!
	]])
:SetIcon( "models/props_buildings/row_res_1_fullscale.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	local key_money = IGS( "Ключ", "custom_key_money" )
:SetPrice( 0 )
:SetDescription("Ключ от Денежного Кейса")
:SetStackable()
:SetHidden()
:SetOnActivate( function( ePly )
end )

	IGS("Связка Ключей [Денежный]", "custom_pack_key_money" )
:SetPrice( 15 )
:SetCategory( cats[3] )
:SetDescription("• 2 комплекта Денежных Ключей")
:SetStackable()
:SetItems( { key_money, key_money } ) -- вы можете использовать и разные предметы

	local key_fun = IGS( "Ключ", "custom_key_fun" )
:SetPrice( 0 )
:SetDescription("Ключ от Fun Кейса")
:SetStackable()
:SetHidden()
:SetOnActivate( function( ePly )
end )

	IGS("Связка Ключей [Fun]", "custom_pack_key_fun" )
:SetPrice( 30 )
:SetCategory( cats[3] )
:SetDescription("• 3 комплекта Fun Ключей")
:SetStackable()
:SetItems( { key_money, key_money } ) -- вы можете использовать и разные предметы








	IGS( "Метеорит", "event_meteorit" )
:SetPrice( 9999 )
:SetTerm( 0 )
:SetCategory( cats[4] )
:SetDescription([[ • Подождите немножко.. ]])
:SetIcon( "models/hunter/misc/sphere175x175.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Землятрясение", "event_quakeearth" )
:SetPrice( 9999 )
:SetTerm( 0 )
:SetCategory( cats[4] )
:SetDescription([[ • Подождите немножко.. ]])
:SetIcon( "models/hunter/misc/sphere175x175.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Покраснение", "event_red_color" )
:SetPrice( 9999 )
:SetTerm( 0 )
:SetCategory( cats[4] )
:SetDescription([[ • Подождите немножко.. ]])
:SetIcon( "models/hunter/misc/sphere175x175.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Потемнее", "event_dark_color" )
:SetPrice( 9999 )
:SetTerm( 0 )
:SetCategory( cats[4] )
:SetDescription([[ • Подождите немножко.. ]])
:SetIcon( "models/hunter/misc/sphere175x175.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Поголубение", "event_blue_color" )
:SetPrice( 9999 )
:SetTerm( 0 )
:SetCategory( cats[4] )
:SetDescription([[ • Подождите немножко.. ]])
:SetIcon( "models/hunter/misc/sphere175x175.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Зомби-Апокалипсис", "event_zombie" )
:SetPrice( 9999 )
:SetTerm( 0 )
:SetCategory( cats[4] )
:SetDescription([[ • Подождите немножко.. ]])
:SetIcon( "models/Zombie/Classic_torso.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Нашествие Альянса", "event_combine" )
:SetPrice( 9999 )
:SetTerm( 0 )
:SetCategory( cats[4] )
:SetDescription([[ • Подождите немножко.. ]])
:SetIcon( "models/Combine_Soldier.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Атака Григориев", "event_monks" )
:SetPrice( 9999 )
:SetTerm( 0 )
:SetCategory( cats[4] )
:SetDescription([[ • Подождите немножко.. ]])
:SetIcon( "models/monk.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Оповещение", "event_message" )
:SetPrice( 9999 )
:SetTerm( 0 )
:SetCategory( cats[4] )
:SetDescription([[ • Подождите немножко.. ]])
:SetIcon( "models/extras/info_speech.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

	IGS( "Громкое Оповещение", "event_message_with_sound" )
:SetPrice( 9999 )
:SetTerm( 0 )
:SetCategory( cats[4] )
:SetDescription([[ • Подождите немножко.. ]])
:SetIcon( "models/extras/info_speech.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )







	IGS( "Обычный дом", "map_home" )
:SetPrice( 55 )
:SetTerm( 0 )
:SetCategory( cats[5] )
:SetDescription([[ Создание Вашего дома на карте в Hammer Editor

	• Это не пропы, а элементы карты (браши)
	• Рабочие двери и окна
	• Максимум 3 этажа у частного дома и 4 этажа у офиса/подъезда
	• Срок неограничен
	• По Вашим чертежам или на усмотрение Titanovsky ]])
:SetIcon( "models/hunter/blocks/cube025x025x025.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky!')
end )

	IGS( "Улучшенный дом", "map_adv_home" )
:SetPrice( 175 )
:SetTerm( 0 )
:SetCategory( cats[5] )
:SetDescription([[ Создание Вашего дома на карте в Hammer Editor

	• Всё тоже самое, что и у Обычного Дома, но..
	• Возможность добавить разный функционал
	• Возможность добавление подземной части (бункер, подвал)
	• Дом может распологаться не только в RP зоне (в спавн зоне запрещено!)]])
:SetIcon( "models/hunter/blocks/cube025x025x025.mdl", true )
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky!')
end )

