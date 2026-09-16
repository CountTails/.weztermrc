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
---@private
local LIGHT_MODE = 0
local DARK_MODE = 1

--- Returns the currently active window theme
---@return WindowTheme
---@private
local function active_window_theme()
	if wezterm.gui then
		if wezterm.gui.get_appearance():find("Light") then
			return LIGHT_MODE
		end
	end
	return DARK_MODE
end

local function dark_appearance_active()
	return active_window_theme() == DARK_MODE
end

local function light_appearance_active()
	return active_window_theme() == LIGHT_MODE
end

M.theme = {
	is_dark_mode = dark_appearance_active,
	is_light_mode = light_appearance_active,
}

return M
