hook.Add( '[Ambi.General.Network.CanIncoming]', 'Ambi.Defense.AntiNetFlood', function( ePly, sName, fAction )
    if ePly.defense_block_msg then return false end -- Чтобы не вызывалось наказание столько раз, сколько игрок нафлудил

    local Config = Ambi.Defense.Config
    if ( Config.enable == false ) then return end
    if ( Config.net_blacklist_messages_enable == false ) then return end

    if Config.net_blacklist_messages[ sName ] then 
        ePly.defense_block_msg = true 
        Ambi.Defense.Punish( ePly, Config.net_blacklist_punishment, 'Запрещённое сетевое сообщение!', 'Запретный net ['..sName..']' ) 

        return false 
    end
end )

if Ambi.Defense.Config.net_blacklist_create_nets then
    for net_message, _ in pairs( Ambi.Defense.Config.net_blacklist_messages ) do
        net.AddString( net_message )
    end
end