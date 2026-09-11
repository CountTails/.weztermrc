local base = require("runtime.base")

---@class ActiveFontOptions: BaseActiveOptions
---@field private _effective EffectiveFontOptions the effective table dictating what is actively applied
local ActiveFontOptions = setmetatable({}, { __index = base })
ActiveFontOptions.__index = ActiveFontOptions

--- Creates the applicable font options table from the effective table
---@param effective EffectiveFontOptions
---@return ActiveFontOptions
function ActiveFontOptions:from_effective_table(effective)
	return setmetatable({ _effective = effective }, self)
end

--- Applies the effective font options to the active configuration
---@param cfg table
function ActiveFontOptions:apply(cfg)
	cfg.font_size = self._effective.font_size
	cfg.font = self._effective.font_choice

	if self._effective.font_loader == nil then
		return
	end

	cfg.font_locator = self._effective.font_loader
	cfg.font_dirs = self._effective.font_dirs
end

return ActiveFontOptions
