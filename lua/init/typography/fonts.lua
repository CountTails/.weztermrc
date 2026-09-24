local base = require("init.base")

local config_dirs_only = "ConfigDirsOnly"

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
	cfg.font = self._effective.app_font

	if self._effective.omit_system_font_dirs then
		cfg.font_locator = config_dirs_only
		cfg.font_dirs = self._effective.font_dirs
	end
end

return ActiveFontOptions
