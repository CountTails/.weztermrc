local wezterm = require("wezterm")

---@class RawAssetsOptions
---@field macos_asset_dir string directory assets on MacOS systems
---@field windows_asset_dir string directory assets on Windows systems
---@field linux_asset_dir string directory assets on Linux systems
local RawAssetsOptions = {}

--- EDIT this value to adjust where the asset directory is on MacOS
---@type string
RawAssetsOptions.macos_asset_dir = wezterm.home_dir .. "/.local/share/wezterm/assets/"

--- EDIT this value to adjust where the asset directory is on Linux
---@type string
RawAssetsOptions.linux_asset_dir = wezterm.home_dir .. "/.local/share/wezterm/assets/"

--- EDIT this value to adjust where the asset directory is on Windows
---@type string
RawAssetsOptions.windows_asset_dir = wezterm.home_dir .. "\\AppData\\Local\\wezterm\\"

return RawAssetsOptions
