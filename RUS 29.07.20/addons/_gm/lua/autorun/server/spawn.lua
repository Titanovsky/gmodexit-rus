local spawnes = {
	["gm_bigcity_improved"] = {
		Vector( -9442.581055, -11358.883789, -11026.514648 ),
		Vector( -9609.178711, -11355.436523, -11026.514648 ),
		Vector( -9790.959961, -11359.327148, -11026.514648 ),
		Vector( -9987.813477, -11365.954102, -11026.514648 ),
		Vector( -10199.814453, -11372.976563, -11026.514648 ),
		Vector( -10381.560547, -11378.179688, -11026.514648 ),

		Vector( -9442.581055, -11574.563477, -11026.514648 ),
		Vector( -9609.178711, -11574.563477, -11026.514648 ),
		Vector( -9790.959961, -11574.563477, -11026.514648 ),
		Vector( -9987.813477, -11574.563477, -11026.514648 ),
		Vector( -10199.814453, -11574.563477, -11026.514648 ),
		Vector( -10381.560547, -11574.563477, -11026.514648 ),

		Vector( -9914.525391, -11824.698242, -11040.433594 )
	},

	["gm_boreas"] = {
		Vector( -15113.613281, -15027.185547, -7935.931152 ),
		Vector( -14781.302734, -14978.892578, -7945.339844 ),
		Vector( -14498.756836, -14956.195313, -7941.608398 ),
		Vector( -14384.287109, -14975.778320, -7936.416016 ),
		Vector( -14421.727539, -15153.579102, -7929.987793 ),
		Vector( -14663.607422, -15140.941406, -7929.180176 ),
		Vector( -14948.408203, -15202.862305, -7944.873535 ),
		Vector( -15097.085938, -15550.071289, -8051.468262 ),
		Vector( -14903.080078, -15585.106445, -8053.565430 ),
		Vector( -14662.455078, -15614.622070, -8053.565430 ),
		Vector( -14768.250977, -15359.422852, -8097.682129 ),
		Vector( -14992.602539, -15381.247070, -8099.318848 ),
		Vector( -14884.555664, -15756.033203, -7957.794922 ),
	},

	["gm_genesis"] = {
		Vector( 1760, -9483, -8739 ),
		Vector( 1766, -9343, -8739 ),
		Vector( 1759, -9187, -8739 ),
		Vector( 1759, -9187, -8739 ),
		Vector( 1513, -9185, -8739 ),
		Vector( 1365, -9182, -8739 ),
		Vector( 1260, -9261, -8739 ),
		Vector( 1261, -9393, -8739 ),
		Vector( 1298, -9546, -8739 ),
		Vector( 1487, -9541, -8739 )
	},

	["gm_construct_in_flatgrass"] = {
		Vector( -4267.724609, -4159.302246, -7972.817383 ),
		Vector( -4267.724609, -4259.302246, -7972.817383 ),
		Vector( -4267.724609, -4359.302246, -7972.817383 ),
		Vector( -4467.724609, -4359.302246, -7972.817383 ),
		Vector( -4467.724609, -4359.302246, -7972.817383 ),
		Vector( -4467.724609, -4359.302246, -7972.817383 ),
		Vector( -4567.724609, -4359.302246, -7972.817383 ),
		Vector( -4567.724609, -4359.302246, -7972.817383 ),
		Vector( -4567.724609, -4359.302246, -7972.817383 ),

		Vector( -4267.724609, -4159.302246, -7872.817383 ),
		Vector( -4267.724609, -4259.302246, -7872.817383 ),
		Vector( -4267.724609, -4359.302246, -7872.817383 ),
		Vector( -4467.724609, -4359.302246, -7872.817383 ),
		Vector( -4467.724609, -4359.302246, -7872.817383 ),
		Vector( -4467.724609, -4359.302246, -7872.817383 ),
		Vector( -4567.724609, -4359.302246, -7872.817383 ),
		Vector( -4567.724609, -4359.302246, -7872.817383 ),
		Vector( -4567.724609, -4359.302246, -7872.817383 ),

		Vector( -4267.724609, -4159.302246, -7772.817383 ),
		Vector( -4267.724609, -4259.302246, -7772.817383 ),
		Vector( -4267.724609, -4359.302246, -7772.817383 ),
		Vector( -4467.724609, -4359.302246, -7772.817383 ),
		Vector( -4467.724609, -4359.302246, -7772.817383 ),
		Vector( -4467.724609, -4359.302246, -7772.817383 ),
		Vector( -4567.724609, -4359.302246, -7772.817383 ),
		Vector( -4567.724609, -4359.302246, -7772.817383 ),
		Vector( -4567.724609, -4359.302246, -7772.817383 ),
	},

	["gm_novenka"] = {
		Vector( 3872, 9949, -169 ),
		Vector( 3872, 9749, -169 ),
		Vector( 3722, 9949, -169 ),
		Vector( 3722, 9749, -169 ),
		Vector( 3621, 9949, -169 ),
		Vector( 3621, 9749, -169 ),
		Vector( 3462, 9949, -169 ),
		Vector( 3462, 9749, -169 ),
		Vector( 3272, 9949, -169 ),
		Vector( 3272, 9749, -169 )
	}
}


