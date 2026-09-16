---@class RawColorOptions
---@field light_mode_theme string the light mode theme to use when wezterm is using a light theme
---@field dark_mode_theme string the dark mode theme to use when wezterm is using a dark theme
---@field light_mode_border_color_hex string the light mode color to use for the window borders
---@field dark_mode_border_color_hex string the dark mode color to use for the window borders
local RawColorOptions = {}

--- EDIT this option to adjust the color theme used in light mode
---@type string
RawColorOptions.light_mode_theme = "Catppuccin Latte"

--- EDIT this option to adjust the color theme used in dark mode
---@type string
RawColorOptions.dark_mode_theme = "Catppuccin Mocha"

--- EDIT this option to adjust the border color in light theme
---@type string
RawColorOptions.light_mode_border_color_hex = "#dce0e8"

--- EDIT this option to adjust the border color in dark theme
---@type string
RawColorOptions.dark_mode_border_color_hex = "#11111b"

return RawColorOptions
