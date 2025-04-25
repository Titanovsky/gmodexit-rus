-- Для предложения совершения покупок в определенных ситуациях
-- /igsitem group_premium_30d

if SERVER then
	local function RunCommand(c)
		return function(pl) pl:RunSCC(c) end
	end

	IGS.WIN = IGS.WIN or {}
	IGS.WIN.Item    = RunCommand("IGSItem")
	IGS.WIN.Group   = RunCommand("IGSGroup")
	IGS.WIN.Deposit = RunCommand("IGSDeposit")
end

scc.addClientside("IGSItem",    IGS.WIN.Item)
scc.addClientside("IGSDeposit", IGS.WIN.Deposit)
scc.addClientside("IGSGroup",   IGS.WIN.Group)
