-- Pull the WezTerm API
local wezterm = require 'wezterm'

-- Initialize actual config
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- General
config.automatically_reload_config = true

-- Appearance
config.font = wezterm.font("Hack Nerd Font", { weight = 'Bold', italic = false })
config.font_size = 14.0
config.color_scheme = "Catppuccin Frappe"
config.default_cursor_style = "BlinkingBar"

-- Window
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.window_close_confirmation = "NeverPrompt"
config.window_frame = {
  font_size = 12.0,
  font = wezterm.font("Hack Nerd Font", { weight = 'Bold', italic = false }),
}

-- Tab Bar
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false

-- Return config to WezTerm
return config