-- Данное творение принадлежит проекту [.ambition]
local w = ScrW()
local h = ScrH()
local RMULT=(ScrW()/1920)
local wb, hb = w/1.4, ScrH()*0.02
local xb, yb = w/2 - wb/2, h-hb

CreateClientConVar( "amb_mine_hud", "1", true, false )

net.Receive( "send_notify", function( len ) -- на самом деле есть либа, но я её хочу использовать на новой сборке =/
    local text = net.ReadString()

    notification.AddLegacy( text, 2, 1.8 )
end )

net.Receive( "amb_mine_hud_net", function( ePly )
    if ( GetConVar("amb_mine_hud"):GetInt() == 0 ) then
        GetConVar("amb_mine_hud"):SetInt( 1 )
    else
        GetConVar("amb_mine_hud"):SetInt( 0 ) -- Данное творение принадлежит проекту [.ambition]
    end
end )

surface.CreateFont("amb_mine24", {
    font = "Tahoma",
    size = 22*RMULT,
})
-- Данное творение принадлежит проекту [.ambition]
local COLOR_BG      = Color( 15, 15, 15, 240 )
local COLOR_TEXT    = Color( 255, 255, 255 )
local COLOR_ORE    = {Color( 200, 200, 200 ),Color( 165, 145, 145 ),Color( 181, 96, 40 ),Color( 0, 161, 179 ),Color( 196, 190, 69 ),Color( 28, 237, 223 ),Color( 219, 45, 22 ),Color( 175, 77, 255 )}
local VERTS={
	{x=ScrW()*0.15,0},
	{x=ScrW()*0.85,0},
	{x=ScrW()*0.80,y=ScrH()*0.04},
	{x=ScrW()*0.20,y=ScrH()*0.04}
}
local function AmbMine_hud()
    if GetConVar("amb_mine_hud"):GetInt() == 0 then return end -- если отключена конвара, то сё
	draw.NoTexture()
	surface.SetDrawColor(0,0,0,200)
	surface.DrawPoly(VERTS)
	local RES={}
	surface.SetFont("amb_mine24")
	local NUM = surface.GetTextSize("9999")
	local START = ScrW()*0.20
	local S=0
	for I=1,8 do
		local xtemp,ytemp=surface.GetTextSize(AmbMine.Config.Names[I]..": ")
		RES[I]=xtemp
		S=S+RES[I]+NUM*1.5
	end
	START=(ScrW()/2)-S/2
	
	for I=1,8 do
		 draw.SimpleText( AmbMine.Config.Names[I]..":",
		"amb_mine24",
		START, hb, COLOR_TEXT,
		TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER ) START=START+RES[I]
		
			
		draw.SimpleText( LocalPlayer():GetNWInt( "amb_mine_ore"..I ),
		"amb_mine24",
		START, hb, COLOR_ORE[I],
		TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		START=START+NUM*1.5
	end
   
	
	
	
end 
hook.Add( "HUDPaint", "amb_0x512", AmbMine_hud )
-- Данное творение принадлежит проекту [.ambition]