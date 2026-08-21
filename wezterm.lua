local config = require("utils.init")
local settings = require("config.setup")

return config
	:init()
	:with(settings.custom_colorscheme())
	:with(settings.custom_typeface())
	:with(settings.custom_cursor_behavior())
	:configure()
