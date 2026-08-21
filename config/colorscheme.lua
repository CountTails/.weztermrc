local wezterm = require("wezterm")
local options = require("utils.options").appearance.colors

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

local M = {}

---@return ColorsOption
M.init = function()
	if wezterm.gui then
		if wezterm.gui.get_appearance():find("Light") then
			return ColorsOption:new(options.scheme.light_mode)
		end
	end
	return ColorsOption:new(options.scheme.dark_mode)
end

return M
