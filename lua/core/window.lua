local wezterm = require("wezterm")
local theme = require("utils.theme")

---@class WindowOptions
---@field options table options that fit under the `window_frame` portion of the wezterm configuration
local WindowOptions = {}
WindowOptions.__index = WindowOptions

--- Create a new `WindowOptions` instance
---@param opts table
---@return WindowOptions
function WindowOptions:new(opts)
	local config = setmetatable({
		options = opts,
	}, self)
	return config
end

--- Apply the `WindowOptions` to the configuration manager
---@param cfg table
function WindowOptions:apply(cfg)
	cfg.window_frame = self:derive_frame_options()
	self:configure_window_options(cfg)
end

--- Helper function to derive the `window_frame` configuration option from the provided window options
---@return table
---@private
function WindowOptions:derive_frame_options()
	local window_frame = {}
	window_frame.border_left_width = self.options.border.border_left_width
	window_frame.border_right_width = self.options.border.border_right_width
	window_frame.border_top_height = self.options.border.border_top_height
	window_frame.border_bottom_height = self.options.border.border_bottom_height
	window_frame.font = wezterm.font(self.options.font.family)
	window_frame.font_size = self.options.font.size

	if theme.active_window_theme() == theme.LIGHT_MODE then
		window_frame.border_bottom_color = self.options.border.scheme.light_mode.border_bottom_color
		window_frame.border_left_color = self.options.border.scheme.light_mode.border_left_color
		window_frame.border_right_color = self.options.border.scheme.light_mode.border_right_color
	else
		window_frame.border_bottom_color = self.options.border.scheme.dark_mode.border_bottom_color
		window_frame.border_left_color = self.options.border.scheme.dark_mode.border_left_color
		window_frame.border_right_color = self.options.border.scheme.dark_mode.border_right_color
	end

	return window_frame
end

--- Helper function to derive window configuration option from the provide window options
---@param cfg table
---@private
function WindowOptions:configure_window_options(cfg)
	cfg.window_close_confirmation = self.options.close_confirmation
	cfg.window_content_alignment = self.options.content_alignment
	cfg.window_decorations = self.options.decorations
	cfg.window_padding = self.options.padding
end

return WindowOptions
