--[[-------------------------------------------------------------------------
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

		gm-donate.ru/docs
--]]

local cats = { '• Аддоны', '• Ранги', '• Кастомизация', '• События', '• Карта', '• Валюта', '• Кейсы', '» Kits' }

IGS( "PlayerModel", "addon_plymodel" )
	:SetPrice( 25 )
	:SetDiscountedFrom( 75 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[1] )
	:SetDescription([[ Аддон из Workshop:

		• Аддон остаётся навсегда!
		• Аддон не должен весить больше 32 мб в распакованном виде
		• После установки аддон нельзя будет поменять
		• Аддон будет удалён, если сервер будет сильно нагружаться от скрипта
		• Аддон будет удалён, если донатер будет мешать другим людям
		• Скрипт будет удалён, если донатер попадёт в Bad Entity]])
	:SetOnActivate( function( ePly )
		ePly:ChatPrint('Обратитесь к Титановскому!')
		ePly:ChatPrint('Скрипт не должен весить больше 32 мб в РАСПАКОВАННОМ ВИДЕ!')
end )

IGS( "Аддон", "addon_script" )
	:SetPrice( 50 )
	:SetDiscountedFrom( 150 )
	:SetTerm( 21 )
	:SetCategory( cats[1] )
	:SetDescription([[ Аддон из Workshop:

		• Аддон будет всего 21 дней!
		• Аддон не должен весить больше 128 мб в распакованном виде
		• После установки аддон нельзя будет поменять
		• Аддон будет удалён, если сервер будет сильно нагружаться от скрипта
		• Аддон будет удалён, если донатер будет мешать другим людям
		• Скрипт будет удалён, если донатер попадёт в Bad Entity]])
	:SetOnActivate( function( ePly )
		ePly:ChatPrint('Обратитесь к Титановскому!')
		ePly:ChatPrint('Скрипт не должен весить больше 128 мб в РАСПАКОВАННОМ ВИДЕ!')
end )

IGS( "Аддон", "addon_script1" )
	:SetPrice( 99 )
	:SetDiscountedFrom( 250 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[1] )
	:SetDescription([[ Аддон из Workshop:

		• Аддон остаётся навсегда!
		• Аддон не должен весить больше 64 мб в распакованном виде
		• После установки аддон нельзя будет поменять
		• Аддон будет удалён, если сервер будет сильно нагружаться от скрипта
		• Аддон будет удалён, если донатер будет мешать другим людям
		• Скрипт будет удалён, если донатер попадёт в Bad Entity]])
	:SetOnActivate( function( ePly )
		ePly:ChatPrint('Обратитесь к Титановскому!')
		ePly:ChatPrint('Скрипт не должен весить больше 64 мб в РАСПАКОВАННОМ ВИДЕ!')
end )

IGS( "Личный Addon", "addon_custom" )
	:SetPrice( 99 )
	:SetDiscountedFrom( 250 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[1] )
	:SetIcon( 'https://i.imgur.com/sozRpIO.png' )
	:SetDescription([[ Заказать собственный скрипт:

		• По урегулированию требований надо обратиться к Titanovsky
		• Скрипт может быть индивидуальным для Вас, так и доступен для всех
		• Titanovsky имеет право отказать в услуге (возврата денег не будет)

		♦ Скрипт остаётся навсегда и может обновляться!]])
	:SetOnActivate( function( ePly )
		ePly:Kill()
end )
-- ## ############################################










--## RANKS ##############################

IGS( "VIP 30д", "rank_vip" )
	:SetPrice( 15 )
	:SetDiscountedFrom( 45 )
	:SetTerm( 30 )
	:SetCategory( cats[2] )
	:SetIcon( 'https://cdn.discordapp.com/attachments/765965677017169970/770363897391087676/VIP.png' )
	:SetDescription([[ Привилегия — VIP
	• Услуга всего лишь на 30 дней
	• Проп лимит увеличен
	• Доступны некоторые Инструменты
	• Огромные шансы пройти набор на хелпера

	• Вы просто становитесь пирожочкем ( ͡° ͜ʖ ͡°) ]])
	:SetOnActivate( function( ePly )
		RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'vip','30' )
end )

