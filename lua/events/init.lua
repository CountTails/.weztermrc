local wezterm = require("wezterm")
local effective_font_opts = require("core.window.font")

wezterm.on("window-resized", function(window, _)
	local dimensions = window:get_dimensions()
	effective_font_opts:compute_effective_font_size(dimensions.pixel_width)
	local font_size = effective_font_opts.font_size

	wezterm.log_info(
		string.format("Adjust font size to %fpt for window of width %d", font_size, dimensions.pixel_width)
	)
	local overrides = window:get_config_overrides() or {}
	if overrides.font_size == font_size then
		return
	end

	overrides.font_size = font_size
	window:set_config_overrides(overrides)
end)
