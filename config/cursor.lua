local wezterm = require("wezterm")
local options = require("utils.options").appearance.cursor

---@class CursorOption
---@field style string the style of the cursor to use
---@field blink_rate integer the blink rate of the cursor in ms
---@field blink_ease_in_fn string the easing function to use when cursor easing into the GUI
---@field blink_ease_out_fn string the easing function to use when cursor easing out of the GUI
local CursorOption = {}
CursorOption.__index = CursorOption

--- Creates a new CursorOption instance
---@param cursorStyle string the cursor style to use
---@param cursorBlinkRate integer the blink rate to use
---@param cursorEaseIn string the easing function to use for rending the cursor
---@param cursorEaseOut string the easing function to use for unrendering the cursor
---@return CursorOption
function CursorOption:new(cursorStyle, cursorBlinkRate, cursorEaseIn, cursorEaseOut)
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
function CursorOption:apply(cfg)
	cfg.default_cursor_style = self.style
	cfg.cursor_blink_rate = self.blink_rate
	cfg.cursor_blink_ease_in = self.blink_ease_in_fn
	cfg.cursor_blink_ease_out = self.blink_ease_out_fn
end

local M = {}

---@return CursorOption
M.init = function()
	return CursorOption:new(options.style, options.blink.rate, options.blink.ease_in, options.blink.ease_out)
end

return M
