local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.font_size = 20

config.font = wezterm.font("AnnotationM Nerd Font Mono")
config.color_scheme = "Catppuccin Mocha"

return config
