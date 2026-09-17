---@class RawCursorOptions
---@field glyph_style string the glyph to use as the cursor
---@field blink_rate integer specifies how often a blinking cursor with transistion between visible and invisible (in ms)
---@field blink_ease_in_fn string easing function used when transitioning to visible
---@field blink_ease_out_fn string easing function used when transitioning to invisible
local RawCursorOptions = {}

--- EDIT this value to change the glyph used as the cursor
RawCursorOptions.glyph_style = "BlinkingBar"

--- EDIT this value to change the blink rate of the cursor animation
RawCursorOptions.blink_rate = 750

--- EDIT this value to change the ease in function
RawCursorOptions.blink_ease_in_fn = "EaseIn"

--- EDIT this value to change the ease out function
RawCursorOptions.blink_ease_out_fn = "Linear"

return RawCursorOptions