IGS( "VIP", "rank_vip1" )

	:SetPrice( 45 )
	:SetDiscountedFrom( 99 )
	:SetCategory( cats[2] )
	:SetDescription([[ Привилегия — VIP
	• Услуга остаётся навсегда
	• Проп лимит увеличен
	• Доступны некоторые Инструменты
	• Огромные шансы пройти набор на хелпера

	• Вы просто становитесь пирожочкем ( ͡° ͜ʖ ͡°) ]])

	:SetTerm( 0 )
	:SetIcon( 'https://cdn.discordapp.com/attachments/765965677017169970/770363897391087676/VIP.png' )
	:SetOnActivate( function( ePly )
		RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'vip','4000' )

end )


IGS( "Хелпер 30д", "rank_helper" )
	:SetPrice( 75 )
	:SetDiscountedFrom( 149 )
	:SetTerm( 0 )
	:SetCategory( cats[2] )
	:SetDescription([[ Чуть попозже описуха будте)!]])
	:SetIcon( 'https://cdn.discordapp.com/attachments/765965677017169970/770363900100739103/HElper.png' )
	:SetOnActivate( function( ePly )
		RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'helper','30' )
end )

IGS( "Хелпер", "rank_helper1" )
	:SetPrice( 100 )
	:SetDiscountedFrom( 250 )
	:SetTerm( 0 )
	:SetCategory( cats[2] )
	:SetDescription([[ Чуть попозже описуха будте)!]])
	:SetIcon( 'https://cdn.discordapp.com/attachments/765965677017169970/770363900100739103/HElper.png' )
	:SetOnActivate( function( ePly )
		RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'helper','4000' )
end )


IGS( "Офицер 30д", "rank_officer" )
	:SetPrice( 100 )
	:SetDiscountedFrom( 200 )
	:SetTerm( 0 )
	:SetCategory( cats[2] )
	:SetDescription([[ Чуть попозже описуха будте)!]])
	:SetOnActivate( function( ePly )
		RunConsoleCommand('ulx', 'adduserid', ePly:SteamID(), 'officer', '30' )
end )

IGS( "Офицер", "rank_officer1" )
	:SetPrice( 150 )
	:SetDiscountedFrom( 300 )
	:SetTerm( 0 )
	:SetCategory( cats[2] )
	:SetDescription([[ Чуть попозже описуха будте)!]])
	:SetOnActivate( function( ePly )
		RunConsoleCommand('ulx', 'adduserid', ePly:SteamID(), 'officer', '4000' )
end )


IGS( 'Администратор 30д', "rank_admin" )
	:SetPrice( 200 )
	:SetDiscountedFrom( 350 )
	:SetTerm( 0 )
	:SetCategory( cats[2] )
	:SetDescription([[ Чуть попозже описуха будте)!]])
	:SetIcon( 'https://i.imgur.com/AUtG2bf.png' )
	:SetOnActivate( function( ePly )
		RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'admin','30' )
end )

IGS( 'Администратор', "rank_admin1" )
	:SetPrice( 300 )
	:SetDiscountedFrom( 450 )
	:SetTerm( 0 )
	:SetCategory( cats[2] )
	:SetDescription([[ Чуть попозже описуха будте)!]])
	:SetIcon( 'https://i.imgur.com/AUtG2bf.png' )
	:SetOnActivate( function( ePly )
		RunConsoleCommand('ulx', 'adduserid',ePly:SteamID(), 'admin','3998' )
end )
-- ## ############################################################











-- ## ############################################################
IGS( "Картинка в TAB", "custom_tab" )
	:SetPrice( 75 )
	:SetDiscountedFrom( 150 )
	:SetTerm()
	:SetCategory( cats[3] )
	:SetDescription([[ Картинка в TAB Меню

		• Размер: 624x78
		• Картинка всего лишь на 30 дней!
		• Ваша собственная картинка!
		• На Ваш вкус и цвет.
		• Ограничения только на: эротику, порнографию, расчленёнку,
		пиар других серверов.]])
	:SetOnActivate( function( ePly )
		ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky!')
end )

