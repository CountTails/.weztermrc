local wezterm = require("wezterm")

---@class ColorsOption
---@field scheme string name of the colorscheme to use
local Colors = {}
Colors.__index = Colors

--- Create a new colors options instance
---@param colors string
---@return ColorsOption
function Colors:new(colors)
	local config = setmetatable({ scheme = colors }, self)
	return config
end

--- Apply the colors options to the configuration manager
---@param cfg Config
function Colors:apply(cfg)
	local availableSchemes = wezterm.color.get_builtin_schemes()
	if availableSchemes[self.scheme] == nil then
		error("unknown color scheme: " .. self.scheme)
	end
	cfg.color_scheme = self.scheme
end

return Colors