hook.Add( "PlayerSpawn", "ru_spawn_post_death", function( ply, tr )
	for map, v in pairs( spawnes ) do
		if map == game.GetMap() then
			ply:SetPos( table.Random( spawnes[map] ) )
		end
	end
	ply:SetEyeAngles( Angle( 0, 0, 0 ) )
end )

hook.Add( "PlayerInitialSpawn", "amb_0x992", function( ply )
		if ( ply:IsSuperAdmin() ) then
			for k, v in pairs( player.GetAll() ) do
				v:SendLua('surface.PlaySound("ru_reborn/superadmin.wav")')
			end
		end
end )


local function killPlayer( flag )
	--[[
		flags:
			1 — Only humans
			2 — Only bots
			3 — All
	]]
	if flag == 1 and #player.GetHumans() < 4 then return end
	if flag == 2 and #player.GetBots() < 2 then return end
	if flag == 3 and #player.GetHumans() < 2 and #player.GetBots() < 1 then return end

	local random_bots = math.random( 1, #player.GetBots() )
	local random_humans = math.random( 1, #player.GetHumans() )
	local random_all = math.random( 1, #player.GetAll() )
	amb_rand_summ = math.random( 6000, 16000 )

	if ( flag == 1 ) then
		for k, v in pairs( player.GetHumans() ) do
			if k == random_humans then
				if !v:GetNWBool("IsBuild") then
					for _, pl in pairs( player.GetHumans() ) do
						pl:ChatPrint( "Объявлена охота на "..v:Nick().." | Награда: "..amb_rand_summ )
						pl:SendLua("surface.PlaySound( 'npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav')")
					end
					v:SetNWBool( "amb_target", true )
				else
					killBot( 1 )
				end
			end
		end
	elseif ( flag == 2 ) then
		for k, v in pairs( player.GetBots() ) do
			if k == random_bots then
				for _, pl in pairs( player.GetHumans() ) do
					pl:ChatPrint( "Объявлена охота на "..v:Nick().." | Награда: "..amb_rand_summ )
					pl:SendLua("surface.PlaySound( 'npc/combine_gunship/gunship_pain.wav')")
				end
				v:SetNWBool( "amb_target", true )
			end
		end
	elseif ( flag == 3 ) then
		for k, v in pairs( player.GetAll() ) do
			if k == random_all then
				if !v:GetNWBool("IsBuild") then
					for _, pl in pairs( player.GetHumans() ) do
						pl:ChatPrint( "Объявлена охота на "..v:Nick().." | Награда: "..amb_rand_summ )
					end
					v:SetNWBool( "amb_target", true )
				else
					killPlayer( 2 )
				end
			end
		end
	end
end

--killPlayer( 3 )
--timer.Create('AmbTimer[KillPlayer]', 660, 0, function() killPlayer( 3 ) end )
--print( timer.Exists('AmbTimer[KillPlayer]') )

hook.Add("DoPlayerDeath", "amb_0x901", function( victim, killer )
	if victim:GetNWBool( "amb_target" ) and victim != killer then
		victim:SetNWBool( "amb_target", false )
		killer:RUB_add(amb_rand_summ)
		killer:SendLua("notification.AddLegacy( 'Вы получили: "..amb_rand_summ.." Рубаксов!', NOTIFY_CLEANUP, 2 )")
	else
		if ( victim ~= killer ) and tonumber( victim:GetNWInt("rub") ) > 250 and !victim:IsBot() and !victim:SetNWBool("amb_target") then
			if IsValid( killer ) then
				killer:RUB_add( 250 )
				victim:RUB_minus(250)
				killer:SendLua("notification.AddLegacy( 'Вы отобрали: 250 Рубаксов!', NOTIFY_CLEANUP, 2 )")
			end
		end
	end
end)

hook.Add( "PlayerLoadout", "ru_loadout", function( ply )

	ply:Give( "weapon_physgun" )
	ply:Give( "weapon_physcannon" )
	ply:Give( "gmod_tool" )

	return true
end)

