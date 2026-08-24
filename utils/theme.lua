local wezterm = require("wezterm")

local M = {}

---@alias SelectedWindowTheme integer values representing window them options
M.LIGHT_MODE = 0
M.DARK_MODE = 1

--- Determines the active window color environement (i.e. light vs. dark mode)
---@return SelectedWindowTheme
M.active_window_theme = function()
	if wezterm.gui then
		if wezterm.gui.get_appearance():find("Light") then
			return M.LIGHT_MODE
		end
	end
	return M.DARK_MODE
end

return M
