local wezterm = require("wezterm")
local mathutils = require("utils.math")

---@class Color
---@field hex string a hexadecimal representation of the color
---@field rgb {r:number, g:number, b:number} a (r, g, b) represenation of a color
---@field hsl {h:number, s:number, l:number} a (h, s, l) represenation of a color
local Color = {}
Color.__index = Color

--- Initializes a color from the given hex value
---@param hex string
---@return Color
function Color:from_hex(hex)
	local this = setmetatable({}, self)

	if not (hex:match("^#%x%x%x%x%x%x$") or hex:match("^#%x%x%x$")) then
		local err = string.format("Color:from_hex: invalid color: %q", hex)
		wezterm.log_error(err)
		error(err)
	end

	this.hex = hex
	this.rgb = mathutils.hex_to_rgb(hex)
	this.hsl = mathutils.rgb_to_hsl(this.rgb.r, this.rgb.g, this.rgb.b)

	return this
end

--- Initializes a color from the given rgb value
---@param r number
---@param g number
---@param b number
---@return Color
function Color:from_rgb(r, g, b)
	local this = setmetatable({}, self)

	if not mathutils.bit_length_unsigned_8(r) then
		local err = string.format("Color:from_rgb: invalid red value: %d", r)
		wezterm.log_error(err)
		error(err)
	end

	if not mathutils.bit_length_unsigned_8(g) then
		local err = string.format("Color:from_rgb: invalid green value: %d", r)
		wezterm.log_error(err)
		error(err)
	end

	if not mathutils.bit_length_unsigned_8(b) then
		local err = string.format("Color:from_rgb: invalid blue value: %d", r)
		wezterm.log_error(err)
		error(err)
	end

	this.rgb = { r = r, g = g, b = b }
	this.hsl = mathutils.rgb_to_hsl(r, g, b)
	this.hex = mathutils.rgb_to_hex(r, g, b)

	return this
end

--- Initializes a color form the given hsl value
---@param h number
---@param s number
---@param l number
---@return Color
function Color:from_hsl(h, s, l)
	local this = setmetatable({}, self)

	if h < 0 then
		local err = string.format("Color:from_hsl: invalid hue valud: %d", h)
		wezterm.log_error(err)
		error(err)
	end

	if s < 0 or s > 1 then
		local err = string.format("Color:from_hsl: invalid saturation value: %f", s)
		wezterm.log_error(err)
		error(err)
	end

	if l < 0 or l > 1 then
		local err = string.format("Color:from_hsl: invalid lightness value: %f", l)
		wezterm.log_error(err)
		error(err)
	end

	this.hsl = { h = h % 360, s = s, l = l }
	this.rgb = mathutils.hsl_to_rgb(h, s, l)
	this.hex = mathutils.rgb_to_hex(this.rgb.r, this.rgb.g, this.rgb.b)

	return this
end

return Color
