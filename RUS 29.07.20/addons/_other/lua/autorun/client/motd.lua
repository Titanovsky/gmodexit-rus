local Rules = [[
			Хей, Здравствуй, ты находишься на [RUs].
						[ Ambition ]

• На нормальном Sandbox сервере, где можно отдохнуть и весело провести время;

• У нас только ОДНО правило: НЕ МЕШАТЬ ДРУГИМ ИГРОКАМ!

• У нас есть система Уровней и Экономика, давай по подробнее:

	★ Раз в 10 минут к Вам идёт зарплата + прибавка за LVL;
	★ LVL добывается с помощью EXP, раз в зарплату даётся 1 EXP;
	★ Посмотреть сколько осталось до другого Уровня: /stats
	★ Тулсы доступны с определённых уровней. Ентити, автомобили и пушки продаются;

|★| У нас очень дешёвый донат на F4 (Кстати, мы разрабатываем DarkRP сервер)

• Все подробности на /help, /cmd, /faq. Удачи, друг мой!


										Сервер принадлежит проекту: [ Ambition ]
]]

local COLOR_BOX = Color( 0, 0, 0, 230 )
local COLOR_TEXT = Color( 255, 18, 29 )
local COLOR_WHITE = Color( 255, 255, 255 )

local w = ScrW()*0.18
local h = ScrH()*0.08
local tw = ScrW()*0.02
local th = ScrH()*-0.1
local bw = ScrW()*0.28
local bh = ScrH()*0.75

function rus_MOTD()

	local Frame = vgui.Create( "DFrame" )


	surface.CreateFont( "motdtext", {
		font = "Tahoma",
    	size = 22
	} )

	surface.CreateFont( "closetext", {
	font = "Tahoma",
   	size = 25
	} )

	Frame:SetPos( w, h )
	Frame:SetSize( 900, 620 )
	Frame:SetTitle( "MOTD" )
	Frame:SetVisible( true )
	Frame:SetDraggable( true )
	Frame:ShowCloseButton( false )
	Frame:MakePopup( true )
	Frame.btnMinim:SetVisible( false )
	Frame.btnMaxim:SetVisible( false )



	Frame.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, COLOR_BOX )

	end

	local DLabel = vgui.Create( "DLabel", Frame )
	DLabel:SetSize( 900, 750 )
	DLabel:SetPos( tw, th )
	DLabel:SetText( Rules )
	DLabel:SetFont( "motdtext" )

	local button = vgui.Create("DButton", Frame)

	button.DoClick = function()

   		Frame:Remove()

	end

	button.Paint = function( self, tw, th )

		local COLOR_CB = Color( 255, 255, 255, 0 )
		draw.RoundedBox( 3, 0, 0, tw+50, th+50, COLOR_CB )

	end


	button:SetTextColor( COLOR_TEXT )
	button:SetFont( "closetext" )
	button:SetText( "Закрыть" )
	button:SetSize( 90, 30 )
	button:SetPos( tw+330, th+650 )

	button.OnCursorEntered = function()

			button:SetFont("closetext")
			button:SetTextColor( COLOR_WHITE )
			--self:SetCursor("hand")

    end

    button.OnCursorExited = function()


        	button:SetFont("closetext")
        	button:SetTextColor( COLOR_TEXT )

	end

end



hook.Add("InitPostEntity", "ply_load_motd", rus_MOTD )

concommand.Add( "motd_open", rus_MOTD )
