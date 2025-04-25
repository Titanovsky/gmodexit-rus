local PANEL = {}

/*---------------------------------------------------------
   Name: 
---------------------------------------------------------*/
function PANEL:DoClick()

	if ( !self:GetParent().Player || LocalPlayer() == self:GetParent().Player ) then return end

	self:DoCommand( self:GetParent().Player )
	--timer.Simple( 0.1, SuiScoreBoard.UpdateScoreboard())

end

/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:Paint( w,h )
	
	local bgColor = Color( 0,0,0,200 )

	if ( self:IsHovered( ) ) then
		bgColor = Color( 50, 50, 50, 200 )
	elseif ( self.Armed ) then
		bgColor = Color( 175, 175, 175, 200 )
	end
	
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), bgColor )
	
	draw.SimpleText( self.Text, "DefaultSmall", self:GetWide() / 2, self:GetTall() / 2, Color(255,255,255,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	return true

end


vgui.Register( "suispawnmenuadminbutton", PANEL, "Button" )
local muted=Material("icon16/sound_mute.png")
local unmuted = Material("icon16/sound.png")
local gag=Material("icon16/email_delete.png")
local ungag = Material("icon16/email.png")
local PANEL = {}


function PANEL:DoClick()
	self.Muted=self.Player:IsMuted()
	self.Muted=not self.Muted
	self.Player:SetMuted(self.Muted)
end

function PANEL:Paint( w,h )
	
	local bgColor = Color( 0,0,0,200 )

	if ( self:IsHovered( ) ) then
		bgColor = Color( 50, 50, 50, 200 )
	elseif ( self.Armed ) then
		bgColor = Color( 175, 175, 175, 200 )
	end
	
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), bgColor )
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(self.Muted and muted or unmuted)
	surface.DrawTexturedRect(w/2-8, h/2-8, 16, 16)
	
	return true

end


vgui.Register( "mutebutton", PANEL, "Button" )
local PANEL = {}


function PANEL:DoClick()
	self.Muted=(self.Player.ChatMute==nil and false or self.Player.ChatMute)
	self.Player.ChatMute=not self.Player.ChatMute
end

function PANEL:Paint( w,h )
	
	local bgColor = Color( 0,0,0,200 )

	if ( self:IsHovered( ) ) then
		bgColor = Color( 50, 50, 50, 200 )
	elseif ( self.Armed ) then
		bgColor = Color( 175, 175, 175, 200 )
	end
	
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), bgColor )
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(self.Player.ChatMute and gag or ungag)
	surface.DrawTexturedRect(w/2-8, h/2-8, 16, 16)
	
	return true

end


vgui.Register( "gagbutton", PANEL, "Button" )

/*   PlayerKickButton */

PANEL = {}
PANEL.Text = "Kick"

/*---------------------------------------------------------
   Name: DoCommand
---------------------------------------------------------*/
function PANEL:DoCommand( ply )

	LocalPlayer():ConCommand( "kickid ".. ply:UserID().. " Kicked By "..LocalPlayer():Nick().."\n" )
	
end

vgui.Register( "suiplayerkickbutton", PANEL, "suispawnmenuadminbutton" )



/*   PlayerPermBanButton */

PANEL = {}
PANEL.Text = "PermBan"

/*---------------------------------------------------------
   Name: DoCommand
---------------------------------------------------------*/
function PANEL:DoCommand( ply )

	LocalPlayer():ConCommand( "banid 0 ".. self:GetParent().Player:UserID().. "\n" )
	LocalPlayer():ConCommand( "kickid ".. ply:UserID().. " Permabanned By "..LocalPlayer():Nick().."\n" )
	
end

vgui.Register( "suiplayerpermbanbutton", PANEL, "suispawnmenuadminbutton" )



/*   PlayerPermBanButton */

PANEL = {}
PANEL.Text = "Goto"

/*---------------------------------------------------------
   Name: DoCommand
---------------------------------------------------------*/
function PANEL:DoCommand( ply )

	LocalPlayer():ConCommand( "ulx goto \"".. self:GetParent().Player:Nick().. "\"\n" )	
end

vgui.Register( "suiplayergotobutton", PANEL, "suispawnmenuadminbutton" )



/*   PlayerPermBanButton */

PANEL = {}
PANEL.Text = "RP Voice"
function PANEL:Paint( w,h )
	

	local bgColor = LocalPlayer():GetNWBool("RPVOICE",false) and Color(0,255,0,66) or Color( 0,0,0,200 )

	if ( self:IsHovered( ) ) then
		bgColor = Color( 50, 50, 50, 200 )
	elseif ( self.Armed ) then
		bgColor = Color( 175, 175, 175, 200 )
	end
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), bgColor )
	
	draw.SimpleText( self.Text, "DefaultSmall", self:GetWide() / 2, self:GetTall() / 2, Color(255,255,255,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	
	return true

end
function PANEL:DoClick(  )
	LocalPlayer():ConCommand("RPVOICE")	
end

vgui.Register( "suiplayerrpbutton", PANEL, "suispawnmenuadminbutton" )
