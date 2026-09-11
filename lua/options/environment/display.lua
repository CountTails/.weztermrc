---@class RawDisplayOptions
---@field reference_pixel_density integer the PPI or DPI to use as a reference or default if not available
---@field effective_pixel_density integer the PPI or DPI to interpret as the display's actual pixel density
---@field reference_refresh_rate integer the refresh rate to use as a reference or default if not available
---@field effective_refresh_rate integer the refresh rate to interpret as the display's actual refresh rate
---@field effective_display_height integer the pixel height to interpret as the display's actual height
---@field effective_display_width integer the pixel height to interpret as the display's actual width
local RawDisplayOptions = {}

--- EDIT this value to specify the reference/default PPI or DPI to use in configuration calculations
---@type integer the fallback value for DPI or PPI if a reasonable value is not obtainable
RawDisplayOptions.reference_pixel_density = 72

--- EDIT this value to specify the reference/default FPS to use in configuration
---@type integer the fallback value for FPS if a reasonable value is not obtainable
RawDisplayOptions.reference_refresh_rate = 30

--- EDIT this value to specify what the assumed PPI or DPI should be in configuration calculations
---@type integer the assumed value for PPI or DPI
RawDisplayOptions.effective_pixel_density = 144

--- EDIT this value to specify what the assumed display refresh rate to use in configuration
---@type integer the assumed FPS for the display environment
RawDisplayOptions.effective_refresh_rate = 144

--- EDIT this value to specify what the assumed display height used in configuration is
---@type integer the assumed display height
RawDisplayOptions.effective_display_height = 2880

--- EDIT this value to specify what the assumed display width used in configuration is
---@type integer the assumed display width
RawDisplayOptions.effective_display_width = 10240

return RawDisplayOptions
