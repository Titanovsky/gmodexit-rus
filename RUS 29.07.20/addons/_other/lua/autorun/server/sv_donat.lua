local wep1 = {
	"weapon_hl2axe",
	"weapon_hl2hook",
	"weapon_hl2pan",
	"weapon_hl2pickaxe",
	"weapon_hl2pot",
	"weapon_hl2shovel"
}

local wep2 = {
	"laserpointer",
	"wep_jack_gmod_hands",
	"manhack_welder",
	"weapon_medkit",
	"weapon_bugbait"
}

local wep3 = {
	"breadfish_weap",
	"weapon_bugbait"
}


local wep4 = {
	"weapon_357",
	"weapon_pistol",
	"weapon_crossbow",
	"weapon_crowbar",
	"weapon_frag",
	"weapon_ar2",
	"weapon_rpg",
	"weapon_slam",
	"weapon_shotgun",
	"weapon_smg1",
	"weapon_stunstick"
}

local wep5 = {
	"cw_ak74",
	"weapon_smg1",
	"cw_ar15",
	"cw_extrema_ratio_official",
	"cw_flash_grenade",
	"cw_fiveseven",
	"cw_scarh",
	"cw_frag_grenade",
	"cw_l115",
	"cw_m249_official",
	"cw_smoke_grenade",
	"cw_mp5",
	"cw_vss"
}

local ents_godno = {
	"cw_ammo_kit_regular",
	"sent_ball",
	"item_ammo_357_large",
	"item_ammo_ar2_large",
	"item_ammo_ar2_altfire",
	"grenade_helicopter",
	"item_box_buckshot",
	"item_battery",
	"item_healthkit",
	"item_ammo_smg1_large",
	"item_rpg_round",
	"item_ammo_pistol_large",
	"ent_jack_bodyarmor_helm_kr",
	"ent_jack_bodyarmor_helm_im",
	"ent_jack_bodyarmor_helm_st",
	"ent_jack_suit_hazmat",
	"ent_jack_suit_fire",
	"ent_jack_bodyarmor_vest_sk",
	"ent_jack_bodyarmor_vest_bn",
	"ent_jack_firework",
	"ent_jack_target",
	"ent_jack_aidfuel_kerosene",
	"ent_jack_fgweaponbox_alpha_long",
	"ent_jack_fgweaponbox_epsilon",
	"ent_jack_fgweaponbox_gamma",
	"ent_jack_fgweaponbox_gamma_long",
	"gmod_sent_vehicle_fphysics_gaspump_diesel",
	"ent_jack_gmod_ezbuildkit",
	"ent_jack_gmod_ezsatchelcharge",
	"ent_jack_gmod_ezarmor_htorso",
	"ent_jack_gmod_ezarmor_thermals"
}

local ents_trash = {
	"models/props_phx/games/chess/black_dama.mdl",
	"models/props_junk/wood_crate001a.mdl",
	"models/props_junk/cardboard_box002a.mdl"
}

local ents_npcs = {
	"npc_monk",
	"npc_crow",
	"npc_pigeon",
	"npc_seagull",
	"npc_cscanner",
	"npc_combine_s",
	"npc_stalker",
	"npc_rollermine",
	"npc_clawscanner",
	"npc_strider",
	"npc_manhack",
	"npc_vortigaunt",
	"npc_odessa",
	"npc_gman",
	"npc_dog",
	"npc_alyx",
	"npc_barney",
	"npc_kleiner",
	"npc_antlion",
	"npc_fastzombie",
	"npc_zombie",
	"npc_poisonzombie",
	"npc_antlionguard",
	"npc_headcrab"
}


function RusCore_CaseGuns( ePly )
	local num = math.random( 1, 100 )

	if ( num >= 1 ) and ( num <= 20 ) then
		ePly:Give( table.Random( wep1 ) )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты открыл: Ни о чём' )")
	end
	if ( num >= 21 ) and ( num <= 40 ) then
		ePly:Give( table.Random( wep2 ) )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты открыл: Бред' )")
	end
	if ( num >= 41 ) and ( num <= 60 ) then
		ePly:Give( table.Random( wep3 ) )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты открыл: Секрет' )")
	end
	if ( num >= 61 ) and ( num <= 80 ) then
		ePly:Give( table.Random( wep4 ) )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты открыл: Half-Life 2' )")
	end
	if ( num >= 81 ) and ( num <= 100 ) then
		ePly:Give( table.Random( wep5 ) )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты открыл: CW 2.0' )")
	end
end

function RusCore_CaseEnts( ePly )
	local num = math.random( 1, 100 )

	if ( num >= 1 ) and ( num <= 30 ) then
		local ent = ents.Create( table.Random( ents_godno ) )
		ent:Spawn()
		ent:SetPos( ePly:GetPos() + Vector( -45, 0, 45 ) )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты открыл: Вещичку' )")
	end

	if ( num >= 31 ) and ( num <= 60 ) then
		local ent = ents.Create( "prop_physics" )
		ent:SetModel( table.Random( ents_trash ) )
		ent:Spawn()
		ent:SetPos( ePly:GetPos() + Vector( -55, 0, 45 ) )
		timer.Simple( 4, function()
			if IsValid(ent) then ent:Remove() else return end
		end)
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты открыл: Мусор' )")
	end

	if ( num >= 61 ) and ( num <= 100 ) then
		local ent = ents.Create( table.Random( ents_npcs ) )
		ent:Spawn()
		ent:SetPos( ePly:GetPos() + Vector( -55, 0, 45 ) )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты открыл: NPC' )")
	end
end

function RusCore_CaseMoney( ePly )
	local num = math.random( 1, 100 )
	local money1 = math.random( 1, 5000 )
	local money2 = math.random( 5000, 25000 )
	local money3 = math.random( 25000, 100000 )

	if ( num >= 1 ) and ( num <= 30 ) then
		ePly:RUB_add( money1 )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты выйграл: '.."..money1.." )")
	end

	if ( num >= 31 ) and ( num <= 60 ) then
		ePly:RUB_add( money2 )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты выйграл: '.."..money2.." )")
	end

	if ( num >= 61 ) and ( num <= 100 ) then
		ePly:RUB_add( money3 )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты выйграл: '.."..money3.." )")
	end
end

function RusCore_GoldEgg( ePly )
	local num = math.random( 1, 100 )
	local money1 = math.random( 100000, 1000000 )
	local money2 = math.random( 1000000, 64000000 )

	if ( num >= 1 ) and ( num <= 50 ) then
		ePly:EXP_add( 1 )
		ePly:RUB_add( money1 )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты выйграл: '.."..money1.." )")
	end

	if ( num >= 51 ) and ( num <= 100 ) then
		ePly:EXP_add( 1 )
		ePly:RUB_add( money2 )
		ePly:SendLua("chat.AddText( Color(224, 211, 108), 'Ты выйграл: '.."..money2.." )")
	end

end