IGS( "Изменить имя", "custom_name" )
	:SetPrice( 5 )
	:SetTerm( 0 )
	:SetCategory( cats[3] )
	:SetDescription([[ • Поменять игровое имя ]])
	:SetOnActivate( function( ePly )
		ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky!')
end )


IGS( "Снять Предупреждение", "custom_cancel_warn" )
	:SetPrice( 25 )
	:SetTerm( 0 )
	:SetCategory( cats[3] )
	:SetDescription([[ Снять Предупреждение
		• Данная возможность снимает один Warn! ]])
	:SetOnActivate( function( ePly )
		ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky! Данная функция ещё не готова :(')
end )

IGS( "Вызвать Бота", "custom_bots" )
	:SetPrice( 1 )
	:SetTerm( 0 )
	:SetCategory( cats[3] )
	:SetDescription([[ Боты:
		• Да и фиг с ними, пусть будут :D]])
	:SetOnActivate( function( ePly )
		RunConsoleCommand( 'bot', '' )
end )
-- ## ############################################













-- ## ############################################################
IGS( "Метеорит", "event_meteorit" )
	:SetPrice( 15 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[4] )
	:SetDescription([[ Донатный Ивент:
		• Вызывает землятрясение 60 секунд
		• Метеорит падает на землю и убивает всех
		• Поможет просраться всем игрокам от неожиданности :) ]])
	:SetOnActivate( function( ePly )
		AmbEvents.D_Events.startEvent( 'meteorit' )
end )

IGS( "Землятрясение", "event_quakeearth" )
	:SetPrice( 15 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[4] )
	:SetDescription([[ Донатный Ивент:
		• Вызывает землятрясение 60 секунд
		• Поможет просраться всем игрокам от неожиданности :) ]])
	:SetOnActivate( function( ePly )
		AmbEvents.D_Events.startEvent( 'earthquake' )
end )

IGS( "Покраснение", "event_red_color" )
	:SetPrice( 10 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[4] )
	:SetDescription([[ Донатный Ивент:
		• Вызывает Красный цвет всего экрана на 60 секунд]])
	:SetOnActivate( function( ePly )
		AmbEvents.D_Events.startEvent( 'colorized', Color( 255, 0, 0 ) )
end )

IGS( "Потемнение", "event_dark_color" )
	:SetPrice( 10 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[4] )
	:SetDescription([[ Донатный Ивент:
		• Вызывает Темный цвет всего экрана на 60 секунд]])
	:SetOnActivate( function( ePly )
		AmbEvents.D_Events.startEvent( 'colorized', Color(0,0,0) )
end )

IGS( "Поголубение", "event_blue_color" )
	:SetPrice( 10 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[4] )
	:SetDescription([[ Донатный Ивент:
		• Вызывает Красный цвет всего экрана на 60 секунд
		• Случайный игрок становится Голубым]])
	:SetOnActivate( function( ePly )
		AmbEvents.D_Events.startEvent( 'choice_blue' )
end )

IGS( "Пожелтение", "event_yellow_color" )
	:SetPrice( 10 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[4] )
	:SetDescription([[ Донатный Ивент:
		• Вызывает Жёлтый цвет всего экрана на 60 секунд]])
	:SetOnActivate( function( ePly )
		AmbEvents.D_Events.startEvent( 'colorized', Color(255,255,0) )
end )

IGS( "Побеление", "event_white_color" )
	:SetPrice( 10 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[4] )
	:SetDescription([[ Донатный Ивент:
		• Вызывает Белый цвет всего экрана на 60 секунд]])
	:SetOnActivate( function( ePly )
		AmbEvents.D_Events.startEvent( 'colorized', Color(255,255,255) )
end )

IGS( "Оповещение", "event_message" )
	:SetPrice( 10 )
	:SetTerm( 0 )
	:SetCategory( cats[4] )
	:SetStackable( true )
	:SetDescription([[ Донатный Ивент:
		• Вызывает сообщение на 2 минуты в центр экрана]])
	:SetOnActivate( function( ePly )
		ePly:SetNWBool( 'donat_msg', true )
		ePly:SendLua( 'AmbEvents.openMenuMessage(1)' )
end )

