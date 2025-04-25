if not Ambi.ChatCommands then Ambi.General.Error( 'Randomizer', 'Before Randomizer module, need to connect ChatCommands module' ) return end

local Add = Ambi.ChatCommands.AddCommand
local TYPE = 'Randomizer'

Add( 'rnd', TYPE, 'Получить рандом!', 30, function( ePly, tArgs ) 
    ePly:BuyAutoAmmo( ammo )
end )