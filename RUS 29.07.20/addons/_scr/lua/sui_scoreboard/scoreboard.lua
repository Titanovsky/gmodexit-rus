include( "player_row.lua" )
include( "player_frame.lua" )
// checking for utime for the hours
utimecheck = false
if file.Exists("autorun/cl_utime.lua", "LUA") then
	utimecheck = true
end

// checking for ulib for the team names
ulibcheck = false
if file.Exists("ulib/cl_init.lua", "LUA") then
	ulibcheck = true
end

surface.CreateFont( "suiscoreboardheader", {
	font = "Century Gothic",
	size = 32,
	weight = 120
})
surface.CreateFont( "suiscoreboardsubtitle", {
	font = "coolvetica",
	size = 20,
	weight = 100
 })
surface.CreateFont( "suiscoreboardlogotext", {
	font = "Century Gothic",
	size = 75,
	weight = 600,
	extended=true
})
surface.CreateFont( "suiscoreboardsuisctext", {
	font = "verdana",
	size = 12,
	weight = 100
})
surface.CreateFont( "suiscoreboardplayername", {
	font = "Century Gothic",
	size = 32,
	weight = 100
})
surface.CreateFont( "suiscoreboardgroupname", {
	font = "Century Gothic",
	size = 20,
	weight = 100
})
local texGradient = surface.GetTextureID( "gui/center_gradient" )
local function ColorCmp( c1, c2 )
	if( !c1 || !c2 ) then return false end

	return (c1.r == c2.r) && (c1.g == c2.g) && (c1.b == c2.b) && (c1.a == c2.a)
end


local PANEL = {}



/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/

function PANEL:Init()
	SCOREBOARD = self
	self.AnimTime=0
	--self.Logog = vgui.Create( "DLabel", self )
	--self.Logog:SetText( "g" )

	self.SuiSc = vgui.Create( "DLabel", self )
	self.SuiSc:SetText( "RU's Таблица игроков" )

	--self.Description = vgui.Create( "DLabel", self )
	--self.Description:SetText( GAMEMODE.Name)

	self.PlayerFrame = vgui.Create( "suiplayerframe", self )

	self.PlayerRows = {}

	self:UpdateScoreboard()

	// Update the scoreboard every 1 second
	timer.Create( "SuiScoreboardUpdater", 1, 0, function() SCOREBOARD:UpdateScoreboard() end )
end



function PANEL:AddPlayerRow( ply )
	local button = vgui.Create( "suiscoreplayerrow", self.PlayerFrame:GetCanvas() )
	button:SetPlayer( ply )
	self.PlayerRows[ ply ] = button
end

/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:GetPlayerRow( ply )
	return self.PlayerRows[ ply ]
end
/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:Paint( w, h )
	if self.IsOpening then
			self:SetPos( (ScrW() - self:GetWide()) / 2, -math.Clamp(1-((SysTime( )-self.AnimTime)/0.2),0,1.0)*(self:GetTall()-20))

		else
			self:SetPos( (ScrW() - self:GetWide()) / 2, -math.Clamp((SysTime( )-self.AnimTime)/0.2,0,1.0)*self:GetTall())

			local _,y=self:GetPos()
	end


	BLUR(7,10)
	local x,y = self:LocalToScreen(0,0)
	local w,h = self:GetWide(),self:GetTall()
	surface.SetDrawColor(Color( 0, 0, 0, 255 ))
	surface.SetMaterial(Blur)
	surface.DrawTexturedRectUV(0, 0,w,h,x/ScrW(),y/ScrH(),(x+w)/ScrW(),(y+h)/ScrH())
	--draw.RoundedBox( 20, 0, -20, self:GetWide(), self:GetTall(),  )
	--surface.SetDrawColor( 255, 255, 255,70)
	---surface.SetMaterial( MAT )
	--surface.DrawTexturedRect( 0, self:GetTall()-720, 948,700)
	surface.SetDrawColor(Color( 0, 0, 0, 225 ))

	surface.DrawRect(0,0,w,h)
	draw.DrawText("[RU's]", "suiscoreboardlogotext",  self:GetWide()/2, 18,  Color( 255, 255,255, 255 ), TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	draw.DrawText(os.date("%H:%M:%S"), "suiscoreboardlogotext",  self:GetWide()-50, 18,  Color( 255, 255,255, 255 ), TEXT_ALIGN_RIGHT)
	--PrintTable(os.date("%H:%M:%S"))
	-- draw.RoundedBox( 4, 20, self.Description.y + self.Description:GetTall() + 6, self:GetWide() - 40, 12, Color( 0, 0, 0, 50 ) )
end


/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/


function PANEL:PerformLayout()
	self:SetSize( ScrW(), ScrH() * 0.75 )

	self.SuiSc:SizeToContents( )
	self.SuiSc:SetPos( self:GetWide() - self.SuiSc:GetWide()-25, self:GetTall() - 40 )

	--self.Description:SizeToContents()
	--self.Description:SetPos( 115, 60 )
	--self.Description:SetColor( Color( 30, 30, 30, 255 ) )

	self.PlayerFrame:SetPos( 5, 92 + 20 )
	self.PlayerFrame:SetSize( self:GetWide() - 10, self:GetTall() - self.PlayerFrame.y - 40 )

	local y = 0

	local PlayerSorted = {}

	for k, v in pairs( self.PlayerRows ) do
		if IsValid( k ) then table.insert( PlayerSorted, v ) end
	end

	table.sort( PlayerSorted, function ( a , b ) return a:HigherOrLower( b ) end )

	for k, v in ipairs( PlayerSorted ) do
		v:SetPos( 0, y )
		v:SetSize( self.PlayerFrame:GetWide(), v:GetTall() )

		self.PlayerFrame:GetCanvas():SetSize( self.PlayerFrame:GetCanvas():GetWide(), y + v:GetTall() )

		y = y + v:GetTall() + 1
	end


end

/*---------------------------------------------------------
   Name: ApplySchemeSettings
---------------------------------------------------------*/
function PANEL:ApplySchemeSettings()

	self.SuiSc:SetFont( "suiscoreboardsuisctext" )

	self.SuiSc:SetTextColor( Color( 200, 200, 200, 200 ) )

end


function PANEL:UpdateScoreboard( force )
	if not self or ( not force and not self:IsVisible() ) then return end
	for k, v in pairs( self.PlayerRows ) do
		if not IsValid( k ) then
			v:Remove()
			self.PlayerRows[ k ] = nil
		end
	end

	local PlayerList = player.GetAll()
	for id, pl in pairs( PlayerList ) do

		if not self:GetPlayerRow( pl ) then
			self:AddPlayerRow( pl )
		end
	end

	// Always invalidate the layout so the order gets updated
	self:InvalidateLayout()
end
vgui.Register( "suiscoreboard", PANEL, "Panel" )