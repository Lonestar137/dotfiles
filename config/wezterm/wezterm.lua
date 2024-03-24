
local wezterm = require 'wezterm'

-- Table to hold the config
local config = {}

-- Newer versions use config builder, which provides better error messages.
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_tab_bar = false

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

return config
