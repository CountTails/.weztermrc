local wezterm = require("wezterm")
local options = require("utils.options")
local theme = require("utils.theme")
local platform = require("utils.platform")

local ColorsOption = require("config.colorscheme")
local CursorOption = require("config.cursor")
local FontOption = require("config.typography")
local WindowOptions = require("config.window")
local LauncherOptions = require("config.launch")

local M = {}

--- Creates the appropriate `ColorsOption` instance to configure the wezterm GUI's colorscheme
---@return ColorsOption
M.custom_colorscheme = function()
	local colors = options.appearance.colors
	if theme.active_window_theme() == theme.LIGHT_MODE then
		return ColorsOption:new(colors.scheme.light_mode)
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

--- Creates the appropriate `LauncherOptions` instance to configure the items included in the launcher menu
M.custom_launch_menu = function()
	local launcher = options.process_spawning
	if platform.is_mac() then
		return LauncherOptions:new(launcher.apple)
	elseif platform.is_linux() then
		return LauncherOptions:new(launcher.linux)
	elseif platform.is_win() then
		return LauncherOptions:new(launcher.windows)
	else
		error("custom launch menu: unrecognized platform: " .. wezterm.target_triple)
	end
end

return M
