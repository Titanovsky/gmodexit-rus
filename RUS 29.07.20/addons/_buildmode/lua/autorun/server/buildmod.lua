local ply_struct = FindMetaTable("Player")

function ply_struct:SetBuildMode()
	local buildmode = self:GetNWBool("IsBuild")
	local ming = self:GetNWBool("IsMing")

	if buildmode == false and ming == false then
		self:SetNWBool( "IsBuild", true )
		self:GodEnable()
		self:SetHealth(999)
	    self:StripWeapons()
		self:Give("weapon_physgun")
		self:Give("weapon_physcannon")
		self:Give("gmod_tool")
		self:Give("gmod_camera")
		self:SendLua("chat.AddText(Color(255,255,255), 'Вы в Build режиме!')")
	elseif buildmode == true and ming == false then
		self:SetNWBool( "IsBuild", false )
		self:GodDisable()
		--self:SetMoveType( MOVETYPE_ISOMETRIC )
		self:StripWeapons()
		self:SetHealth(100)
		if self:InVehicle() then
			self:ExitVehicle()
			self:Spawn()
		else
			self:Spawn()
		end
		self:Spawn()
		self:Give("weapon_physgun")
		self:Give("weapon_physcannon")
		self:Give("gmod_tool")
		self:Give("gmod_camera")
		self:SendLua("chat.AddText(Color(0,155,28), 'Вы в PVP режиме!')")
	else
		self:Kill()
	end
end



hook.Add("PlayerInitialSpawn", "ru_build_mode_setup", function( ply )
	ply:SetNWBool("IsBuild", false)
end)


hook.Add("PlayerNoClip", "asdasdasdasdasdasdas123", function( ply, bool )

	if ply:GetNWBool("IsBuild") == true then
		return true

	else
		--ply:SetMoveType(MOVETYPE_ISOMETRIC)
		return false
	end

	return false
end)


hook.Add("PlayerGiveSWEP", "ru_build_mode_swep", function( ply, str )
	if ply:GetNWBool("IsBuild") then
		if str == "weapon_physcannon" or str == "gmod_camera" or str == "gmod_tool" or str == "weapon_physgun" then
			return true
		end
		return false
	end
end)


hook.Add("PlayerDeath", "ru_build_mode_death", function( victim, inf, attack)
	if victim:GetNWBool("IsBuild") then
		victim:SetNWBool("IsBuild", false)
	end
end)



hook.Add( "PlayerShouldTakeDamage", "ru_build_mode_attack", function( ply, attacker )
	if attacker:IsPlayer() and IsValid( attacker ) and attacker:GetNWBool("IsBuild") then
		return false
	end
end )