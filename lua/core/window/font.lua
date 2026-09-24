local wezterm = require("wezterm")
local platform = require("utils.platform")
local mathutils = require("utils.math")

local raw_font_opts = require("options.window.font")
local reference_display_opts = require("options.environment.display")

---@class EffectiveFontOptions
---@field font_size number the font size to use at runtime based on the base font size and display configuration
---@field fonts table<string, table> collection of fonts to use for configuration
---@field font_dirs string[] directories to look up fonts at runtime
---@field omit_system_font_dirs boolean rule for whether locating and loading fonts from default system dirs is allowed
---@field private _raw_font RawFontOptions source for the effective table
---@field private _raw_display RawDisplayOptions source for display details
local EffectiveFontOptions = {}
EffectiveFontOptions.__index = EffectiveFontOptions

--- Creates an effective loadout from a raw font options table
---@param raw1 RawFontOptions the raw options to derive an effective loadout from
---@param raw2 RawDisplayOptions the raw display options for adjustable font size
---@return EffectiveFontOptions
function EffectiveFontOptions:from_raw(raw1, raw2)
	local this = setmetatable({ _raw_font = raw1, _raw_display = raw2 }, self)
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
	if self._raw_font.use_responsive_font_size then
		local w = width or self._raw_display.reference_display_width
		local size = self._raw_font.base_font_size * math.sqrt(w / self._raw_display.reference_display_width)
		self.font_size =
			mathutils.clamp(size, self._raw_font.min_font_size_allowed, self._raw_font.max_font_size_allowed)
	else
		self.font_size = self._raw_font.base_font_size
	end
end

--- Populates the font choices of the effective options table
---@private
function EffectiveFontOptions:resolve_fonts()
	self.fonts = {}
	for name, family in pairs(self._raw_font.font_book) do
		self.fonts[name] = wezterm.font(family)
	end
end

--- Populates the font_dirs of the effective options table
---@private
function EffectiveFontOptions:resolve_font_locations()
	if platform.os.is_win() then
		self.font_dirs = self._raw_font.windows_font_dirs
	elseif platform.os.is_linux() then
		self.font_dirs = self._raw_font.linux_font_dirs
	elseif platform.os.is_mac() then
		self.font_dirs = self._raw_font.macos_font_dirs
	else
		local err =
			string.format("EffectiveFontOptions:resolve_font_locations: unknown platform: %s", wezterm.target_triple)
		wezterm.log_error(err)
		error(err)
	end
end

--- Populates the font_loader field of the effective options table
---@private
function EffectiveFontOptions:resolve_from_config_locations_only()
	self.omit_system_font_dirs = not self._raw_font.use_system_fonts_only
end

local _resolved = EffectiveFontOptions:from_raw(raw_font_opts, reference_display_opts)
return _resolved
