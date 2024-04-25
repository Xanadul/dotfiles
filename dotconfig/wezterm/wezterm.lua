-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_wayland = true -- false to prevent crashes on startup in Hyprland. However, leads to compositor stuttering in wayland

config.color_scheme = 'Dracula'
--config.color_scheme = "Dracula (Official)" config.color_scheme_dirs = { '$HOME/.config/wezterm/colors' }
--config.color_scheme = "Catppuccin Latte"

config.window_close_confirmation = 'NeverPrompt'

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 18.0

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 35
config.hide_mouse_cursor_when_typing = false


--config.window_background_opacity = 0.85
config.text_background_opacity = 1

config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}


config.set_environment_variables = {
  GTK_THEME="Dracula",
  QT_QPA_PLATFORMTHEME="qt5ct"
}

config.warn_about_missing_glyphs = false


config.harfbuzz_features = {'calt=1', 'clig=1', 'liga=1'} --enables ligatures

-- and finally, return the configuration to wezterm
return config
