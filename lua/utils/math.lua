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

--- Converts a hexadecimal number representation into an integer value; converts invalid hex numbers into 0
---@param hex_str string the hex string to convert
---@return number
M.hex_to_number = function(hex_str)
	return tonumber(hex_str, 16) or 0
end

--- Converts a hex string representing a color into its RGB representation
---@param hex string the hex string representation of the color to convert
---@return {r:number, g:number, b:number}
M.hex_to_rgb = function(hex)
	hex = hex:gsub("#", "")
	if #hex == 3 then
		-- Short form #RGB
		return {
			r = M.hex_to_number(string.sub(hex, 1, 1)),
			g = M.hex_to_number(string.sub(hex, 2, 2)),
			b = M.hex_to_number(string.sub(hex, 3, 3)),
		}
	else
		-- Long form #RRGGBB
		return {
			r = M.hex_to_number(string.sub(hex, 1, 2)),
			g = M.hex_to_number(string.sub(hex, 3, 4)),
			b = M.hex_to_number(string.sub(hex, 5, 6)),
		}
	end
end

--- Converts an RGB color representation into its HSL counterpart
---@param r number the red value in the RGB color
---@param g number the green value in the RGB color
---@param b number the blue value in the RGB color
---@return {h:number, s:number, l:number}
M.rgb_to_hsl = function(r, g, b)
	r = r / 255
	g = g / 255
	b = b / 255

	local max_val = math.max(r, g, b)
	local min_val = math.min(r, g, b)
	local delta = max_val - min_val

	local l = (max_val + min_val) / 2
	if delta == 0 then
		-- Gray color
		return { h = 0, s = 0, l = l }
	end

	local s = delta / (1 - math.abs(2 * l - 1))
	local h
	if max_val == r then
		h = ((g - b) / delta) % 6
	elseif max_val == g then
		h = (b - r) / delta + 2
	else -- max_val == b
		h = (r - g) / delta + 4
	end
	h = h * 60

	return { h = h, s = s, l = l }
end

--- Converts a HSL color representation into its RGB counterpart
---@param h number the hue value of the HSL color
---@param s number the saturation value of the HSL color
---@param l number the lightness value of the HSL color
---@return {r:number, g:number, b:number}
M.hsl_to_rgb = function(h, s, l)
	h = h % 360
	h = h / 360

	local function hue2rgb(p, q, t)
		if t < 0 then
			t = t + 1
		end
		if t > 1 then
			t = t - 1
		end
		if t < 1 / 6 then
			return p + (q - p) * 6 * t
		end
		if t < 1 / 2 then
			return q
		end
		if t < 2 / 3 then
			return p + (q - p) * (2 / 3 - t) * 6
		end
		return p
	end

	local r, g, b

	if s == 0 then
		r = l
		g = l
		b = l
	else
		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q
		r = hue2rgb(p, q, h + 1 / 3)
		g = hue2rgb(p, q, h)
		b = hue2rgb(p, q, h - 1 / 3)
	end

	return {
		r = math.floor(r * 255 + 0.5),
		g = math.floor(g * 255 + 0.5),
		b = math.floor(b * 255 + 0.5),
	}
end

--- Converts a given RGB color representation into its hexadecimal counterpart
---@param r number
---@param g number
---@param b number
---@return string
M.rgb_to_hex = function(r, g, b)
	return string.format("#%02x%02x%02x", r, g, b)
end

--- Determines if the given number would fit into a the `unsigned char` datatype (1 byte)
---@param x number
---@return boolean
M.bit_length_unsigned_8 = function(x)
	return 0 <= x and x <= 255
end

return M
