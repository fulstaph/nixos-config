local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.use_fancy_tab_bar = false
config.enable_tab_bar = false

config.window_background_opacity = 0.8
config.font = wezterm.font_with_fallback({
    "JetBrainsMono",
    "FiraCode"
})
config.font_size = 10.0

-- Set up colour scheme
config.color_scheme = 'Catppuccin Mocha'

return config
