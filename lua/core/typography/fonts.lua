local wezterm = require("wezterm")
local platform = require("utils.platform")

local raw_font_opts = require("options.typography.fonts")
local reference_display_opts = require("options.environment.display")

---@class EffectiveFontOptions
---@field font_size number the font size to use at runtime based on the base font size and display configuration
---@field app_font table the font table to use for application purposes
---@field decor_font table the font table to use for decorative purposes
---@field font_dirs string[] directories to look up fonts at runtime
---@field omit_system_font_dirs boolean rule for whether locating and loading fonts from default system dirs is allowed
---@field private _raw RawFontOptions source for the effective table
local EffectiveFontOptions = {}
EffectiveFontOptions.__index = EffectiveFontOptions

--- Creates an effective loadout from a raw font options table
---@param raw RawFontOptions the raw options to derive an effective loadout from
---@return EffectiveFontOptions
function EffectiveFontOptions:from_raw(raw)
	local this = setmetatable({ _raw = raw }, self)
	this:resolve()
	return this
end

--- Resolves the effective loadout from the internal raw options table
function EffectiveFontOptions:resolve()
	self:compute_effective_font_size()
	self:resolve_font_locations()
	self:resolve_from_config_locations_only()
	self:resolve_fonts()
end

--- Populates the font_size field of the effective options table
---@param width? integer the width to use for font size computation
function EffectiveFontOptions:compute_effective_font_size(width)
	local w = width or self._raw.base_display_width
	local size = self._raw.base_font_size * math.sqrt(w / self._raw.base_display_width)
	self.font_size = math.max(self._raw.min_font_size_allowed, math.min(self._raw.max_font_size_allowed, size))
end

--- Populates the font choices of the effective options table
---@private
function EffectiveFontOptions:resolve_fonts()
	self.app_font = wezterm.font(self._raw.terminal_font)
	self.decor_font = wezterm.font(self._raw.decorative_font)
end

--- Populates the font_dirs of the effective options table
---@private
function EffectiveFontOptions:resolve_font_locations()
	if platform.os.is_win() then
		self.font_dirs = self._raw.windows_font_dirs
	elseif platform.os.is_linux() then
		self.font_dirs = self._raw.linux_font_dirs
	elseif platform.os.is_mac() then
		self.font_dirs = self._raw.macos_font_dirs
	else
		local err =
			string.format("EffectiveFontOptions:resolve_font_locations: unknown platfrom: %s", wezterm.target_triple)
		wezterm.log_error(err)
		error(err)
	end
end

--- Populates the font_loader field of the effective options table
---@private
function EffectiveFontOptions:resolve_from_config_locations_only()
	self.omit_system_font_dirs = not self._raw.use_system_fonts_only
end

local _resolved = EffectiveFontOptions:from_raw(raw_font_opts)
return _resolved
