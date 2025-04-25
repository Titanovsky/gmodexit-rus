__e2setcost(50)
e2function table findMetaTable( string sMetaTable )
	if not self.player:CheckAccess( 3, 'findMetaTable' ) then return end

	return FindMetaTable( sMetaTable )
end

e2function table color( nR, nG, nB, nA )
	nR = nR or 255
	nG = nG or 255
	nB = nB or 255
	nA = nA or 255

	return { r = nR, g = nG, b = nB, a = nA }
end

e2function void entity:kill()
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 3, 'kill' ) then return end

	this:Kill()
end

e2function void entity:chatSend( ... )
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 2, 'chatSend' ) then return end

	local args = { ... }
	this:ChatSend( unpack( args ) )
end

e2function number entity:getXP()
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 1, 'getXP' ) then return end

	return this:GetXP()
end

e2function void entity:setXP( number nXP )
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 3, 'setXP' ) then return end

	this:SetXP( nXP )
end

e2function void entity:addXP( number nXP )
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 3, 'addXP' ) then return end

	this:AddXP( nXP )
end

e2function number entity:getMoney()
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 1, 'getMoney' ) then return end

	return this:GetMoney()
end

e2function void entity:setMoney( number nMoney )
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 3, 'setMoney' ) then return end

	this:SetMoney( nMoney )
end

e2function void entity:addMoney( number nMoney )
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 3, 'addMoney' ) then return end

	this:AddMoney( nMoney )
end

-- ------------------------------------------------------------------------------ -

__e2setcost(200)
e2function void entity:setWeaponColor(vector rgb) -- Zimon4eR
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 2, 'setWeaponColor' ) then return end

	local Vec = Vector(0,0,0)
	Vec[1] = isNan(rgb[1]) and 0 or math.Clamp(rgb[1], 0, 255)/255
	Vec[2] = isNan(rgb[2]) and 0 or math.Clamp(rgb[2], 0, 255)/255
	Vec[3] = isNan(rgb[3]) and 0 or math.Clamp(rgb[3], 0, 255)/255
	this:SetWeaponColor(Vec)
end

e2function void entity:setPlayerColor(vector rgb) -- Zimon4eR
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 2, 'setPlayerColor' ) then return end

	local Vec = Vector(0,0,0)
	Vec[1] = isNan(rgb[1]) and 0 or math.Clamp(rgb[1], 0, 255)/255
	Vec[2] = isNan(rgb[2]) and 0 or math.Clamp(rgb[2], 0, 255)/255
	Vec[3] = isNan(rgb[3]) and 0 or math.Clamp(rgb[3], 0, 255)/255
	this:SetPlayerColor(Vec)
end

e2function vector entity:getWeaponColor() -- Zimon4eR
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end

	local Vec = this:GetWeaponColor()*255
	return {math.floor(Vec[1]),math.floor(Vec[2]),math.floor(Vec[3])}
end

e2function vector entity:getPlayerColor() -- Zimon4eR
	if !IsValid(this)  then return end
	if !this:IsPlayer() then return end

	local Vec = this:GetPlayerColor()*255
	return {math.floor(Vec[1]),math.floor(Vec[2]),math.floor(Vec[3])}
end
__e2setcost(20)
e2function void entity:playerFreeze()
	if !IsValid(this)  then return end
	if not self.player:CheckAccess( 2, 'playerFreeze' ) then return end
	if !this:IsPlayer() then return end

  this:Lock()
end

e2function void entity:playerUnFreeze()
	if !IsValid(this)  then return end
	if not self.player:CheckAccess( 2, 'playerUnFreeze' ) then return end
	if !this:IsPlayer() then return end

  this:UnLock()
end

e2function number entity:hasGodMode()
	if !IsValid(this) then return 0 end
	if !this:IsPlayer() then return 0 end

	return this:HasGodMode() and 1 or 0
end

e2function void entity:playerRemove()
	if not self.player:CheckAccess( 2, 'playerRemove' ) then return end
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end

  this:Remove()
end

e2function void entity:playerSetAlpha(rv2)
	if !IsValid(this) then return end
	if not self.player:CheckAccess( 2, 'playerSetAlpha' ) then return end
	if !this:IsPlayer() then return end

	local r,g,b = this:GetColor()
	this:SetColor(r, g, b, math.Clamp(rv2, 0, 255))
