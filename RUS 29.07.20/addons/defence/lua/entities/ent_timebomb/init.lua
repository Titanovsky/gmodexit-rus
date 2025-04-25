AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
util.AddNetworkString("timebomb_set")
function ENT:Initialize()
    self.Entity:SetModel( 'models/weapons/w_c4_planted.mdl' )
    self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
    self.Entity:SetSolid(SOLID_VPHYSICS)
    self.Entity:SetUseType(SIMPLE_USE)
    self:SetTimeToExplode(10)
    local phys = self.Entity:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end
end
local function StartFuse(aaa,ply)
	if(not aaa:GetStarted())then
		aaa:EmitSound("buttons/blip1.wav",100,200)
		aaa:SetStarted(1)
		aaa:SetStartTime(CurTime())
		timer.Simple(aaa:GetTimeToExplode(),function()
			if aaa:IsValid()then
				local SelfPos = aaa:LocalToWorld( aaa:OBBCenter( ))
				for _,v in pairs( ents.FindInSphere( SelfPos, 125 ) ) do
					if v:GetClass() == "prop_physics" then
						v:Remove()
					end
				end
				local pos=aaa:GetPos()
				util.BlastDamage(aaa,ply,pos,400,400)
				local data=EffectData()
				data:SetOrigin(pos)
				util.Effect("Explosion",data,true,true)
				aaa:Remove()
			end
		end)
	end
end
function ENT:OnTakeDamage( dmginfo )

    self.Entity:TakePhysicsDamage( dmginfo )

end
function TimeBomb_SetTime(ply,cmd,args)
	local explodetime=args[2]
	if not args[1] then return end
	local bomb=Entity(args[1])
	if(bomb==nil)then return end
	if(!bomb:GetStarted())then
		local TimeToExplode=tonumber(explodetime)
		if(ply:GetPos():Distance(bomb:GetPos())>256)then return end
		if(TimeToExplode==nil)then
			ply:PrintMessage(HUD_PRINTTALK,"Number contains invalid characters!")
			return
		end
		if(TimeToExplode>120 or TimeToExplode<10)then
			ply:PrintMessage(HUD_PRINTTALK,"Time cannot be less than 00:10 or greater than 10:00!")
			return
		end
		bomb:SetTimeToExplode(TimeToExplode)
		StartFuse( bomb, ply )
	end
end
function ENT:Use(activator,caller)
	if(activator:IsPlayer() and (activator:KeyDown(IN_WALK) or activator:KeyDown(IN_RELOAD) and not self:GetStarted()))then
		net.Start("timebomb_set")
		net.WriteEntity(self)
		net.WriteString(self:GetTimeToExplode())
		net.Send(activator)
	else
		StartFuse(self,activator)
	end
end
concommand.Add("timebomb_settime",TimeBomb_SetTime)
function ENT:SpawnFunction(ply,tr)
	if(not util.IsValidModel("models/weapons/w_c4_planted.mdl"))then
		ply:PrintMessage(HUD_NOTIFY,"У вас отсутствует CSS контент. Моделька бомбы не будет видна!")
		return
	end
	if not tr.Hit then return end
	local pos=tr.HitPos+tr.HitNormal*16
	local ent=ents.Create(ClassName)
	ent:SetPos(pos)
	ent:Spawn()
	ent:Activate()
	if not ply.hasspawnedtimebomb then
		ply.hasspawnedtimebomb=true
		ply:PrintMessage(HUD_PRINTTALK,"Нажмите ALT + E или RELOAD + E чтобы изменить время.")
		ply:PrintMessage(HUD_PRINTTALK,"Нажмите [E] чтобы активировать.")
	end
	return ent
end
