local ply_struct = FindMetaTable("Player")




-- FriskCoinsLib -- -----------------------------------------------------


function ply_struct:FC_set( int )
	self:SetNWInt("friskCoins", int )
	self:PS_money_LoadData()
	self:FC_save()
end

function ply_struct:FC_add( int )
	self:SetNWInt("friskCoins", self:GetNWInt("friskCoins") + int )
	self:PS_money_LoadData()
	self:FC_save()
end

function ply_struct:FC_minus( int )
	self:SetNWInt("friskCoins", self:GetNWInt("friskCoins") - int )
	self:PS_money_LoadData()
	self:FC_save()
end

-- -----------------------------------------------------



-- PayDay -- -------------------------------------------

