local wezterm = require("wezterm")
local platform = require("utils.platform")

local M = {}

--- EDIT this value to adjust the fonts to choose from
---@type string[] list of fonts to try to resolve for terminal text
M.fonts = {
	"CommitMono Nerd Font Mono",
	"Hurmit Nerd Font Mono",
}

--- EDIT this value to adjust the base size
---@type integer the base size font to use for the wezterm configuration
M.base_size = 16

---@type string[] list of directories to lookup fonts from
M.font_locations = {}

--- EDIT the `table.insert` lines to add/remove/modify the directories that are used for font resolution
if platform.is_mac() then
	table.insert(M.font_locations, "/System/Library/Fonts")
	table.insert(M.font_locations, "/Library/Fonts")
	table.insert(M.font_locations, wezterm.home_dir .. "/Library/Fonts")
elseif platform.is_linux() then
	table.insert(M.font_locations, "/usr/share/fonts")
	table.insert(M.font_locations, "/usr/local/share/fonts")
	table.insert(M.font_locations, wezterm.home_dir .. "/.local/share/fonts")
elseif platform.is_win() then
	table.insert(M.font_locations, "C:\\Windows\\Fonts")
end

return M
