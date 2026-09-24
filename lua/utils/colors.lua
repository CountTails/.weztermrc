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
---@param ... Color the colors to include in the newly constructed pallete
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

---@class TabStateColors
---@field bg_color Color
---@field fg_color Color
---@field intensity "Normal"|"Bright"
---@field italic boolean
---@field strikethrough boolean
---@field underline "None"|"Single"|"Double"
local TabStateColors = {}
TabStateColors.__index = TabStateColors

--- Creates a new tab state colors specification
---@param fg Color the color to use for the foreground
---@param bg Color the color to use for the background
---@param intensity? nil|"Normal"|"Bright" the intesity for the new tab state colors
---@param italic? nil|boolean whether to use italics in this tab state colors
---@param strikethrough? nil|boolean whether to use strikethrough in this tab state colors
---@param underline? nil|"None"|"Single"|"Double" the underline for the new tab state colors
---@return TabStateColors
function TabStateColors:new(fg, bg, intensity, italic, strikethrough, underline)
	local this = setmetatable({ bg_color = bg, fg_color = fg }, self)
	this.intensity = intensity or "Normal"
	this.italic = italic or false
	this.strikethrough = strikethrough or false
	this.underline = underline or "None"
	return this
end

--- Extracts the state colors into a wezterm-friendly table for tab states
---@return table
function TabStateColors:as_raw_tbl()
	return {
		bg_color = self.bg_color.hex,
		fg_color = self.fg_color.hex,
		intensity = self.intensity,
		italic = self.italic,
		strikethrough = self.strikethrough,
		underline = self.underline,
	}
end

---@class ColorScheme
---@field private ansi Color[]
---@field private brights Color[]
---@field private background Color
---@field private foreground Color
---@field private compose_cursor Color
---@field private cursor_bg Color
---@field private cursor_fg Color
---@field private cursor_border Color
---@field private selection_bg Color
---@field private selection_fg Color
---@field private scrollbar_thumb Color
---@field private split Color
---@field private indexed table<integer, Color>
---@field private active_tab TabStateColors
---@field private inactive_tab TabStateColors
---@field private inactive_tab_hover TabStateColors
---@field private new_tab TabStateColors
---@field private new_tab_hover TabStateColors
---@field private tab_bar_background Color
---@field private tab_bar_inactive_edge Color
---@field private visual_bell Color
local ColorScheme = {}
ColorScheme.__index = ColorScheme

--- Creates a proxy table to reduce color scheme construction complexity. The resulting table is empty and will not specify a color scheme (yet)
---@return ColorScheme
function ColorScheme:builder()
	local this = setmetatable({}, self)
	return this
end

--- Populates the proxy table's ansi color sequence
---@param ansi_black Color
---@param ansi_red Color
---@param ansi_green Color
---@param ansi_yellow Color
---@param ansi_blue Color
---@param ansi_magenta Color
---@param ansi_cyan Color
---@param ansi_white Color
---@return ColorScheme
function ColorScheme:with_ansi_colors(
	ansi_black,
	ansi_red,
	ansi_green,
	ansi_yellow,
	ansi_blue,
	ansi_magenta,
	ansi_cyan,
	ansi_white
)
	self.ansi = {
		ansi_black,
		ansi_red,
		ansi_green,
		ansi_yellow,
		ansi_blue,
		ansi_magenta,
		ansi_cyan,
		ansi_white,
	}
	return self
end

--- Populates the proxy table's brights colors sequence
---@param bright_black Color
---@param bright_red Color
---@param bright_green Color
---@param bright_yellow Color
---@param bright_blue Color
---@param bright_magenta Color
---@param bright_cyan Color
---@param bright_white Color
---@return ColorScheme
function ColorScheme:with_bright_colors(
	bright_black,
	bright_red,
	bright_green,
	bright_yellow,
	bright_blue,
	bright_magenta,
	bright_cyan,
	bright_white
)
	self.brights = {
		bright_black,
		bright_red,
		bright_green,
		bright_yellow,
		bright_blue,
		bright_magenta,
		bright_cyan,
		bright_white,
	}
	return self
