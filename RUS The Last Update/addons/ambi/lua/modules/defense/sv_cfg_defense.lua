-- ⚠️ Данный конфиг НЕ ДОЛЖЕН БЫТЬ КОМУ-ТО ДОСТУПЕН!                       
-- ⭕️ Его невозможно своровать, не имея доступ к серверу!                  
-- ⭕️ Серверная часть конфига служит для самых ВАЖНЫХ и ОПАСНЫХ моментов!  
-- ⭕️ Пожалуйста, отнеситесь к этому серьёзно!                             

local Config = Ambi.Defense.Config
-- Все типы стандартных наказаний делятся:
-- 0 - Нет (хук срабатывает)
-- 1 - Предупреждение в чат
-- 2 - Кик
-- 3 - Бан на N (указывается в конфиге) минут
-- 4 - Бан навсегда

-- ------------------------------------------------------------------------------------------------------------------------------------
Config.net_flood_enable = true -- Вкл/Выкл защиту от флуда net-сообщениями (от клиента к серверу)
Config.net_flood_delay = .24 -- Задержка до ресета счётчика net-сообщений у игрока
Config.net_flood_max = 128 -- Максимальное количество net-сообщений (для одного) до окончания задержки
Config.net_flood_punishment = 2 -- Тип наказания (При любом наказаний у игрока будет стоять блок на отправку сообщений!)
Config.net_flood_log = true -- Логгировать, игрок какие сетевые сообщения отправил на сервер
Config.net_flood_exceptiones = { -- Исключения
    [ 'TFA_Attachment_Request' ] = { max = 999999 },
    [ 'arccw_rqwpnnet' ] = { max = 999999 },
    [ 'arccw_quicknade' ] = { max = 999999 },
    [ 'arccw_sendattinv' ] = { max = 999999 },
    [ 'arccw_reloadatts' ] = { max = 999999 },
    [ 'arccw_togglecustomize' ] = { max = 999999 },
    [ 'arccw_slidepos' ] = { max = 999999 },
    [ 'simfphys_blockcontrols' ] = { max = 999999 },
    [ 'simfphys_mousesteer' ] = { max = 999999 },
    [ 'NetStreamRequest' ] = { max = 999999 },
    [ 'wire_expression2_upload' ] = { max = 999999 },
    [ 'starfall_upload' ] = { max = 999999 },
    [ 'WireLib.Paths.RequestPaths' ] = { max = 999999 },
    [ 'simfphys_request_ppdata' ] = { max = 999999 },
    [ 'properties' ] = { max = 999999 },
    [ 'editvariable' ] = { max = 999999 },
    [ 'arccw_asktoattach' ] = { max = 999999 },
    [ 'arccw_togglenum' ] = { max = 999999 },
    [ 'vj_npcmover_sv_startmove' ] = { max = 999999 },
    [ 'arccw' ] = { max = 999999 },
    [ 'properties' ] = { max = 3 },
}

-- ------------------------------------------------------------------------------------------------------------------------------------
Config.net_blacklist_messages_enable = false -- Вкл/Выкл список net-сообщений, которые невозможно
Config.net_blacklist_create_nets = false -- Создать фейковые сетевые сообщения, которых нет на сервере? [НУЖЕН РЕСТАРТ]
Config.net_blacklist_punishment = 0 -- Тип наказания
Config.net_blacklist_messages = { -- Список net, за которые будет наказание
    [ 'sosi' ] = true,
}

-- ------------------------------------------------------------------------------------------------------------------------------------
Config.frequent_reconnect_enable = true -- Вкл/Выкл Частый Перезаход на сервер
Config.frequent_reconnect_delay = 1 -- Задержка до ресета счётчика заходов у игрока
Config.frequent_reconnect_max = 3 -- Максимальное количество заходов на сервер
Config.frequent_reconnect_block_time = 5 -- Время блокировки в секундах
Config.frequent_reconnect_block_reason = 'Пожалуйста, подождите' -- Причина, которая покажется игроку

-- ------------------------------------------------------------------------------------------------------------------------------------
Config.hard_ranks_enable = false -- Вкл/Выкл систему закреплённых рангов для специальных игроков (по их SteamID)
Config.hard_ranks_punishment = 0 -- Тип наказания
Config.hard_ranks_list = { -- Список рангов
    [ 'superadmin' ] = true,
    [ 'owner' ] = true,
    [ 'founder' ] = true,
    [ 'root' ] = true,
}
Config.hard_ranks_whitelist = { -- Список SteamID игроков, которые могут быть этими рангами
    [ 'STEAMID' ] = true,
}

-- ------------------------------------------------------------------------------------------------------------------------------------
Config.spoof_steamid = true -- Вкл/Выкл проверку на воровство SteamID
Config.spoof_steamid_punishment = 2 -- Тип наказания

-- ------------------------------------------------------------------------------------------------------------------------------------
Config.chat_flood_enable = false -- Вкл/Выкл Анти-Флуд сообщений в чат
Config.chat_flood_delay = .75 -- Задержка между сообщениями
Config.chat_flood_max = 4 -- Максимальное количество сообщений 
Config.chat_flood_punishment = 1 -- Тип наказания

-- ------------------------------------------------------------------------------------------------------------------------------------
Config.ghost_protect_entities_enable = true -- Вкл/Выкл систему защиту энтитей 
Config.ghost_protect_entities_spawned_freeze = true -- При спавне энтити будут замораживаться
Config.ghost_protect_entities_physgun_pickup_freeze = false -- При взятий физганом, энтити будут замораживаться
Config.ghost_protect_entities_physgun_reload = true -- Можно устроить массовый расфриз физганом на R?
Config.ghost_protect_entities_list = {
    [ 'prop_physics' ] = true,
    [ 'prop_dynamic' ] = true,
    [ 'sent_ball' ] = true,
}

-- ------------------------------------------------------------------------------------------------------------------------------------
Config.lag_enable = true -- Вкл/Выкл систему по нахождению и устранению лагов
Config.lag_levels = { -- Уровни лагов, обозначаются разницей между временем начала работы процессора и реальным
    [ 1 ] = .3,
    [ 2 ] = .6,
    [ 3 ] = 1.2,
}
Config.lag_send_to_chat = true -- Отправлять в чат сообщение, что случилась проверка на лаг