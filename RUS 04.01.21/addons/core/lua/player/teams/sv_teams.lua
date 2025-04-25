--[[
	Основная информация про игрока.
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[30.07.20]
		• Перенёс сюда teams.
	.
    [31.07.20]
        • Добавил конфигурацию, надеюсь сработает (godmode, should_damage, noclip).
    .
]]

local COLOR_TEXT = Color( 240, 240, 240 )
local COLOR_RED = Color( 242, 90, 73 )

local delay_team = 2

local info_teams = {

    [ AMB_TEAM_CITIZEN ] = {

    	pos = {

            [ 'gm_construct' ] = { 
                
                { vec = Vector( -3881, -3485, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3984, -3480, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4087, -3474, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4190, -3468, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4294, -3462, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4397, -3456, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4391, -3353, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4288, -3359, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4185, -3365, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4081, -3371, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3978, -3376, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3875, -3382, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3869, -3279, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3972, -3273, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4076, -3267, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4179, -3262, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4282, -3256, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4385, -3250, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4379, -3147, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4276, -3153, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4173, -3158, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4070, -3164, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3967, -3170, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3863, -3176, 313 ), ang = Angle( 0, 90, 0 ) },
                
            },

            [ 'gm_flatgrass' ] = {

                { vec = Vector( 192, 957, -12715 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( 101, 929, -12724 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -2, 923, -12727 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -85, 906, -12727 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -200, 901, -12727 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -296, 917, -12732 ), ang = Angle( 0, 90, 0 ) }

            }

        },
        on_noclip = false,
        on_godmode = true,
        on_damageplayer = false,
        walk_speed = 60,
        run_speed = 100,
        weapons = {}

    },

    [ AMB_TEAM_PVP ] = {

        pos = {

            [ 'gm_construct' ] = { 
                
                { vec = Vector( -3881, -3485, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3984, -3480, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4087, -3474, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4190, -3468, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4294, -3462, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4397, -3456, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4391, -3353, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4288, -3359, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4185, -3365, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4081, -3371, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3978, -3376, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3875, -3382, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3869, -3279, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3972, -3273, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4076, -3267, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4179, -3262, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4282, -3256, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4385, -3250, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4379, -3147, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4276, -3153, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4173, -3158, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4070, -3164, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3967, -3170, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3863, -3176, 313 ), ang = Angle( 0, 90, 0 ) },
                
            },

            [ 'gm_flatgrass' ] = {

                { vec = Vector(-526, 1104, -12724 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-526, 1104, -12724  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-800, 1028, -12718  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-942, 929, -12716  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1070, 682, -12723  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1125, 446, -12727  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1122, 200, -12699  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1074, 21, -12712  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1095, -80, -12700  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1111, -181, -12701  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1103, -279, -12713  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1097, -381, -12709  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1101, -502, -12698  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1096, -592, -12707  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1059, -686, -12719  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1041, -777, -12717  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-984, -865, -12717  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-894, -954, -12715  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-798, -1026, -12719  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-585, -1081, -12721  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-449, -1082, -12734  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 456, 1083, -12721 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 730, 1068, -12718 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 950, 911, -12714 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1111, 709, -12723 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1118, 490, -12715 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1156, 353, -12716 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1101, 87, -12723 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1106, -102, -12712 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1119, -277, -12701 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1104, -474, -12721 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1071, -704, -12730 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 965, -896, -12729 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 819, -1049, -12740 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 595, -1118, -12723 ), ang = Angle( 0, 45, 0 ) },


            },

            [ 'gm_rus' ] = {

                { vec = Vector( 5282, -3347, 616 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( 5987, -3348, 613 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( 6066, -4054, 617 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( 5278, -4030, 630 ), ang = Angle( 0, -90, 0 ) },

            }

        },
        on_noclip = false,
        on_godmode = false,
        on_damageplayer = true,
        walk_speed = 380,
        run_speed = 600,
        weapons = {

            'weapon_crowbar',
            'weapon_physgun',
            'weapon_physcannon',
            'gmod_tool',

        }

    },

    [ AMB_TEAM_RP ] = {

        pos = {

            [ 'gm_construct' ] = { 
                
                { vec = Vector( -3881, -3485, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3984, -3480, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4087, -3474, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4190, -3468, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4294, -3462, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4397, -3456, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4391, -3353, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4288, -3359, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4185, -3365, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4081, -3371, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3978, -3376, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3875, -3382, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3869, -3279, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3972, -3273, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4076, -3267, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4179, -3262, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4282, -3256, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4385, -3250, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4379, -3147, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4276, -3153, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4173, -3158, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4070, -3164, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3967, -3170, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3863, -3176, 313 ), ang = Angle( 0, 90, 0 ) },
                
            },

            [ 'gm_flatgrass' ] = {

                { vec = Vector(-526, 1104, -12724 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-526, 1104, -12724  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-800, 1028, -12718  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-942, 929, -12716  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1070, 682, -12723  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1125, 446, -12727  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1122, 200, -12699  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1074, 21, -12712  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1095, -80, -12700  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1111, -181, -12701  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1103, -279, -12713  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1097, -381, -12709  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1101, -502, -12698  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1096, -592, -12707  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1059, -686, -12719  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-1041, -777, -12717  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-984, -865, -12717  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-894, -954, -12715  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-798, -1026, -12719  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-585, -1081, -12721  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector(-449, -1082, -12734  ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 456, 1083, -12721 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 730, 1068, -12718 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 950, 911, -12714 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1111, 709, -12723 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1118, 490, -12715 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1156, 353, -12716 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1101, 87, -12723 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1106, -102, -12712 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1119, -277, -12701 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1104, -474, -12721 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 1071, -704, -12730 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 965, -896, -12729 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 819, -1049, -12740 ), ang = Angle( 0, 45, 0 ) },
                { vec = Vector( 595, -1118, -12723 ), ang = Angle( 0, 45, 0 ) },


            },

            [ 'gm_rus' ] = {

                { vec = Vector( 5282, -3347, 616 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( 5987, -3348, 613 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( 6066, -4054, 617 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( 5278, -4030, 630 ), ang = Angle( 0, -90, 0 ) },

            }

        },
        on_noclip = false,
        on_godmode = false,
        on_damageplayer = true,
        walk_speed = 220,
        run_speed = 360,
        weapons = {

            'weapon_physgun',
            'weapon_physcannon',
            'weapon_empty_hands',
            'gmod_tool',

        }

    },

    [ AMB_TEAM_BUILD ] = {

    	pos = {

            [ 'gm_construct' ] = { 
                
                { vec = Vector( -3881, -3485, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3984, -3480, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4087, -3474, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4190, -3468, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4294, -3462, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4397, -3456, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4391, -3353, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4288, -3359, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4185, -3365, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4081, -3371, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3978, -3376, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3875, -3382, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3869, -3279, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3972, -3273, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4076, -3267, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4179, -3262, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4282, -3256, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4385, -3250, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4379, -3147, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4276, -3153, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4173, -3158, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -4070, -3164, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3967, -3170, 313 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -3863, -3176, 313 ), ang = Angle( 0, 90, 0 ) },
                
            },

            [ 'gm_flatgrass' ] = {

                { vec = Vector( 192, 957, -12715 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( 101, 929, -12724 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -2, 923, -12727 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -85, 906, -12727 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -200, 901, -12727 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( -296, 917, -12732 ), ang = Angle( 0, 90, 0 ) },
                { vec = Vector( 223, -1006, -12732 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( 138, -1010, -12736 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( 55, -1004, -12737 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( -36, -998, -12734 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( -155, -994, -12737 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( -265, -1003, -12728 ), ang = Angle( 0, -90, 0 ) }

            },

            [ 'gm_rus' ] = {

                { vec = Vector( -9693, -9033, 621 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( -9590, -9063, 610 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( -9285, -9040, 607 ), ang = Angle( 0, -90, 0 ) },
                { vec = Vector( -9156, -9031, 610 ), ang = Angle( 0, -90, 0 ) },

            }

        },
        on_noclip = true,
        on_godmode = true,
        on_damageplayer = false,
        walk_speed = 250,
        run_speed = 450,
        weapons = {

            'weapon_physcannon',
            'gmod_tool',
            'weapon_physgun'

        }

    }

}

function AmbStats.Players.changeTeam( ePly, nTeam )

    if ePly:GetNWBool( 'amb_bad' ) then return end
    
    if info_teams[ nTeam ] then

        ePly:SetTeam( nTeam )
        ePly:Spawn()
        AmbLib.chatSend( ePly, AMB_COLOR_AMBITION, '[•] ', COLOR_TEXT, 'Вы стали ', team.GetColor( ePly:Team() ),team.GetName( ePly:Team() ) ) 

    else

        ePly:SetTeam( AMB_TEAM_CITIZEN )
        ePly:Spawn()

    end

end

function AmbStats.Players.loadWeapons( ePly )

    if not info_teams[ ePly:Team() ] then return false end

    local guns = info_teams[ ePly:Team() ].weapons
    if not guns then return false end
    
    ePly:StripWeapons()

    for i = 1, #guns do
        
        ePly:Give( guns[ i ] )

    end

    return false

end
hook.Add( 'PlayerLoadout', 'AmbitionTeamsLoadout', AmbStats.Players.loadWeapons )

local rand_name_teachers = {

    'Галина',
    'Комария',
    'Наталья',
    'Айгуля',
    'Анастасия',
    'Тамара',
    'Любовь',
    'София',
    'Марина',
    'Мария',
    'Надежда',
    'Александра',
    'Валерия',
    'Виктория',
    'Екатерина',

}

local rand_name_father_teachers = {

    'Фёдоровна',
    'Владимировна',
    'Ковылановна',
    'Пантелеевна',
    'Алексеевна',
    'Анатольевна',
    'Ивановна',
    'Михайловна',
    'Евгеньевна',
    'Азадовна',
    'Александровна',

}

hook.Add( 'PlayerInitialSpawn', 'AmbitionTeamsSpawnInitial', function( ePly )

    timer.Simple( 0, function() 
    
        AmbStats.Players.changeTeam( ePly, AMB_TEAM_CITIZEN )

        if ePly:IsBot() then

            AmbStats.Players.changeTeam( ePly, AMB_TEAM_PVP )
            AmbStats.Players.setStats( ePly, 'name', table.Random( rand_name_teachers )..' '..table.Random( rand_name_father_teachers ) )

        end
        
    end )

end )

hook.Add( 'PlayerSpawn', 'AmbitionTeamsSpawn', function( ePly )

    if ePly:GetNWBool('amb_bad') then ePly:StripWeapons() end
    
    local team = info_teams[ ePly:Team() ]
    if not team then return end

    timer.Simple( 0, function() 

        ePly:SetRunSpeed( team.run_speed )
        ePly:SetWalkSpeed( team.walk_speed )
        if team.on_godmode then ePly:GodEnable() end

    end )

    if ( ePly:Team() == AMB_TEAM_PVP ) then 

        ePly:SetMaterial( 'models/alyx/emptool_glow' )
        timer.Create( 'AmbTime[PVP;ID:'..ePly:EntIndex()..']', 4, 1, function() ePly:SetMaterial( '' ) end )

    end

    local pos = team.pos[ game.GetMap() ]
    if not pos then return end
    
    pos = team.pos[ game.GetMap() ][ math.random( 1, #pos ) ]

    ePly:SetPos( pos.vec )
    ePly:SetEyeAngles( pos.ang )

end )

hook.Add( 'PlayerNoClip', 'AmbitionTeamsNoclip', function( ePly )

    if ( ePly:Team() == AMB_TEAM_CITIZEN ) then return false end

    return info_teams[ ePly:Team() ].on_noclip

end)

hook.Add( 'PlayerShouldTakeDamage', 'amb_0x3492', function( ply, attacker )

    if ( ply:Team() == AMB_TEAM_CITIZEN ) or ( ply:Team() == AMB_TEAM_BUILD ) then return false end
    if ( ply:Team() == AMB_TEAM_PVP ) and timer.Exists( 'AmbTime[PVP;ID:'..ply:EntIndex()..']' ) then return false end

end )

hook.Add( 'EntityTakeDamage', 'amb_0x3492', function( ent, damage )

    if IsValid( damage:GetAttacker() ) and damage:GetAttacker():IsPlayer() then

        if ( damage:GetAttacker():Team() == AMB_TEAM_CITIZEN ) or ( damage:GetAttacker():Team() == AMB_TEAM_BUILD ) then damage:SetDamage( 0 ) end
        if ( damage:GetAttacker():Team() == AMB_TEAM_PVP ) and timer.Exists( 'AmbTime[PVP;ID:'..damage:GetAttacker():EntIndex()..']' ) then damage:SetDamage( 0 ) end

    end

end )

util.AddNetworkString('amb_teams_change')
net.Receive( 'amb_teams_change', function( len )

    local ePly = net.ReadEntity()
    local id = net.ReadUInt( 3 )

    AmbStats.Players.changeTeam( ePly, id )

end )
