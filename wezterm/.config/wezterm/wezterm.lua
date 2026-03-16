-- Pull the WezTerm API
local wezterm = require 'wezterm'

-- Initialize actual config
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Zed One Dark color scheme (from Zed IDE's default theme)
config.color_schemes = {
  ["Zed One Dark"] = {
    foreground = "#abb2bf",
    background = "#282c34",
    cursor_bg = "#74ade8",
    cursor_fg = "#282c34",
    cursor_border = "#74ade8",
    selection_fg = "#282c34",
    selection_bg = "rgba(116, 173, 232, 0.24)",
    split = "#363c46",
    ansi = {
      "#282c34",
      "#e06c75",
      "#98c379",
      "#e5c07b",
      "#61afef",
      "#c678dd",
      "#56b6c2",
      "#abb2bf",
    },
    brights = {
      "#636d83",
      "#ea858b",
      "#aad581",
      "#ffd885",
      "#85c1ff",
      "#d398eb",
      "#6ed5de",
      "#fafafa",
    },
  },
}


-- General
config.automatically_reload_config = true
config.check_for_updates = true
config.enable_wayland = true

-- Appearance (Zed default: .ZedMono = Lilex, 15pt)
-- Note: .ZedMono aliases to Lilex in Zed. Zed Mono Nerd Font is a different font (Iosevka-based from zed-fonts).
config.font = wezterm.font_with_fallback({
  "Lilex Nerd Font",
  "Lilex",
  "Hack Nerd Font",
})
config.font_size = 15.0
config.color_scheme = "Zed One Dark"
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 800
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Window (Zed One Dark: title_bar #3b414d, inactive #2e343e)
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 1.0
config.window_close_confirmation = "NeverPrompt"
config.window_frame = {
  font_size = 12.0,
  font = wezterm.font("Lilex Nerd Font", { weight = "Regular" }),
  active_titlebar_bg = "#3b414d",
  inactive_titlebar_bg = "#2e343e",
}
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

-- Tab Bar (Zed: tab_bar #2f343e, active #282c33, text #dce0e5 / #a9afbc)
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.native_macos_fullscreen_mode = false
config.tab_max_width = 25
config.colors = {
  tab_bar = {
    background = "#2f343e",
    active_tab = {
      bg_color = "#282c33",
      fg_color = "#dce0e5",
    },
    inactive_tab = {
      bg_color = "#2f343e",
      fg_color = "#a9afbc",
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
