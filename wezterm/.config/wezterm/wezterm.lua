-- Pull the WezTerm API
local wezterm = require 'wezterm'

-- Initialize actual config
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

-- General
config.automatically_reload_config = true
config.check_for_updates = true
config.enable_wayland = true

-- Appearance
config.font = wezterm.font("Hack Nerd Font", { weight = 'Bold', italic = false })
config.font_size = 14.0
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 800
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Window
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.window_close_confirmation = "NeverPrompt"
config.window_frame = {
  font_size = 12.0,
  font = wezterm.font("Hack Nerd Font", { weight = 'Bold', italic = false }),
  active_titlebar_bg = "#1e1e2e", -- Catppuccin Mocha base
  inactive_titlebar_bg = "#181825", -- Catppuccin Mocha mantle
}
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

-- Tab Bar
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false
config.tab_max_width = 25
config.colors = {
  tab_bar = {
    background = "#181825", -- Catppuccin Mocha mantle
    active_tab = {
      bg_color = "#1e1e2e", -- Catppuccin Mocha base
      fg_color = "#cdd6f4", -- Catppuccin Mocha text
    },
    inactive_tab = {
      bg_color = "#181825", -- Catppuccin Mocha mantle
      fg_color = "#a6adc8", -- Catppuccin Mocha subtext0
    },
  },
}

-- Key Bindings
config.keys = {
  {
    key = "t",
    mods = "CMD",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "[",
    mods = "CMD",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "]",
    mods = "CMD",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
}

-- Return config to WezTerm
return config
