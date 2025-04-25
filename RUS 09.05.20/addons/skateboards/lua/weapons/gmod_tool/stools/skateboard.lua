
// basic
TOOL.Category = "Le Visards"
TOOL.Name = "Skateboard"

-- TO ADD NEW HOVERBOARDS, CHECK OUT THE AUTORUN FILE

AddCSLuaFile( "vgui/skateboard_gui.lua" )

cleanup.Register( "Skateboards" )

for _, hbt in pairs( SkateboardTypes ) do

	list.Set( "SkateboardModels", hbt[ 'model' ], {} )
	util.PrecacheModel( hbt[ 'model' ] )

	if ( SERVER && GetConVarNumber( "rb655_force_downloads" ) > 0 ) then

		resource.AddFile( hbt[ 'model' ] )

		if ( hbt[ 'files' ] ) then

			for __, f in pairs( hbt[ 'files' ] ) do

				resource.AddFile( f ) // send other files

			end

		end
		
	end

end

TOOL.ClientConVar[ 'model' ] = "models/skateboard/skateboard.mdl"
TOOL.ClientConVar[ 'lights' ] = 0
TOOL.ClientConVar[ 'mousecontrol' ] = 0
TOOL.ClientConVar[ 'boostshake' ] = 1
TOOL.ClientConVar[ 'height' ] = 1
TOOL.ClientConVar[ 'viewdist' ] = 128
TOOL.ClientConVar[ 'trail_size' ] = 0
TOOL.ClientConVar[ 'trail_r' ] = 0
TOOL.ClientConVar[ 'trail_g' ] = 0
TOOL.ClientConVar[ 'trail_b' ] = 0
TOOL.ClientConVar[ 'boost_r' ] = 0
TOOL.ClientConVar[ 'boost_g' ] = 0
TOOL.ClientConVar[ 'boost_b' ] = 0
TOOL.ClientConVar[ 'recharge_r' ] = 0
TOOL.ClientConVar[ 'recharge_g' ] = 0
TOOL.ClientConVar[ 'recharge_b' ] = 0
TOOL.ClientConVar[ 'speed' ] = 5
TOOL.ClientConVar[ 'jump' ] = 0
TOOL.ClientConVar[ 'turn' ] = 16
TOOL.ClientConVar[ 'flip' ] = 16
TOOL.ClientConVar[ 'twist' ] = 16

function TOOL:LeftClick( trace )

	local result, skateboard = self:CreateBoard( trace )
	return result

end

function TOOL:RightClick( trace )

	local result, skateboard = self:CreateBoard( trace )

	if ( CLIENT ) then return result end // client result

	if ( IsValid( skateboard ) ) then // validate board

		local pl = self:GetOwner() // owner
		local dist = ( skateboard:GetPos() - pl:GetPos() ):Length() // check distance

		if ( dist <= 192 ) then // make sure its relatively close?

			timer.Simple( 0.25, function() // had to delay it to avoid errors

				if ( IsValid( skateboard ) && IsValid( pl ) ) then skateboard:SetDriver( pl ) end

			end )

		end

	end

	return result

end

