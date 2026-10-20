local base = require("init.base")

---@class ActiveThemeOptions: BaseActiveOptions
---@field private _effective EffectiveThemeOptions
local ActiveThemeOptions = setmetatable({}, { __index = base })
ActiveThemeOptions.__index = ActiveThemeOptions

--- Creates the applicable colorscheme options table from the effective table
---@param effective EffectiveThemeOptions
---@return ActiveThemeOptions
function ActiveThemeOptions:from_effective_table(effective)
	return setmetatable({ _effective = effective }, self)
end

--- Applies the effect color scheme options to the active configuration
---@param cfg table
function ActiveThemeOptions:apply(cfg)
	cfg.colors = self._effective.active_theme:colors()
end

return ActiveThemeOptions
