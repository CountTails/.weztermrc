local wezterm = require("wezterm")

---@class RawFontOptions
---@field desired_fonts string[] list of fonts to try to resolve for terminal text
---@field base_font_size integer the base font size to use for the wezterm configuration
---@field windows_font_dirs string[] list of directories to lookup fonts on a Windows system
---@field macos_font_dirs string[] list of directories to lookup fonts on a macOS system
---@field linux_font_dirs string[] list of directories to lookup fonts on a Linux system
---@field font_locator string rule for determining how fonts are located and loaded
local RawFontOptions = {}

--- EDIT this value to adjust the base size
---@type integer the base size font to use for the wezterm configuration
RawFontOptions.base_font_size = 18

--- EDIT this value to adjust the fonts to choose from
---@type string[] list of fonts to try to resolve for terminal text
RawFontOptions.desired_fonts = {
	"CommitMono Nerd Font Mono",
	"Hurmit Nerd Font Mono",
}

--- EDIT this value to adjust the rule for locating and loading fonts
---@type "ConfigDirsOnly"|nil
RawFontOptions.font_locator = "ConfigDirsOnly"

--- EDIT this value to adjust where fonts are looked up on Windows systems
---@type string[]
RawFontOptions.windows_font_dirs = {
	"C:\\Windows\\Fonts",
}

--- EDIT this value to adjust where fonts are looked up on macOS systems
---@type string[]
RawFontOptions.macos_font_dirs = {
	"/System/Library/Fonts",
	"/Library/Fonts",
	wezterm.home_dir .. "/Library/Fonts",
}

--- EDIT this value to adjust where fonts are looked up on Linux systems
---@type string[]
RawFontOptions.linux_font_dirs = {
	"/usr/share/fonts",
	"/usr/local/share/fonts",
	wezterm.home_dir .. "/.local/share/fonts",
}

return RawFontOptions
