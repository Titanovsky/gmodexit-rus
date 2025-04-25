--[[
	Цены в .Add указываются в рублях
	pl:IGSFunds()*0.04 (проценты)
	pl:AddIGSFunds
]]

local function PrintChat( ePly, sText )

	AmbLib.chatSend( ePly, AMB_COLOR_AMETHYST, '[•] ', AMB_COLOR_WHITE, sText )

end

IGS.LVL.Add( 200, 'Бродяга' )

	:SetBonus( function( ePly )

		local summ = 25
		ePly:AddIGSFunds( summ, 'Бонус за 50 рублей!' )
		PrintChat( ePly, 'Донат-Бонус: Cashback в размере '..summ..' рублей!' )

	end)

:SetDescription( 'При пополнений на 50 рублей, вы получаете Кешбек на 50% (25 рублей)' )

IGS.LVL.Add( 500, 'Школьник' )

	:SetBonus( function( ePly )

		local summ = 50
		ePly:AddIGSFunds( summ, 'Бонус за 100 рублей!' )
		PrintChat( ePly, 'Донат-Бонус: Cashback в размере '..summ..' рублей!' )

	end)

:SetDescription( 'При пополнений на 100 рублей, вы получаете Кешбек в размере 50-ти рублей' )