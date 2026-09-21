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

--- Ensures that value falls between a minimum and a maximum, inclusively
---@param val number the value to clamp
---@param min number the minimum value allowed
---@param max number the maximum value allowed
---@return number
M.clamp = function(val, min, max)
	return math.max(min, math.min(max, val))
end

return M
