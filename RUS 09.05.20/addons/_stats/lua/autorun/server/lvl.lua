local ply_struct = FindMetaTable("Player")


--


function ply_struct:LVL_set( int )
	self:SetNWInt("lvl", int )
	self:LVL_save()
end

function ply_struct:LVL_add( int )
	self:SetNWInt("lvl", self:GetNWInt("lvl") + int )
	self:LVL_save()
end

--

function ply_struct:EXP_set( int )
	self:SetNWInt("exp", int )
	self:EXP_save()
end

function ply_struct:EXP_add( int )
	self:SetNWInt("exp", self:GetNWInt("exp") + int )
	if tonumber(self:GetNWInt("exp")) >= tonumber(self:GetNWInt("next_exp")) then
		self:SetNWInt("exp", 0)
		self:LVL_add(1)
		self:NEXP_add()
	end
	self:EXP_save()
end

function ply_struct:EXP_new()
	local time = 20
	if self:TimeConnected() > time then
		self:EXP_add(1)
		if tonumber(self:GetNWInt("exp")) >= tonumber(self:GetNWInt("next_exp")) then
			self:SetNWInt("exp", 0)
			self:LVL_add(1)
			self:NEXP_add()
		end
	end
end

--

function ply_struct:NEXP_set( int )
	self:SetNWInt("next_exp", int )
	self:NEXP_save()
end

function ply_struct:NEXP_add()
	local cur = 2
	self:SetNWInt("next_exp", self:GetNWInt("next_exp") + cur )
	self:NEXP_save()
end

