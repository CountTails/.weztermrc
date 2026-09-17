local M = {}

--- Ensures the input number is 0 or greater. If the input is less than 0, then 0 is returned
---@param x number
---@return number
M.ensure_non_negative = function(x)
	if x >= 0 then
		return x
	end
	return 0
end

return M
