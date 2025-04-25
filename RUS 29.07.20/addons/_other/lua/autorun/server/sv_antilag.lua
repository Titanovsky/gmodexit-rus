local last_diff = 9999
local delta_diff = 0
local lag = 0.4
local delay = 1.45
local delay_phys_reload = 10

local ply_struct = FindMetaTable( "Player" )

local function RusLag_LagRemove()
	for _, ply in pairs( player.GetHumans() ) do
		ply:ChatPrint("\n[RUs] AntiLag Work")
		ply:ChatPrint("Пропы заморожены!")
	end

	for _, v in pairs( ents.FindByClass("prop_physics") ) do
		if not v:IsVehicle() then
			local phys = v:GetPhysicsObject()
			phys:EnableMotion( false )
		end
	end
end

function RusLag_LagDetected()
	local sys_diff = SysTime() - CurTime()
	--print( "=======###===========" )
	--print( "Time[1]: " .. sys_diff )
	--print( "Last[1]: " .. last_diff )
	--print( "Delt[1]: " .. delta_diff )
	delta_diff = sys_diff - last_diff
	--print( "\nTime[2]: " .. sys_diff )
	--print( "Last[2]: " .. last_diff )
	--print( "Delt[2]: " .. delta_diff )
	last_diff = sys_diff
	--print( "\nTime[3]: " .. sys_diff )
	--print( "Last[3]: " .. last_diff )
	--print( "Delt[3]: " .. delta_diff )

	if delta_diff >= lag then
		RusLag_LagRemove()
	end
end

hook.Add( "Think", "rus_antilag_hook", function()
	if delay < CurTime() then
		RusLag_LagDetected()
	end
end )



--[[
hook.Add("Think","antelag",function()
	if Testos < CurTime() then
		local Test = GetCurrentDelta()
		local LagLvl = Test - Resol[LagLvlnakazanie] or 0
		--print(Test,Resol[LagLvlnakazanie])
		Testos = CurTime()+0.3
		--RunConsoleCommand("say",Test.." - ".. Resol[LagLvlnakazanie])
		if LagLvl > 4 then Lag[4]() return end
		if(LagLvl > 0.2) then
			Testos = CurTime()+0.2
			LagLvlnakazanie = LagLvlnakazanie + 1
			LagLvlnakazanie = math.Clamp(LagLvlnakazanie,0,4)
			game.SetTimeScale(math.Clamp(1-(LagLvlnakazanie/5),0.2,1))
			unlages()
			Lag[math.Clamp(LagLvlnakazanie,1,4)]()
		end
	end
end)
local function unlages()
	timer.Create("unlag",4*LagLvlnakazanie,1,function()
		if LagLvlnakazanie < 1 then return end
		LagLvlnakazanie = LagLvlnakazanie - 1

		--RunConsoleCommand('say',LagLvlnakazanie..",|"..(1-(LagLvlnakazanie/5)))
		game.SetTimeScale(math.Clamp(1-(LagLvlnakazanie/5),0.4,1))
		if(LagLvlnakazanie>=1) then
			unlages()
		end
	end)
end

]]