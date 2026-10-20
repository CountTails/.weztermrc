local wezterm = require("wezterm")
local platform = require("utils.platform")
local colorutils = require("utils.colors")
local tableutils = require("utils.table")
local assets = require("core.environment.assets")
local raw_color_opts = require("options.window.theme")

---@class EffectiveThemeOptions
---@field private _raw RawThemeOptions source for the effective table
---@field active_theme ColorTheme
---@field active_extras table<string, string>
local EffectiveThemeOptions = {}
EffectiveThemeOptions.__index = EffectiveThemeOptions

--- Creates an effective loadout from a raw color options table
---@param raw RawThemeOptions the raw source for the effective table
---@return EffectiveThemeOptions
function EffectiveThemeOptions:from_raw(raw)
	local this = setmetatable({ _raw = raw }, self)
	this:resolve()
	return this
end

--- Resolves the effective loadout from the internal raw source table
function EffectiveThemeOptions:resolve()
	if self._raw.initcolors == "default" then
		self.active_theme = colorutils.Theme:default()
	elseif self._raw.initcolors == "random" then
		self.active_theme = self:load_random_colors_from_schemes_list()
	elseif self._raw.initcolors == "index" then
		self.active_theme = self:load_colors_from_schemes_list_index()
	else
		local err = string.format(
			"[EffectiveThemeOptions:resolve]: unable to resolve colors: unknown initcolors option: %s",
			self._raw.initcolors
		)
		wezterm.log_error(err)
		error(err)
	end
end

--- Resolves a random color from the schemes list
---@return ColorTheme
---@private
function EffectiveThemeOptions:load_random_colors_from_schemes_list()
	math.randomseed(os.time())
	local coloridx = math.random(#self._raw.schemes)
	local theme, extras = self:load_theme(coloridx)
	self.active_extras = extras
	return theme
end

--- Resolves a selected color from the schemes list
---@return ColorTheme
---@private
function EffectiveThemeOptions:load_colors_from_schemes_list_index()
	local theme, extras = self:load_theme(self._raw.initcolorsidx)
	self.active_extras = extras
	return theme
end

--- Resolves a theme from the schemes list by the given index
---@param idx integer the index into the schemes list
---@return ColorTheme, table<string, string>
---@private
function EffectiveThemeOptions:load_theme(idx)
	local schemespec = self._raw.schemes[idx]
	local variant = platform.theme.is_light_mode() and schemespec.variants.light or schemespec.variants.dark
	local theme = colorutils.Theme:new(variant)
	local extras = tableutils.deep_copy(schemespec.extras)
	theme:resolve(extras)
	return theme, extras
end

local _resolved = EffectiveThemeOptions:from_raw(raw_color_opts)
return _resolved
