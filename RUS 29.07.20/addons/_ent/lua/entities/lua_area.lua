ENT.Base = "base_brush"
ENT.Type = "brush"

Areas = {}

function ENT:Initialize()
	if not self.area_type then
		local min, max = self:WorldSpaceAABB()
		-- ErrorNoHalt("[lua_area][" .. self:EntIndex() .. "][" .. self.area_type .. "] no area_type defined "
		-- 	.. tostring(self) .." at <" .. tostring(min) .."> x <" .. tostring(max) .. ">\n")
		self.error = true
	end
	if self.error then
		if self.area_type then
			Areas[self.area_type] = {self:WorldSpaceAABB()}
		end
		self:Remove()
	end
end

function ENT:GetAreaType()
	return self.area_type
end

function ENT:KeyValue(key, value)
	if key=="area_type" then
		self.area_type = value
		if Areas[value] then
			-- ErrorNoHalt("[lua_area][" .. self:EntIndex() .. "][" .. self.area_type .. "] DUPLICATE AREA \"" .. value .. "\"")
		end
		Areas[value] = self
		local filename = "lua_area/" .. value .. ".lua"
		_G.AREA = self
		if file.Exists(filename, "LUA") then
			-- Msg("[lua_area][" .. self:EntIndex() .. "][" .. self.area_type .. "] ")print(value)
			include(filename)
		else
			-- ErrorNoHalt("[lua_area][" .. self:EntIndex() .. "][" .. self.area_type .. "] missing area definition: " .. filename .. "\n")
			--include("lua_area/debug.lua")
			self.error = true
		end
		_G.AREA = nil
	end
end
