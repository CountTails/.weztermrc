local M = {}

M.appearance = {
	colors = {
		scheme = {
			light_mode = "Catppuccin Latte",
			dark_mode = "Catppuccin Mocha",
		},
	},
	font = {
		family = "CommitMono Nerd Font Mono",
		size = 20,
	},
	cursor = {
		style = "BlinkingBar",
		blink = {
			rate = 750,
			ease_in = "Ease",
			ease_out = "Linear",
		},
	},
}

M.window = {
	padding = {
		left = "1cell",
		right = "1cell",
		top = 0,
		bottom = 0,
	},
	decorations = "TITLE | RESIZE",
	content_alignment = {
		horizontal = "Center",
		vertical = "Center",
	},
	close_confirmation = "NeverPrompt",
	border = {
		border_left_width = "1cell",
		border_right_width = "1cell",
		border_bottom_height = "0.5cell",
		border_top_height = "0.0cell",
		scheme = {
			light_mode = {
				border_bottom_color = "#dce0e8",
				border_left_color = "#dce0e8",
				border_right_color = "#dce0e8",
			},
			dark_mode = {
				border_bottom_color = "#11111b",
				border_left_color = "#11111b",
				border_right_color = "#11111b",
			},
		},
	},
	font = {
		size = 14,
		family = "Monaco",
	},
}

return M
