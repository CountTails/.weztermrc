local colorutils = require("utils.colors")

---@class RawColorOptions
---@field using_builtin_schemes boolean indicates whether a builtin scheme is used or one is derived from the custom palletes
---@field light_mode_theme string name of the colorscheme to use when wezterm is using a light theme
---@field dark_mode_theme string name of the colorscheme to use when wezterm is using a dark theme
---@field light_mode_pallete Pallete the light mode pallete to use when wezterm is using a light theme
---@field dark_mode_pallete Pallete the dark mode pallete to use when wezterm is using a dark theme
---@field light_mode_scheme ColorScheme the custom color scheme to use when wezterm is using a light theme
---@field dark_mode_scheme ColorScheme the custom color scheme to use when wezterm is using a dark theme
local RawColorOptions = {}

--- EDIT this option to dictate whether colors are set using builtin color schemes or custom schemes
---@type boolean
RawColorOptions.using_builtin_schemes = false

--- EDIT this option to specify the builtin scheme to use in light mode
---@type string
RawColorOptions.light_mode_theme = "Catppuccin Latte"

--- EDIT this option to specify the builtin scheme to use in dark mode
---@type string
RawColorOptions.dark_mode_theme = "Catppuccin Mocha"

--- EDIT this option to adjust the color theme used in light mode
---@see utils/colors.lua see the Pallete class for declaring a color pallete
---@type Pallete
RawColorOptions.light_mode_pallete = colorutils.Pallete:new(
	"Catppuccin Latte (Modified)",
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
---@see utils/colors.lua see the Pallete class for declaring a color pallete
---@type Pallete
RawColorOptions.dark_mode_pallete = colorutils.Pallete:new(
	"Catppuccin Mocha (Modified)",
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

--- EDIT this value to adjust the light mode custom colorscheme
---@see utils/colors.lua for the ColorScheme class for declaring a custom colorscheme
---@type ColorScheme
RawColorOptions.light_mode_scheme = colorutils.Scheme
	:builder()
	:with_ansi_colors(
		RawColorOptions.light_mode_pallete:pick_color("surface1"),
		RawColorOptions.light_mode_pallete:pick_color("red"),
		RawColorOptions.light_mode_pallete:pick_color("green"),
		RawColorOptions.light_mode_pallete:pick_color("yellow"),
		RawColorOptions.light_mode_pallete:pick_color("blue"),
		RawColorOptions.light_mode_pallete:pick_color("pink"),
		RawColorOptions.light_mode_pallete:pick_color("teal"),
		RawColorOptions.light_mode_pallete:pick_color("subtext1")
	)
	:with_bright_colors(
		RawColorOptions.light_mode_pallete:pick_color("surface2"),
		RawColorOptions.light_mode_pallete:pick_color("red"),
		RawColorOptions.light_mode_pallete:pick_color("green"),
		RawColorOptions.light_mode_pallete:pick_color("yellow"),
		RawColorOptions.light_mode_pallete:pick_color("blue"),
		RawColorOptions.light_mode_pallete:pick_color("pink"),
		RawColorOptions.light_mode_pallete:pick_color("teal"),
		RawColorOptions.light_mode_pallete:pick_color("subtext0")
	)
	:with_contrast(
		RawColorOptions.light_mode_pallete:pick_color("text"),
		RawColorOptions.light_mode_pallete:pick_color("base")
	)
	:with_cursor_scheme(
		RawColorOptions.light_mode_pallete:pick_color("flamingo"),
		RawColorOptions.light_mode_pallete:pick_color("crust"),
		RawColorOptions.light_mode_pallete:pick_color("flamingo"),
		RawColorOptions.light_mode_pallete:pick_color("flamingo")
	)
	:with_selection_scheme(
		RawColorOptions.light_mode_pallete:pick_color("text"),
		RawColorOptions.light_mode_pallete:pick_color("surface2")
	)
	:with_bars_and_lines_scheme(
		RawColorOptions.light_mode_pallete:pick_color("surface2"),
		RawColorOptions.light_mode_pallete:pick_color("overlay0")
	)
	:with_extra_colors({
		[16] = RawColorOptions.light_mode_pallete:pick_color("peach"),
		[17] = RawColorOptions.light_mode_pallete:pick_color("rosewater"),
	})
	:with_tab_state_active(
		RawColorOptions.light_mode_pallete:pick_color("crust"),
		RawColorOptions.light_mode_pallete:pick_color("mauve"),
		"Normal",
		false,
		false,
		"None"
	)
	:with_tab_state_inactive(
		RawColorOptions.light_mode_pallete:pick_color("text"),
		RawColorOptions.light_mode_pallete:pick_color("mantle"),
		"Normal",
		false,
		false,
		"None"
	)
	:with_tab_state_inactive_hover(
		RawColorOptions.light_mode_pallete:pick_color("text"),
		RawColorOptions.light_mode_pallete:pick_color("base"),
		"Normal",
		false,
		false,
		"None"
	)
	:with_tab_state_new_tab(
		RawColorOptions.light_mode_pallete:pick_color("text"),
		RawColorOptions.light_mode_pallete:pick_color("surface0"),
		"Normal",
		false,
		false,
		"None"
	)
	:with_tab_state_new_tab_hover(
		RawColorOptions.light_mode_pallete:pick_color("text"),
		RawColorOptions.light_mode_pallete:pick_color("surface1"),
		"Normal",
		false,
		false,
		"None"
	)
	:with_tab_bar_scheme(
		RawColorOptions.light_mode_pallete:pick_color("crust"),
		RawColorOptions.light_mode_pallete:pick_color("surface0")
	)
	:with_visual_bell(RawColorOptions.light_mode_pallete:pick_color("surface0"))

--- EDIT this value to adjust the dark mode custom colorscheme
---@see utils/colors.lua for the ColorScheme class for declaring a custom colorscheme
---@type ColorScheme
RawColorOptions.dark_mode_scheme = colorutils.Scheme
	:builder()
	:with_ansi_colors(
		RawColorOptions.dark_mode_pallete:pick_color("surface1"),
		RawColorOptions.dark_mode_pallete:pick_color("red"),
		RawColorOptions.dark_mode_pallete:pick_color("green"),
		RawColorOptions.dark_mode_pallete:pick_color("yellow"),
		RawColorOptions.dark_mode_pallete:pick_color("blue"),
		RawColorOptions.dark_mode_pallete:pick_color("pink"),
		RawColorOptions.dark_mode_pallete:pick_color("teal"),
		RawColorOptions.dark_mode_pallete:pick_color("subtext1")
	)
	:with_bright_colors(
		RawColorOptions.dark_mode_pallete:pick_color("surface2"),
		RawColorOptions.dark_mode_pallete:pick_color("red"),
		RawColorOptions.dark_mode_pallete:pick_color("green"),
		RawColorOptions.dark_mode_pallete:pick_color("yellow"),
		RawColorOptions.dark_mode_pallete:pick_color("blue"),
		RawColorOptions.dark_mode_pallete:pick_color("pink"),
		RawColorOptions.dark_mode_pallete:pick_color("teal"),
		RawColorOptions.dark_mode_pallete:pick_color("subtext0")
	)
	:with_contrast(
		RawColorOptions.dark_mode_pallete:pick_color("text"),
		RawColorOptions.dark_mode_pallete:pick_color("base")
	)
	:with_cursor_scheme(
		RawColorOptions.dark_mode_pallete:pick_color("flamingo"),
		RawColorOptions.dark_mode_pallete:pick_color("crust"),
		RawColorOptions.dark_mode_pallete:pick_color("flamingo"),
		RawColorOptions.dark_mode_pallete:pick_color("flamingo")
	)
	:with_selection_scheme(
		RawColorOptions.dark_mode_pallete:pick_color("text"),
		RawColorOptions.dark_mode_pallete:pick_color("surface2")
	)
	:with_bars_and_lines_scheme(
		RawColorOptions.dark_mode_pallete:pick_color("surface2"),
		RawColorOptions.dark_mode_pallete:pick_color("overlay0")
	)
	:with_extra_colors({
		[16] = RawColorOptions.dark_mode_pallete:pick_color("peach"),
		[17] = RawColorOptions.dark_mode_pallete:pick_color("rosewater"),
	})
	:with_tab_state_active(
		RawColorOptions.dark_mode_pallete:pick_color("crust"),
		RawColorOptions.dark_mode_pallete:pick_color("mauve"),
		"Normal",
		false,
		false,
		"None"
	)
	:with_tab_state_inactive(
		RawColorOptions.dark_mode_pallete:pick_color("text"),
		RawColorOptions.dark_mode_pallete:pick_color("mantle"),
		"Normal",
		false,
		false,
		"None"
	)
	:with_tab_state_inactive_hover(
		RawColorOptions.dark_mode_pallete:pick_color("text"),
		RawColorOptions.dark_mode_pallete:pick_color("base"),
		"Normal",
		false,
		false,
		"None"
	)
	:with_tab_state_new_tab(
		RawColorOptions.dark_mode_pallete:pick_color("text"),
		RawColorOptions.dark_mode_pallete:pick_color("surface0"),
		"Normal",
		false,
		false,
		"None"
	)
	:with_tab_state_new_tab_hover(
		RawColorOptions.dark_mode_pallete:pick_color("text"),
		RawColorOptions.dark_mode_pallete:pick_color("surface1"),
		"Normal",
		false,
		false,
		"None"
	)
	:with_tab_bar_scheme(
		RawColorOptions.dark_mode_pallete:pick_color("crust"),
		RawColorOptions.dark_mode_pallete:pick_color("surface0")
	)
	:with_visual_bell(RawColorOptions.dark_mode_pallete:pick_color("surface0"))

return RawColorOptions
