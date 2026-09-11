local wezterm = require("wezterm")

local M = {}

--- Returns a boolean value indicating whether the current OS running wezterm is windows
---@return boolean
local function is_win()
	return string.find(wezterm.target_triple, "windows") ~= nil
end

--- Returns a boolean value indicating whether the current OS running wezterm is macOS
---@return boolean
local function is_mac()
	return string.find(wezterm.target_triple, "apple") ~= nil
end

--- Returns a boolean value indicating whether the current OS running wezterm is Linux
---@return boolean
local function is_linux()
	return string.find(wezterm.target_triple, "linux") ~= nil
end

M.os = {
	is_win = is_win,
	is_mac = is_mac,
	is_linux = is_linux,
}

return M
