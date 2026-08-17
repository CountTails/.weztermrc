local wezterm = require("wezterm")

---@class ConfigOption
local Option = {}
Option.__index = Option

--- Create a new option instance
function Option:new()
	error("not implemented: Option:new. This function should be overridden in a concrete implementation.")
end

--- Apply this option to the configuration manager
---@param cfg Config
---@overload fun(cfg: Config)
function Option:apply(cfg)
	error("not implemented: Option:apply. This function should be overridden in a concrete implementation.")
end

return Option
