local luaunit = require("luaunit")
local wezterm = require("wezterm")

---@class MockFile
---@field private data string
local MockFile = {}
MockFile.__index = MockFile

--- Constructs a mock file instance with the provided contents to read from
---@param contents string
---@return MockFile
function MockFile:new(contents)
	return setmetatable({ data = contents }, self)
end

--- Mocks File:read()
---@param mode '*a'|'*n'|'*l'|'*L'
---@return string
function MockFile:read(mode)
	if mode ~= "*a" then
		error(string.format("this mock does not support reading in %q mode", mode))
	end
	return self.data
end

--- Mocks File:close()
---@return boolean
function MockFile:close()
	return true
end

local files = {
	["/var/test/custom.toml"] = require("files").colors.externalcustom.contents,
	["/var/test/invalidcustom.toml"] = require("files").colors.externalcustombadformat.contents,
}

local original_open = io.open

--- Mocks the `io.open` function to avoid the filesystem
---@param filename string path to the file to the open (index to the `files` table)
---@param mode string the mode to open the "file" in
---@return MockFile|nil
---@return string|nil
local function mock_open(filename, mode)
	if files[filename] == nil then
		return nil, "No such file or directory (os error 2)"
	end
	if mode ~= "r" then
		return nil, string.format("this mock does not support opening in %q mode", mode)
	end
	return MockFile:new(files[filename]), nil
end

local colorutils = require("utils.colors")

local function create_theme(method, name)
	return colorutils.Theme:new(string.format("%s:%s", method, name))
end

---@class TestThemeCreationSuite
TestThemeCreationSuite = {}

function TestThemeCreationSuite:setUp()
	io.open = mock_open
end

function TestThemeCreationSuite:tearDown()
	io.open = original_open
end

function TestThemeCreationSuite:TestThemeFromValidBuiltinSchemeName()
	local dark_theme = colorutils.Theme:new("builtin:Codeschool (dark) (terminal.sexy)")
	local light_theme = colorutils.Theme:new("builtin:Codeschool (light) (terminal.sexy)")

	luaunit.assertEquals(dark_theme.__index, colorutils.Theme.__index)
	luaunit.assertEquals(light_theme.__index, colorutils.Theme.__index)
	luaunit.assertTrue(dark_theme:is_resolved())
	luaunit.assertTrue(light_theme:is_resolved())
end

function TestThemeCreationSuite:TestThemeFromInvalidBuiltinSchemeName()
	local fake_theme = "Not a real colorscheme"
	local err_msg = string.format("unknown color scheme: %s", fake_theme)
	luaunit.assertErrorMsgContains(err_msg, create_theme, "builtin", fake_theme)
	luaunit.assertTrue(wezterm.logs_contain(err_msg))
end

function TestThemeCreationSuite:TestThemeFromInvalidMethodNameFails()
	local fake_method = "http"
	local fake_theme = "not real"
	local err_msg = string.format("unable to create color theme from input scheme (%s:%s)", fake_method, fake_theme)
	luaunit.assertErrorMsgContains(err_msg, create_theme, fake_method, fake_theme)
	luaunit.assertTrue(wezterm.logs_contain(err_msg))
end

function TestThemeCreationSuite:TestThemeFromNonExistentBase16SpecFails()
	local base16_method = "externalyaml"
	local unreal_file = "/tmp/colors/notreal.yaml"
	local err_msg = string.format("could not evaluate %q as a base16 color scheme", unreal_file)
	luaunit.assertErrorMsgContains(err_msg, create_theme, base16_method, unreal_file)
	luaunit.assertTrue(wezterm.logs_contain(err_msg))
end

function TestThemeCreationSuite:TestThemeFromValidBase16SpecYieldsResolvedTheme()
	local base16_method = "externalyaml"
	local real_file = "/tmp/test.yaml"
	local theme = create_theme(base16_method, real_file)
	luaunit.assertEquals(theme.__index, colorutils.Theme.__index)
	luaunit.assertTrue(theme:is_resolved())
end

function TestThemeCreationSuite:TestThemeFromInvalidTOMLFileFails()
	local toml_method = "externaltoml"
	local invalid_file = "/tmp/notrealexternal.toml"
	local err_msg = string.format("could not evaluate %q as an external color scheme", invalid_file)
	luaunit.assertErrorMsgContains(err_msg, create_theme, toml_method, invalid_file)
	luaunit.assertTrue(wezterm.logs_contain(err_msg))
end

function TestThemeCreationSuite:TestThemeFromValidTOMLFileYieldsResolvedTheme()
	local toml_method = "externaltoml"
	local valid_file = "/tmp/testexternal.toml"
	local theme = create_theme(toml_method, valid_file)
	luaunit.assertEquals(theme.__index, colorutils.Theme.__index)
	luaunit.assertTrue(theme:is_resolved())
end

function TestThemeCreationSuite:TestThemeFromInvalidJSONFileFails()
	local json_method = "externaljson"
	local invalid_file = "/tmp/notreal.json"
	local err_msg = string.format("could not evaluate %q as a terminal.sexy color scheme", invalid_file)
	luaunit.assertErrorMsgContains(err_msg, create_theme, json_method, invalid_file)
	luaunit.assertTrue(wezterm.logs_contain(err_msg))
end

function TestThemeCreationSuite:TestThemeFromValidJSONFileYieldsResolvedTheme()
	local json_method = "externaljson"
	local valid_file = "/tmp/test.json"
	local theme = create_theme(json_method, valid_file)
	luaunit.assertEquals(theme.__index, colorutils.Theme.__index)
	luaunit.assertTrue(theme:is_resolved())
end

function TestThemeCreationSuite:TestThemeFromInvalidCustomFileFails()
	local custom_method = "externalcustom"
	local invalid_file = "/tmp/notreal.toml"
	local err_msg = "could not open custom definition file: No such file or directory (os error 2)"
	luaunit.assertErrorMsgContains(err_msg, create_theme, custom_method, invalid_file)
	luaunit.assertTrue(wezterm.logs_contain(err_msg))
end

function TestThemeCreationSuite:TestThemeFromValidCustomFileYieldsUnresolvedTheme()
	local custom_method = "externalcustom"
	local valid_file = "/var/test/custom.toml"
	local theme = create_theme(custom_method, valid_file)
	luaunit.assertEquals(theme.__index, colorutils.Theme.__index)
	luaunit.assertFalse(theme:is_resolved())
end

function TestThemeCreationSuite:TestThemeFromMalformedCustomFileFails()
	local custom_method = "externalcustom"
	local invalid_file = "/var/test/invalidcustom.toml"
	local err_msg = "could not parse custom definition contents: "
	luaunit.assertErrorMsgContains(err_msg, create_theme, custom_method, invalid_file)
	luaunit.assertTrue(wezterm.logs_contain(err_msg))
end
