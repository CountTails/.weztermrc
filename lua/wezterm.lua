require("events")

local config = require("utils.init")
local settings = require("runtime.setup")

return config:init():with(settings.custom_font_settings()):with(settings.custom_color_scheme()):configure()
