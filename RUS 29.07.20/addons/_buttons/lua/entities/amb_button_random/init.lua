AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/maxofs2d/button_02.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:PhysicsInit( SOLID_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetNWBool( "IsReloaded", true )

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:EnableMotion( false )
	end
end

function ENT:makeRandom( ePly, nType )
	if ( nType >= 1 ) and (nType < 5 ) then
		ePly:Say("я хочу, чтобы отодрали мою попу!")
	elseif ( nType >= 5 ) and (nType < 10 ) then
		ePly:Say("/me съел сосиску")
	elseif ( nType >= 10 ) and (nType < 15 ) then
		ePly:Say("./pm titanovsky я в лс напишу, короче.. я люблю парней")
	elseif ( nType >= 15 ) and (nType < 20 ) then
		ePly:Say("/me перданул так, что аж окна запотели")
	elseif ( nType >= 20 ) and (nType < 25 ) then
		ePly:Say("хочу секса =/")
	elseif ( nType >= 25 ) and (nType < 30 ) then
		ePly:StripWeapons()
	elseif ( nType >= 30 ) and (nType < 35 ) then
		ePly:RUB_add( math.random( 1, 1000 ) )
	elseif ( nType >= 35 ) and (nType < 40 ) then
		ePly:RUB_add( math.random( 1, 4000 ) )
	elseif ( nType >= 40 ) and (nType < 45 ) then
		ePly:Kill()
	elseif ( nType >= 45 ) and (nType < 50 ) then
		ePly:AddFrags( 1024 )
	elseif ( nType >= 50 ) and (nType < 55 ) then
		ePly:AddDeaths( 1024 )
	elseif ( nType >= 55 ) and (nType < 60 ) then
		ePly:Say("мне нравится дрочить на взрослых мам лол")
	elseif ( nType >= 60 ) and (nType < 65 ) then
		ePly:Kick( "Кнопка рандомка так решила =/" )
	elseif ( nType >= 65 ) and (nType < 70 ) then
		ePly:SetArmor( 200 )
		ePly:SetHealth( 200 )
		ePly:ChatPrint("Вы стали Мостадонтом!")
	elseif ( nType >= 70 ) and (nType < 75 ) then
		ePly:SetArmor( 400 )
		ePly:SetHealth( 600 )
		ePly:ChatPrint("Вы стали Кириллицей!")
	elseif ( nType >= 75 ) and (nType < 80 ) then
		ePly:SetArmor( 1000 )
		ePly:SetHealth( 2000 )
		ePly:Give("weapon_rpg")
		ePly:GiveAmmo( 24, 8, true )
		ePly:SetColor( Color(255, 0, 0) )
		ePly:ChatPrint("Вы стали Богом!")
	elseif ( nType >= 80 ) and (nType < 85 ) then
		ePly:SetPos( math.random(1, 900), math.random(1, 900), math.random(-200, 200) )
		ePly:ChatPrint("Вы пропали..")
	elseif ( nType >= 85 ) and (nType < 90 ) then
		ePly:Give("weapon_frag")
		ePly:Give("weapon_frag")
		ePly:Give("weapon_frag")
		ePly:Give("weapon_frag")
	elseif ( nType >= 90 ) and (nType < 100 ) then
		ePly:ChatPrint("ВЫ НЕ ДОСТОЙНЫ КНОПКИ РАНДОМКУСА!")
	end
end

function ENT:Use( ePly )
	if ( ePly:IsPlayer() ) then
		if ( self:GetNWBool("IsReloaded") ) then
			local num = math.random( 1, 100 )
			self:makeRandom( ePly, num )
			self:SetNWBool("IsReloaded", false)
			timer.Simple( 728, function() self:SetNWBool("IsReloaded", true) end )
		else
			ePly:SendLua("notification.AddLegacy( 'Кнопка горячая..', NOTIFY_ERROR, 3 )")
		end
	end
end
