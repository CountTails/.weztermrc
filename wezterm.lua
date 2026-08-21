local config = require("utils.init")

return config
	:init()
	:with(require("config.typography").init())
	:with(require("config.colorscheme").init())
	:with(require("config.cursor").init())
	:configure()
