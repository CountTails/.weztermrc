local files = require("files")

local M = {}

M.toml_decode = function(data)
	for _, f in pairs(files.colors) do
		if f.contents == data and f.parsed ~= nil then
			return f.parsed
		end
	end
	error("TOML decode error")
end

return M
