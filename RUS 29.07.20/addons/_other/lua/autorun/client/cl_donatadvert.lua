local w, h = ScrW(), ScrH()
local main_x, main_y = 4000, 0
local COLOR_MAIN = Color( 245, 245, 245 )
local COLOR_OUTLINE = Color( 99, 164, 255 )
local COLOR_TEXT = Color( 154, 76, 194 )
local sound = "ru_reborn/wet_porno.wav"

local delay = 1124

util.PrecacheSound("ru_reborn/wet_porn.wav")


local function rus_adv()
	local main_block = vgui.Create("DFrame")
	main_block:SetSize(200, 60)
	main_block:SetPos(main_x, main_y)
	main_block:ShowCloseButton(false)
	main_block:SetTitle("")
	main_block.Paint = function( self, w, h)
		draw.RoundedBox(4, 0, 0, w, h, COLOR_OUTLINE )
		draw.RoundedBox(1, 5, 5, w-10, h-10, COLOR_MAIN )
		draw.SimpleText("Донат на F4", "ZN",  42, 15, COLOR_TEXT)
	end
	main_block:MoveTo(w / 2 - 80, 0, .7, 0)
	timer.Simple( 46, function() main_block:Remove() end)
	surface.PlaySound(sound)
end

hook.Add("Initialize", "rus_InitDonateAdvert", function()
	timer.Create("donateAdvert", delay, 0, function()
		rus_adv()
	end)
end)
