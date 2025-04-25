local ply_struct = FindMetaTable("Player")



function ply_struct:RUB_set( int )
	self:SetNWInt("rub", int )
	self:RUB_save()
end

function ply_struct:RUB_add( int )
	self:SetNWInt("rub", self:GetNWInt("rub") + int )
	self:RUB_save()
end

function ply_struct:RUB_minus( int )
	self:SetNWInt("rub", self:GetNWInt("rub") - int )
	self:RUB_save()
end


hook.Add("PlayerDeath", "ru_rubaks_death", function( victim, inf, attack)
	local reward = 99

	if ( not victim:GetName() == inf:GetName() ) then
		inf:RUB_add(reward)
	end 

	if victim:GetNWBool("IsBuild") then
		victim:SetNWBool("IsBuild", false)
	end
end)