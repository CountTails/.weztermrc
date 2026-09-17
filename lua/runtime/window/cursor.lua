local base = require("runtime.base")

---@class ActiveCursorOptions: BaseActiveOptions
---@field private _effective EffectiveCursorOptions
local ActiveCursorOptions = setmetatable({}, { __index = base })
ActiveCursorOptions.__index = ActiveCursorOptions

--- Creates the applicable cursor options table from effective table
---@param effective EffectiveCursorOptions
---@return ActiveCursorOptions
function ActiveCursorOptions:from_effective_table(effective)
	return setmetatable({ _effective = effective }, self)
end

--- Applies the effective cursor options to the active configuration
function ActiveCursorOptions:apply(cfg)
	cfg.default_cursor_style = self._effective.style
	cfg.cursor_blink_rate = self._effective.blink_rate
	cfg.cursor_blink_ease_in = self._effective.ease_in_animation
	cfg.cursor_blink_ease_out = self._effective.ease_out_animation
end

return ActiveCursorOptions
