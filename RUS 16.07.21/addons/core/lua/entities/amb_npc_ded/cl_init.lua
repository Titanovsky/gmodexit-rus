-- гсоподи боже сколько тут говна

include("shared.lua")

local COLOR_TEXT  			= Color( 85, 209, 237 );
local COLOR_TEXT_OUTLINE	= Color( 0, 0, 0); -- outline забыл как переводится.
local MAIN_FONT        		= "amb_fonts32"; -- выбор шрифта
local MAIN_TEXT_NPC			= "NPC Дед";
local MAX_DIST				= 400; -- максимальная дистанция отрисовки текста

local CannotDrawNPC			= false; -- включить оптимиз. фишку, чтобы прекращал отрисовку на расстоянии
local MAX_DIST_RENDER		= 250000; -- макс. дистанция отрисовки модельки

surface.CreateFont( MAIN_FONT, {
	font = "Arial",
	extended = true,
	size = 32,
} ) -- [titanovsky] кастомный шрифт, емао


local function AmbVGUI_drawPanelNPC(ent, dist) -- thx for _AMD_ (gm-donate крутой сервис)
	dist = dist or EyePos():DistToSqr( ent:GetPos() )

	if ( dist > MAX_DIST ) then
		surface.SetAlphaMultiplier( math.Clamp( 3 - ( dist / 20000 ), 0, 1 ) )
		local _,max = ent:GetRotatedAABB( ent:OBBMins(), ent:OBBMaxs() )
		local rot = ( ent:GetPos() - EyePos() ):Angle().yaw - 90 --  чтобы крутилась.
		local center = ent:LocalToWorld( ent:OBBCenter() )

		cam.Start3D2D(center + Vector( 0, 0, math.abs( max.z / 2 ) + 12 ), Angle( 0, rot, 90 ), 0.13 )
		surface.SetFont('amb_fonts32')
			local x, y = surface.GetTextSize( MAIN_TEXT_NPC )
			draw.SimpleTextOutlined( MAIN_TEXT_NPC, MAIN_FONT, -x/2, 15, COLOR_TEXT, 0, 0, 1, Color(0,0,0) )
		cam.End3D2D()

		surface.SetAlphaMultiplier( 1 )
	end
end

function ENT:Draw()
	local dist = EyePos():DistToSqr( self:GetPos() )

	if ( CannotDrawNPC ) then
		if MAX_DIST_RENDER and dist > MAX_DIST_RENDER then return end
	end

	self:DrawModel()
	self:DrawShadow( false )
	AmbVGUI_drawPanelNPC( self, dist )
end
