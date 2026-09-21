local wezterm = require("wezterm")

---@class Color
---@field name string the name this color can be referred as
---@field hex string a hexadecimal representation of the color
local Color = {}
Color.__index = Color

--- Initializes a color with the given name, hex string, and optional alternative representations
---@param name string the name to assign to the newly constructed color
---@param hex string the hexadecimal color representation
---@return Color
function Color:new(name, hex)
	local this = setmetatable({ name = name }, self)

	if not (hex:match("^#%x%x%x%x%x%x$") or hex:match("^#%x%x%x$")) then
		local err = string.format("Color:new: invalid color: %q", hex)
		wezterm.log_error(err)
		error(err)
	end

	this.hex = hex

	return this
end

---@class Pallete
---@field name string the name this color pallete can be referred as
---@field shades Color[] the collection of colors in this pallete
local Pallete = {}
Pallete.__index = Pallete

--- Initializes a color pallete with the given name and the colors
---@param name string the name of the newly constructed pallete
---@param ... Color[] the colors to include in the newly constructed pallete
---@return Pallete
function Pallete:new(name, ...)
	local this = setmetatable({ name = name }, self)
	this.shades = ... or {}
	return this
end

--- Adds a color to this pallete. Returns true if the color is added successfully, otherwise false
---@param color Color color to add
---@return boolean
function Pallete:add_color(color)
	if self:has_color(color) then
		return false
	end

	table.insert(self.shades, color)
	return true
end

--- Removes a color from this pallete by its name or hex representation. Returns true if the color is successfully removed, otherwise false
---@param name_or_hex string the color name or hex to look for and remove
---@return boolean
function Pallete:remove_color(name_or_hex)
	local exists, pos = self:has_color(name_or_hex)
	if exists then
		table.remove(self.shades, pos)
		return true
	end
	return false
end

--- Retrieves the specified color (by name) instance from the shade collection
---@param color string
---@return Color
function Pallete:pick_color(color)
	local exists, pos = self:has_color(color)
	if not exists then
		local err = string.format("Pallete:pick_color: color is not part of pallete: %q", color)
		wezterm.log_error(err)
		error(err)
	end
	return self.shades[pos]
end

--- Checks if a color already exists in the pallete
---@param color Color|string color to check existness for
---@return boolean, integer
function Pallete:has_color(color)
	local exists = false
	local pos = -1
	if type(color) == "string" then -- treat color as a lookup attempt by name or hex value string
		for idx, shade in ipairs(self.shades) do
			if shade.hex == color or shade.name == color then
				exists = true
				pos = idx
			end
		end
	else -- treate color as a lookup attempt by Color table instance
		for idx, shade in ipairs(self.shades) do
			if color.name == shade.name and color.hex == shade.hex then
				exists = true
				pos = idx
			end
		end
	end
	return exists, pos
end

return {
	Color = Color,
	Pallete = Pallete,
}
