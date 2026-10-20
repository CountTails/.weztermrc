local wezterm = require("wezterm")
local platform = require("utils.platform")

---@class EffectiveAssetOptions
---@field private _raw RawAssetsOptions
---@field active_asset_dir string
local EffectiveAssetOptions = {}
EffectiveAssetOptions.__index = EffectiveAssetOptions

--- Creates an effective loadout from a raw asset options table
---@param raw RawAssetsOptions
---@return EffectiveAssetOptions
function EffectiveAssetOptions:from_raw(raw)
	local this = setmetatable({ _raw = raw }, self)
	this:resolve()
	return this
end

--- Resolves the effective asset directory from the internal raw asset options source
function EffectiveAssetOptions:resolve()
	if platform.os.is_linux() then
		self.active_asset_dir = self._raw.linux_asset_dir
	elseif platform.os.is_mac() then
		self.active_asset_dir = self._raw.macos_asset_dir
	elseif platform.os.is_win() then
		self.active_asset_dir = self._raw.windows_asset_dir
	else
		local err = string.format(
			"[EffectiveAssetOptions:resolve]: unable to resolve platform asset directory: unknown platform: %s",
			wezterm.target_triple
		)
		wezterm.log_error(err)
		error(err)
	end
end

local _resolved = EffectiveAssetOptions:from_raw(require("options.environment.assets"))
return _resolved