function TOOL:CreateBoard( trace )
	if ( CLIENT ) then return true end

	local pl = self:GetOwner()
	if ( GetConVarNumber( "sv_skateboard_adminonly" ) > 0 && !( pl:IsAdmin() || pl:IsSuperAdmin() ) ) then return false end

	local model = self:GetClientInfo( "model" )
	local mcontrol = self:GetClientNumber( "mousecontrol" )
	local shake = self:GetClientNumber( "boostshake" )
	local trailsize = math.Clamp( self:GetClientNumber( "trail_size" ), 0, 10 )
	local height = math.Clamp( self:GetClientNumber( "height" ), 1, 100 )
	local viewdist = math.Clamp( self:GetClientNumber( "viewdist" ), 64, 256 )
	local trail = Vector( self:GetClientNumber( "trail_r" ), self:GetClientNumber( "trail_g" ), self:GetClientNumber( "trail_b" ) )
	local boost = Vector( self:GetClientNumber( "boost_r" ), self:GetClientNumber( "boost_g" ), self:GetClientNumber( "boost_b" ) )
	local recharge = Vector( self:GetClientNumber( "recharge_r" ), self:GetClientNumber( "recharge_g" ), self:GetClientNumber( "recharge_b" ) )

	local attributes = {
		speed = math.Clamp( self:GetClientNumber( "speed" ), 0, 15 ),
		jump = math.Clamp( self:GetClientNumber( "jump" ), 0, 15 ),
		turn = math.Clamp( self:GetClientNumber( "turn" ), 0, 15 ),
		flip = math.Clamp( self:GetClientNumber( "flip" ), 0, 15 ),
		twist = math.Clamp( self:GetClientNumber( "twist" ), 0, 15 )
	}

	local ang = pl:GetAngles()
	ang.p = 0
	ang.y = ang.y + 180

	local pos = trace.HitPos + trace.HitNormal * 32

	local skateboard = MakeSkateboard( pl, model, ang, pos, mcontrol, shake, height, viewdist, trailsize, trail, boost, recharge, attributes )
	if ( !IsValid( skateboard ) ) then return false end

	undo.Create( "Skateboard" )
		undo.AddEntity( skateboard )
		undo.SetPlayer( pl )
	undo.Finish()

	return true, skateboard

end

function TOOL:Reload( trace )
end

function TOOL:Think( )
end

if ( SERVER ) then

	function MakeSkateboard( pl, model, ang, pos, mcontrol, shake, height, viewdist, trailsize, trail, boost, recharge, attributes )

		if ( IsValid( pl ) && !pl:CheckLimit( "skateboards" ) ) then return false end

		local skateboard = ents.Create( "modulus_skateboard" )

		if ( !IsValid( skateboard ) ) then return false end

		local boardinfo

		for _, board in pairs( SkateboardTypes ) do

			if ( board[ 'model' ]:lower() == model:lower() ) then

				boardinfo = board
				break

			end

		end

		if ( !boardinfo ) then return false end

		util.PrecacheModel( model )

		skateboard:SetModel( model )
		skateboard:SetAngles( ang )
		skateboard:SetPos( pos )

		skateboard:SetBoardRotation( 0 )

		if ( boardinfo[ "rotation" ] ) then

			local rot = tonumber( boardinfo[ "rotation" ] )

			skateboard:SetBoardRotation( tonumber( boardinfo[ "rotation" ] ) )

			ang.y = ang.y - rot
			skateboard:SetAngles( ang )

		end

		skateboard:Spawn()
		skateboard:Activate()

		skateboard:SetAvatarPosition( Vector( 0, 0, 0 ) )

		if ( boardinfo[ 'driver' ] ) then

			skateboard:SetAvatarPosition( boardinfo[ 'driver' ] )

		end

		for k, v in pairs( boardinfo ) do

			if ( k:sub( 1, 7 ):lower() == "effect_" && type( boardinfo[ k ] == "table" ) ) then

				local effect = boardinfo[ k ]

				local normal
				if ( effect[ 'normal' ] ) then normal = effect[ 'normal' ] end

				skateboard:AddEffect( effect[ 'effect' ] or "trail", effect[ 'position' ], normal, effect[ 'scale' ] or 1 )
			
			end
		
		end

		skateboard:SetControls( math.Clamp( tonumber( mcontrol ), 0, 1 ) ) // controls
		skateboard:SetBoostShake( math.Clamp( tonumber( shake ), 0, 1 ) ) // boost shake
		skateboard:SetHoverHeight( math.Clamp( tonumber( height ), 1, 100 ) ) // hover height
		skateboard:SetViewDistance( math.Clamp( tonumber( viewdist ), 64, 256 ) ) // view distance
		skateboard:SetSpring( 0.07 * ( ( 0.8 / height ) * ( 1.6 / height ) ) ) // spring


		//local count = 0
		//local points = GetConVarNumber( "sv_skateboard_points" )

		for k, v in pairs( attributes ) do

			//local remaining = points - count

			//v = math.Clamp( v, 0, math.min( 16, remaining ) )

			v = math.Clamp( v, 0, 16 )

			//attributes[ k ] = v

			//count = count + v
		
		end

		/*for k, v in pairs( boardinfo[ 'bonus' ] or {} ) do

			if ( attributes[ k ] ) then

				attributes[ k ] = attributes[ k ] + tonumber( v )

			end

		end*/

		local speed = ( attributes[ 'speed' ] * 0.1 ) * 20
		skateboard:SetSpeed( speed )
		local jump = ( attributes[ 'jump' ] * 0.1 ) * 250 -- It seems to me that this should be 2500
		skateboard:SetJumpPower( jump )
		local turn = ( attributes[ 'turn' ] * 0.1 ) * 25
		skateboard:SetTurnSpeed( turn )
		local flip = ( attributes[ 'flip' ] * 0.1 ) * 25
		skateboard:SetPitchSpeed( flip )
		local twist = ( attributes[ 'twist' ] * 0.1 ) * 25
		skateboard:SetYawSpeed( twist )
		local roll = ( ( flip + twist ) / 50 ) * 22
		skateboard:SetRollSpeed( roll )

		DoPropSpawnedEffect( skateboard )
		
		if ( IsValid( pl ) ) then
			pl:AddCount( "skateboards", skateboard )
			pl:AddCleanup( "skateboards", skateboard )
			skateboard.Creator = pl:UniqueID()
		end

		return skateboard

	end

	return