end

--- Populates the foreground and background in the proxy table
---@param fg Color
---@param bg Color
---@return ColorScheme
function ColorScheme:with_contrast(fg, bg)
	self.foreground = fg
	self.background = bg
	return self
end

--- Populates the cursor relevant entries in the proxy table
---@param compose Color
---@param fg Color
---@param bg Color
---@param border Color
---@return ColorScheme
function ColorScheme:with_cursor_scheme(compose, fg, bg, border)
	self.compose_cursor = compose
	self.cursor_fg = fg
	self.cursor_bg = bg
	self.cursor_border = border
	return self
end

--- Populates selection relevant entries in the proxy table
---@param fg Color
---@param bg Color
---@return ColorScheme
function ColorScheme:with_selection_scheme(fg, bg)
	self.selection_fg = fg
	self.selection_bg = bg
	return self
end

--- Populates bars and lines relevant entries in the proxy table
---@param scrollbar Color
---@param split Color
---@return ColorScheme
function ColorScheme:with_bars_and_lines_scheme(scrollbar, split)
	self.scrollbar_thumb = scrollbar
	self.split = split
	return self
end

--- Populates the indexed entry in the proxy table
---@param extraneous table<integer, Color>
---@return ColorScheme
function ColorScheme:with_extra_colors(extraneous)
	self.indexed = extraneous
	return self
end

--- Populates the active tab entry in the proxy table
---@param fg Color
---@param bg Color
---@param intensity? nil|"Normal"|"Bright"
---@param italic? nil|boolean
---@param strikethrough? nil|boolean
---@param underline? nil|"None"|"Single"|"Double"
---@return ColorScheme
function ColorScheme:with_tab_state_active(fg, bg, intensity, italic, strikethrough, underline)
	self.active_tab = TabStateColors:new(fg, bg, intensity, italic, strikethrough, underline)
	return self
end
---
--- Populates the inactive tab entry in the proxy table
---@param fg Color
---@param bg Color
---@param intensity? nil|"Normal"|"Bright"
---@param italic? nil|boolean
---@param strikethrough? nil|boolean
---@param underline? nil|"None"|"Single"|"Double"
---@return ColorScheme
function ColorScheme:with_tab_state_inactive(fg, bg, intensity, italic, strikethrough, underline)
	self.inactive_tab = TabStateColors:new(fg, bg, intensity, italic, strikethrough, underline)
	return self
end

--- Populates the inactive hover tab entry in the proxy table
---@param fg Color
---@param bg Color
---@param intensity? nil|"Normal"|"Bright"
---@param italic? nil|boolean
---@param strikethrough? nil|boolean
---@param underline? nil|"None"|"Single"|"Double"
---@return ColorScheme
function ColorScheme:with_tab_state_inactive_hover(fg, bg, intensity, italic, strikethrough, underline)
	self.inactive_tab_hover = TabStateColors:new(fg, bg, intensity, italic, strikethrough, underline)
	return self
end

--- Populates the new tab entry in the proxy table
---@param fg Color
---@param bg Color
---@param intensity? nil|"Normal"|"Bright"
---@param italic? nil|boolean
---@param strikethrough? nil|boolean
---@param underline? nil|"None"|"Single"|"Double"
---@return ColorScheme
function ColorScheme:with_tab_state_new_tab(fg, bg, intensity, italic, strikethrough, underline)
	self.new_tab = TabStateColors:new(fg, bg, intensity, italic, strikethrough, underline)
	return self
end

--- Populates the active new tab hover entry in the proxy table
---@param fg Color
---@param bg Color
---@param intensity? nil|"Normal"|"Bright"
---@param italic? nil|boolean
---@param strikethrough? nil|boolean
---@param underline? nil|"None"|"Single"|"Double"
---@return ColorScheme
function ColorScheme:with_tab_state_new_tab_hover(fg, bg, intensity, italic, strikethrough, underline)
	self.new_tab_hover = TabStateColors:new(fg, bg, intensity, italic, strikethrough, underline)
	return self
