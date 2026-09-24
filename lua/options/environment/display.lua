---@class RawDisplayOptions
---@field refresh_rate integer the refresh rate to interpret as the display's actual refresh rate
---@field virtual_display_height integer the pixel height to interpret as the display's actual height
---@field virtual_display_width integer the pixel height to interpret as the display's actual width
---@field reference_display_width integer the pixel width for interpret as the display's reference width
local RawDisplayOptions = {}

--- EDIT this value to specify what the assumed display refresh rate to use in configuration
---@type integer the assumed FPS for the display environment
RawDisplayOptions.refresh_rate = 144

--- EDIT this value to specify what the assumed display height used in configuration is
---@type integer the assumed display height
RawDisplayOptions.virtual_display_height = 2880

--- EDIT this value to specify what the assumed display width used in configuration is
---@type integer the assumed display width
RawDisplayOptions.virtual_display_width = 10240

--- EDIT this value to specify what the reference display used in configuration is
---@type integer the reference display width
RawDisplayOptions.reference_display_width = 1440

return RawDisplayOptions
