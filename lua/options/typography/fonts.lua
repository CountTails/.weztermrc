local wezterm = require("wezterm")

---@class RawFontOptions
---@field terminal_font string the font name to use for terminal applications
---@field decorative_font string the font name to use for decorative functions
---@field base_font_size integer the base font size to use for the wezterm configuration
---@field base_display_width integer the reference display width for the base font size
---@field min_font_size_allowed integer the minimum size the font should be allowed to shrink to
---@field max_font_size_allowed integer the maximum size the font should be allowed to grow to
---@field windows_font_dirs string[] list of directories to lookup fonts on a Windows system
---@field macos_font_dirs string[] list of directories to lookup fonts on a macOS system
---@field linux_font_dirs string[] list of directories to lookup fonts on a Linux system
---@field use_system_fonts_only boolean rule for determining how fonts are located and loaded
local RawFontOptions = {}

--- EDIT this value to adjust the base size
---@type integer the base size font to use for the wezterm configuration
RawFontOptions.base_font_size = 18

--- EDIT this value to adjust the reference display width
---@type integer the reference display width
RawFontOptions.base_display_width = 1440

--- EDIT this value to adjust the min font size
---@type integer smallest font size allowed
RawFontOptions.min_font_size_allowed = 14

--- EDIT this value to adjust the max font size
---@type integer largest font size allowed
RawFontOptions.max_font_size_allowed = 24

--- EDIT this value to adjust the font family used within wezterm panes
---@type string the font family to use for terminal applications
RawFontOptions.terminal_font = "CommitMono Nerd Font Mono"

--- EDIT this value to adjust the font family used for wezterm decorative purposes
---@type string the font family to use for decorative functions
RawFontOptions.decorative_font = "Hurmit Nerd Font Mono"

--- EDIT this value to adjust the rule for locating and loading fonts
---@type boolean true means that font dirs (specified below) will be ignored; false means to exclusively used the dirs specified below
RawFontOptions.use_system_fonts_only = false

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