end

e2function void entity:playerNoclip(status)
	if !IsValid(this) then return end
	if not self.player:CheckAccess( 2, 'playerNoclip' ) then return end
	if !this:IsPlayer() then return end

	if tobool(status) then // Some reason just "status" does not work so i just will convert it to bool..
		this:SetMoveType( MOVETYPE_NOCLIP )
	else
		this:SetMoveType( MOVETYPE_WALK )
	end
end

e2function void entity:playerNoclipToggle() -- Zimon4eR
	if !IsValid(this) then return end
	if not self.player:CheckAccess( 2, 'playerNoclipToggle' ) then return end
	if !this:IsPlayer() then return end

	if this:GetMoveType() ~= MOVETYPE_NOCLIP then
		this:SetMoveType( MOVETYPE_NOCLIP )
	else
		this:SetMoveType( MOVETYPE_WALK )
	end
end

e2function number entity:playerIsRagdoll()
	if !IsValid(this) then return 0 end
	if !this:IsPlayer() then return 0 end

	return IsValid(this.ragdoll) and 1 or 0
end

__e2setcost(100)
e2function void entity:playerModel(string model)
	if !IsValid(this) then return end
	if not self.player:CheckAccess( 2, 'playerModel' ) then return end
	if !this:IsPlayer() then return end

	local modelname = player_manager.TranslatePlayerModel( model )
	util.PrecacheModel( modelname )
	this:SetModel( modelname )
end

e2function vector entity:playerBonePos(Index)
	if !IsValid(this) then return {0,0,0} end
	if !this:IsPlayer() then return {0,0,0} end
	if not self.player:CheckAccess( 2, 'playerBonePos' ) then return end

	local bonepos, boneang = this:GetBonePosition(this:TranslatePhysBoneToBone(Index))
	if bonepos == nil then return {0,0,0}
	else return bonepos end
end

e2function angle entity:playerBoneAng(Index)
	if !IsValid(this) then return {0,0,0} end
	if !this:IsPlayer() then return {0,0,0} end
	if not self.player:CheckAccess( 2, 'playerBoneAng' ) then return end

	local bonepos, boneang = this:GetBonePosition(this:TranslatePhysBoneToBone(Index))
	if boneang == nil then return {0,0,0}
	else return {boneang.Yaw,boneang.Pitch,boneang.Roll} end
end

e2function vector entity:playerBonePos(string boneName)
	if !IsValid(this) then return {0,0,0} end
	if !this:IsPlayer() then return {0,0,0} end
	if not self.player:CheckAccess( 2, 'playerBonePos' ) then return end

	local bonepos, boneang = this:GetBonePosition(this:LookupBone(boneName))
	if bonepos == nil then return {0,0,0}
	else return bonepos end
end

e2function angle entity:playerBoneAng(string boneName)
	if !IsValid(this) then return {0,0,0} end
	if !this:IsPlayer() then return {0,0,0} end
	if not self.player:CheckAccess( 2, 'playerBoneAng' ) then return end

	local bonepos, boneang = this:GetBonePosition(this:LookupBone(boneName))
	if boneang == nil then return {0,0,0}
	else return {boneang.Yaw,boneang.Pitch,boneang.Roll} end
end

e2function number entity:lookUpBone(string boneName)
	if !IsValid(this) then return -1 end
	return this:LookupBone(boneName) or -1
end

e2function void entity:playerSetBoneAng(Index,angle ang)
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 2, 'playerSetBoneAng' ) then return end

	if isNan(ang[1]) or isNan(ang[2]) or isNan(ang[3]) then return end
	this:ManipulateBoneAngles( Index, Angle(ang[1], ang[2], ang[3]) )
end

e2function void entity:playerSetBoneAng(string boneName, angle ang)
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	if not self.player:CheckAccess( 2, 'playerSetBoneAng' ) then return end

	this:ManipulateBoneAngles( this:LookupBone(boneName), Angle(ang[1],ang[2],ang[3]) )
end

e2function void playerSetBoneAng(Index,angle ang)
	if not self.player:CheckAccess( 2, 'playerSetBoneAng' ) then return end

	self.player:ManipulateBoneAngles( Index, Angle(ang[1], ang[2], ang[3]) )
end

