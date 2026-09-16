local base = require("runtime.base")

---@class ActiveColorSchemeOptions: BaseActiveOptions
---@field private _effective EffectiveColorSchemeOptions
local ActiveColorSchemeOptions = setmetatable({}, { __index = base })
ActiveColorSchemeOptions.__index = ActiveColorSchemeOptions

--- Creates the applicable colorscheme options table from the effective table
---@param effective EffectiveColorSchemeOptions
---@return ActiveColorSchemeOptions
function ActiveColorSchemeOptions:from_effective_table(effective)
	return setmetatable({ _effective = effective }, self)
end

--- Applies the effect color scheme options to the active configuration
---@param cfg table
function ActiveColorSchemeOptions:apply(cfg)
	cfg.colors = self._effective.active_scheme
end

return ActiveColorSchemeOptions
