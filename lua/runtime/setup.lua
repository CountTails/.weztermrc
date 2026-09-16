local ActiveFontOpts = require("runtime.typography.fonts")
local ActiveColorSchemeOpts = require("runtime.window.colorscheme")

local M = {}

--- Creates the `ActiveFontOptions` derived from the effective font options table
---@return ActiveFontOptions
M.custom_font_settings = function()
	return ActiveFontOpts:from_effective_table(require("effective.typography.fonts"))
end

--- Creates the `ActiveColorSchemeOptions` derived from the effective color scheme table
---@return ActiveColorSchemeOptions
M.custom_color_scheme = function()
	return ActiveColorSchemeOpts:from_effective_table(require("effective.window.colorscheme"))
end

return M
