-------------------------------
--   "Catppuccin Mocha" awesome theme   --
-- Adapted from the Dracula theme --
-------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local themes_path = require("gears.filesystem").get_themes_dir()

-- BASICS
local theme = {}
theme.font          = "sans 8"

-- Catppuccin Mocha color palette
theme.bg_focus      = "#45475a"
theme.bg_normal     = "#1e1e2e"
theme.bg_urgent     = "#f38ba8"
theme.bg_minimize   = "#585b70"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#cdd6f4"
theme.fg_focus      = "#a6e3a1"
theme.fg_urgent     = "#f9e2af"
theme.fg_minimize   = "#cdd6f4"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(4)
theme.border_normal = "#1e1e2e"
theme.border_focus  = "#a6e3a1"
theme.border_marked = "#cba6f7"

-- IMAGES
theme.layout_fairh           = themes_path .. "default/layouts/fairh.png"
theme.layout_fairv           = themes_path .. "default/layouts/fairv.png"
theme.layout_floating        = themes_path .. "default/layouts/floating.png"
theme.layout_magnifier       = themes_path .. "default/layouts/magnifier.png"
theme.layout_max             = themes_path .. "default/layouts/max.png"
theme.layout_fullscreen      = themes_path .. "default/layouts/fullscreen.png"
theme.layout_tilebottom      = themes_path .. "default/layouts/tilebottom.png"
theme.layout_tileleft        = themes_path .. "default/layouts/tileleft.png"
theme.layout_tile            = themes_path .. "default/layouts/tile.png"
theme.layout_tiletop         = themes_path .. "default/layouts/tiletop.png"
theme.layout_spiral          = themes_path .. "default/layouts/spiral.png"
theme.layout_dwindle         = themes_path .. "default/layouts/dwindle.png"
theme.layout_cornernw        = themes_path .. "default/layouts/cornernw.png"
theme.layout_cornerne        = themes_path .. "default/layouts/cornerne.png"
theme.layout_cornersw        = themes_path .. "default/layouts/cornersw.png"
theme.layout_cornerse        = themes_path .. "default/layouts/cornerse.png"

theme.awesome_icon           = themes_path .. "default/awesome-icon.png"

theme.menu_submenu_icon     = themes_path .. "default/submenu.png"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- MISC
theme.wallpaper             = themes_path .. "default/background.png"
theme.taglist_squares       = "true"
theme.titlebar_close_button = "true"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "default/titlebar/maximized_focus_active.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
