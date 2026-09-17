local wezterm = require("wezterm")
local mathutils = require("utils.math")
local raw_cursor_opts = require("options.window.cursor")

--- A list of known glyph keywords that will work with wezterm
local valid_cursor_glyphs = {
	"SteadyBlock",
	"BlinkingBlock",
	"SteadyUnderline",
	"BlinkingUnderline",
	"SteadyBar",
	"BlinkingBar",
}

--- A list of known easing function keywords that will work with wezterm
local valid_easing_functions = {
	"Constant",
	"Linear",
	"Ease",
	"EaseIn",
	"EaseOut",
	"EaseInOut",
}

---@class EffectiveCursorOptions
---@field private _raw RawCursorOptions
---@field style string validated cursor glyph
---@field blink_rate integer validated blink duration
---@field ease_in_animation string validated easing function used for transitioning the cursor to visible
---@field ease_out_animation string validated easing function used for transitioning the cursor to invisible
---@field private known_glyphs string[] list of acceptable cursor glyphs
---@field private known_easing_fns string[] list of acceptable easing functions
local EffectiveCursorOptions = {}
EffectiveCursorOptions.__index = EffectiveCursorOptions

--- Creates an effective loadout from a raw cursor options table
---@param raw RawCursorOptions the raw source for the effective table
---@return EffectiveCursorOptions
function EffectiveCursorOptions:from_raw(raw)
	local this = setmetatable(
		{ _raw = raw, known_glyphs = valid_cursor_glyphs, known_easing_fns = valid_easing_functions },
		self
	)
	this:resolve()
	return this
end

--- Resolves the effective loadout from the internal raw source table
function EffectiveCursorOptions:resolve()
	self.style = self.validated_cursor_style(self, self._raw.glyph_style)
	self.ease_in_animation = self.validated_easing_function(self, self._raw.blink_ease_in_fn)
	self.ease_out_animation = self.validated_easing_function(self, self._raw.blink_ease_out_fn)
	self.blink_rate = mathutils.ensure_non_negative(self._raw.blink_rate)
end

--- Validates that the raw cursor style is an acceptable cursor glyph
---@param raw_style string the cursor style string to validate
---@return string
---@private
function EffectiveCursorOptions:validated_cursor_style(raw_style)
	for idx, glyph in ipairs(self.known_glyphs) do
		if raw_style == glyph then
			return self.known_glyphs[idx]
		end
	end
	local err =
		string.format("EffectiveCursorOptions:validated_cursor_style: unknown cursor style specified: %s", raw_style)
	wezterm.log_error(err)
	error(err)
end

--- Validates that the raw easing function is an acceptable value
---@param raw_ease_fn string the easing function string to validate
---@return string
---@private
function EffectiveCursorOptions:validated_easing_function(raw_ease_fn)
	for idx, ease_fn in ipairs(self.known_easing_fns) do
		if raw_ease_fn == ease_fn then
			return self.known_easing_fns[idx]
		end
	end
	local err = string.format(
		"EffectiveCursorOptions:validated_easing_function: unknown easing function specified: %s",
		raw_ease_fn
	)
	wezterm.log_error(err)
	error(err)
end

local _resolved = EffectiveCursorOptions:from_raw(raw_cursor_opts)
return _resolved
