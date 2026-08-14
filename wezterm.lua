local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.font_size = 16
config.font = wezterm.font("ComicShannsMono Nerd Font Mono")
config.color_scheme = "Catppuccin Mocha"

return config
