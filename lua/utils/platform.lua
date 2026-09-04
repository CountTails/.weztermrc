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

--- Returns the height and width of the active screen
---@return integer height
---@return integer width
local function active_resolution()
	local screens = wezterm.gui.screens()
	return screens.active.height, screens.active.width
end

--- Returns the refresh rate of the active screen
---@return integer
local function active_refresh_rate()
	local DEFAULT_FPS = 30
	local screens = wezterm.gui.screens()
	if screens.active.max_fps ~= nil then
		return screens.active.max_fps
	end
	return DEFAULT_FPS
end

--- Returns the DPI of the active screen
---@return integer
local function active_pixel_density()
	local DEFAULT_DPI = 72
	local screens = wezterm.gui.screens()
	if screens.active.effective_dpi ~= nil then
		return screens.active.effective_dpi
	end
	return DEFAULT_DPI
end

M.display = {
	resolution = active_resolution,
	fps = active_refresh_rate,
	dpi = active_pixel_density,
}

return M
