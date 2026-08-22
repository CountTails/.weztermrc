local wezterm = require("wezterm")
local options = require("utils.options")

local ColorsOption = require("config.colorscheme")
local CursorOption = require("config.cursor")
local FontOption = require("config.typography")
local WindowOptions = require("config.window")

local M = {}

--- Creates the appropriate `ColorsOption` instance to configure the wezterm GUI's colorscheme
---@return ColorsOption
M.custom_colorscheme = function()
	local colors = options.appearance.colors
	if wezterm.gui then
		if wezterm.gui.get_appearance():find("Light") then
			return ColorsOption:new(colors.scheme.light_mode)
		end
	end
	return ColorsOption:new(colors.scheme.dark_mode)
end

--- Creates the appropriate `FontOption` instance to configure the font used by the wezterm GUI
---@return FontOption
M.custom_typeface = function()
	local font = options.appearance.font
	return FontOption:new(font.size, font.family)
end

--- Creates the appropriate `CursorOption` instance to configure the way the cursor behaves in the wezterm GUI
---@return CursorOption
M.custom_cursor_behavior = function()
	local cursor = options.appearance.cursor
	return CursorOption:new(cursor.style, cursor.blink.rate, cursor.blink.ease_in, cursor.blink.ease_out)
end

--- Creates the appropriate `WindowOptions` instance to configure the way the window looks in the wezterm GUI
---@return WindowOptions
M.custom_window_options = function()
	local window = options.window
	return WindowOptions:new(window)
end

return M
