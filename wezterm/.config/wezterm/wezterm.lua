local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config = {
  automatically_reload_config = true,

  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",

  use_fancy_tab_bar = true,
  enable_tab_bar = true,
  window_frame = {
    font_size = 12.0,
    font = wezterm.font("Hack Nerd Font", { weight = 'Bold', italic = false }),
  },
  default_cursor_style = "BlinkingBar",
  color_scheme = "Catppuccin Frappe",
  font = wezterm.font("Hack Nerd Font", { weight = 'Bold', italic = false }),
  font_size = 18.0,
  color_scheme = "Catppuccin Frappe",
  window_background_opacity = 0.9,
}

return config