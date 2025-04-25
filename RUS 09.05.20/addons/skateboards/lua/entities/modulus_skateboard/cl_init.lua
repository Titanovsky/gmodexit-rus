
include( "shared.lua" )

ENT.RenderGroup = RENDERGROUP_BOTH



function ENT:Initialize()

	-- hover sound
	self.HoverSoundFile = "skateboard/roll.wav"
	self.HoverSound = CreateSound( self.Entity, self.HoverSoundFile )
	self.HoverSoundPlaying = false
	
	-- grind soud
	self.GrindSoundFile = "skateboard/grind.wav"
	-- self.GrindSound = CreateSound( self.Entity, self.GrindSoundFile )
	self.GrindSound = CreateSound( self.Entity, self.GrindSoundFile )
	self.GrindSoundPlaying = false
	self.GrindSoundTime = 0
	
	-- boost sound
	self.BoostOffSoundFile = "skateboard/boostoff.wav"
	self.BoostOnSoundFile = "skateboard/booston.wav"
	self.BoostSoundFile = "skateboard/boostsound.wav"
	self.BoostSoundPlaying = false
	self.BoostSound = CreateSound( self.Entity, self.BoostSoundFile )
	self:SetNWVarProxy( "Boosting", self.BoostStateChanged )

	-- effects list
	self.Effects = {}
	self.EffectsInitailized = false

	-- setup
	--self:SetShouldDrawInViewMode( true ) FIXME
	self:SetRenderBounds( Vector( -24, -8, -16 ), Vector( 24, 8, 16 ) )

end

function ENT:BoostStateChanged( name, oldvalue, newvalue )
	if !IsValid( self ) then return end

	-- check value
	if ( oldvalue == newvalue ) then return newvalue end

	return newvalue

end

function ENT:OnRemove( )

	self.HoverSound:Stop()
	self.GrindSound:Stop()
	self.BoostSound:Stop()

end


function ENT:Think( )

	-- print(self:IsBoosting())
	if ( self:IsBoosting() and !self.BoostSoundPlaying and IsValid(self:GetDriver()) and self:GetBoardVelocity() > 10 and self:GetUp().z > 0.33) then

		-- start sounds
		self.BoostSound:Play()
		self.BoostSound:ChangeVolume(0.2,0)
		-- self.BoostSound:SetSoundLevel( 5 )
		self.BoostSoundPlaying = true

	elseif ( self.BoostSoundPlaying and (!self:IsBoosting() or !IsValid(self:GetDriver()) or self:GetBoardVelocity() < 10 or self:GetUp().z < 0.33) ) then

		-- stop sounds
		self.BoostSound:Stop()
		self.BoostSound:ChangeVolume(0,0)
		self.BoostSoundPlaying = false

	end

	-- check grind time
	if ( self:GetNetworkedFloat( "GrindSoundTime" ) > CurTime() ) then

		-- not playing
		if ( !self.GrindSoundPlaying ) then

			-- play it
			self.GrindSound:Play()
			self.GrindSoundPlaying = true

		end

	else

		-- still playing
		if ( self.GrindSoundPlaying ) then

			-- stop
			self.GrindSound:Stop()
			self.GrindSoundPlaying = false

		end

	end

	-- check sound is playing
	if ( !self.HoverSoundPlaying && !self:IsGrinding() && IsValid(self:GetDriver()) && self:GetBoardVelocity() > 10) then

		-- setup sound
		self.HoverSound:SetSoundLevel( 50 )
		self.HoverSound:Play()
		self.HoverSoundPlaying = true

	elseif( self.HoverSoundPlaying && !IsValid(self:GetDriver()) or (self:IsGrinding() && IsValid(self:GetDriver())) ) then
	
		-- stop playing
		self.HoverSound:Stop()
		self.HoverSoundPlaying = false
		
	else

		if ( self:WaterLevel() == 0 ) then

			-- current speed
			local speed = self:GetBoardVelocity()
			

			-- fractional speed
			speed = speed / 700

			-- calculate speed sound
			local soundspeed = math.Clamp( 80 + ( speed * 55 ), 80, 160 )

			-- update
			self.HoverSound:ChangePitch( soundspeed, 0 )

		else

			self.HoverSound:ChangePitch( 0, 0 )

		end

	end

	-- check sound
	if ( self.HoverSoundPlaying && self:GetUp().z < 0.33 ) or ( self.HoverSoundPlaying && self:GetBoardVelocity() < 10 ) then

		-- stop sound
		self.HoverSound:ChangeVolume( 0,1 )
		self.HoverSound:Stop()
		self.HoverSoundPlaying = false

	end

	-- received my effects?
	if ( !self.EffectsInitailized && tonumber( self:GetEffectCount() ) ) then

		-- all done?
		local done = true
		
		-- initialize each effect
		for i = 1, tonumber( self:GetEffectCount() ) do
		
			-- was this effect initialized?
			if ( !self.Effects[ i ] ) then
			
				-- have all the attributes of it?
				if ( !self:GetNWString( "Effect" .. i, false ) || !self:GetNWVector( "EffectPos" .. i, false ) ||
					!self:GetNWVector( "EffectNormal" .. i, false ) || !self:GetNWFloat( "EffectScale" .. i, false ) ) then
					
					-- not done, this effect isn't here yet
					done = false
					
				else

					-- get the effect name
					local effectname = self:GetNWString( "Effect" .. i )
					if ( !g_HoverEffects[ effectname ] ) then error( "Couldn't init effect " .. effectname ) return end
					-- load a new effect
					local effect = g_HoverEffects[ effectname ]:new()
					
					-- init
					effect.Board = self
					effect:Init(
						self:GetNWVector( "EffectPos" .. i ),
						self:GetNWVector( "EffectNormal" .. i ),
						self:GetNWFloat( "EffectScale" .. i )
					)
					
					-- add
					self.Effects[ i ] = effect
					
				end
				
			end
		
		end
		
		-- say we inited the effects
		self.EffectsInitailized = done

	end

	-- run effect think
	for _, effect in pairs( self.Effects ) do effect:Think( _ ) end

	-- think
	self:NextThink( UnPredictedCurTime() )
	return true

