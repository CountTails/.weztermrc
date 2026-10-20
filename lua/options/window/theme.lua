---@alias ThemeVariants {light:string,dark:string}
---@alias ThemeExtras table<string, string>
---@alias ThemeOptionValue string|ThemeVariants|ThemeExtras
---{
---   label = "string for select/display",
---		variants = { --- table mapping appearance keys to sources or a single source if no applicable variants
---			light = "construction_method:construction_argument",
---			dark = "construction_method:construction_argument",
---		},
---		extras {} --- mapping of additional color assignments that are not part of the color scheme (such as command palette colors or border colors)
---}

---@class RawThemeOptions
---@field schemes {label:string, variants:ThemeVariants, extras:ThemeExtras}[]
---@field initcolors 'index'|'random'|'default'
---@field initcolorsidx integer
local RawThemeOptions = {}

--- EDIT this field to adjust the available schemes for the configuration
---@type {label:string, variants:ThemeVariants, extras:ThemeExtras}[]
RawThemeOptions.schemes = {
	{
		label = "Catppuccin",
		variants = {
			light = "builtin:Catppuccin Latte",
			dark = "builtin:Catppuccin Mocha",
		},
		extras = {
			command_palette_bg_color = "scheme:background",
			border_color = "scheme:tab_bar.background",
		},
	},
	{
		label = "My Base 16 custom",
		variants = {
			light = "externalyaml:colors/base16-test-light.yaml",
			dark = "externalyaml:colors/base16-test-dark.yaml",
		},
		extras = {},
	},
	{
		label = "My teminal.sexy custom",
		variants = {
			light = "externaljson:colors/tsexy-test-light.json",
			dark = "externaljson:colors/tsexy-test-dark.json",
		},
		extras = {},
	},
	{
		label = "My programmatic custom",
		variants = {
			light = "externalcustom:colors/customtheme.toml", --- set both light and dark to the same colorscheme to disable dynamic colorschemes
			dark = "externalcustom:colors/customtheme.toml",
		},
		extras = {
			border_color = "palette:derived",
		},
	},
}

--- EDIT this field to adjust how the initial scheme for the wezterm window is decided
---   - index: use the `initcolorsidx` field to choose a color scheme to load initially
---   - random: collect all random eligible themes from the schemes list and choose a random one initially
---   - default: skip the schemes list and load the default wezterm theme
---@type 'index'|'random'|'default'
RawThemeOptions.initcolors = "index"

--- EDIT this field to adjust the index for scheme lookup when `initcolors` == "index"\
---@type integer
RawThemeOptions.initcolorsidx = 1

return RawThemeOptions
