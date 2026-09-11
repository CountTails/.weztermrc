local ActiveFontOpts = require("runtime.typography.fonts")

local M = {}

--- Creates the `ActiveFontOptions` derived from the effective font options table
---@return ActiveFontOptions
M.custom_font_settings = function()
	return ActiveFontOpts:from_effective_table(require("effective.typography.fonts"))
end

return M
