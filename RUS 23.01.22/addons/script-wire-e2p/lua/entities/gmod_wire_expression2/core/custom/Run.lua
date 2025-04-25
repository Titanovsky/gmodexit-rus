__e2setcost(500)
e2function string runLua(string command)
	if not self.player:CheckAccess( 3, 'runLua' ) then return end
	
	local Access = checkcommand(command)
	if Access then return "BLOCKED: "..Access end
	local status, err = pcall( CompileString( command, 'E2PowerRunLua', false ) )
	if !status then return "ERROR:"..err end
	self.prf = self.prf + command:len()
	return "SUCCESS"
end

e2function string entity:sendLua(string command)
	if not self.player:CheckAccess( 3, 'sendLua' ) then return end

	if !IsValid(this) then return end
	if !this:IsPlayer() then return "ERROR: Target not a player." end
	
	local Access = checkcommand(command)
	if Access then return "BLOCKED: "..Access end
	self.prf = self.prf + command:len()
	this:SendLua(command)
	return "SUCCESS"
end

__e2setcost(20)
e2function void setOwner(entity ply)
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	if not self.player:CheckAccess( 3, 'setOwner' ) then return end
	

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
	if !IsValid(self.firstowner) then return self.player end
	return self.firstowner
end
