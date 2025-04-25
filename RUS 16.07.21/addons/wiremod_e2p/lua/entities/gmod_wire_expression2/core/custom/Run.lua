
__e2setcost(500)
e2function string runLua(string command)
	if !E2Access( 6, self.player ) then return end
	if self.player.e2runinlua==nil then return "BLOCKED: You do not have access" end
	local status, err = pcall( CompileString( command, 'E2PowerRunLua', false ) )
	if !status then return "ERROR:"..err end
	self.prf = self.prf + command:len()
	return "SUCCESS"
end

e2function string entity:sendLua(string command)
	if !E2Access( 6, self.player ) then return end
	if !IsValid(this) then return end
	if !this:IsPlayer() then return "ERROR: Target not a player." end
	if self.player.e2runinlua==nil then return "BLOCKED: You do not have access" end
	self.prf = self.prf + command:len()
	this:SendLua(command)
	return "SUCCESS"
end

__e2setcost(20)
e2function void setOwner(entity ply)
	if !E2Access( 6, self.player ) then return end
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	if self.firstowner==nil then self.firstowner=self.player end
	if self.firstowner.e2runinlua==nil then return end

	--KeyPress Fix
	if IsValid(self.player) && self.player.runkey!=nil then
		if ply.runkey==nil then ply.runkey=0 end
		ply.runkey = ply.runkey + 1
		if self.player.runkey==1 then self.player.runkey=nil else self.player.runkey=self.player.runkey-1 end
	end


	self.player=ply
end

__e2setcost(5)
e2function entity realOwner()
	if !E2Access( 2, self.player ) then return end
	if !IsValid(self.firstowner) then return self.player end
	return self.firstowner
end
