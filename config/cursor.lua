local wezterm = require("wezterm")

---@class CursorOption
---@field style string the style of the cursor to use
---@field blink_rate integer the blink rate of the cursor in ms
---@field blink_ease_in_fn string the easing function to use when cursor easing into the GUI
---@field blink_ease_out_fn string the easing function to use when cursor easing out of the GUI
local Cursor = {}
Cursor.__index = Cursor

--- Creates a new CursorOption instance
---@param cursorStyle string the cursor style to use
---@param cursorBlinkRate integer the blink rate to use
---@param cursorEaseIn string the easing function to use for rending the cursor
---@param cursorEaseOut string the easing function to use for unrendering the cursor
---@return CursorOption
function Cursor:new(cursorStyle, cursorBlinkRate, cursorEaseIn, cursorEaseOut)
	local config = setmetatable({
		style = cursorStyle,
		blink_rate = cursorBlinkRate,
		blink_ease_in_fn = cursorEaseIn,
		blink_ease_out_fn = cursorEaseOut,
	}, self)
	return config
end

--- Apply the cursor options to the configuration manager
---@param cfg table
function Cursor:apply(cfg)
	cfg.default_cursor_style = self.style
	cfg.cursor_blink_rate = self.blink_rate
	cfg.cursor_blink_ease_in = self.blink_ease_in_fn
	cfg.cursor_blink_ease_out = self.blink_ease_out_fn
end

return Cursor
