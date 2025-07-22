-- ====================================================================
-- WezTerm Configuration
-- ====================================================================
-- This file is structured into logical sections for easier maintenance.

local wezterm = require "wezterm"
local act = wezterm.action
local config = {}

-- On Wayland, we can let the compositor handle decorations.
if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
  config.window_decorations = "NONE"
end

-- ====================================================================
-- Color Palette (GitHub Dark Inspired)
-- ====================================================================
local colors = {
  fg = "#d0d7de",
  bg = "#0d1117",
  comment = "#8b949e",
  red = "#ff7b72",
  green = "#3fb950",
  yellow = "#d29922",
  blue = "#539bf5",
  magenta = "#bc8cff",
  cyan = "#39c5cf",
  selection = "#415555",
  caret = "#58a6ff",
  invisibles = "#2f363d",
}

-- ====================================================================
-- Font Configuration
-- ====================================================================
config.font = wezterm.font_with_fallback({
  { family = 'SauceCodePro Nerd Font Mono', weight = 'Regular' },
  { family = 'FiraCode Nerd Font Mono', weight = 'Regular' },
  { family = 'Noto Naskh Arabic', weight = 'Regular' },
  { family = 'Amiri', weight = 'Regular' },
  { family = 'Symbols Nerd Font Mono', weight = 'Regular' },
})
config.font_size = 16.0

-- ====================================================================
-- Window & Appearance
-- ====================================================================
config.window_background_opacity = 0.80
config.text_background_opacity = 1.0
config.line_height = 1.1
config.enable_scroll_bar = false
config.warn_about_missing_glyphs = false

-- ====================================================================
-- Tab Bar Configuration
-- ====================================================================
config.use_fancy_tab_bar = true
config.window_frame = {
  font = wezterm.font { family = 'FiraCode Nerd Font Mono', weight = 'Regular' },
  font_size = 12.0,
  active_titlebar_bg = colors.bg,
}

-- ====================================================================
-- Performance & Behavior
-- ====================================================================
config.max_fps = 120
config.animation_fps = 1
config.term = "xterm-256color"

-- ====================================================================
-- Key Bindings
-- ====================================================================
config.keys = {
  { mods = "ALT", key = "`", action = act.SplitPane { direction = "Right", size = { Percent = 30 } } },
  { mods = "ALT", key = "Tab", action = act.SplitPane { direction = "Down", size = { Percent = 30 } } },
  { mods = "ALT", key = "Enter", action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { mods = "ALT", key = "\\", action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { mods = "ALT", key = "w", action = act.CloseCurrentPane { confirm = true } },
  { mods = "ALT", key = "LeftArrow", action = act.ActivatePaneDirection 'Left' },
  { mods = "ALT", key = "RightArrow", action = act.ActivatePaneDirection 'Right' },
  { mods = "ALT", key = "UpArrow", action = act.ActivatePaneDirection 'Up' },
  { mods = "ALT", key = "DownArrow", action = act.ActivatePaneDirection 'Down' },
  { mods = "ALT", key = "t", action = act.SpawnTab 'CurrentPaneDomain' },
  { mods = "ALT", key = "q", action = act.CloseCurrentTab { confirm = true } },
  { mods = "ALT", key = "1", action = act.ActivateTab(0) },
  { mods = "ALT", key = "2", action = act.ActivateTab(1) },
  { mods = "ALT", key = "3", action = act.ActivateTab(2) },
  { mods = "ALT", key = "4", action = act.ActivateTab(3) },
  { mods = "ALT", key = "5", action = act.ActivateTab(4) },
  { mods = "ALT", key = "6", action = act.ActivateTab(5) },
  { mods = "ALT", key = "7", action = act.ActivateTab(6) },
  { mods = "ALT", key = "8", action = act.ActivateTab(7) },
  { mods = "CTRL|ALT", key = "UpArrow", action = act.ActivateLastTab },
  { mods = "CTRL|ALT", key = "DownArrow", action = act.ActivateLastTab },
  { mods = "CTRL|ALT", key = "LeftArrow", action = act.MoveTabRelative(-1) },
  { mods = "CTRL|ALT", key = "RightArrow", action = act.MoveTabRelative(1) },
  { mods = "ALT", key = "c", action = act.CopyTo 'ClipboardAndPrimarySelection' },
  { mods = "ALT", key = "v", action = act.PasteFrom 'Clipboard' },
  { mods = "SHIFT|ALT", key = "v", action = act.PasteFrom 'PrimarySelection' }, 
  { mods = "ALT", key = "+", action = act.IncreaseFontSize },
  { mods = "ALT", key = "-", action = act.DecreaseFontSize },
  { mods = "ALT", key = "*", action = act.ResetFontSize },
}

-- ====================================================================
-- Mouse Bindings
-- ====================================================================
config.mouse_bindings = {
  { event = { Down = { streak = 1, button = "Right" } }, mods = "NONE", action = act.CopyTo("Clipboard") },
  { event = { Down = { streak = 1, button = "Middle" } }, mods = "NONE", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { event = { Down = { streak = 1, button = "Middle" } }, mods = "SHIFT", action = act.CloseCurrentPane { confirm = false } },
}

-- ====================================================================
-- Color Scheme Application
-- ====================================================================
config.colors = {
  foreground = colors.fg,
  background = colors.bg,
  cursor_bg = colors.caret,
  cursor_fg = colors.bg,
  cursor_border = colors.caret,
  selection_fg = colors.fg,
  selection_bg = colors.selection,
  scrollbar_thumb = colors.invisibles,
  split = colors.invisibles,
  ansi = {
    colors.invisibles, colors.red, colors.green, colors.yellow,
    colors.blue, colors.magenta, colors.cyan, colors.fg,
  },
  brights = {
    colors.comment, "#ff9790", "#6af28c", "#e3b341",
    "#79c0ff", "#d2a8ff", "#56d4dd", "#ffffff",
  },
  tab_bar = {
    background = colors.bg,
    active_tab = { bg_color = colors.blue, fg_color = colors.bg, intensity = "Bold" },
    inactive_tab = { bg_color = colors.bg, fg_color = colors.comment },
    inactive_tab_hover = { bg_color = "#21262d", fg_color = colors.caret },
    new_tab = { bg_color = colors.bg, fg_color = colors.caret, intensity = "Bold" },
    new_tab_hover = { bg_color = "#21262d", fg_color = colors.red },
    inactive_tab_edge = colors.invisibles,
  },
}

-- ====================================================================
-- Platform-Specific Overrides
-- ====================================================================
-- Uncomment and use this if you have issues with NVIDIA drivers
-- or other GPU-related glitches on Wayland.
--[[
  local function is_nvidia_gpu()
    local handle = io.popen("lspci -k | grep -A 2 -E '(VGA|3D)'")
    if handle then
      local result = handle:read("*a")
      handle:close()
      return result:find("nvidia")
    end
    return false
  end

  if is_nvidia_gpu() then
    wezterm.log_info("NVIDIA GPU detected, applying stability settings.")
    config.enable_wayland = false
    config.front_end = "OpenGL"
    config.webgpu_power_preference = "HighPerformance"
    config.prefer_egl = true
    config.freetype_load_target = "Light"
    config.freetype_render_target = "HorizontalLcd"
  end
]]

-- Return config table
return config
