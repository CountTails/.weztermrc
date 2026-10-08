local wezterm = require("wezterm")

--- A dispatch table for color mainpulation methods for resolving programmatic color values
---@alias ColorTransform fun(color: 'wezterm.Color', arg: any): 'wezterm.Color'
---@type table<string, ColorTransform>
local color_methods = {
	adjust_hue_fixed = function(color, arg)
		return color:adjust_hue_fixed(arg)
	end,

	adjust_hue_fixed_ryb = function(color, arg)
		return color:adjust_hue_fixed_ryb(arg)
	end,

	complement = function(color, arg)
		return arg and color:complement() or color
	end,

	complement_ryb = function(color, arg)
		return arg and color:complement_ryb() or color
	end,

	darken = function(color, arg)
		return color:darken(arg)
	end,

	darken_fixed = function(color, arg)
		return color:darken_fixed(arg)
	end,

	desaturate = function(color, arg)
		return color:desaturate(arg)
	end,

	desaturate_fixed = function(color, arg)
		return color:desaturate_fixed(arg)
	end,

	lighten = function(color, arg)
		return color:lighten(arg)
	end,

	lighten_fixed = function(color, arg)
		return color:lighten_fixed(arg)
	end,

	saturate = function(color, arg)
		return color:saturate(arg)
	end,

	saturate_fixed = function(color, arg)
		return color:saturate_fixed(arg)
	end,
}

