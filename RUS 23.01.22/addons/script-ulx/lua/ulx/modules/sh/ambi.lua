local CATEGORY = '[RUS]'

function ulx.giveaccess( ePly, eTarget, nAccess )
    eTarget[1]:SetAccess( nAccess )

	ulx.fancyLogAdmin( ePly, "#A дал #i уровень доступа #T", nAccess, eTarget )
end
local method = ulx.command( CATEGORY, 'ulx giveaccess', ulx.giveaccess, '/giveaccess' )
method:addParam{ type=ULib.cmds.PlayersArg }
method:addParam{ type=ULib.cmds.NumArg, min = 0, default = 0, max = 2, hint = 'Access', ULib.cmds.optional, ULib.cmds.round }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( '!' )

function ulx.addxp( ePly, eTarget, nXP )
    eTarget[1]:AddXP( nXP )

	ulx.fancyLogAdmin( ePly, "#A дал #i XP игроку #T", nXP, eTarget )
end
local method = ulx.command( CATEGORY, 'ulx addxp', ulx.addxp, '/addxp' )
method:addParam{ type=ULib.cmds.PlayersArg }
method:addParam{ type=ULib.cmds.NumArg, min = 0, default = 0, max = 999999999, hint = 'XP', ULib.cmds.optional, ULib.cmds.round }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( '!' )

function ulx.setname( ePly, eTarget, sName )
    eTarget[1]:SetName( sName )

	ulx.fancyLogAdmin( ePly, "#A изменил имя игроку #T на #s", eTarget, sName )
end
local method = ulx.command( CATEGORY, 'ulx setname', ulx.setname, '/setname' )
method:addParam{ type=ULib.cmds.PlayersArg }
method:addParam{ type=ULib.cmds.StringArg, hint = 'Имя' }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( 'Изменить имя' )

function ulx.addlevel( ePly, eTarget, nLevel )
    eTarget[1]:AddLevel( nLevel )

	ulx.fancyLogAdmin( ePly, "#A дал #i уровень игроку #T", nLevel, eTarget )
end
local method = ulx.command( CATEGORY, 'ulx addlevel', ulx.addlevel, '/addlevel' )
method:addParam{ type=ULib.cmds.PlayersArg }
method:addParam{ type=ULib.cmds.NumArg, min = 0, default = 0, max = 999999999, hint = 'Level', ULib.cmds.optional, ULib.cmds.round }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( '!' )

function ulx.addmoney( ePly, eTarget, nMoney )
    eTarget[1]:AddMoney( nMoney )

	ulx.fancyLogAdmin( ePly, "#A дал #i денюшек игроку #T", nMoney, eTarget )
end
local method = ulx.command( CATEGORY, 'ulx addmoney', ulx.addmoney, '/addmoney' )
method:addParam{ type=ULib.cmds.PlayersArg }
method:addParam{ type=ULib.cmds.NumArg, min = 0, default = 0, max = 999999999, hint = 'Money', ULib.cmds.optional, ULib.cmds.round }
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( '!' )

function ulx.startvotemap( ePly )
    AMB.VoteMap.Start()

    ulx.fancyLogAdmin( ePly, "#A запустил (попытался) голосование на смену карты")
end
local method = ulx.command( CATEGORY, 'ulx startvotemap', ulx.startvotemap, '/startvotemap' )
method:defaultAccess( ULib.ACCESS_SUPERADMIN )
method:help( '!' )