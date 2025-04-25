include( "admin_buttons.lua" )

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

local texGradient = surface.GetTextureID( "gui/center_gradient" )

local PANEL = {}
local buildicon = Material("icon16/wrench.png")

function PANEL:Paint( w, h )
	if not IsValid( self.Player ) then
		self:Remove()
		SCOREBOARD:InvalidateLayout()
		return
	end

	local color = Color( 100, 100, 100, 150 )

	if self.Armed then
		color = Color( 125, 125, 125, 150 )
	end

	if self.Selected then
		color = Color( 125, 125, 125, 150 )
	end

	if self.Player:Team() == TEAM_CONNECTING then
		color = Color( 100, 100, 100, 155 )
	elseif IsValid( self.Player ) then
		if self.Player:Team() == TEAM_UNASSIGNED then
			color = Color( 100, 100, 100, 150 )
		else
			color = team.GetColor( self.Player:Team() )
		end
	elseif self.Player:IsAdmin() then
		color = Color( 255, 155, 0, 150 )
	end

	if self.Player == LocalPlayer() then
		color = team.GetColor( self.Player:Team() )
	end
	color.a=100
	draw.RoundedBox( 4, 18, 0, self:GetWide() - 36, self.Size, color )
	if self.Player.CustomBack then
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(self.Player.CustomBack)
	--print(self.Player:GetName()..": "..(self.Player.CustomBackType==0 and "left" or "center").."("..self.Player.CustomBackType..")"..type(self.Player.CustomBackType).." "..self.Player.CustomBackW.."x"..self.Player.CustomBackH)
		if self.Player.CustomBackType==1 then surface.DrawTexturedRectUV(18,h/2-self.Player.CustomBackH/2,self.Player.CustomBackW,self.Player.CustomBackH,0.007,0,1.0-0.007,1.0) else surface.DrawTexturedRect((18+w/2)-self.Player.CustomBackW/2,h/2-self.Player.CustomBackH/2,self.Player.CustomBackW,self.Player.CustomBackH) end
	end
	local PD = 6-(self.Player:Ping()/150)*6
	for i=0, 5 do
		if i<PD then surface.SetDrawColor(Color(200,200,200,220)) else surface.SetDrawColor(Color(0,0,0,220)) end
		surface.DrawRect(self:GetWide()-40, self:GetTall()-15-(i*7), 15, 5)
	end

	local PP = math.Clamp(((self.Player:GetCount( "props" )/500+self.Player:GetCount( "wire_lamps" )/4+self.Player:GetCount( "ragdolls" )/10+self.Player:GetCount( "wire_lights" )/5+self.Player:GetCount( "wire_expressions" )/5+self.Player:GetCount( "lamps" )/4+self.Player:GetCount( "lights" )/5)/7)*6,0,6)

	for i=0, 5 do
		if i<PP then surface.SetDrawColor(Color(255,0,0,220)) else surface.SetDrawColor(Color(0,0,0,220)) end
		surface.DrawRect(self:GetWide()-57, self:GetTall()-15-(i*7), 15, 5)
	end

	local w2 = self.lblDeaths:GetSize()
	w2=w-w2-171
	draw.RoundedBox( 4, w2,6, 100, 60, Color(0,0,0,200) )
	draw.RoundedBox( 4, w2,6, (self.Player:GetNWInt("exp")/self.Player:GetNWInt("next_exp"))*100, 60, Color(0,255,0,66) )
	draw.SimpleText(tostring(self.Player:GetNWInt("lvl")), "suiscoreboardheader", w2+50, 25, Color(255,255,255,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	draw.SimpleText("Level", "DefaultSmall",w2+50, 25, Color(255,255,255,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

	w2=self.RPB
	if not self.btnRP then
		draw.RoundedBox( 4, self.RPB, 6,60, 60, self.Player:GetNWBool("RPVOICE") and Color(0,255,0,66) or Color( 0,0,0,200 ))
		draw.SimpleText("RP Voice", "DefaultSmall", self.RPB+30, 72/2, Color(255,255,255,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		w2=self.RPB-64
	end
	if self.Player:GetNWBool("IsBuild") then
		draw.RoundedBox( 4, w2, 6, 60, 60, Color( 0,0,0,200 ) )
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(buildicon)
		surface.DrawTexturedRect(w2+22, (72/2)-8, 16, 16)
	end
	if self.Player:GetNWBool("IsMing") then
		draw.SimpleText("МИНГ!", "suiscoreboardlogotext", w/2, h/2, Color(255,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	-- Titanovsky
	if self.Player:Nick() == 'STEAM_0:1:95303327' then
		draw.SimpleTextOutlined("Шериф", "suiscoreboardlogotext", w/2, h/2, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,200,255) )
	end

	return true
end

/*---------------------------------------------------------
   Name: SetPlayer
---------------------------------------------------------*/
function PANEL:SetPlayer( ply )
	self.Player = ply
	self:UpdatePlayerData()
	self.imgAvatar:SetPlayer( ply,64)
end

/*---------------------------------------------------------
   Name: UpdatePlayerData
---------------------------------------------------------*/
function PANEL:UpdatePlayerData()
	local ply = self.Player
	if not IsValid( ply ) then return end
	self.btnMute.Player=ply
	if tobool(ply:GetNWBool("hideavatar")) then
		self.imgAvatar:SetVisible(false)
		self.btnAvatar:SetAlpha(0)
	else
		self.imgAvatar:SetVisible(true)
		self.btnAvatar:SetAlpha(255)
	end
	--if self.PlayTime == nil or self.PlayTime == 0 then
	self.lblName:SetText( ply:Nick() )
	if !ply:Alive() then self.lblName:SetText( ply:Nick().."(МЁРТВ)" ) end

		self.lblFrags:SetText("Убийств: "..ply:Frags() )
		self.lblDeaths:SetText("Смертей: ".. ply:Deaths() )
		self.lblPing:SetText( ply:Ping() )

	self.lblTeam:SetText( team.GetName( ply:Team() ))

end

/*---------------------------------------------------------
   Name: Init
---------------------------------------------------------*/
function PANEL:Init()
	self.Size = 72



	self.btnMute = vgui.Create( "mutebutton", self )

	self.btnGoto = vgui.Create( "suiplayergotobutton", self )


	self.lblName 	= vgui.Create( "DLabel", self )
	if ulibcheck then self.lblTeam 	= vgui.Create( "DLabel", self ) end
	self.lblFrags 	= vgui.Create( "DLabel", self )
	self.lblDeaths 	= vgui.Create( "DLabel", self )
	self.lblPing 	= vgui.Create( "DLabel", self )
	self.lblPing:SetText( "999" )

	self.btnAvatar = vgui.Create( "DButton", self )
	self.btnAvatar.DoClick = function() self.Player:ShowProfile() end
	self.imgAvatar = vgui.Create( "AvatarImage", self.btnAvatar )
	self.lblName:SetMouseInputEnabled( false )
	if ulibcheck then self.lblTeam:SetMouseInputEnabled( false ) end
	--if utimecheck then self.lblHours:SetMouseInputEnabled( false ) end
	--self.lblHealth:SetMouseInputEnabled( false )
	--self.lblFrags:SetMouseInputEnabled( false )
	--self.lblDeaths:SetMouseInputEnabled( false )
	self.lblPing:SetMouseInputEnabled( false )
	self.imgAvatar:SetMouseInputEnabled( false )
end

/*---------------------------------------------------------
   Name: ApplySchemeSettings
---------------------------------------------------------*/
function PANEL:ApplySchemeSettings()
	self.lblName:SetFont( "suiscoreboardplayername" )
	if ulibcheck then self.lblTeam:SetFont( "suiscoreboardgroupname" ) end
	self.lblFrags:SetFont( "suiscoreboardgroupname" )
	self.lblDeaths:SetFont( "suiscoreboardgroupname" )
	self.lblPing:SetFont( "suiscoreboardsuisctext" )
	local col = color_black
	local h,s,l = ColorToHSL(team.GetColor(self.Player:Team()))
	if l<0.4 or self.Player.CustomBack then col=color_white end
	self.lblName:SetTextColor( col )
	if ulibcheck then self.lblTeam:SetTextColor( col ) end
	self.lblFrags:SetTextColor( col )
	self.lblDeaths:SetTextColor( col )
	self.lblPing:SetTextColor( color_white )

end


/*---------------------------------------------------------
   Name: Think
---------------------------------------------------------*/
function PANEL:Think()


	if not self.PlayerUpdate or self.PlayerUpdate < CurTime() then
		self.PlayerUpdate = CurTime() + 0.5
		self:UpdatePlayerData()
	end
end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:PerformLayout()
	if !IsValid(self.Player) then return end

	self:SetSize( self:GetWide(), self.Size )

	self.btnAvatar:SetPos( 21, 4 )
	self.btnAvatar:SetSize( 64, 64 )

 	self.imgAvatar:SetSize( 64, 64 )
	if self.icon and EYEMODEL then self.icon:SetVisible(true) end
	self.lblName:SizeToContents()
	if ulibcheck then self.lblTeam:SizeToContents() end
	self.lblFrags:SizeToContents()
	self.lblDeaths:SizeToContents()
	self.lblPing:SizeToContents()
	self.lblDeaths:SetWide( 100 )
	self.lblFrags:SetWide( 100 )

	self.lblName:SetPos( 94, 3 )
	if ulibcheck then self.lblTeam:SetPos( 94, self.Size -32) end
	local w,h = self.lblFrags:GetSize()
	self.lblFrags:SetPos( self:GetParent():GetWide() - w- 64, 6 )
	w,h = self.lblPing:GetSize()
	self.lblPing:SetPos( self:GetParent():GetWide() - w-27, 3 )
	w,h = self.lblDeaths:GetSize()
	self.lblDeaths:SetPos( self:GetParent():GetWide() -w -64, h*2 )
	w= self:GetParent():GetWide() -w -64-171
	if self.Player == LocalPlayer() then
		self.btnMute:SetVisible( false )
	else
		self.btnMute:SetVisible( true )
		self.btnMute:SetSize( 60, 60 )
		self.btnMute:SetPos(w, 6 )
		w=w-64
	end
	if LocalPlayer():query("ulx goto") and self.Player != LocalPlayer() then
		self.btnGoto:SetVisible( true )
		self.btnGoto:SetSize( 60, 60 )
		self.btnGoto:SetPos( w, 6 )
		w=w-64
	else
		self.btnGoto:SetVisible( false )
	end
	if self.btnRP==nil and self.Player==LocalPlayer() then
		self.btnRP=vgui.Create( "suiplayerrpbutton", self )
		self.btnRP:SetVisible( true )
		self.btnRP:SetSize( 60, 60 )
		self.btnRP:SetPos( w, 6 )
	end
	self.RPB=w

end

/*---------------------------------------------------------
   Name: HigherOrLower
---------------------------------------------------------*/
function PANEL:HigherOrLower( row )
	if self.Player:Team() == TEAM_CONNECTING then return false end
	if row.Player:Team() == TEAM_CONNECTING then return true end
	if self.Player:Team() ~= row.Player:Team() then
		return self.Player:Team() < row.Player:Team()
	end
	if ( tonumber(self.Player:GetNWInt("lvl",0)) == tonumber(row.Player:GetNWInt("lvl",0))) then
		if ( self.Player:Frags() == row.Player:Frags() ) then
			return self.Player:Deaths() < row.Player:Deaths()
		end
		return  self.Player:Frags() > row.Player:Frags()
	end
	return tonumber(self.Player:GetNWInt("lvl",0)) > tonumber(row.Player:GetNWInt("lvl",0))
end

vgui.Register( "suiscoreplayerrow", PANEL, "DButton" )