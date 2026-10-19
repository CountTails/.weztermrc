local externalcustomcontents = [[
[metadata]
name = "theme name"
author = "Me, obviously"

[palette]
rosewater = "#dc8a78"
flamingo = "#dd7878"
pink = "#ea76cb"
mauve = "#8839ef"
red = "#d20f39"
maroon = "#e64553"
peach = "#fe640b"
yellow = "#df8e1d"
green = "#40a02b"
teal = "#179299"
sky = "#04a5e5"
sapphire = "#209fb5"
blue = "#1e66f5"
lavender = "#7287fd"
text = "#4c4f69"
subtext1 = "#5c5f77"
subtext0 = "#6c6f85"
overlay2 = "#7c7f93"
overlay1 = "#8c8fa1"
overlay0 = "#9ca0b0"
surface2 = "#acb0be"
surface1 = "#bcc0cc"
surface0 = "#ccd0da"
base =  "#eff1f5"
mantle =  "#e6e9ef"
crust = "#dce0e8"
derived = {color = "palette:mantle", darken = 0.5} # --> compiler resolves color to #e6e9ef then darkens by a factor of 0.5

[scheme]
foreground = "pallete:text" # --> compiler would resolve to "#4c4f69"
background = "pallete:base" # --> compiler would resolve to "#eff1f5"
compose_cursor = "#f2cdcd"
cursor_bg = "#f5e0dc"
cursor_border = "#f5e0dc"
cursor_fg = "#11111b"
selection_fg = {color = "pallete:text", complement = true, desaturate = 0.25} # compiler resolves color to "#4c4f69", computes the complement, and desaturates the complement result
selection_bg = {color = "pallete:base", darken = 0.75, desaturate = 0.25} # compiler resolves color to "#eff1f5", darkens by a factor of 0.75 and desaturates the result
indexed = { 16 = "#fab387", 17 = "#f5e0dc" }
visual_bell = "pallete:surface0"

[scheme.ansi]
black = "palette:surface1"
red = "palette:red"
green = "palette:green"
yellow = "palette:yellow"
blue = "palette:blue"
magenta = "palette:pink"
cyan = "palette:teal"
white = "palette:subtext1"

[scheme.brights]
black = "palette:surface2"
red = "palette:red"
green = "palette:green"
yellow = "palette:yellow"
blue = "palette:blue"
magenta = "palette:pink"
cyan = "palette:teal"
white = "palette:subtext0"

[scheme.tab_bar]
background = "pallete:crust"
inactive_tab_edge = "pallete:surface0"

[scheme.tab_bar.active_tab]
fg_color = "pallete:mauve"
bg_color = "pallete:crust"
intensity = "Normal"
italic = false
strikethrough = false
underline = "None"
]]

local externalcustomparsed = {
	metadata = {
		author = "Me, obviously",
		name = "theme name",
	},
	palette = {
		base = "#eff1f5",
		blue = "#1e66f5",
		crust = "#dce0e8",
		derived = {
			color = "palette:mantle",
			darken = 0.5,
		},
		flamingo = "#dd7878",
		green = "#40a02b",
		lavender = "#7287fd",
		mantle = "#e6e9ef",
		maroon = "#e64553",
		mauve = "#8839ef",
		overlay0 = "#9ca0b0",
		overlay1 = "#8c8fa1",
		overlay2 = "#7c7f93",
		peach = "#fe640b",
		pink = "#ea76cb",
		red = "#d20f39",
		rosewater = "#dc8a78",
		sapphire = "#209fb5",
		sky = "#04a5e5",
		subtext0 = "#6c6f85",
		subtext1 = "#5c5f77",
		surface0 = "#ccd0da",
		surface1 = "#bcc0cc",
		surface2 = "#acb0be",
		teal = "#179299",
		text = "#4c4f69",
		yellow = "#df8e1d",
	},
	scheme = {
		ansi = {
			black = "palette:surface1",
			blue = "palette:blue",
			cyan = "palette:teal",
			green = "palette:green",
			magenta = "palette:pink",
			red = "palette:red",
			white = "palette:subtext1",
			yellow = "palette:yellow",
		},
		background = "pallete:base",
		brights = {
			black = "palette:surface2",
			blue = "palette:blue",
			cyan = "palette:teal",
			green = "palette:green",
			magenta = "palette:pink",
			red = "palette:red",
			white = "palette:subtext0",
			yellow = "palette:yellow",
		},
		compose_cursor = "#f2cdcd",
		cursor_bg = "#f5e0dc",
		cursor_border = "#f5e0dc",
		cursor_fg = "#11111b",
		foreground = "pallete:text",
		indexed = {
			[16] = "#fab387",
			[17] = "#f5e0dc",
		},
		selection_bg = {
			color = "pallete:base",
			darken = 0.75,
			desaturate = 0.25,
		},
		selection_fg = {
			color = "pallete:text",
			complement = true,
			desaturate = 0.25,
		},
		tab_bar = {
			active_tab = {
				bg_color = "pallete:crust",
				fg_color = "pallete:mauve",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			background = "pallete:crust",
			inactive_tab_edge = "pallete:surface0",
		},
		visual_bell = "pallete:surface0",
	},
}

local M = {}

M.colors = {
	externalcustom = {
		contents = externalcustomcontents,
		parsed = externalcustomparsed,
	},
	externalcustombadformat = {
		contents = "not valid TOML",
	},
}

return M
