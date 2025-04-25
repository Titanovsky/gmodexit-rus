--[[-------------------------------------------------------------------------
	Лаунчер убеждается в том, что все необходимые данные могут быть загружены
	для предотвращения неизбежных ошибок во время работы без них
---------------------------------------------------------------------------]]
IGS.sh("dependencies/plurals.lua")
IGS.sh("dependencies/chatprint.lua")
IGS.sv("dependencies/stack.lua")
IGS.sh("dependencies/scc.lua")
IGS.sv("dependencies/resources.lua") -- иконки, моделька дропнутого итема
IGS.sh("dependencies/bib.lua")

-- Антиконфликт с https://trello.com/c/3ti6xIjW/
IGS.sh("dependencies/dash/nw.lua")

-- if !dash then
IGS.sh("dependencies/dash/hash.lua")
IGS.sh("dependencies/dash/misc.lua")
IGS.cl("dependencies/dash/wmat.lua")

IGS.sh("settings/config_sh.lua")
IGS.sv("settings/config_sv.lua") -- для фетча project key (Генерация подписи)

-- Метаобъекты
IGS.dir("objects", IGS.sh)

IGS.sh("network/nw_sh.lua") -- для igs_servers в serv_sv.lua

IGS.sv("core_sv.lua") -- для фетча подписи

IGS.sv("repeater.lua")
IGS.sv("apinator.lua")

-- После датапровайдера, хотя сработают все равно после первого входа игрока
IGS.sh("servers/serv_sh.lua")
IGS.sv("servers/serv_sv.lua")



--[[-------------------------------------------------------------------------
	Второй "этап" (для работы требовал загрузку серверов)
---------------------------------------------------------------------------]]
IGS.sh("utils/ut_sh.lua")
IGS.sv("utils/ut_sv.lua")
IGS.cl("utils/ut_cl.lua")


-- Нельзя ниже sh_additems
IGS.dir("extensions", IGS.sh)

IGS.sh("settings/sh_additems.lua")
IGS.sh("settings/sh_addlevels.lua")

IGS.sv("network/net_sv.lua")
IGS.cl("network/net_cl.lua")


IGS.cl("interface/skin.lua")
-- IGS.cl("core_cl.lua")

-- Подключение VGUI компонентов
IGS.dir("interface/vgui", IGS.cl)

IGS.WIN = IGS.WIN or {}

IGS.cl("interface/core.lua")

IGS.dir("interface/activities", IGS.cl)
IGS.dir("interface/windows", IGS.cl)

IGS.dir("modules", nil, true)

IGS.sv("processor_sv.lua") -- начинаем обработку всего серверного в конце


--[[------------------------------
	Уродский кусок пост хуков
--------------------------------]]
if SERVER then
	hook.Add("IGS.ServersLoaded", "Loaded", function()
		IGS.GetSettings(function(t)
			IGS.UpdateMoneySettings(t["MinCharge"],t["CurrencyPrice"])
			hook.Run("IGS.Loaded")
		end)
	end)
else
	hook.Add("IGS.OnSettingsUpdated","Loaded",function()
		hook.Run("IGS.Loaded")
	end)
end

hook.Run("IGS.Initialized") -- можно создавать итемы
