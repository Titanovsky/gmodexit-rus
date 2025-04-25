ENT.Type        = 'anim'

ENT.PrintName   = 'Токарный Станок'
ENT.Author      = '[ Ambition ]'
ENT.Category    = '[ AMB ] Factory 2'
ENT.Spawnable   = true

ENT.flags = { }
ENT.flags[1] = { time = 4, chunk = 'Bolt Carrier', metal = 1, min_pay = 1, max_pay = 4 } -- затворная рама
ENT.flags[2] = { time = 6, chunk = 'Butt', metal = 2, min_pay = 4, max_pay = 8 } -- приклад
ENT.flags[3] = { time = 8, chunk = 'Magazine', metal = 3, min_pay = 6, max_pay = 10 } -- магазин
ENT.flags[4] = { time = 12, chunk = 'Barrel', metal = 5, min_pay = 6, max_pay = 24 } -- ствол

AmbFactory2Chunks = {}
table.Merge( AmbFactory2Chunks, ENT.flags )

--[[

    [ Ambition ]

https://steamcommunity.com/groups/ambitiongmod
https://vk.com/ambgmod
https://discord.com/invite/G4vzxrq

--]]