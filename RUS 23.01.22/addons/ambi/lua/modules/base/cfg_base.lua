-- * - потребуется рестарт
-- ** - потребуется, чтобы игрок/игроки перезашли

-- ############################################################################ --
Ambi.Base.Config.version = '1.0' -- Версия модуля

-- ############################################################################ --
Ambi.Base.Config.fonts_max_size = 128 -- До какого размера шрифты будут созданы (Не рекомендую больше 128)

-- ############################################################################ --
Ambi.Base.Config.hud_enable = true -- Включить систему мульти-худов
Ambi.Base.Config.hud_command = 'ambi_hud_'..Ambi.Config.prefix
Ambi.Base.Config.hud_disable_target_id = true -- Отключить стандартную инфу игрока при наведений (ник и ХП)
Ambi.Base.Config.hud_block = { -- Какие элементы блочить всегда?
    [ 'CHudHealth' ] = true,
    [ 'CHudBattery' ] = true,
    [ 'CHudAmmo' ] = true,
    [ 'CHudCrosshair' ] = false,
    [ 'CHudCloseCaption' ] = true,
    [ 'CHudDamageIndicator' ] = true,
    [ 'CHudHintDisplay' ] = true,
    [ 'CHudPoisonDamageIndicator' ] = false,
    [ 'CHudSecondaryAmmo' ] = true,
    [ 'CHudSuitPower' ] = true,
    [ 'CHudHintDisplay' ] = true,
}

-- ############################################################################ --