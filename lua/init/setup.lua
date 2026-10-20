local ActiveFontOpts = require("init.window.typography")
local ActiveThemeOpts = require("init.window.theme")
local ActiveCursorOpts = require("init.window.cursor")

local M = {}

--- Creates the `ActiveFontOptions` derived from the effective font options table
---@return ActiveFontOptions
M.custom_font_settings = function()
	return ActiveFontOpts:from_effective_table(require("core.window.typography"))
end

--- Creates the `ActiveColorSchemeOptions` derived from the effective color scheme table
---@return ActiveThemeOptions
M.custom_color_scheme = function()
	return ActiveThemeOpts:from_effective_table(require("core.window.theme"))
end

--- Creates the `ActiveCursorOptions` derived from the effective cursor options table
---@return ActiveCursorOptions
M.custom_cursor_behavior = function()
	return ActiveCursorOpts:from_effective_table(require("core.window.cursor"))
end

return M
