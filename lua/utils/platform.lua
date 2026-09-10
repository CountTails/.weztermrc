local wezterm = require("wezterm")

local DEFAULT_DPI = 72
local DEFAULT_FPS = 30

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
	local screens = wezterm.gui.screens()
	if screens.active.max_fps ~= nil then
		return screens.active.max_fps
	end
	return DEFAULT_FPS
end

--- Returns the DPI of the active screen
---@return integer
local function active_pixel_density()
	local screens = wezterm.gui.screens()
	if screens.active.effective_dpi ~= nil then
		return screens.active.effective_dpi
	end
	return DEFAULT_DPI
end

--- Returns the font size to use in the runtime environment
---@param base_size integer the base font size to base the computed size off of
---@return integer
local function calculate_scaled_fontsize(base_size)
	local effective_dpi = active_pixel_density()
	local desired_dpi = DEFAULT_DPI
	local scaling_factor = desired_dpi / effective_dpi
	return math.floor(base_size * scaling_factor)
end

M.display = {
	resolution = active_resolution,
	fps = active_refresh_rate,
	dpi = active_pixel_density,
	scale_font_size = calculate_scaled_fontsize,
}

return M
