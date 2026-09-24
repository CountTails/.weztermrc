require("events")

local config = require("utils.configmanager")
local settings = require("init.setup")

return config
	:init()
	:with(settings.custom_font_settings())
	:with(settings.custom_color_scheme())
	:with(settings.custom_cursor_behavior())
	:configure()
