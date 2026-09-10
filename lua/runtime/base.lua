--- A base class for active option subclassing.
--- Specifies a `apply` interface to have the corresponding active options applied to the lua configuration
--- Object instances are not constructable, but subclasses should be constructable from the appropriate effective options table
---@class BaseActiveOptions
local BaseActiveOptions = {}
BaseActiveOptions.__index = BaseActiveOptions

--- Applies the active options to the given configuration
---@param cfg table
function BaseActiveOptions:apply(cfg)
	error("BaseActiveOptions.apply: not implemented")
end

return BaseActiveOptions
