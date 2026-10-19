local M = {}

---@type string[]
M.log_capture = {}

M.home_dir = "/tmp/weztermrctest"

M.log_error = function(msg, ...)
	local args = { ... }
	table.insert(M.log_capture, string.format("ERROR >> %s", string.format(msg, table.unpack(args))))
end

M.logs_contain = function(msg)
	for _, record in ipairs(M.log_capture) do
		if record:find(msg, 1, true) ~= nil then
			return true
		end
	end

	return false
end

M.color = require("wezterm.color")
M.serde = require("wezterm.serde")

return M