--- Maps a named color elements (name = color) to a named color value acceptable by a pallete
---@param colors table<string, string|{color:string}>[]
local function map_named_color(colors)
	local out = {}
	for k, v in pairs(colors) do
		out[#out + 1] = { name = k, color = v }
	end
	return out
end

--- Determines whether a given value matches a 6 digit hex color code
---@param v any the value to match against a hex code pattern (if it is a string)
---@return boolean
local function is_hex_string(v)
	if type(v) == "string" then
		return v:match("^#%x%x%x%x%x%x$") ~= nil
	end
	return false
end

--- Determines whether a given value is possibly a hex color code, a palette reference, or a programmatic color spec
---@param v any the value to assess for color valueness
---@return boolean
local function is_color_value(v)
	if type(v) == "string" then
		return is_hex_string(v) or v:match("^palette:(.+)$") ~= nil
	elseif type(v) == "table" then
		return v.color ~= nil and is_color_value(v.color)
	else
		return false
	end
end

--- Walks a Lua table for string values that satisfy a given filter function
---@param val table the value to walk
---@param transform? fun(v: any): any a mapping function that modifies the discovered value before yielding it
---@param filter? fun(v: any): boolean the predicate function determining if a value should be included in the result set
---@param unique? boolean switch to toggle uniqueness in result set
---@param skip? string[] list of keys to avoid recursively walking
---@return string[]
local function walk(val, transform, filter, unique, skip)
	local found = {}
	local seen = {}
	local visited = {}
	local filterfn = filter or function(v)
		return type(v) == "string"
	end
	local transformfn = transform or function(s)
		return s
	end
	local skipkeys = {}
	for _, s in pairs(skip or {}) do
		skipkeys[s] = true
	end

	--- Iterates through the given value
	---@param v any
	---@return string|nil
	local function iter(v)
		if filterfn(v) then
			if unique and seen[v] then
				return nil
			end
			seen[v] = true
			found[#found + 1] = transformfn(v)
			return found[#found]
		end

		if type(v) ~= "table" or visited[v] then
			return nil
		end

		visited[v] = true

		for key, value in pairs(v) do
			if not skip or not skipkeys[key] then
				local newv = iter(value)
				if newv ~= nil then
					v[key] = newv
				end
			end
		end
		return v
	end

	iter(val)
	return found
end

--- Resolves the given colorv in the following manner:
---   1) if it is already a hex color, leave it alone
---   2) if it is string prefixed with "palette:", attempt to resolve it by indexing pallete with the key following the prefix
---   3) if it is table containing a "color" key, recursively apply steps 1 and 2 on that value
---     3a) if there are additional recognizable keys to manipulate the color, apply them accordingly (see: https://wezterm.org/config/lua/color/index.html for color manipulation)
---@param colorv string|{color:string} the color value to be resolved
---@param pallete ColorPalette the source of colors that may also require resolution
---@return string
local function resolve_color_value(colorv, pallete)
	if type(colorv) == "string" then
		local key = colorv:match("^palette:(.+)$")

		if key then
			local value = pallete.shades[key]

			if value == nil then
				error("Unknown palette color: " .. key)
			end

			return resolve_color_value(value, pallete)
		end

		if pcall(wezterm.color.parse, colorv) then
			return colorv
		else
			error("Invalid color sequence: " .. colorv)
		end
	end

	if type(colorv) == "table" and type(colorv.color) == "string" then
		local ok, resolved = pcall(resolve_color_value, colorv.color, pallete)

		if ok then
			local color = wezterm.color.parse(resolved)

			for method, arg in pairs(colorv) do
				if method ~= "color" then
					local fn = color_methods[method]
					if fn == nil then
						error("Unknown color manipulation instruction: " .. method)
					end
					color = fn(color, arg)
				end
			end

			return tostring(color)
		end
	end

	error(
		"[resolve_color_value]: colorv is not a hex string, a palette reference, or a programmatic color table: "
			.. tostring(colorv)
	)
end

---@class ColorPalette
---@field shades table<string|integer, 'wezterm.Color'> the collection of colors in this pallete
local ColorPalette = {}
ColorPalette.__index = ColorPalette

--- Extracts the unique colors from an existing colorscheme and provides an index of colors utilized
---@param scheme ColorScheme the scheme to extract a pallete from
---@return ColorPalette
function ColorPalette:from_colorscheme(scheme)
	local found = walk(scheme.colors, nil, is_hex_string, true)
	table.sort(found)
	return setmetatable({ shades = found }, self)
end

--- Creates a pallete from a list of colors
---@param ... {name:string, color:string|'wezterm.Color'|table}
---@return ColorPalette
function ColorPalette:from_colors(...)
	local shades = {}
	local items = { ... }

	for _, v in pairs(items) do
		shades[v.name] = v.color
	end

	return setmetatable({ shades = shades }, self)
end

--- Resolves the color pallete to ensure every color is a valid hex color parsable by wezterm.color.parse
function ColorPalette:resolve()
	while not self:is_resolved() do
		for name, color in pairs(self.shades) do
			self.shades[name] = resolve_color_value(color, self)
		end
	end
end

--- States whether this color pallete is resolved or not
---@return boolean
function ColorPalette:is_resolved()
	for _, color in pairs(self.shades) do
		if not pcall(wezterm.color.parse, color) then
			return false
		end
	end
	return true
end

---@class ColorScheme
---@field colors table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>> the colorscheme declaration table that should be consumed by wezterm to create the desired appearance
---@field metadata table<string, string> something obtained from most external colorschemes
local ColorScheme = {}
ColorScheme.__index = ColorScheme

--- Creates a colorscheme instance from wezterm's builtin colors
---@param scheme string
---@return ColorScheme
function ColorScheme:from_builtin(scheme)
	local colors = wezterm.color.get_builtin_schemes()[scheme]
	local metadata = { name = scheme, author = "Builtin" }

	if colors == nil then
		local err = string.format(
			"[ColorScheme:from_builtin]: unknown color scheme: %s, falling back to default colors",
			scheme
		)
		wezterm.log_warn(err)
		colors = wezterm.color.get_default_colors()
		metadata = { name = "Default", author = "Builtin" }
	end

	return ColorScheme:new(metadata, colors)
end

--- Create a color scheme instance from a base16 specification file
---@param path string filepath to the specification file
---@return ColorScheme
function ColorScheme:from_base16_file(path)
	local ok, colors, metadata = pcall(wezterm.color.load_base16_scheme, path)
	if not ok then
		local err = string.format(
			"[ColorScheme:from_base16_file]: could not evaluate `%s`, falling back to default colors",
			path
		)
		wezterm.log_warn(err)
		colors = wezterm.color.get_default_colors()
		metadata = { name = "Default", author = "Builtin" }
	end

	return ColorScheme:new(metadata, colors)
end

--- Creates a color scheme instance from a toml specification file
---@param path string filepath to the specification file
---@return ColorScheme
function ColorScheme:from_toml_file(path)
	local ok, colors, metadata = pcall(wezterm.color.load_scheme, path)
	if not ok then
		local err =
			string.format("[ColorScheme:from_toml_file]: could not evaluate `%s`, falling back to default colors", path)
		wezterm.log_warn(err)
		colors = wezterm.color.get_default_colors()
		metadata = { name = "Default", author = "Builtin" }
	end

	return ColorScheme:new(metadata, colors)
end

--- Creates a color scheme instance from a json specification file
---@param path string filepath to the specification file
---@return ColorScheme
function ColorScheme:from_json_file(path)
	local ok, colors, metadata = pcall(wezterm.color.load_terminal_sexy_scheme, path)
	if not ok then
		local err =
			string.format("[ColorScheme:from_json_file]: could not evaluate `%s`, falling back to default colors", path)
		wezterm.log_warn(err)
		colors = wezterm.color.get_default_colors()
		metadata = { name = "Default", author = "Builtin" }
	end

	return ColorScheme:new(metadata, colors)
end

--- Creates a color scheme from the given metadata and color tables
---@param metadata table
---@param colors table
---@return ColorScheme
function ColorScheme:new(metadata, colors)
	return setmetatable({ colors = colors, metadata = metadata }, self)
end

--- Resolves the color scheme to ensure every color is a valid hex color parsable by wezterm.color.parse
---@param palette ColorPalette the color palette to assist with resolution
function ColorScheme:resolve(palette)
	local skipkeys = { "intensity", "italic", "strikethrough", "underline" }
	local map_color = function(s)
		return resolve_color_value(s, palette)
	end
	if not palette:is_resolved() then
		palette:resolve()
	end
	walk(self.colors, map_color, is_color_value, false, skipkeys)
end

--- States whether this color scheme is resolved or not
---@return boolean
function ColorScheme:is_resolved()
	local skipkeys = { "intensity", "italic", "strikethrough", "underline" }
	for _, color in pairs(walk(self.colors, nil, nil, false, skipkeys)) do
		if not pcall(wezterm.color.parse, color) then
			return false
		end
	end
	return true
end

---@class ColorTheme
---@field private palette ColorPalette
---@field private scheme ColorScheme
local ColorTheme = {}
ColorTheme.__index = ColorTheme

--- Creates a color theme from a builtin colorscheme
---@param name string the name of the builtin color scheme to use
---@return ColorTheme
function ColorTheme:from_builtin(name)
	local scheme = ColorScheme:from_builtin(name)
	local palette = ColorPalette:from_colorscheme(scheme)
	return setmetatable({ scheme = scheme, palette = palette }, self)
end

--- Creates a color theme from a YAML file in base16 format
---@param path string path to the file to parse into a base16 colorscheme
---@return ColorTheme
function ColorTheme:from_base16_definition(path)
	local scheme = ColorScheme:from_base16_file(path)
	local palette = ColorPalette:from_colorscheme(scheme)
	return setmetatable({ scheme = scheme, palette = palette }, self)
end

--- Creates a color theme from a raw TOML color scheme format
---@param path string path to the file to parse into a wezterm colorscheme definition
---@return ColorTheme
function ColorTheme:from_toml_definition(path)
	local scheme = ColorScheme:from_toml_file(path)
	local palette = ColorPalette:from_colorscheme(scheme)
	return setmetatable({ scheme = scheme, palette = palette }, self)
end

--- Creates a color theme from a terminal.sexy exported JSON file
---@param path string path to the file to parse a terminal.sexy colorscheme into a wezterm colorscheme definition
---@return ColorTheme
function ColorTheme:from_terminal_dot_sexy_definition(path)
	local scheme = ColorScheme:from_json_file(path)
	local palette = ColorPalette:from_colorscheme(scheme)
	return setmetatable({ scheme = scheme, palette = palette }, self)
end

--- Creates a color theme from a custom definition allowing for programmatically defined colorschemes to emerge
---@param path string path to the file to parse the custom colorscheme into a wezterm colorscheme definition
---@return ColorTheme
function ColorTheme:from_custom_definition(path)
	local file, open_err = io.open(path, "r")
	if not file then
		local err =
			string.format("[ColorTheme:from_custom_definition]: could not open custom definition file: %s", open_err)
		wezterm.log_error(err)
		error(err)
	end

	local contents, read_err = file:read("*a")
	file:close()
	if not contents then
		local err =
			string.format("[ColorTheme:from_custom_definition]: could not read custom definition file: %s", read_err)
		wezterm.log_error(err)
		error(err)
	end

	local ok, data = pcall(wezterm.serde.toml_decode, contents)
	if not ok then
		local err = string.format(
			"[ColorTheme:from_custom_definition]: could not parse custom definition contents: %s",
			tostring(data)
		)
		wezterm.log_error(err)
		error(err)
	end

	local palette = ColorPalette:from_colors(table.unpack(map_named_color(data.palette or {})))
	local scheme = ColorScheme:new(data.metadata or {}, data.scheme or wezterm.color.get_default_colors())

	return setmetatable({ scheme = scheme, palette = palette }, self)
end

--- Resolves the color theme to ensure every color is a valid hex color parsable by wezterm.color.parse
function ColorTheme:resolve()
	self.palette:resolve()
	self.scheme:resolve(self.palette)
end

--- States whether this color theme is resolved or not
---@return boolean
function ColorTheme:is_resolved()
	if not self.palette:is_resolved() then
		return false
	end

	if not self.scheme:is_resolved() then
		return false
	end

	return true
end

return {
	Palatte = ColorPalette,
	Scheme = ColorScheme,
	Theme = ColorTheme,
}
