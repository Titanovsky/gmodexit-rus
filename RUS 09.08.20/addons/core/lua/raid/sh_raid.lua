AmbRaid = AmbRaid or {}
AmbRaid.Bosses = {
	[1] = {
		name 	= 'The Boss',
		class 	= 'npc_combine_s',
		minions = 0,
		mdl  	= 'models/Combine_Super_Soldier.mdl',
		color 	= Color( 180, 0, 0, 255 ),
		weapon  = 'weapon_ar2',
		dmg 	= 5,
		size 	= 2,
		cost 	= 24,
		hp 		= 2800
	},
	[2] = {
		name 	= 'Chamilion',
		class   = 'npc_combine_s',
		minions = 0,
		mdl  	= 'models/breen.mdl',
		weapon  = 'weapon_ar2',
		color 	= Color( 120, 100, 0, 255 ),
		dmg 	= 4,
		size 	= 3,
		cost 	= 32,
		hp 		= 900
	},
	[3] = {
		name 	= 'Big Zombie',
		class   = 'npc_fastzombie',
		minions = 4,
		mdl  	= '',
		color 	= Color( 255, 255, 255, 140 ),
		dmg 	= 6,
		size 	= 1.4,
		cost 	= 24,
		hp 		= 2400
	},
	[4] = {
		name 	= 'Gargantua',
		class   = 'npc_antlionguard',
		minions = 0,
		mdl  	= '',
		color 	= Color( 35, 0, 0, 200 ),
		dmg 	= 6,
		size 	= 1.4,
		cost 	= 24,
		hp 		= 5400
	},
}

local function debugRaid()
	PrintTable( AmbRaid ) -- debug
end

