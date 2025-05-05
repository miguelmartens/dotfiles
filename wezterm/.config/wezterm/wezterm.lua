-- Pull the WezTerm API
local wezterm = require 'wezterm'

-- Initialize actual config
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Frappe"
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
  active_titlebar_bg = "#303446", -- Catppuccin Frappe base
  inactive_titlebar_bg = "#232634", -- Catppuccin Frappe mantle
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
    background = "#232634", -- Catppuccin Frappe mantle
    active_tab = {
      bg_color = "#303446", -- Catppuccin Frappe base
      fg_color = "#c6d0f5", -- Catppuccin Frappe text
    },
    inactive_tab = {
      bg_color = "#232634", -- Catppuccin Frappe mantle
      fg_color = "#a5adce", -- Catppuccin Frappe subtext0
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
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentTab({ confirm = false }),
  },
  {
    key = "h",
    mods = "CMD",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "v",
    mods = "CMD",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
}

-- Return config to WezTerm
return config