IGS( "Громкое Оповещение", "event_message_with_sound" )
	:SetPrice( 20 )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[4] )
	:SetDescription([[ • Вызывает сообщение на 2 минуты в центр экрана
	• Даёт просраться людям из-за неожиданного звука]])
	:SetOnActivate( function( ePly )
		ePly:SetNWBool( 'donat_msg', true )
		ePly:SendLua( 'AmbEvents.openMenuMessage(2)' )
end )
-- ## ############################################














-- ## ############################################
local icons_homes = { 'https://image.flaticon.com/icons/png/512/25/25694.png', 'https://www.iconfinder.com/data/icons/user-interface-vol-5-4/66/2-512.png' }
IGS( "Обычный дом", "map_home" )
	:SetPrice( 100 )
	:SetIcon( icons_homes[1] )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[5] )
	:SetDescription([[ Создание Вашего дома на карте в Hammer Editor

		• Это не пропы, а элементы карты (браши)
		• Рабочие двери и окна
		• Максимум 1 этаж у частного дома и 3 этажа у офиса/подъезда
		• Срок неограничен
		• По Вашим чертежам или на усмотрение Titanovsky ]])
:SetOnActivate( function( ePly )
	ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky!')
end )

IGS( "Улучшенный дом", "map_adv_home" )
	:SetPrice( 150 )
	:SetDiscountedFrom( 250 )
	:SetIcon( icons_homes[2] )
	:SetTerm( 0 )
	:SetStackable( true )
	:SetCategory( cats[5] )
	:SetDescription([[ Создание Вашего дома на карте в Hammer Editor

		• Всё тоже самое, что и у Обычного Дома, но..
		• Возможность добавить разный функционал  ( Например, лифт )
		• Возможность добавление подземной части (бункер, подвал)
		• Дом может распологаться не только в RP зоне (в спавн зоне запрещено!)]])
	:SetOnActivate( function( ePly )
		ePly:ChatPrint('Пожалуйста, обратитесь к Titanovsky!')
end )
-- ## ############################################










-- ## ############################################
IGS( "Мешочек с говном", "custom_money1" )
	:SetPrice( 25 )
	:SetTerm( 0 )
	:SetIcon( 'https://image.flaticon.com/icons/png/512/189/189093.png' )
	:SetStackable( true )
	:SetCategory( cats[6] )
	:SetDescription([[ Био. Эссенция - Валюта Сервера [RUs]:
		• Выдаёт 200 Биологической Эссенций]])
	:SetOnActivate( function( ePly )
		AmbStats.Players.addStats( ePly, '$', 200 )
end )

IGS( "Коробочка", "custom_money2" )
	:SetPrice( 99 )
	:SetTerm( 0 )
	:SetIcon( 'https://image.flaticon.com/icons/png/512/189/189093.png' )
	:SetStackable( true )
	:SetCategory( cats[6] )
	:SetDescription([[ Био. Эссенция - Валюта Сервера [RUs]:
		• Выдаёт 2.000 Биологической Эссенций]])
	:SetOnActivate( function( ePly )
		AmbStats.Players.addStats( ePly, '$', 2000 )
end )

IGS( "Украденный Сейф", "custom_money3" )
	:SetPrice( 199 )
	:SetTerm( 0 )
	:SetIcon( 'https://image.flaticon.com/icons/png/512/189/189093.png' )
	:SetStackable( true )
	:SetCategory( cats[6] )
	:SetDescription([[ Био. Эссенция - Валюта Сервера [RUs]:
		• Выдаёт 8.000 Биологической Эссенций]])
	:SetOnActivate( function( ePly )
		AmbStats.Players.addStats( ePly, '$', 8000 )
end )

IGS( "Потерянный Клад", "custom_money4" )
	:SetPrice( 299 )
	:SetTerm( 0 )
	:SetIcon( 'https://image.flaticon.com/icons/png/512/189/189093.png' )
	:SetStackable( true )
	:SetCategory( cats[6] )
	:SetDescription([[ Био. Эссенция - Валюта Сервера [RUs]:
		• Выдаёт 16.000 Биологической Эссенций]])
	:SetOnActivate( function( ePly )
		AmbStats.Players.addStats( ePly, '$', 16000 )
end )
-- ## ############################################
