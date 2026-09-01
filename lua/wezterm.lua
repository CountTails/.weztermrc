local config = require("utils.init")
local settings = require("options.setup")

return config
	:init()
	:with(settings.custom_colorscheme())
	:with(settings.custom_typeface())
	:with(settings.custom_cursor_behavior())
	:with(settings.custom_window_options())
	:with(settings.custom_launch_menu())
	:configure()
