local colorutils = require("utils.colors")

---@class RawColorOptions
---@field light_mode_theme Pallete the light mode theme to use when wezterm is using a light theme
---@field dark_mode_theme Pallete the dark mode theme to use when wezterm is using a dark theme
local RawColorOptions = {}

--- EDIT this option to adjust the color theme used in light mode
---@type Pallete
RawColorOptions.light_mode_theme = colorutils.Pallete:new(
	"Catppuccin Latte",
	colorutils.Color:new("rosewater", "#dc8a78"),
	colorutils.Color:new("flamingo", "#dd7878"),
	colorutils.Color:new("pink", "#ea76cb"),
	colorutils.Color:new("mauve", "#8839ef"),
	colorutils.Color:new("red", "#d20f39"),
	colorutils.Color:new("maroon", "#e64553"),
	colorutils.Color:new("peach", "#fe640b"),
	colorutils.Color:new("yellow", "#df8e1d"),
	colorutils.Color:new("green", "#40a02b"),
	colorutils.Color:new("teal", "#179299"),
	colorutils.Color:new("sky", "#04a5e5"),
	colorutils.Color:new("sapphire", "#209fb5"),
	colorutils.Color:new("blue", "#1e66f5"),
	colorutils.Color:new("lavender", "#7287fd"),
	colorutils.Color:new("text", "#4c4f69"),
	colorutils.Color:new("subtext1", "#5c5f77"),
	colorutils.Color:new("subtext0", "#6c6f85"),
	colorutils.Color:new("overlay2", "#7c7f93"),
	colorutils.Color:new("overlay1", "#8c8fa1"),
	colorutils.Color:new("overlay0", "#9ca0b0"),
	colorutils.Color:new("surface2", "#acb0be"),
	colorutils.Color:new("surface1", "#bcc0cc"),
	colorutils.Color:new("surface0", "#ccd0da"),
	colorutils.Color:new("base", "#eff1f5"),
	colorutils.Color:new("mantle", "#e6e9ef"),
	colorutils.Color:new("crust", "#dce0e8")
)

--- EDIT this option to adjust the color theme used in dark mode
---@type Pallete
RawColorOptions.dark_mode_theme = colorutils.Pallete:new(
	"Catppuccin Mocha",
	colorutils.Color:new("rosewater", "#f5e0dc"),
	colorutils.Color:new("flamingo", "#f2cdcd"),
	colorutils.Color:new("pink", "#f5c2e7"),
	colorutils.Color:new("mauve", "#cba6f7"),
	colorutils.Color:new("red", "#f38ba8"),
	colorutils.Color:new("maroon", "#eba0ac"),
	colorutils.Color:new("peach", "#fab387"),
	colorutils.Color:new("yellow", "#f9e2af"),
	colorutils.Color:new("green", "#a6e3a1"),
	colorutils.Color:new("teal", "#94e2d5"),
	colorutils.Color:new("sky", "#89dceb"),
	colorutils.Color:new("sapphire", "#74c7ec"),
	colorutils.Color:new("blue", "#89b4fa"),
	colorutils.Color:new("lavender", "#b4befe"),
	colorutils.Color:new("text", "#cdd6f4"),
	colorutils.Color:new("subtext1", "#bac2de"),
	colorutils.Color:new("subtext0", "#a6adc8"),
	colorutils.Color:new("overlay2", "#9399b2"),
	colorutils.Color:new("overlay1", "#7f849c"),
	colorutils.Color:new("overlay0", "#6c7086"),
	colorutils.Color:new("surface2", "#585b70"),
	colorutils.Color:new("surface1", "#45475a"),
	colorutils.Color:new("surface0", "#313244"),
	colorutils.Color:new("base", "#1e1e2e"),
	colorutils.Color:new("mantle", "#181825"),
	colorutils.Color:new("crust", "#11111b")
)

return RawColorOptions
