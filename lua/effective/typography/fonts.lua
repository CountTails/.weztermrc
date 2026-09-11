local wezterm = require("wezterm")
local platform = require("utils.platform")

---@alias Font table

---@class EffectiveFontOptions
---@field font_size number the font size to use at runtime based on the base font size and display configuration
---@field font_choice Font[] the font list to use at runtime
---@field font_dirs string[] directories to look up fonts at runtime
---@field font_loader "ConfigDirsOnly"|nil rule for whether locating and loading system fonts is allowed
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
	self:resolve_font_list()
	self:resolve_font_locations()
	self:allow_system_fonts()
end

--- Populates the font_size field of the effective options table
---@private
function EffectiveFontOptions:compute_effective_font_size()
	self.font_size = platform.display.scale_font_size(self._raw.base_font_size)
end

--- Populates the font choice of the effective opotions table
---@private
function EffectiveFontOptions:resolve_font_list()
	self.font_choice = wezterm.font_with_fallback(self._raw.desired_fonts)
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
function EffectiveFontOptions:allow_system_fonts()
	self.font_loader = self._raw.font_locator
end

local _resolved = EffectiveFontOptions:from_raw(require("options.typography.fonts"))
return _resolved