end

--- Populates the tab bar relevant entries in the proxy table
---@param bg Color
---@param inactive Color
---@return ColorScheme
function ColorScheme:with_tab_bar_scheme(bg, inactive)
	self.tab_bar_background = bg
	self.tab_bar_inactive_edge = inactive
	return self
end

--- Populates the visual bell entry in the proxy table
---@param bell Color
---@return ColorScheme
function ColorScheme:with_visual_bell(bell)
	self.visual_bell = bell
	return self
end

--- Constructs the resulting color scheme table that can be understood by wezterm
---@return table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
function ColorScheme:spec()
	local scheme = {}
	self:populate_scheme_from_proxy(scheme)
	return scheme
	--[[
	return {
		ansi = {
			"#45475a",
			"#f38ba8",
			"#a6e3a1",
			"#f9e2af",
			"#89b4fa",
			"#f5c2e7",
			"#94e2d5",
			"#bac2de",
		},
		brights = {
			"#585b70",
			"#f38ba8",
			"#a6e3a1",
			"#f9e2af",
			"#89b4fa",
			"#f5c2e7",
			"#94e2d5",
			"#a6adc8",
		},
		background = "#1e1e2e",
		foreground = "#cdd6f4",
		compose_cursor = "#f2cdcd",
		cursor_bg = "#f5e0dc",
		cursor_border = "#f5e0dc",
		cursor_fg = "#11111b",
		indexed = {
			[16] = "#fab387",
			[17] = "#f5e0dc",
		},
		scrollbar_thumb = "#585b70",
		selection_bg = "#585b70",
		selection_fg = "#cdd6f4",
		split = "#6c7086",
		tab_bar = {
			active_tab = {
				bg_color = "#cba6f7",
				fg_color = "#11111b",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			background = "#11111b",
			inactive_tab = {
				bg_color = "#181825",
				fg_color = "#cdd6f4",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			inactive_tab_edge = "#313244",
			inactive_tab_hover = {
				bg_color = "#1e1e2e",
				fg_color = "#cdd6f4",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			new_tab = {
				bg_color = "#313244",
				fg_color = "#cdd6f4",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
			new_tab_hover = {
				bg_color = "#45475a",
				fg_color = "#cdd6f4",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
		},
		visual_bell = "#313244",
	}
  -- ]]
end

--- Populates a wezterm-friendly scheme table from the internal color assignments
---@param colorscheme table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
---@private
function ColorScheme:populate_scheme_from_proxy(colorscheme)
	self:populate_ansi_colors(colorscheme)
	self:populate_bright_colors(colorscheme)
	self:populate_contrast(colorscheme)
	self:populate_cursor(colorscheme)
	self:populate_select(colorscheme)
	self:populate_bars_and_lines(colorscheme)
	self:populate_indexed(colorscheme)
	self:populate_tab_bar(colorscheme)
	self:populate_visual_bell(colorscheme)
end

--- Populates the ansi colors from the proxy table to the colorscheme table
---@param colorscheme table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
---@private
function ColorScheme:populate_ansi_colors(colorscheme)
	if self.ansi == nil then
		-- Nothing to populate
		return
	end

	if #self.ansi ~= 8 then
		-- Insufficient or too many colors
		return
	end

	colorscheme.ansi = {
		self.ansi[1].hex,
		self.ansi[2].hex,
		self.ansi[3].hex,
		self.ansi[4].hex,
		self.ansi[5].hex,
		self.ansi[6].hex,
		self.ansi[7].hex,
		self.ansi[8].hex,
	}
end

--- Populates the bright colors from the proxy table to the colorscheme table
---@param colorscheme table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
---@private
function ColorScheme:populate_bright_colors(colorscheme)
	if self.brights == nil then
		-- Nothing to populate
		return
	end

	if #self.brights ~= 8 then
		-- Insufficient or too many colors
		return
	end

	colorscheme.brights = {
		self.brights[1].hex,
		self.brights[2].hex,
		self.brights[3].hex,
		self.brights[4].hex,
		self.brights[5].hex,
		self.brights[6].hex,
		self.brights[7].hex,
		self.brights[8].hex,
	}
end

--- Populate the color contrast from the proxy table to the colorscheme table
---@param colorscheme table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
---@private
function ColorScheme:populate_contrast(colorscheme)
	if self.foreground ~= nil then
		colorscheme.foreground = self.foreground.hex
	end

	if self.background ~= nil then
		colorscheme.background = self.background.hex
	end
end

--- Populate the cursor theme from the proxy table to the colorscheme table
---@param colorscheme table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
---@private
function ColorScheme:populate_cursor(colorscheme)
	if self.compose_cursor ~= nil then
		colorscheme.compose_cursor = self.compose_cursor.hex
	end

	if self.cursor_border ~= nil then
		colorscheme.cursor_border = self.cursor_border.hex
	end

	if self.cursor_fg ~= nil then
		colorscheme.cursor_fg = self.cursor_fg.hex
	end

	if self.cursor_bg ~= nil then
		colorscheme.cursor_bg = self.cursor_bg.hex
	end
end

--- Populate the select theme from the proxy table to the colorscheme table
---@param colorscheme table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
---@private
function ColorScheme:populate_select(colorscheme)
	if self.selection_fg ~= nil then
		colorscheme.selection_fg = self.selection_fg.hex
	end

	if self.selection_bg ~= nil then
		colorscheme.selection_bg = self.selection_bg.hex
	end
end

--- Populate the bars and lines theme from the proxy table to the colorscheme table
---@param colorscheme table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
---@private
function ColorScheme:populate_bars_and_lines(colorscheme)
	if self.scrollbar_thumb ~= nil then
		colorscheme.scrollbar_thumb = self.scrollbar_thumb.hex
	end

	if self.split ~= nil then
		colorscheme.split = self.split.hex
	end
end

--- Populate the indexed colors from the proxy table to the colorscheme table
---@param colorscheme table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
---@private
function ColorScheme:populate_indexed(colorscheme)
	if self.indexed ~= nil then
		local indexed = {}
		for idx, color in ipairs(self.indexed) do
			table.insert(indexed, idx, color.hex)
		end
		colorscheme.indexed = indexed
	end
end

--- Populate the visual bell color from the proxy table to the colorscheme table
---@param colorscheme table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
---@private
function ColorScheme:populate_visual_bell(colorscheme)
	if self.visual_bell ~= nil then
		colorscheme.visual_bell = self.visual_bell.hex
	end
end

--- Populate the tab bar scheme from the proxy table to the colorscheme table
---@param colorscheme table<string, table<string>|string|table<integer, string>|table<string,table<string,string>>>
---@private
function ColorScheme:populate_tab_bar(colorscheme)
	local tab_bar = {}

	if self.tab_bar_background ~= nil then
		tab_bar.background = self.tab_bar_background.hex
	end

	if self.tab_bar_inactive_edge ~= nil then
		tab_bar.inactive_tab_edge = self.tab_bar_inactive_edge.hex
	end

	if self.active_tab ~= nil then
		tab_bar.active_tab = self.active_tab:as_raw_tbl()
	end

	if self.inactive_tab ~= nil then
		tab_bar.inactive_tab = self.inactive_tab:as_raw_tbl()
	end

	if self.inactive_tab_hover ~= nil then
		tab_bar.inactive_tab_hover = self.inactive_tab_hover:as_raw_tbl()
	end

	if self.new_tab ~= nil then
		tab_bar.new_tab = self.new_tab:as_raw_tbl()
	end

	if self.new_tab_hover ~= nil then
		tab_bar.new_tab_hover = self.new_tab_hover:as_raw_tbl()
	end

	colorscheme.tab_bar = tab_bar
end

return {
	Color = Color,
	Pallete = Pallete,
	Scheme = ColorScheme,
}
