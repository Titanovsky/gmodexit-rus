if ( SERVER ) then 
	if ( AMB.config.module_drinks == false ) then return end 
end

AmbAlco = AmbAlco or {}

local words_beer = { "Мм, вкусное пивцо!", "Я лошадиная жопа!", "Я гей.", "Ты меня уважаешь?", "Я счастлив!!!", "Что за? Ааа..", "Паа-рни, я лююблю в-а-асс!" }

function AmbAlco.getDrunk( ePly )
	return tonumber( ePly:GetNWInt( 'amb_alco_drunk' ) )
end

if ( CLIENT ) then
	hook.Add( "RenderScreenspaceEffects", "amb_0x4", function() -- лол'amb_0x4' начал записывать ещё в августе 19 года :D
		if ( AmbAlco.getDrunk( LocalPlayer() ) > 0 ) then
			--DrawMotionBlur( 0.4, 0.6, 0.25)
			DrawBloom( 0.65, 2, 9, 9, 1, 1, 1, 1, 1 )
			--DrawColorModify( { ["$pp_colour_brightness"] = 12 } )
		end
	end )
elseif ( SERVER ) then
	function AmbAlco.setDrunk( ePly, nCondition )
		ePly:SetNWInt( 'amb_alco_drunk', nCondition )
		ePly:Say( table.Random( words_beer ) )
	end

	function AmbAlco.removeDrunk( ePly )
		ePly:SetNWInt( 'amb_alco_drunk', 0 )
	end
end