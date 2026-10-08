local wezterm = require("wezterm")
local colorutils = require("utils.colors")

---@class RawColorOptions
---@field using_builtin_schemes boolean indicates whether a builtin scheme is used or one is derived from the custom palletes
---@field light_mode_theme string name of the colorscheme to use when wezterm is using a light theme
---@field dark_mode_theme string name of the colorscheme to use when wezterm is using a dark theme
local RawColorOptions = {}

return RawColorOptions
