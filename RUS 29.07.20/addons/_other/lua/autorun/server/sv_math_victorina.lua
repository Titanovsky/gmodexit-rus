-- need to develop custom net lib (for send chat.AddText and not just), because SendLua bad solution :(

local mathVic_a = 0
local mathVic_b = 0
local mathVic_c = 0
local mathVic_result = 0

local math = math -- for local very fast
local player = player -- for local very fast
local timer = timer -- for local very fast

local mathVic_delay = 766 -- 8 min


function ru_CalcMathVic( dif )
	if dif == 1 then
		mathVic_a = math.random( 2, 2^4 )
		mathVic_b = math.random( 2, 2^4 )
		mathVic_result = mathVic_a + mathVic_b
	 elseif dif == 2 then
		mathVic_a = math.random( 2, 2^6 )
		mathVic_b = math.random( 2, 2^6 )
		mathVic_result = mathVic_a - mathVic_b
	 elseif dif == 3 then
		mathVic_a = math.random( 2, 2^8 )
		mathVic_b = math.random( 2, 2^8 )
		mathVic_с = math.random( 2, 2^2 )
		mathVic_result = mathVic_a + mathVic_b * mathVic_с
	 elseif dif == 4 then
		mathVic_a = math.random( 2^4, 2^5 )
		mathVic_b = math.random( 2, 2^4 )
		mathVic_result = mathVic_a * mathVic_b
	end
end

function ru_StartMathVic()
	local mathVic_r = math.random( 1, 5 )
	ru_CalcMathVic( mathVic_r )

	for k, v in pairs( player.GetHumans() ) do
		if mathVic_r == 1 then
			v:SendLua('chat.AddText( Color(39, 227, 155), "Викторина: ", Color(255,255,255), "'..mathVic_a..'", " + ", "'..mathVic_b..'", " = ", " ?")')
		elseif mathVic_r == 2 then
			v:SendLua('chat.AddText( Color(39, 227, 155), "Викторина: ", Color(255,255,255), "'..mathVic_a..'", " - ", "'..mathVic_b..'", " = ", " ?")')
		elseif mathVic_r == 3 then
			v:SendLua('chat.AddText( Color(39, 227, 155), "Викторина: ", Color(255,255,255), "'..mathVic_a..'", " + ", "'..mathVic_b..'", " * ", "'..mathVic_с..'" ," = ", " ?")')
		elseif mathVic_r == 4 then
			v:SendLua('chat.AddText( Color(39, 227, 155), "Викторина: ", Color(255,255,255), "'..mathVic_a..'", " * ", "'..mathVic_b..'", " = ", " ?")')
		end
	end
	timer.Create("ru_MathVicTimerClose", 30, 1, function() 
		for k, v in pairs( player.GetHumans() ) do
			v:SendLua('chat.AddText( Color(39, 227, 155), "Ответ был: ", Color( 255, 255, 255 ), "'..mathVic_result..'")')
			--timer.Simple( 2, function() mathVic_result = nil end)
		end
	end)
end

hook.Add("PlayerSay", "ru_MathVic", function( ply, text)
	local mathVicAward = math.random( 820, 6974 )


	if string.lower(text) == tostring( mathVic_result ) and timer.Exists( "ru_MathVicTimerClose" ) then
		timer.Remove("ru_MathVicTimerClose")
		ply:RUB_add( mathVicAward )
		ply:SendLua("notification.AddLegacy( 'Reward: "..mathVicAward.." Roblox', NOTIFY_GENERIC, 3 )")
		for k, v in pairs( player.GetHumans() ) do
			v:SendLua('chat.AddText( Color(39, 227, 155), "Ответ был: ", Color(255,255,255), "'..mathVic_result..'", Color(39, 227, 155), " | Победитель: ", Color(255,255,255), "'..ply:Nick()..'")')
		end
		--mathVic_result = nil
	end
end)

hook.Add("Initialize", "ru_MathVic", function() 
	timer.Create("ru_MathVicTimerOpen", mathVic_delay, 0, function() 
		ru_StartMathVic()
	end)
end)