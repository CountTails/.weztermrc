local wezterm = require("wezterm")

---@class FontOption
---@field size integer size of the font (in pt) to use
---@field family string name of the font family to use
local FontOption = {}
FontOption.__index = FontOption

--- Create a new font options instance
---@param sz integer
---@param name string
---@return FontOption
function FontOption:new(sz, name)
	local config = setmetatable({ size = sz, family = name }, self)
	return config
end

--- Apply the font options to the configuration manager
---@param cfg Config
function FontOption:apply(cfg)
	local fontobj = wezterm.font(self.family)
	local fontsz = self.size

	if fontobj == nil then
		error("unknown font name: " .. self.family)
	end

	cfg.font = fontobj
	cfg.font_size = fontsz
end

return FontOption
