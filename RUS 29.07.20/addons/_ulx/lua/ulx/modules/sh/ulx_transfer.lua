local CATEGORY_NAME = "[RU's] Dev"
local CAT = "[RU's] Статистика"
local warpCat = "[RU's] Events"


function ulx.secret( calling_ply, target_ply )
	if target_ply:IsBot() then
		ULib.tsayError( calling_ply, "This player is immune to banning", true )
		return
	end

	ulx.fancyLogAdmin( calling_ply, false, "#A сделал для #T какой-то секрет", target_ply )

	target_ply:ConCommand("material_bad")
end
local secret = ulx.command( CATEGORY_NAME, "ulx secret", ulx.secret, "!secret" )
secret:addParam{ type=ULib.cmds.PlayerArg }
secret:defaultAccess( ULib.ACCESS_SUPERADMIN )
secret:help( "Дать игроку секрет." )


local warpOn = false
local warpPos = Vector(0,0,0)


function ulx.warp( calling_ply )
	if warpOn then
		calling_ply:SetPos( warpPos )
		ulx.fancyLogAdmin( calling_ply, false, "#A отправился в Warp" )
	else
		ULib.tsayError( calling_ply, "Варп закрыт", true )
	end
end
local warp = ulx.command( warpCat, "ulx warp", ulx.warp, "!warp" )
warp:defaultAccess( ULib.ACCESS_ALL )
warp:help( "ТПшнутся на варп." )

function ulx.setwarp( calling_ply )
	if warpOn then
		warpOn = false
		ulx.fancyLogAdmin( calling_ply, false, "#A закрыл Warp" )
	else
		warpOn = true
		warpPos = calling_ply:GetPos()
		ulx.fancyLogAdmin( calling_ply, false, "#A открыл Warp" )
	end
end
local setwarp = ulx.command( warpCat, "ulx setwarp", ulx.setwarp, "!setwarp" )
setwarp:defaultAccess( ULib.ACCESS_ADMIN )
setwarp:help( "Открыть и сделать варп по Вашей позиции/Закрыть варп." )

function ulx.stripsweaponsevent( calling_ply )

	for k, v in pairs(player.GetHumans()) do
		if ( v ~= calling_ply ) and ( ( calling_ply:GetPos():Distance( v:GetPos() ) ) <= 1000 )then
			v:StripWeapons()
		end
	end
end
local stripsweaponsevent = ulx.command( warpCat, "ulx swe", ulx.stripsweaponsevent, "!swe" )
stripsweaponsevent:defaultAccess( ULib.ACCESS_ADMIN )
stripsweaponsevent:help( "Стрипнуть игроков по радиусу." )

function ulx.hpevent( calling_ply, number )

	for k, v in pairs(player.GetHumans()) do
		if ( v ~= calling_ply ) and ( ( calling_ply:GetPos():Distance( v:GetPos() ) ) <= 1200 ) then
			v:SetHealth( number )
		end
	end

	ulx.fancyLogAdmin( calling_ply, false, "#A дал ХПшки по радиусу #i", number )
end
local hpevent = ulx.command( warpCat, "ulx he", ulx.hpevent, "!he" )
hpevent:addParam{ type=ULib.cmds.NumArg, hint="HP" }
hpevent:defaultAccess( ULib.ACCESS_ADMIN )
hpevent:help( "дать Хп по радиусу." )

function ulx.hpevent( calling_ply, number )

	for k, v in pairs(player.GetHumans()) do
		if ( v ~= calling_ply ) and ( ( calling_ply:GetPos():Distance( v:GetPos() ) ) <= 1200 ) then
			v:SetHealth( number )
		end
	end

	ulx.fancyLogAdmin( calling_ply, false, "#A дал ХПшки по радиусу #i", number )
end
local hpevent = ulx.command( warpCat, "ulx he", ulx.hpevent, "!he" )
hpevent:addParam{ type=ULib.cmds.NumArg, min=0, max=10^25, default=1, hint="HP", ULib.cmds.optional}
hpevent:defaultAccess( ULib.ACCESS_ADMIN )
hpevent:help( "Восстановить Хп и снять Armor по радиусу." )

function ulx.money_set( ply, targ, amount )
	for i=1, #targ do
		targ[ i ]:RUB_set( amount )
	end
	ulx.fancyLogAdmin( ply, "#A изменил количество рубаксов для #T на #i", targ, amount )
end
local money_set = ulx.command( CAT, "ulx set money", ulx.money_set, "!setmoney" )
money_set:addParam{ type=ULib.cmds.PlayersArg }
money_set:addParam{ type=ULib.cmds.NumArg, min=0, max=2^25, hint="Рубаксы", ULib.cmds.round }
money_set:defaultAccess( ULib.ACCESS_ADMIN )
money_set:help( "Изменить количество рубаксов." )


function ulx.money_add( ply, targ, amount )
	for i=1, #targ do
		targ[ i ]:RUB_add( amount )
	end
	ulx.fancyLogAdmin( ply, "#A добавил количество рубаксов для #T по #i", targ, amount )
