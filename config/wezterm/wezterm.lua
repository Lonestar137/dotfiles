
local wezterm = require 'wezterm'

-- Table to hold the config
local config = {}

-- Newer versions use config builder, which provides better error messages.
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_tab_bar = false
config.enable_wayland = false -- required for hyprland

-- config.color_scheme = 'GruvboxDarkHard'
-- config.color_scheme = 'Tomorrow Night Burns'
config.color_scheme = 'Molokai'
-- config.color_scheme = 'Spacedust (Gogh)'
--config.color_scheme = 'Treehouse'
-- config.color_scheme = 'Shaman'
-- config.color_scheme = 'Setti'
-- config.color_scheme = 'Monkai Soda'
-- config.color_scheme = 'Breath Darker (Gogh)'
-- config.color_scheme = 'Hardcore'
-- config.color_scheme = 'Geohot (Gogh)'


local My_font_size = 14.0
local Font_size = My_font_size

function Recompute_font_size(window)
    local window_dims = window:get_dimensions()
    local overrides = window:get_config_overrides() or {}
    local Dpi = window_dims.dpi / 96
    local Scale_factor_general = 7
    local Scale_factor_x = window_dims.pixel_width / ( Scale_factor_general * 9 * Dpi )
    local Scale_factor_y = window_dims.pixel_height / ( Scale_factor_general * 7 * Dpi )
    local Scale_factor = Scale_factor_x

    if (Scale_factor_y > Scale_factor_x)
    then
        Scale_factor = Scale_factor_x
    else
        Scale_factor = Scale_factor_y
    end

    if Scale_factor > My_font_size
    then
        Font_size = My_font_size
    else
        Font_size = math.floor(Scale_factor)
    end
    overrides.font_size = Font_size
    window:set_config_overrides(overrides)
end

wezterm.on('window-resized', function(window)
    Recompute_font_size(window)
end)

return config
