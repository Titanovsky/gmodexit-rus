--[[
    Ambi Eco — платформа (экосистема) для создания проектов в игре Garry's Mod

    • Это основной файл для конфигураций сервера и добавления модулей и режима.

    Github: https://github.com/Titanovsky/ambi-eco
    Documentation: https://app.gitbook.com/@titanovskyteam/s/ambi-eco/
--]]

--############################################################################################ --
Ambi.Config.dev = true -- true/false - Включить режим разработки?
Ambi.Config.log_level = 1 -- Уровень логгирования (TODO: На данный момент не работает)
Ambi.Config.directory = 'rus' -- Название корневой папки сервера в data/[ambi]
Ambi.Config.prefix = 'rus' -- Префикс для консольных команд
Ambi.Config.language = 'ru' -- Язык сервера
--############################################################################################ --

Ambi.ConnectModule( 'Base', 'base', 'Базовый фреймворк для разработки проектов под экосистему' )
Ambi.ConnectModule( 'ChatCommands', 'chatcommands', 'Выполнение команд в чате' )
Ambi.ConnectModule( 'AutoSpawn', 'autospawn', 'Автоматический спавн объектов' )
Ambi.ConnectModule( 'InfoHUD', 'infohud', 'Панель с информацией о энтити' )
Ambi.ConnectModule( 'PlayerFreeze', 'player-freeze', 'Особый способ заморозки игрока (Можно двигать мышью)' )
Ambi.ConnectModule( 'ESP', 'esp', 'ESP' )
Ambi.ConnectModule( 'Fine', 'fine', 'Система наказаний' )
Ambi.ConnectModule( 'Image', 'image', 'Показ картинки с имгура игрокам' )
Ambi.ConnectModule( 'Time', 'time', 'Система по использованию времени' )
Ambi.ConnectModule( 'VoteMap', 'votemap', 'Голосование по смене карты' )
Ambi.ConnectModule( 'Kit', 'kit', 'Система выдачи наборов' )

Ambi.ConnectModule( 'Rus', 'rus', 'Gamemode сервера - RUS' )
