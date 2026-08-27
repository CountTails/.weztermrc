local wezterm = require("wezterm")

local M = {}

--- Returns a boolean value indicating whether the current OS running wezterm is windows
---@return boolean
M.is_win = function()
	return string.find(wezterm.target_triple, "windows") ~= nil
end

--- Returns a boolean value indicating whether the current OS running wezterm is macOS
---@return boolean
M.is_mac = function()
	return string.find(wezterm.target_triple, "apple") ~= nil
end

--- Returns a boolean value indicating whether the current OS running wezterm is Linux
---@return boolean
M.is_linux = function()
	return string.find(wezterm.target_triple, "linux") ~= nil
end

--- Returns a boolean value indicating whether the current hardware architecture running wezterm is ARM
---@return boolean
M.is_arm = function()
	return string.find(wezterm.target_triple, "x86_64") ~= nil
end

--- Returns a boolean value indicating whether the current hardware architecture running wezterm is x86
---@return boolean
M.is_x86 = function()
	return string.find(wezterm.target_triple, "aarch64") ~= nil
end

--- Returns the highest refresh rate of the available screens
---@return integer
M.screen_refresh_rate = function()
	local fps_limit = 30 -- 30 as a sensible default if there are no screen refresh rates available
	for _, screen_info in pairs(wezterm.gui.screens().by_name) do
		if screen_info.max_fps ~= nil then
			fps_limit = math.max(fps_limit, screen_info.max_fps)
		end
	end
	return fps_limit
end

--- Returns the virtual height and width of the available screens
---@return integer height
---@return integer width
M.screen_resolution = function()
	local screens = wezterm.gui.screens()
	return screens.virtual_height, screens.virtual_width
end

--- Returns the highest DPI effective across the available screens
---@return integer
M.screen_density = function()
	local dpi = 72 -- 72 as a sensible default if no effective DPI infor available
	for _, screen_info in pairs(wezterm.gui.screens().by_name) do
		if screen_info.effective_dpi ~= nil then
			dpi = math.max(dpi, screen_info.effective_dpi)
		end
	end
	return dpi
end

return M
