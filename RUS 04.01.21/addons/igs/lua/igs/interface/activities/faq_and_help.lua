IGS_HELP_TEXT = "Хелп!" -- для IGS.OpenUITab(IGS_HELP_TEXT) например

local url -- кешируем
hook.Add("IGS.CatchActivities","faq_and_help",function(activity,sidebar)
	local bg = sidebar:AddPage("FAQ")

	for _,v in ipairs( IGS.C.Help ) do
		IGS.AddTextBlock(bg.side, v.TITLE, v.TEXT)
	end

	bg.html = uigs.Create("igs_html", bg)
	bg.html:Dock(FILL)

	bg.OnOpenOver = function()
		-- Антирефреш страницы при переключении вкладки
		if !bg.html.opened then
			bg.html.opened = true

			if url then
				-- в DERMA не откроется, нужен ТОЛЬКО оверлей
				-- https://trello.com/c/UK2b4xCa/581
				bg.html:OpenURL(url)
				gui.OpenURL(url)
				return
			end

			IGS.GetHelpURL(function(fresh_url)
				url = fresh_url
				bg.html:OpenURL(fresh_url)
				gui.OpenURL(url)
			end)

			return
		end
	end

	activity:AddTab(IGS_HELP_TEXT,bg,"materials/icons/fa32/question.png")
end)

-- IGS.UI()