e2function void playerSetBoneAng(string boneName ,angle ang)
	if not self.player:CheckAccess( 2, 'playerSetBoneAng' ) then return end

	self.player:ManipulateBoneAngles( self.player:LookupBone(boneName), Angle(ang[1], ang[2], ang[3]) )
end

__e2setcost(15000)
e2function entity entity:playerRagdoll()
	if !IsValid(this) then return end
	if !this:IsPlayer() then return end
	if !this:Alive() then return end
	if not self.player:CheckAccess( 2, 'playerRagdoll' ) then return end
	if this:InVehicle() then this:ExitVehicle()	end
	local v = this

	if !IsValid(v.ragdoll) then

		local ragdoll = ents.Create( "prop_ragdoll" )
		ragdoll.ragdolledPly = v
		ragdoll:SetPos( v:GetPos() )
		local velocity = v:GetVelocity()
		ragdoll:SetAngles( v:GetAngles() )
		ragdoll:SetModel( v:GetModel() )
		ragdoll:Spawn()
		ragdoll:Activate()
		v:SetParent( ragdoll )

		local j = 1
		while true do
			local phys_obj = ragdoll:GetPhysicsObjectNum( j )
			if phys_obj then
				phys_obj:SetVelocity( velocity )
				j = j + 1
			else
				break
			end
		end

		v:Spectate( OBS_MODE_CHASE )
		v:SpectateEntity( ragdoll )
		v:StripWeapons()

		v.ragdoll = ragdoll

		return ragdoll
	else
		v:SetParent()
		v:UnSpectate()

		local ragdoll = v.ragdoll
		v.ragdoll = nil
		if ragdoll:IsValid() then

			local pos = ragdoll:GetPos()
			pos.z = pos.z + 10

			v:Spawn()
			v:SetPos( pos )
			v:SetVelocity( ragdoll:GetVelocity() )
			local yaw = ragdoll:GetAngles().yaw
			v:SetAngles( Angle( 0, yaw, 0 ) )
			ragdoll:Remove()
		end

		return self.player
	end
end

__e2setcost(20)

e2function void entity:plyRunSpeed(number speed)
	if !IsValid(this)  then return end
	if not self.player:CheckAccess( 2, 'plyRunSpeed' ) then return end
	if !this:IsPlayer() then return end

	speed=math.Clamp(speed, 0, 90000)
	if speed > 0 then
		this:SetRunSpeed(speed)
	else
		this:SetRunSpeed(500)
	end
end

e2function void entity:plyWalkSpeed(number speed)
	if !IsValid(this)  then return end
	if not self.player:CheckAccess( 2, 'plyWalkSpeed' ) then return end
	if !this:IsPlayer() then return end

	speed=math.Clamp(speed, 0, 90000)
	if speed > 0 then
		this:SetWalkSpeed(speed)
	else
		this:SetWalkSpeed(250)
	end
end

e2function void entity:plyJumpPower(number power)
	if !IsValid(this)  then return end
	if not self.player:CheckAccess( 2, 'plyJumpPower' ) then return end
	if !this:IsPlayer() then return end

	power=math.Clamp(power, 0, 90000)
	if power > 0 then
		this:SetJumpPower(power)
	else
		this:SetJumpPower(160)
	end
end

e2function void entity:plyCrouchWalkSpeed(number speed)
	if !IsValid(this)  then return end
	if not self.player:CheckAccess( 2, 'plyCrouchWalkSpeed' ) then return end
	if !this:IsPlayer() then return end
	speed=math.Clamp(speed, 0.01, 10)
	this:SetCrouchedWalkSpeed(speed)
end

e2function number entity:plyGetRunSpeed() -- Zimon4eR
	if not IsValid(this) then return end
	if !this:IsPlayer() then return end

	return this:GetRunSpeed()
end

e2function number entity:plyGetWalkSpeed() -- Zimon4eR
	if not IsValid(this) then return end
	if !this:IsPlayer() then return end

	return this:GetWalkSpeed()
end

e2function number entity:plyGetMaxSpeed()
	if not IsValid(this) then return end
	if !this:IsPlayer() then return end

	return this:GetMaxSpeed()
end

e2function number entity:plyGetJumpPower()
	if not IsValid(this) then return end
	if !this:IsPlayer() then return end

	return this:GetJumpPower()
end
