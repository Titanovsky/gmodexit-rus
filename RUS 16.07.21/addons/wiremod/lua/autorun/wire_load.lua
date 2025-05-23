if SERVER then
	-- this file
	AddCSLuaFile("autorun/wire_load.lua")

	-- shared includes
	AddCSLuaFile("wire/wire_paths.lua")
	AddCSLuaFile("wire/wireshared.lua")
	AddCSLuaFile("wire/wiregates.lua")
	AddCSLuaFile("wire/wiremonitors.lua")
	AddCSLuaFile("wire/gpulib.lua")
	AddCSLuaFile("wire/cpulib.lua")
	AddCSLuaFile("wire/timedpairs.lua")
	AddCSLuaFile("wire/default_data_decompressor.lua")
	AddCSLuaFile("wire/flir.lua")
	AddCSLuaFile("wire/von.lua")

	-- client includes
	AddCSLuaFile("wire/client/cl_wirelib.lua")
	AddCSLuaFile("wire/client/cl_modelplug.lua")
	AddCSLuaFile("wire/client/cl_wire_map_interface.lua")
	AddCSLuaFile("wire/client/wiredermaexts.lua")
	AddCSLuaFile("wire/client/wiremenus.lua")
	AddCSLuaFile("wire/client/wire_expression2_browser.lua")
	AddCSLuaFile("wire/client/wire_filebrowser.lua")
	AddCSLuaFile("wire/client/wire_listeditor.lua")
	AddCSLuaFile("wire/client/wire_soundpropertylist.lua")
	AddCSLuaFile("wire/client/e2helper.lua")
	AddCSLuaFile("wire/client/e2descriptions.lua")
	AddCSLuaFile("wire/client/e2_extension_menu.lua")
	AddCSLuaFile("wire/client/gmod_tool_auto.lua")
	AddCSLuaFile("wire/client/sound_browser.lua")
	AddCSLuaFile("wire/client/thrusterlib.lua")
	AddCSLuaFile("wire/client/rendertarget_fix.lua")
	AddCSLuaFile("wire/client/customspawnmenu.lua")

	-- text editor
	AddCSLuaFile("wire/client/text_editor/texteditor.lua")
	AddCSLuaFile("wire/client/text_editor/wire_expression2_editor.lua")
	AddCSLuaFile("wire/client/text_editor/modes/e2.lua")
	AddCSLuaFile("wire/client/text_editor/modes/zcpu.lua")

	-- HL-ZASM
	AddCSLuaFile("wire/client/hlzasm/hc_compiler.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_opcodes.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_expression.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_preprocess.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_syntax.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_codetree.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_optimize.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_output.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_tokenizer.lua")

	-- ZVM
	AddCSLuaFile("wire/zvm/zvm_core.lua")
	AddCSLuaFile("wire/zvm/zvm_features.lua")
	AddCSLuaFile("wire/zvm/zvm_opcodes.lua")
	AddCSLuaFile("wire/zvm/zvm_data.lua")

	if CreateConVar("wire_force_workshop", 1, {FCVAR_ARCHIVE}, "Should Wire force all clients to download the Workshop edition of Wire, for models? (requires restart to disable)"):GetBool() then
		resource.AddWorkshop("160250458")
	end
end

-- shared includes
include("wire/wireshared.lua")
include("wire/wire_paths.lua")
include("wire/wiregates.lua")
include("wire/wiremonitors.lua")
include("wire/gpulib.lua")
include("wire/cpulib.lua")
include("wire/timedpairs.lua")
include("wire/default_data_decompressor.lua")
include("wire/flir.lua")
include("wire/von.lua")

-- server includes
if SERVER then
	include("wire/server/wirelib.lua")
	include("wire/server/modelplug.lua")
	include("wire/server/radiolib.lua")
	include("wire/server/debuggerlib.lua")
end

-- client includes
if CLIENT then
	include("wire/client/cl_wirelib.lua")
	include("wire/client/cl_modelplug.lua")
	include("wire/client/cl_wire_map_interface.lua")
	include("wire/client/wiredermaexts.lua")
	include("wire/client/wiremenus.lua")
	include("wire/client/text_editor/texteditor.lua")
	include("wire/client/wire_expression2_browser.lua")
	include("wire/client/text_editor/wire_expression2_editor.lua")
	include("wire/client/wire_filebrowser.lua")
	include("wire/client/wire_listeditor.lua")
	include("wire/client/wire_soundpropertylist.lua")
	include("wire/client/e2helper.lua")
	include("wire/client/e2descriptions.lua")
	include("wire/client/e2_extension_menu.lua")
	include("wire/client/gmod_tool_auto.lua")
	include("wire/client/sound_browser.lua")
	include("wire/client/thrusterlib.lua")
	include("wire/client/rendertarget_fix.lua")
	include("wire/client/hlzasm/hc_compiler.lua")
	include("wire/client/customspawnmenu.lua")

end

-- Load UWSVN, done here so its definitely after Wire is loaded.
if file.Find("wire/uwsvn_load.lua","LUA")[1] then
	if SERVER then AddCSLuaFile( "wire/uwsvn_load.lua" ) end
	include("wire/uwsvn_load.lua")
end