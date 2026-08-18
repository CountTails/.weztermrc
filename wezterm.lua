local config = require("utils.init")

return config
	:init()
	:with(require("config.typography"):new(20, "AnnotationM Nerd Font Mono"))
	:with(require("config.colorscheme"):new("Catppuccin Mocha"))
	:configure()
