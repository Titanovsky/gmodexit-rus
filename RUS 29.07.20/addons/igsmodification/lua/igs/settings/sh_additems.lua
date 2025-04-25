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

	Бесплатная быстрая помощь и настройка:
		gm-donate.ru/support
---------------------------------------------------------------------------]]

-- IGS("Отмычка", "otmichka") -- второй параметр не должен(!) повторяться с другими предметами
-- 	:SetPrice(1) -- 1 рубль

-- 	-- 0 - одноразовое (Т.е. купил, выполнилось OnActivate и забыл. Полезно для валюты)
-- 	-- 30 - месяц, 7 - неделя и т.д. :SetPerma() - навсегда
-- 	:SetTerm(30)

-- 	:SetDarkRPItem("lockpick") -- реальный класс энтити
-- 	:SetDescription("Разрешает вам покупать отмычку") -- описание
-- 	:SetCategory("Оружие") -- категория

-- 	-- квадратная ИКОНКА (Не обязательно). Отобразится на главной странице. Может быть с прозрачностью
-- 	:SetIcon("http://i.imgur.com/4zfVs9s.png")

-- 	-- БАННЕР 1000х400 (Не обязательно). Отобразится в подробностях итема
-- 	:SetImage("http://i.imgur.com/RqsP5nP.png")



IGS("Suasd", "vip")
	:SetPrice(45)
	:SetCategory("Ранги")
	:SetDescription("[1] Увеличен лимит пропов до 9999\n[2] Доступны многие инструменты\n[3] Выдаётся навсегда ;3")
	:SetOnActivate( function( ply )
		ply:SetUserGroup("vip")
		ply:ChatPrint("Пожалуйста, обратитесь к Суперадмину, чтобы вам выдали ранг")
	end )

	IGS("!SuperAdmin", "adsdasdasd")
	:SetPrice(999)
	:SetCategory("Ранги")
	:SetDescription("[1] ДАЁТ БОГОМ СЕРВЕРА НАВСЕГДА")
	:SetOnActivate( function( ply )
		ply:SetUserGroup("vip")
		ply:ChatPrint("Пожалуйста, обратитесь к Суперадмину, чтобы вам выдали ранг")
	end )

IGS("Офицер", "officer")
	:SetPrice( 149 )
	:SetCategory("Ранги")
	:SetDescription("[1] Доступны админ команды\n[2] Доступен спавн всего\n[3]Выдаётся навсегда ;3")
	:SetOnActivate( function( ply )
		ply:SetUserGroup("officer")
		ply:ChatPrint("Пожалуйста, обратитесь к Суперадмину, чтобы вам выдали ранг")
	end )

IGS("Админ", "adm")
	:SetPrice( 299 )
	:SetTerm(0)
	:SetCategory("Ранги")
	:SetDescription("[1] Можете банить людей да-да\n[2] Можете выдавать себе денюшку да-да\n[3] Выдаётся навсегда ;3")
	:SetOnActivate( function( ply )
		ply:SetUserGroup("admin")
		ply:ChatPrint("Пожалуйста, обратитесь к Суперадмину, чтобы вам выдали ранг")
	end )

IGS("Админ Высшей Категории", "avk")
	:SetPrice( 645 )
	:SetCategory("Ранги")
	:SetDescription("Ну тут как говорится, того самого..")
	:SetOnActivate( function( ply ) ply:SetUserGroup("avk") end )


IGS("Картинка в Tab", "1321231223")
	:SetPrice( 499 )
	:SetCategory("Иное")
	:SetDescription("Вы сможете загрузить собственную пикчу в таб. После покупки обратитесь к Titanovsky или The Overseer")
	:SetOnActivate( function( ply ) ply:Kill() end )

IGS("Спонсорство", "spons_darkrp")
	:SetPrice( 499 )
	:SetCategory("Ранги")
	:SetIcon("https://i.imgur.com/3dzo5gS.png")
	:SetDescription("• В СЛУЧАЕ ОТМЕНЫ ПРОЕКТА, ДЕНЬГИ ВОЗВРАЩАЮТСЯ ДОНАТЕРУ НА КОШЕЛЁК!\n • Мы собираем деньги на очень хороший DarkRP сервер\n • Все подробности к Титановскому или /discord")
	:SetOnActivate( function( ply ) ply:Say("Я крутой челик =)") end )


IGS("100.000 Рубаксов", "100_rub")
	:SetPrice(9)
	:SetCategory("Валюта")
	:SetIcon("https://i.imgur.com/KTttOXs.png")
	:SetDescription("• Добавляет 100.000 Рубаксов")
	:SetOnActivate( function( ply ) ply:RUB_add(100000) end )

IGS("1.000.000 Рубаксов", "1kk_rubaksov")
	:SetPrice(85)
	:SetIcon("https://i.imgur.com/KTttOXs.png")
	:SetCategory("Валюта")
	:SetDescription("Добавляет 1kк Рубаксов")
	:SetOnActivate( function( ply ) ply:RUB_add(1000000) end )

IGS("10.000.000 Рубаксов", "25kk_rubaksov")
	:SetPrice(149)
	:SetIcon("https://i.imgur.com/KTttOXs.png")
	:SetCategory("Валюта")
	:SetDescription("Добавляет 10kк Рубаксов")
	:SetOnActivate( function( ply ) ply:RUB_add(10000000) end )


IGS("Оружейный кейс", "case_wep")
	:SetPrice( 4 )
	:SetCategory("Cases")
	:SetDescription("[1] Half-Life 2 Melee\n[2] Забавные пушечки\n[3] РЫБО-ХЛЕБ\n[4] Half-Life 2 Weapons\n[5] CW 2.0")
	:SetStackable()
	:SetIcon("https://skinodds.com/images/cases/knife-case.png")
	:SetOnActivate( function( ply )
		RusCore_CaseGuns( ply )
	end )

IGS("Аддон | Выкачка нефти", "123123")
	:SetPrice( 350 )
	:SetCategory("")
	:SetDescription("")
	:SetOnActivate( function( ply )
		ply:Kill()
	end )

IGS("Денежный кейс", "case_money")
	:SetPrice( 15 )
	:SetCategory("Cases")
	:SetDescription("[1] От 1 до 5к\n[2] От 5к до 25к\n[3] От 25к до 500к")
	:SetStackable()
	:SetIcon("https://topwar.ru/uploads/posts/2019-10/1570185019_dollar-putin.jpg")
	:SetOnActivate( function( ply )
		RusCore_CaseMoney( ply )
	end )

IGS("Ентитя кейс", "case_ents")
	:SetPrice( 6 )
	:SetCategory("Cases")
	:SetDescription("[1] Спавн полезных вещей\n[2] Спавн мусора (Удалится)\n[3] Спавн забавных НПСях")
	:SetStackable()
	:SetIcon("https://www.thomann.de/pics/bdb/241136/8911585_800.jpg")
	:SetOnActivate( function( ply )
		RusCore_CaseEnts( ply )
	end )

IGS("Золотое Яйцо", "case_eggs")
	:SetPrice( 55 )
	:SetCategory("Cases")
	:SetDescription("[1] Секрет Деньги\n[2] Секрет Услуги\n[3] Top Secret!!!")
	:SetStackable()
	:SetIcon("https://i.pinimg.com/originals/a4/12/0f/a4120f246183c5a6c7fa5454e4669ff5.png")
	:SetOnActivate( function( ply )
		RusCore_GoldEgg( ply )
	end )

