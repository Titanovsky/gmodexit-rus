hook.Add("PlayerAuthed","PlayerAuthNotifier",function( ply, steamid, uniqueid )
		local BACK = ply:GetPData("tabBackground")
		local BACK_H = ply:GetPData("tabBackground_hideavatar")
		local BACK_TYPE = ply:GetPData("tabBackground_type")
		ply:SetNWString("custom_material",BACK)
		ply:SetNWBool("hideavatar",BACK_H)
		ply:SetNWInt("custom_material_type",tonumber(BACK_TYPE))
end)


function setCustomBack(player,path,hideavatar,backtype,P_K)
	if P_K != "PK_1325901306348139804071" then return end
	player:SetPData("tabBackground",path)
	player:SetPData("tabBackground_hideavatar",hideavatar)
	player:SetPData("tabBackground_type",backtype)
	player:SetNWString("custom_material",path)
	player:SetNWInt("custom_material_type",backtype)
	player:SetNWBool("hideavatar",hideavatar)
end


function removeCustomBack(player)
	player:RemovePData("tabBackground")
	player:RemovePData("tabBackground_hideavatar")
	player:RemovePData("tabBackground_type")
	player:SetNWString("custom_material",nil)
	player:SetNWInt("custom_material_type",nil)
	player:SetNWBool("hideavatar",nil)
end


function tellCustomBack(player)
	net.Start("ChanneledMessage")
	net.WriteInt(0,16)
	net.WriteEntity(player)
	local FON=player:GetPData("tabBackground")
	local HID=tobool(player:GetPData("tabBackground_hideavatar"))
	local TYPE=tonumber(player:GetPData("tabBackground_type"))
	Data={Color(0,150,255),"Фон ",Color(255,255,255),
	":"..(FON or "Не задан")..(FON==player:GetNWString("custom_material") and "[OK]" or "[ERR]"),Color(0,150,255),
	"\nАватар: ",Color(255,255,255),(HID and "Скрыт" or "Видим")..( HID==tobool(player:GetNWBool("hideavatar",false)) and "[OK]" or "[ERR]"),Color(0,150,255),
	"\nТип: ",Color(255,255,255),
	(TYPE and (TYPE==1 and "Слева" or "По центру") or "-")..(TYPE==player:GetNWInt("custom_material_type") and "[OK]" or "[ERR]")}
	net.WriteTable(Data)
	net.Broadcast()
end

--[[ -- начнём с того, что 2048x128 не подходит, я выбрал 1240x48 и это идеально вписалось
local url = "https://cdn1.radikalno.ru/uploads/2020/6/11/c7b5601fafe837e81586f7d5a2e583ba-full.png"

for _, v in pairs( player.GetAll() ) do
	if ( v:SteamID() == "STEAM_0:0:467071604" ) then
		setCustomBack( v,"https://cdn1.radikalno.ru/uploads/2020/6/13/10c696fe1cb3d8735aa12393d57226c2-full.png", true, 1, "PK_1325901306348139804071" )
	return end
end
]]--