end

language.Add( "tool.Skateboard.name", "Skateboard" )
language.Add( "tool.Skateboard.desc", "Spawn skateboards" )
language.Add( "tool.Skateboard.0", "Left click to spawn a skateboard. Right click to spawn a skateboard & mount onto it." )

language.Add( "Undone_Skateboard", "Undone Skateboard" )
language.Add( "SBoxLimit_Skateboard", "You've reached the Skateboard limit!" )

local hbpanel = vgui.RegisterFile( "vgui/skateboard_gui.lua" )

function TOOL.BuildCPanel( cp )

	//cp:AddControl( "PropSelect", { Label = "Skateboard Model", Height = 3, ConVar = "skateboard_model", Models = list.Get( "SkateboardModels" ) } )

	local panel = vgui.CreateFromTable( hbpanel )
	panel:PopulateBoards( SkateboardTypes )
	panel:PerformLayout( )
	cp:AddPanel( panel )

	cp:AddControl( "Slider", { Label = "View Distance", Min = 64, Max = 256, Command = "skateboard_viewdist" } )
	cp:AddControl( "Checkbox", { Label = "Mouse Control", Command = "skateboard_mousecontrol" } )
	cp:AddControl( "Checkbox", { Label = "Boost Shake", Command = "skateboard_boostshake" } )
	
	

	cp:AddControl( "Checkbox", { Label = "ADMIN: Can Fall From Skateboard?", Command = "sv_skateboard_canfall" } )
	cp:AddControl( "Checkbox", { Label = "ADMIN: Can Share?", Command = "sv_skateboard_canshare" } )
	cp:AddControl( "Checkbox", { Label = "ADMIN: Can Steal?", Command = "sv_skateboard_cansteal" } )
	cp:AddControl( "Checkbox", { Label = "ADMIN: Admin Only?", Command = "sv_skateboard_adminonly" } )
	cp:AddControl( "Slider", { Label = "ADMIN: Max Skateboards Per Player", Min = 1, Max = 10, Command = "sbox_maxskateboards" } )
	//cp:AddControl( "Slider", { Label = "ADMIN: Max Points", Min = 5, Max = 80, Command = "sv_skateboard_points" } )

end