end
local money_add = ulx.command( CAT, "ulx add money", ulx.money_add, "!addmoney" )
money_add:addParam{ type=ULib.cmds.PlayersArg }
money_add:addParam{ type=ULib.cmds.NumArg, min=1, max=2^25, hint="Рубаксы", ULib.cmds.round }
money_add:defaultAccess( ULib.ACCESS_ADMIN )
money_add:help( "Добавить количество рубаксов." )

function ulx.transfer_money( ply, targ, amount )
    if ( ply:GetNWInt("rub") >= amount ) then
        ply:RUB_minus( amount )
        for i=1, #targ do
			targ[i]:RUB_add( amount )
		end
    else
        ULib.tsayError( ply, "У вас нет столько рубаксов", true )
    end
end
local transfer_money = ulx.command( CAT, "ulx transfer", ulx.transfer_money, "!transfer" )
transfer_money:addParam{ type=ULib.cmds.PlayersArg }
transfer_money:addParam{ type=ULib.cmds.NumArg, min=1, max=2^25, hint="Передать рубаксы", ULib.cmds.round }
transfer_money:defaultAccess( ULib.ACCESS_ALL )
transfer_money:help( "Передать рубаксы." )

------------------------------ LVL ------------------------------

function ulx.lvl_set( ply, targ, amount )
	for i=1, #targ do
		targ[ i ]:LVL_set( amount )
	end
	ulx.fancyLogAdmin( ply, "#A изменил уровень #T на #i", targ, amount )
end
local lvl_set = ulx.command( CAT, "ulx set lvl", ulx.lvl_set, "!setlvl" )
lvl_set:addParam{ type=ULib.cmds.PlayersArg }
lvl_set:addParam{ type=ULib.cmds.NumArg, min=1, max=99, hint="Уровень", ULib.cmds.round }
lvl_set:defaultAccess( ULib.ACCESS_SUPERADMIN )
lvl_set:help( "Изменить уровень." )


function ulx.lvl_add( ply, targ, amount )
	for i=1, #targ do
		targ[ i ]:LVL_add( amount )
	end
	ulx.fancyLogAdmin( ply, "#A добавил #i уровень для #T", amount, targ )
end
local lvl_add = ulx.command( CAT, "ulx add lvl", ulx.lvl_add, "!addlvl" )
lvl_add:addParam{ type=ULib.cmds.PlayersArg }
lvl_add:addParam{ type=ULib.cmds.NumArg, min=1, max=99, hint="Уровень", ULib.cmds.round }
lvl_add:defaultAccess( ULib.ACCESS_SUPERADMIN )
lvl_add:help( "Добавить уровень." )



------------------------------ EXP ------------------------------

function ulx.exp_set( ply, targ, amount )
	for i=1, #targ do
		targ[ i ]:EXP_set( amount )
	end
	ulx.fancyLogAdmin( ply, "#A изменил экспу #T на #i", targ, amount )
end
local exp_set = ulx.command( CAT, "ulx set exp", ulx.exp_set, "!setexp" )
exp_set:addParam{ type=ULib.cmds.PlayersArg }
exp_set:addParam{ type=ULib.cmds.NumArg, min=0, max=99, hint="EXP", ULib.cmds.round }
exp_set:defaultAccess( ULib.ACCESS_SUPERADMIN )
exp_set:help( "Изменить экспу." )


function ulx.exp_add( ply, targ, amount )
	for i=1, #targ do
		targ[ i ]:EXP_add( amount )
	end
	ulx.fancyLogAdmin( ply, "#A добавил #i экспы для #T", amount, targ )
end
local exp_add = ulx.command( CAT, "ulx add exp", ulx.exp_add, "!addexp" )
exp_add:addParam{ type=ULib.cmds.PlayersArg }
exp_add:addParam{ type=ULib.cmds.NumArg, min=1, max=99, hint="EXP", ULib.cmds.round }
exp_add:defaultAccess( ULib.ACCESS_SUPERADMIN )
exp_add:help( "Добавить экспу." )

------------------------------ LVL ------------------------------

function ulx.next_exp_set( ply, targ, amount )
	for i=1, #targ do
		targ[ i ]:NEXP_set( amount )
	end
end
local next_exp_set = ulx.command( CAT, "ulx set nextexp", ulx.next_exp_set, "!setnextexp" )
next_exp_set:addParam{ type=ULib.cmds.PlayersArg }
next_exp_set:addParam{ type=ULib.cmds.NumArg, min=1, max=9999, hint="NextExp", ULib.cmds.round }
next_exp_set:defaultAccess( ULib.ACCESS_SUPERADMIN )
next_exp_set:help( "Изменить уровень." )

------------------------------ Armor ------------------------------
function ulx.armor( calling_ply, target_plys, amount )
	for i=1, #target_plys do
		target_plys[ i ]:SetArmor( amount )
	end
	ulx.fancyLogAdmin( calling_ply, "#A set the armor for #T to #i", target_plys, amount )
end
local armor = ulx.command( CATEGORY_NAME, "ulx armor", ulx.armor, "!armor" )
armor:addParam{ type=ULib.cmds.PlayersArg }
armor:addParam{ type=ULib.cmds.NumArg, min=0, max=255, hint="armor", ULib.cmds.round }
armor:defaultAccess( ULib.ACCESS_ADMIN )
armor:help( "Sets the armor for target(s)." )