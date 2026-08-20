local config = require("utils.init")

return config
	:init()
	:with(require("config.typography"):new(20, "CommitMono Nerd Font Mono"))
	:with(require("config.colorscheme"):new("Catppuccin Mocha"))
	:with(require("config.cursor"):new("BlinkingBar", 750, "Ease", "Linear"))
	:configure()
