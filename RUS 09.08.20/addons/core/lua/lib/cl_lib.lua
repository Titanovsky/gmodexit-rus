AmbLib = AmbLib or {}

net.Receive( "amb_chat", function( len ) -- Данное творение принадлежит проекту [.ambition]
	local msg = net.ReadTable()
	chat.AddText( unpack( msg ) )
end)

net.Receive( "amb_notify", function()
	local text = net.ReadString()
	local type_notify = net.ReadFloat()
	local life = net.ReadFloat()
	local snd = net.ReadString() -- sounds
	notification.AddLegacy( text, type_notify, life)
	if ( snd ) and ( #snd > 0 ) then -- generic, лампочка
		surface.PlaySound( snd )
	end
end)

function AmbLib.convertIDtoNick( steamid )
    for _, v in pairs( player.GetAll() ) do
        if ( v:SteamID() == steamid ) then
            return v:Nick()
        end 
    end
    return false
end

function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

function draw.CircleCustom( x, y, w, h, ang, color, x0, y0 )
    for i=0,ang do
        local c = math.cos(math.rad(i))
        local s = math.sin(math.rad(i))
        local newx = y0 * s - x0 * c
        local newy = y0 * c + x0 * s

        draw.NoTexture()
        surface.SetDrawColor(color)
        surface.DrawTexturedRectRotated(x + newx,y + newy,w,h,i)
    end
end
-- Данное творение принадлежит проекту [.ambition]