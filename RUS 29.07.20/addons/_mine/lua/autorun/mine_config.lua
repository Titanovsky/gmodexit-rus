--[[
	Шахта для сандбокса (данные игрока, изменение, выведение, сохранение; камни, оружие, добыча; продажа ).
	Сервер находится в полном подчинений проекта: .ambition (.amb)

    Руды | Добыча simple киркой (max) | Добыча продвинутой киркой (max) | Цена | Модиф. за ранг VIP | Модиф. за ранг Admin | Частота:
    ( Прод. кирка = x1.5 добыча, Модиф vip = x2 продажа, Модиф Admin = x3 продажа, ничего не получите 19% )

    1. Камень   | 10 | 15 | 1$     | 2$     | 3$     | 25% (44%)
    2. Уголь    | 8  | 12 | 2$     | 4$     | 6$     | 20% (64%)
    3. Медь     | 6  | 9  | 6$     | 12$    | 18$    | 15% (74%)
    4. Железо   | 5  | 7  | 10$    | 20$    | 30$    | 10% (89%)
    5. Топаз    | 4  | 6  | 32$    | 64$    | 96$    | 5%  (94%)
    6. Алмаз    | 2  | 3  | 512$   | 1024$  | 1536$  | 4%  (98%)
    7. Рубин    | 1  | 1  | 4096$  | 8192$  | 12288$ | 1.6%  (99.6%)
    8. Титаниум | 1  | 1  | 16384$ | 32768$ | 49152$ | 0.4%  (100%)

	[09.05.20]
		• Первая версия. Сделал разметку.
    [10.05.20]
		• Сделал первую версию аддона, на этот раз без автомат. бура, которые собирает руду.
	.
##########################################################################################
]]


AmbMine = AmbMine or {} -- диджей ебан
AmbMine.Config = {}

AmbMine.Config.Names = {
    "Камень",
    "Уголь",
    "Медь",
    "Свинец",
    "Топаз",
    "Уран",
    "Рубин",
    "DarkRP"
}

if CLIENT then return end -- не смотрите на  меня =)

AmbMine.Config.ModelRock = "models/props_wasteland/rockcliff01j.mdl"

AmbMine.Config.ExtractOre1 = 8; -- добыча камня
AmbMine.Config.ExtractOre2 = 6; -- уголь
AmbMine.Config.ExtractOre3 = 4; -- медь
AmbMine.Config.ExtractOre4 = 3; -- железо
AmbMine.Config.ExtractOre5 = 2; -- топаз
AmbMine.Config.ExtractOre6 = 1; -- алмаз
AmbMine.Config.ExtractOre7 = 1; -- рубин
AmbMine.Config.ExtractOre8 = 1; -- титаниум

AmbMine.Config.FrequencyOre0 = { 1, 25 } -- min and max frequency, this is void
AmbMine.Config.FrequencyOre1 = { 25, 55 } -- камень
AmbMine.Config.FrequencyOre2 = { 55, 75 } -- уголт
AmbMine.Config.FrequencyOre3 = { 75, 84 } -- медь
AmbMine.Config.FrequencyOre4 = { 84, 89 } -- железо
AmbMine.Config.FrequencyOre5 = { 89, 93 } -- топаз
AmbMine.Config.FrequencyOre6 = { 93, 96 } -- алмаз
AmbMine.Config.FrequencyOre7 = { 96, 98 } -- рубин
AmbMine.Config.FrequencyOre8 = { 98, 99 }

AmbMine.Config.CostOres         = { 2, 4, 6, 9, 46, 200, 800, 1050 };
AmbMine.Config.ModifyCostVIP    = 2;
AmbMine.Config.ModifyCostAdmin  = 2;

AmbMine.Config.ModifySimpleAxe = 1; -- todo: add speed attack pickaxe
AmbMine.Config.ModifyAdvAxe    = 2;


AmbMine.Config.AxeHP    = 80; -- need pickaxe, no just axe =/
AmbMine.Config.AdvAxeHP = AmbMine.Config.AxeHP * 8;


-- Данное творение принадлежит проекту [.ambition]