if ( SERVER ) then

	amb_ent_boss = nil

	if not raid_on then -- чтобы при тест скрипта он постоянно не выполнял startRaid
		local raid_on = false
	end
	local remove_boss = 180 -- 6 min

	local pos = {
		Vector( 1129, -1642, 638 ),
		Vector( 929, -1642, 638 ),
		Vector( 729, -1642, 638 ),
		Vector( 429, -1642, 638 ),

		Vector( 1129, -1475, 638 ),
		Vector( 929, -1475, 638 ),
		Vector( 729, -1475, 638 ),
		Vector( 429, -1475, 638 )
	}

	local pos_boss = {
		Vector( -100, 343, 824 ),
		Vector( -150, 343, 824 ),
		Vector( -200, 343, 824 )
	}

	local pos_sub_boss = {
	}

	--AmbRaid.startRaid()

	function AmbRaid.startRaid()
		local max_players = 0
		if ( raid_on ) then return end
		for k, v in pairs( player.GetHumans() ) do
			if ( v:Team() == 2 ) then
				max_players = max_players + 1
			end
		end
		if max_players <= 0 then return end
		raid_on = true

		for k, ply in pairs( player.GetAll() ) do
			AmbLib.notifySend( ply, "Begin Raid Bosses!", 4, 3, 'buttons/button16.wav' )
			if ( ply:Team() == 2 ) then
				ply:SetNWBool( 'amb_raid', true )
				ply:Spawn()
			end
		end

		AmbRaid.spawnBoss()
	end

	util.AddNetworkString('amb_raid_time_send')
	util.AddNetworkString('amb_raid_ent_send')

	function AmbRaid.spawnBoss()
		local random = math.random( 1, #AmbRaid.Bosses )

		net.Start('amb_raid_time_send')
			net.WriteBool( true )
		net.Broadcast()

		timer.Create( 'AmbRaid[Time]', 10, 1, function()
			for k, v in pairs( AmbRaid.Bosses ) do
				if ( k == random ) then
					local boss = ents.Create( v.class )
					boss:Spawn()
					boss:SetPos( table.Random( pos_boss ) )
					boss:SetAngles( Angle( 0, -90, 0 ) )
					boss:SetModel( v.mdl )
					boss:SetModelScale( v.size, 1)
					boss:SetColor( v.color )
					boss:SetHealth( v.hp )
					if v.weapon then
						if #v.weapon > 0 then
							boss:Give( v.weapon )
						end
					end
					boss:DropToFloor()
					boss:SetNPCState( NPC_STATE_COMBAT )
					boss:SetNWBool( 'amb_raid_boss', true ) -- todo: поменять на просто boss.raid_boss = true
					boss:SetNWFloat( 'amb_raid_damage', v.dmg )
					boss:SetNWString( 'amb_raid_name', v.name )
					amb_ent_boss = boss
					timer.Simple( 1, function()
						net.Start('amb_raid_ent_send')
							net.WriteEntity( amb_ent_boss )
						net.Broadcast()
					end )
					-- print( amb_ent_boss ) -- debug

					net.Start('amb_raid_time_send')
						net.WriteBool( false )
					net.Broadcast()


					timer.Create( 'AmbRaid[Time]Remove', 180, 1, function()
						raid_on = false
						if IsValid( amb_ent_boss ) then
							amb_ent_boss:Remove()
						end
						for k, v in pairs( player.GetAll() ) do
							if v:GetNWBool('amb_raid') then
								v:ChatPrint('You lose')
								v:SetNWBool('amb_raid', false)
								v:Kill()
							end
						end
					end )
				end
			end
		end )
	end

	function AmbRaid.spawnSubBoss()
	end

	util.AddNetworkString('amb_raid_win')

	function AmbRaid.winRaid()
		raid_on = false
		timer.Remove( 'AmbRaid[Time]Remove' )
		net.Start('amb_raid_win')
		net.Broadcast()

		for k, v in pairs( player.GetAll() ) do
			if v:GetNWBool('amb_raid') then
				v:ChatPrint('You win!')
				v:SetNWBool('amb_raid', false)
				v:Spawn()
			end
		end
	end

	if not timer.Exists('AmbRaid[Start]') then
		timer.Create( 'AmbRaid[Start]', 2700, 0, function()
			AmbRaid.startRaid()
		end )
	end

	-- HOOKS #########
	hook.Add( 'PlayerSpawn', 'amb_0x88', function( ePly )
		if ePly:GetNWBool( 'amb_raid' ) then
			timer.Simple( 0, function()
				ePly:SetPos( table.Random( pos ) )
			end)
		end
	end )

	hook.Add( 'PlayerJoinTeam', 'amb_0x88', function( ePly )
		if ePly:GetNWBool( 'amb_raid' ) then
			ePly:SetNWBool( 'amb_raid', false )
		end
	end )

	hook.Add( 'EntityTakeDamage', 'amb_0x88', function( ent, damage )
		if damage:GetAttacker().up then
			damage:SetDamage( damage:GetDamage() * 6 )
		end
		if IsValid( damage:GetAttacker() ) then
			if damage:GetAttacker():IsPlayer() and ent:IsPlayer() then
        		if damage:GetAttacker():GetNWBool('amb_raid') and ent:GetNWBool('amb_raid') then
            		damage:SetDamage(0)
            	end
            elseif damage:GetAttacker():GetNWBool( 'amb_raid_boss' ) then
            	damage:SetDamage( damage:GetDamage() * damage:GetAttacker():GetNWFloat( 'amb_raid_damage' ) )
            end
        end
	end )

	hook.Add( 'OnNPCKilled', 'amb_0x88', function( npc, attacker, inflictor )
		if npc == amb_ent_boss and raid_on then
			AmbRaid.winRaid()
		end
	end )

	--hook.Add( "OnEntityCreated", "amb_0x88", function( ent ) -- todo: перенести в gm
	--if ( IsValid( ent ) ) then
	--	if ( ent:IsNPC() ) then
	--		timer.Simple( 0, function()
	--			ent:SetKeyValue( "spawnflags", "8192" )
				--ent:AddRelationship('player D_HT 99')
				--ent.up = true
	--		end )
	--	end
	--end
--end )
	-- ###############
elseif ( CLIENT ) then
	local w = ScrW()
	local h = ScrH()
	amb_ent_boss = nil

	net.Receive( 'amb_raid_time_send', function(len)
		local flag = net.ReadBool()
		if flag then
			timer.Create( 'AmbRaid[Time]', 10, 1, function() print('[AmbRaid] Begin Raid') end )
		else
			timer.Create( 'AmbRaid[Time]Remove', 180, 1, function() print('[AmbRaid] Begin Close') end )
		end
	end )

	net.Receive( 'amb_raid_win', function(len)
		timer.Remove('AmbRaid[Time]Remove')
	end )

	net.Receive( 'amb_raid_ent_send', function( len )
		local ent = net.ReadEntity()
		--print( 'NET: '..tostring(ent) ) -- debug
		amb_ent_boss = ent
	end )
	--print( 'DA: '..tostring( amb_ent_boss ) ) -- debug

	hook.Add( 'HUDPaint', 'amb_0x88', function()
		if ( LocalPlayer():Team() == 2 ) then
			if timer.Exists('AmbRaid[Time]') then
				if ( GetConVar( "amb_hud" ):GetInt() == 1 ) or ( GetConVar( "amb_hud" ):GetInt() == 2 ) then
					draw.SimpleText( 'Begin Round: '..math.Round( timer.TimeLeft('AmbRaid[Time]') ) , "ambFont22",
			        w/2, 54,
			        Color( 255, 255, 255, 255 ),
			        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
			        )
				end
			end

			if timer.Exists('AmbRaid[Time]Remove') then
				if ( GetConVar( "amb_hud" ):GetInt() == 1 ) or ( GetConVar( "amb_hud" ):GetInt() == 2 ) then
					draw.SimpleText(  'TimeLife: '..math.Round( timer.TimeLeft('AmbRaid[Time]Remove')/60, 2 ), "ambFont22",
			        w/2, 54,
			        Color( 255, 255, 255, 255 ),
			        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
			        )
				end
			end

			if IsValid( amb_ent_boss ) then
				if ( GetConVar( "amb_hud" ):GetInt() == 1 ) or ( GetConVar( "amb_hud" ):GetInt() == 2 ) then
					draw.SimpleText(  tostring( amb_ent_boss:GetNWString('amb_raid_name') )..': '..amb_ent_boss:Health()..' HP', "ambFont32",
			        w/2, 86,
			        Color( 255, 255, 255, 255 ),
			        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
			        )
				end
			end
		end
	end )
end