local wezterm = require("wezterm")

---@alias ConfigOption table

---@class ConfigBuilder
---@field private options table
local Config = {}
Config.__index = Config

--- Initialize the config builder
---@return ConfigBuilder
function Config:init()
	local config = setmetatable({ options = wezterm.config_builder() }, self)
	return config
end

--- Add an option to apply to the configuration
---@param opt ConfigOption option to apply to the configuration
---@return ConfigBuilder
function Config:with(opt)
	opt:apply(self.options)
	return self
end

--- Return the wezterm configuration builder under management
function Config:configure()
	return self.options
end

return Config
