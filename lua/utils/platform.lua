local wezterm = require("wezterm")

local M = {}

--- Returns a boolean value indicating whether the current OS running wezterm is windows
---@return boolean
local function is_win()
	return string.find(wezterm.target_triple, "windows") ~= nil
end

--- Returns a boolean value indicating whether the current OS running wezterm is macOS
---@return boolean
local function is_mac()
	return string.find(wezterm.target_triple, "apple") ~= nil
end

--- Returns a boolean value indicating whether the current OS running wezterm is Linux
---@return boolean
local function is_linux()
	return string.find(wezterm.target_triple, "linux") ~= nil
end

M.os = {
	is_win = is_win,
	is_mac = is_mac,
	is_linux = is_linux,
}

---@alias WindowTheme integer value representing the window theme
local light_mode = 0
local dark_mode = 1

--- Returns the currently active window theme
---@return WindowTheme
local function active_window_theme()
	if wezterm.gui then
		if wezterm.gui.get_appearance():find("Light") then
			return light_mode
		end
	end
	return dark_mode
end

M.theme = {
	LIGHT_MODE = light_mode,
	DARK_MODE = dark_mode,
	current_window_appearance = active_window_theme,
}

return M
