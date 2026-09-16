local wezterm = require("wezterm")
local platform = require("utils.platform")
local raw_color_opts = require("options.window.color")

---@class EffectiveColorSchemeOptions
---@field private _raw RawColorOptions source for the effective table
---@field active_scheme table the color scheme to utilize
local EffectiveColorSchemeOptions = {}
EffectiveColorSchemeOptions.__index = EffectiveColorSchemeOptions

--- Creates an effective loadout from a raw color options table
---@param raw RawColorOptions the raw source for the effective table
---@return EffectiveColorSchemeOptions
function EffectiveColorSchemeOptions:from_raw(raw)
	local this = setmetatable({ _raw = raw }, self)
	this:resolve()
	return this
end

--- Resolves the effective loadout from the internal raw source table
function EffectiveColorSchemeOptions:resolve()
	local available_schemes = wezterm.color.get_builtin_schemes()
	local effective_scheme = platform.theme.is_light_mode() and self._raw.light_mode_theme or self._raw.dark_mode_theme

	if available_schemes[effective_scheme] == nil then
		local err = string.format("EffectiveColorSchemeOptions:resolve: unknown color scheme: %s", effective_scheme)
		wezterm.log_error(err)
		error(err)
	end

	self.active_scheme = available_schemes[effective_scheme]
end

local _resolved = EffectiveColorSchemeOptions:from_raw(raw_color_opts)
return _resolved
