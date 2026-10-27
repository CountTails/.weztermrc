---@alias ThemeVariant {external: boolean, source: string}
---@alias ThemeVariants {light:ThemeVariant,dark:ThemeVariant}
---@alias ThemeExtras table<string, string>
---@alias ThemeOptionValue string|ThemeVariants|ThemeExtras
---{
---   label = "string for select/display",
---		variants = { --- table mapping appearance keys to sources or a single source if no applicable variants
---			light = {
---			  external = true|false, --- colorscheme included with wezterm?
---			  source = "construction_method:construction_argument"
---			},
---			dark = {
---			  external = true|false,
---			  source = "construction_method:construction_argument",
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
			light = {
				external = false,
				source = "builtin:Catppuccin Latte",
			},
			dark = {
				external = false,
				source = "builtin:Catppuccin Mocha",
			},
		},
		extras = {
			command_palette_bg_color = "scheme:background",
			border_color = "scheme:tab_bar.background",
		},
	},
	{
		label = "My Base 16 custom",
		variants = {
			light = {
				external = true,
				source = "externalyaml:base16-test-light.yaml",
			},
			dark = {
				external = true,
				source = "externalyaml:base16-test-dark.yaml",
			},
		},
		extras = {},
	},
	{
		label = "My teminal.sexy custom",
		variants = {
			light = {
				external = true,
				source = "externaljson:tsexy-test-light.json",
			},
			dark = {
				external = true,
				source = "externaljson:tsexy-test-dark.json",
			},
		},
		extras = {},
	},
	{
		label = "My programmatic custom",
		variants = {
			light = {
				external = true,
				source = "externalcustom:customtheme.toml",
			},
			dark = {
				external = true,
				source = "externalcustom:customtheme.toml",
			},
			--- set both light and dark to the same colorscheme to disable dynamic colorschemes
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
