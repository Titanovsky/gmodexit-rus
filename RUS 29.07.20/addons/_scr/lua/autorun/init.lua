if SERVER then

	AddCSLuaFile( )
	AddCSLuaFile( "sui_scoreboard/admin_buttons.lua" )
	AddCSLuaFile( "sui_scoreboard/cl_tooltips.lua" )
	AddCSLuaFile( "sui_scoreboard/player_frame.lua" )
	AddCSLuaFile( "sui_scoreboard/player_row.lua" )
	AddCSLuaFile( "sui_scoreboard/scoreboard.lua" )
else


CUSTOM_MATERIAL_LIST={}
timer.Create("customMaterialChecker",1,0,function()
	for k,ply in pairs(player.GetAll()) do
		local key=ply:GetNWString("custom_material")
		if key and CUSTOM_MATERIAL_LIST[key]==nil or ply.CustomBack==nil then
			local FN = "custom_materials/"..ply:UniqueID().."_"..util.CRC(key)..".png"
			if file.Exists(FN,"DATA") then
				CUSTOM_MATERIAL_LIST[key]=Material("data/"..FN,"nocull")
				ply.CustomBack=CUSTOM_MATERIAL_LIST[key]
				ply.CustomBackType=tonumber(ply:GetNWInt("custom_material_type"))
				ply.CustomBackW=CUSTOM_MATERIAL_LIST[key]:GetInt("$realwidth")
				ply.CustomBackH=CUSTOM_MATERIAL_LIST[key]:GetInt("$realheight")
			else
				http.Fetch(key,function(body,size,headers,code)
				file.CreateDir("custom_materials")
				   file.Write(FN, body)
				   CUSTOM_MATERIAL_LIST[key]=Material("data/"..FN,"nocull")
				   ply.CustomBack=CUSTOM_MATERIAL_LIST[key]
				   ply.CustomBackType=tonumber(ply:GetNWInt("custom_material_type"))
				   ply.CustomBackW=CUSTOM_MATERIAL_LIST[key]:GetInt("$realwidth")
				   ply.CustomBackH=CUSTOM_MATERIAL_LIST[key]:GetInt("$realheight")
				end)
			end
		end
	end
end)


Blur = Material( "pp/blurscreen" )
function BLUR(steps,mult)
	steps=steps or 3
	multiplier =mult or 5
	render.SetMaterial( Blur )
	render.UpdateScreenEffectTexture()
	render.PushRenderTarget(render.GetScreenEffectTexture())
	for i = 1, steps do
		Blur:SetFloat("$blur", (i / steps) * (multiplier or 6))
		Blur:Recompute()
		render.UpdateScreenEffectTexture()
		render.DrawScreenQuad()
	 end
	render.PopRenderTarget()
end
	include( "sui_scoreboard/scoreboard.lua" )
	if ( SuiScoreBoard ) then
		SuiScoreBoard:Remove()
		SuiScoreBoard = nil
	end


	timer.Simple( 1.5, function()
		function GAMEMODE:CreateScoreboard()
			if ( ScoreBoard ) then

				ScoreBoard:Remove()
				ScoreBoard = nil

			end

			if ( SuiScoreBoard ) then

				SuiScoreBoard:Remove()
				SuiScoreBoard = nil

			end
			SuiScoreBoard = vgui.Create( "suiscoreboard" )

			return true
		end

		function GAMEMODE:ScoreboardShow()
			if not SuiScoreBoard then
				self:CreateScoreboard()
			end

			GAMEMODE.ShowScoreboard = true
			gui.EnableScreenClicker( true )
			SuiScoreBoard:SetPos( (ScrW() - SuiScoreBoard:GetWide()) / 2, -SuiScoreBoard:GetTall()+1)
			SuiScoreBoard.AnimTime=SysTime()
			SuiScoreBoard.IsOpening=true
			SuiScoreBoard:SetVisible( true )
			SuiScoreBoard:UpdateScoreboard( true )
			return true
		end

		function GAMEMODE:ScoreboardHide()
			GAMEMODE.ShowScoreboard = false
			gui.EnableScreenClicker( false )
			SuiScoreBoard:SetPos( (ScrW() - SuiScoreBoard:GetWide()) / 2, -20)
			SuiScoreBoard.AnimTime=SysTime()
			SuiScoreBoard.IsOpening=false
			--if SuiScoreBoard then

			--end
			return true
		end
	end )
end