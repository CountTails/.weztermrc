local ActiveFontOpts = require("init.typography.fonts")
local ActiveColorSchemeOpts = require("init.window.colorscheme")
local ActiveCursorOpts = require("init.window.cursor")

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

--- Creates the `ActiveCursorOptions` derived from the effective cursor options table
---@return ActiveCursorOptions
M.custom_cursor_behavior = function()
	return ActiveCursorOpts:from_effective_table(require("effective.window.cursor"))
end

return M
