local wezterm = require("wezterm")

---@class WindowOptions
---@field padding table controls that amount of padding between the window border and the terminal cells
---@field decorations string configures whether the window has a title bar and/or resizeable border
---@field content_alignment table controls the alignment of the terminal cells inside the window (nightly build required)
---@field close_confirmation string configures whether to display a confirmation prompt when the window is closed
---@field frames table customize colors of the window frame
local WindowOptions = {}
WindowOptions.__index = WindowOptions

--- Create a new `WindowOptions` instance
---@param opts table
---@return WindowOptions
function WindowOptions:new(opts)
	local config = setmetatable({
		padding = opts.padding,
		decorations = opts.decorations,
		content_alignment = opts.content_alignment,
		close_confirmation = opts.close_confirmation,
		frames = opts.frames,
	}, self)
	return config
end

--- Apply the `WindowOptions` to the configuration manager
---@param cfg table
function WindowOptions:apply(cfg)
	cfg.window_close_confirmation = self.close_confirmation
	cfg.window_content_alignment = self.content_alignment
	cfg.window_decorations = self.decorations
	cfg.window_padding = self.padding
	if wezterm.gui then
		if wezterm.gui.get_appearance():find("Light") then
			cfg.window_frame = self.frames.light_mode
		else
			cfg.window_frame = self.frames.dark_mode
		end
	end
end

return WindowOptions
