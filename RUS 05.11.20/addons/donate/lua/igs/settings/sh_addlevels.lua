--[[
	Цены в .Add указываются в рублях
	pl:IGSFunds()*0.04 (проценты)
	pl:AddIGSFunds
]]

local function PrintChat( ePly, sText )

	AmbLib.chatSend( ePly, AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, sText )

end

IGS.LVL.Add( 50, 'Бродяга' )

	:SetBonus( function( ePly )

		local summ = 25
		ePly:AddIGSFunds( summ, 'Бонус за 50 рублей!' )
		PrintChat( ePly, 'Донат-Бонус: Cashback в размере '..summ..' рублей!' )

	end)

:SetDescription( 'При пополнений на 50 рублей, вы получаете Кешбек на 50% (25 рублей)' )

IGS.LVL.Add( 100, 'Школьник' )

	:SetBonus( function( ePly )

		local summ = 50
		ePly:AddIGSFunds( summ, 'Бонус за 100 рублей!' )
		PrintChat( ePly, 'Донат-Бонус: Cashback в размере '..summ..' рублей!' )

	end)

:SetDescription( 'При пополнений на 100 рублей, вы получаете Кешбек в размере 50-ти рублей' )

local rand_guns = {
	'arccw_ak47',
	'arccw_deagle50',
	'arccw_m107',
	'arccw_tommygun'
}

IGS.LVL.Add( 150, 'DarkRP-Помойка' )

	:SetBonus( function( ePly )

		local summ = 25
		ePly:AddIGSFunds( summ, 'Бонус за 150 рублей!' )
		PrintChat( ePly, 'Донат-Бонус: Cashback в размере '..summ..' рублей! И какие-ту пушку.' )
		ePly:Give( rand_guns )

	end)

:SetDescription( 'При пополнений на 150 рублей, вы получаете Кешбек в размере 25-ти рублей и какую-то пушку' )

IGS.LVL.Add( 200, 'Мажор' )

	:SetBonus( function( ePly )

		local summ = 25
		ePly:AddIGSFunds( summ, 'Бонус за 200 рублей!' )
		PrintChat( ePly, 'Донат-Бонус: Cashback в размере '..summ..' рублей! И какие-ту пушку.' )
		ePly:Give( rand_guns )
		ePly:SetHealth( 666 )

	end)

:SetDescription( 'При пополнений на 200 рублей, вы получаете Кешбек в размере 25-ти рублей, пушку и 666 HP' )
