local wezterm = require("wezterm")

---@class ColorsOption
---@field scheme string name of the colorscheme to use
local ColorsOption = {}
ColorsOption.__index = ColorsOption

--- Create a new colors options instance
---@param colors string
---@return ColorsOption
function ColorsOption:new(colors)
	local config = setmetatable({ scheme = colors }, self)
	return config
end

--- Apply the colors options to the configuration manager
---@param cfg table
function ColorsOption:apply(cfg)
	local availableSchemes = wezterm.color.get_builtin_schemes()
	if availableSchemes[self.scheme] == nil then
		error("unknown color scheme: " .. self.scheme)
	end
	cfg.color_scheme = self.scheme
end

return ColorsOption