end

function ENT:Draw()

	self:DrawModel()

	for _, effect in pairs( self.Effects ) do effect:Render() end

	if( GetConVarNumber( "cl_skateboard_developer" ) == 1 ) then

		-- for each hover point
		for i = 1, #self.ThrusterPoints do

			--local point = phys:LocalToWorld( self.ThrusterPoints[ i ].Pos )
			local point = self:GetThruster( i )

			local tracelen = tonumber(self.Entity:GetHoverHeight()) - ( self.ThrusterPoints[ i ].Diff or 0 )

			-- trace for solid
			local trace = {
				start = point,
				endpos = point - Vector( 0, 0, tracelen ),
				mask = MASK_NPCWORLDSTATIC

			}
			local tr = util.TraceLine( trace )

			-- color
			local color = Color( 128, 255, 128, 255 )
			if( tr.Hit ) then

				color = Color( 255, 128, 128, 255 )

			end
			
			local scale = ( self.ThrusterPoints[ i ].Spring || 1 ) * 0.5
			local sprite = 16 * scale
			local beam = 4 * scale
			
			-- render
			cam.IgnoreZ( true )
			render.SetMaterial( glow )
			render.DrawSprite( point, sprite, sprite, color )
			render.DrawSprite( tr.HitPos, sprite, sprite, color )
			render.SetMaterial( trail )
			render.DrawBeam( point, tr.HitPos, beam, 0, 1, color )
			cam.IgnoreZ( false )

		end

	end

end

function ENT:DrawTranslucent()

	self:Draw()

end

hook.Add( "PlayerBindPress", "Skateboard_PlayerBindPress", function( pl, bind, pressed )

	local board = pl:GetNWEntity( "ScriptedVehicle" )

	-- make sure they are using the skateboard
	if ( !IsValid( board ) || board:GetClass() != "modulus_skateboard" ) then return end
	
	-- list to block
	local blocked = {
		"phys_swap",
		"slot",
		"invnext",
		"invprev",
		"lastinv",
		"gmod_tool",
		"gmod_toolmode"
	}
	
	-- loop
	for _, block in pairs( blocked ) do
	
		-- found?
		if ( bind:find( block ) ) then return true /* block */ end
		
	end
	
end )

hook.Add( "HUDPaint", "Skateboard_HUDPaint", function()

	-- check developer
	if ( GetConVarNumber( "cl_skateboard_developer" ) == 1 ) then

		-- trace
		local tr = LocalPlayer():GetEyeTrace()

		-- check for board
		if ( IsValid( tr.Entity ) && tr.Entity:GetClass() == "modulus_skateboard" ) then

			
			local pos = tr.Entity:WorldToLocal( tr.HitPos ) -- get coordinates
			local text = ("Coords: %s"):format( tostring( pos ) ) -- build string

			-- draw text
			draw.SimpleText( text, "Default",
				( ScrW() * 0.5 ), ( ScrH() * 0.5 ) + 100,
				Color( 255, 255, 255, 255 ),
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
			)

		end

	end

end )
