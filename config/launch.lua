---@class LauncherOptions
---@field launcher_items table information about what apps to add to the launcher menu
local LauncherOptions = {}
LauncherOptions.__index = LauncherOptions

--- Creates a new `LauncherOptions` instance with the given
---@param launchspec table the launcher information to initialize the instance with
---@return LauncherOptions
function LauncherOptions:new(launchspec)
	local this = setmetatable({ launcher_items = launchspec }, self)
	return this
end

--- Apply the launcher options to the given config
---@param cfg table the configuration to update
function LauncherOptions:apply(cfg)
	local launch_menu = {}
	local path = self.launcher_items.binary_lookup
	local apps = self.launcher_items.menu_entries
	local sep = package.config:sub(1, 1)

	for _, entry in ipairs(apps) do
		for _, dir in ipairs(path) do
			if self:is_application(dir .. sep .. entry.args[1]) then
				entry.args[1] = dir .. sep .. entry.args[1]
				table.insert(launch_menu, entry)
				break
			end
		end
	end

	cfg.launch_menu = launch_menu
	cfg.default_prog = launch_menu[1].args
end

--- Check that this given path is a file
---@private
---@param path string the file to check
---@return boolean
function LauncherOptions:is_application(path)
	local f = io.open(path, "rb")
	if f == nil then
		return false
	end
	io.close(f)
	return true
end

return LauncherOptions
