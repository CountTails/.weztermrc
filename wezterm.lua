local wezterm = require("wezterm")
local config = require("utils.init")

---config.font_size = 20
---config.font = wezterm.font("AnnotationM Nerd Font Mono")
return config
	:init()
	:with(require("config.typography"):new(20, "AnnotationM Nerd Font Mono"))
	:with(require("config.colorscheme"):new("Catppuccin Mocha")).options
