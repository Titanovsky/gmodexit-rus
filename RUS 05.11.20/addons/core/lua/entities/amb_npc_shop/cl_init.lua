include("shared.lua")

local COLOR_TEXT  			= Color( 48, 197, 242 )
local COLOR_TEXT_OUTLINE	= Color( 255, 255, 0 )
local MAIN_FONT        		= "ambFont32"
local MAIN_TEXT_NPC			= "NPC IKEA"
local MAX_DIST				= 400

local function AmbVGUI_drawPanelNPC( ent, dist )

	dist = dist or EyePos():DistToSqr( ent:GetPos() )

	if ( dist > MAX_DIST ) then
		surface.SetAlphaMultiplier( math.Clamp( 3 - ( dist / 20000 ), 0, 1 ) )
		local _,max = ent:GetRotatedAABB( ent:OBBMins(), ent:OBBMaxs() )
		local rot = ( ent:GetPos() - EyePos() ):Angle().yaw - 90 --  чтобы крутилась.
		local center = ent:LocalToWorld( ent:OBBCenter() )

		cam.Start3D2D(center + Vector( 0, 0, math.abs( max.z / 2 ) + 12 ), Angle( 0, rot, 90 ), 0.13 )
		surface.SetFont('amb_fonts32')
			local x, y = surface.GetTextSize( MAIN_TEXT_NPC )
			draw.SimpleTextOutlined( MAIN_TEXT_NPC, MAIN_FONT, -x/2, 15, COLOR_TEXT_OUTLINE, 0, 0, 1, COLOR_TEXT )
		cam.End3D2D()

		surface.SetAlphaMultiplier( 1 )
	end
end

function ENT:Draw()
	local dist = EyePos():DistToSqr( self:GetPos() )

	self:DrawModel()
	self:DrawShadow( false )
	AmbVGUI_drawPanelNPC( self, dist )
end