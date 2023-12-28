-- [ Dependancies ] ------------------------------------------------------------
-- Only used for generating:
-- - Taglist squares
-- - The awesomewm logo icon
local themeAssets = require("beautiful.theme_assets")

local gfs = require("gears.filesystem")
local path = "~/.config/awesome/themes/"

local theme = {}
-- [ Settings ] ----------------------------------------------------------------
-- [ Basic Colours ] --
theme.black  = { main = "#000000", contrast = "#FFFFFF" }
theme.white  = { main = "#FFFFFF", contrast = theme.black.main }
theme.grey   = { main = "#444751", contrast = theme.white.main }

theme.grey100 = { main = "#FAFAFA", contrast = theme.black.main }
theme.grey200 = { main = "#EEEEEE", contrast = theme.black.main }
theme.grey300 = { main = "#E0E0E0", contrast = theme.black.main }
theme.grey400 = { main = "#BDBDBD", contrast = theme.black.main }
theme.grey500 = { main = "#9E9E9E", contrast = theme.white.main }
theme.grey600 = { main = "#757575", contrast = theme.white.main }
theme.grey700 = { main = "#616161", contrast = theme.white.main }
theme.grey800 = { main = "#424242", contrast = theme.white.main }
theme.grey900 = { main = "#212121", contrast = theme.white.main }

theme.red    = { main = "#ff5555", contrast = theme.black.main }
theme.orange = { main = "#ffb86c", contrast = theme.black.main }
theme.yellow = { main = "#f1fa8c", contrast = theme.black.main }
theme.green  = { main = "#50fa7b", contrast = theme.black.main }
theme.cyan   = { main = "#8be9fd", contrast = theme.black.main }
theme.blue   = { main = "#6272a4", contrast = theme.black.main }
theme.purple = { main = "#bd93f9", contrast = theme.black.main }
theme.pink   = { main = "#ff79c6", contrast = theme.black.main }
-- [ Terminal Colours ] --
theme.c00 = { main = "#21222c", contrast = theme.white.main } -- black
theme.c01 = { main = "#ff5555", contrast = theme.black.main } -- red
theme.c02 = { main = "#50fa7b", contrast = theme.black.main } -- green
theme.c03 = { main = "#f1fa8c", contrast = theme.black.main } -- yellow
theme.c04 = { main = "#bd93f9", contrast = theme.black.main } -- blue
theme.c05 = { main = "#ff79c6", contrast = theme.black.main } -- magenta
theme.c06 = { main = "#8be9fd", contrast = theme.black.main } -- cyan
theme.c07 = { main = "#f8f8f2", contrast = theme.black.main } -- white
theme.c08 = { main = "#6272a4", contrast = theme.white.main } -- bright black
theme.c09 = { main = "#ff6e6e", contrast = theme.black.main } -- bright red
theme.c10 = { main = "#69ff94", contrast = theme.black.main } -- bright green
theme.c11 = { main = "#f1ffa5", contrast = theme.black.main } -- bright yellow
theme.c12 = { main = "#d6acff", contrast = theme.black.main } -- bright blue
theme.c13 = { main = "#ff92df", contrast = theme.black.main } -- bright magenta
theme.c14 = { main = "#a4ffff", contrast = theme.black.main } -- bright cyan
theme.c15 = { main = "#ffffff", contrast = theme.black.main } -- bright white
-- [ UI Colours ] --
theme.bg = theme.white.main
theme.fg = theme.black.main

theme.accents = { 
  primary = theme.grey800, 
  secondary = theme.grey400, 
  tertiary = theme.grey200 
}

theme.error = theme.grey500
theme.warn  = theme.grey300
-- [ Defaults ] ----------------------------------------------------------------
theme.font          = "Cantarell 16"

theme.bg_normal     = theme.bg
theme.bg_focus      = theme.grey600.main
theme.bg_urgent     = theme.error.main
theme.bg_minimize   = theme.accents.tertiary.main
theme.bg_systray    = theme.grey200.main

theme.fg_normal     = theme.fg
theme.fg_focus      = theme.grey600.contrast
theme.fg_urgent     = theme.error.contrast
theme.fg_minimize   = theme.grey200.contrast

theme.useless_gap   = dpi(2) -- changed in screens.lua, varies per tag
theme.border_width  = dpi(1)
theme.border_normal = theme.grey200.main
theme.border_focus  = theme.accents.primary.main
theme.border_marked = theme.accents.secondary.main

-- [ Taglist ] --
theme.taglist_bg_focus    = theme.accents.primary.main
theme.taglist_bg_urgent   = theme.error.main
theme.taglist_bg_occupied = theme.grey300.main
theme.taglist_bg_empty    = theme.bg
theme.taglist_bg_volatile = theme.accents.secondary.main

theme.taglist_fg_focus    = theme.accents.primary.contrast
theme.taglist_fg_urgent   = theme.error.contrast
theme.taglist_fg_occupied = theme.grey300.contrast
theme.taglist_fg_empty    = theme.fg
theme.taglist_fg_volatile = theme.accents.secondary.contrast

-- [ Tasklist ] --
theme.tasklist_bg_focus  = theme.accents.tertiary.main
theme.tasklist_bg_urgent = theme.error.main
theme.tasklist_fg_focus  = theme.accents.tertiary.contrast
theme.tasklist_fg_urgent = theme.error.contrast

-- [ Titlebar ] --
theme.titlebar_bg_normal = theme.grey100.main
theme.titlebar_bg_focus  = theme.grey300.main
theme.titlebar_fg_normal = theme.grey100.contrast
theme.titlebar_fg_focus  = theme.grey300.contrast

-- [ Tooltip ] --
theme.tooltip_font    = theme.font
theme.tooltip_opacity = 1
theme.tooltip_fg = theme.fg
theme.tooltip_bg = theme.bg
theme.tooltip_border_width = theme.border_width
theme.tooltip_border_color = theme.bg
theme.tooltip_align = "left"
theme.tooltip_mode  = "outside"

-- [ Prompt ] --
-- IMO you should just use rofi, but I'm a comment, not a cop
theme.prompt_font = theme.font
theme.prompt_fg = theme.accents.secondary.contrast
theme.prompt_bg = theme.accents.secondary.main
theme.prompt_fg_cursor = theme.grey.contrast
theme.prompt_bg_cursor = theme.grey.main

theme.hotkeys_bg = theme.bg
theme.hotkeys_fg = theme.fg
theme.hotkeys_border_width = theme.border_width
theme.hotkeys_border_color = theme.accents.secondary.main
--theme.hotkeys_shape =
--theme.hotkeys_opacity =
theme.hotkeys_modifiers_fg = theme.accents.primary.main
theme.hotkeys_label_bg = theme.accents.primary.main
theme.hotkeys_label_fg = theme.accents.primary.contrast
theme.hotkeys_group_margin = theme.border_width
theme.hotkeys_font = theme.font
theme.hotkeys_description_font = theme.font


--theme.notification_font = 
--theme.notification_bg = 
--theme.notification_fg = 
--theme.notification_width =
--theme.notification_height =
--theme.notification_margin =
--theme.notification_border_color =
--theme.notification_border_width =
--theme.notification_shape =
--theme.notification_opacity =


-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = path.."default/submenu.png"
theme.menu_height = dpi(25)
theme.menu_width  = dpi(200)

-- Uncomment to generate taglist squares:
-- (the little squares that show if a tag has contents/focus
--local taglist_square_size = dpi(4)
--theme.taglist_squares_sel = themeAssets.taglist_squares_sel(
--    taglist_square_size, theme.fg_normal
--)
--theme.taglist_squares_unsel = themeAssets.taglist_squares_unsel(
--    taglist_square_size, theme.fg_normal
--)

-- Define the image to load
theme.titlebar_close_button_normal = path.."default/titlebar/close.svg"

theme.titlebar_more_button_active = theme.titlebar_close_button_normal
theme.titlebar_more_button_inactive = theme.titlebar_close_button_normal
theme.titlebar_close_button_focus  = path.."default/titlebar/close.svg"

theme.titlebar_minimize_button_normal = path.."default/titlebar/minimize.svg"
theme.titlebar_minimize_button_focus  = path.."default/titlebar/minimize.svg"

theme.titlebar_ontop_button_normal_inactive = path.."default/titlebar/ontop.svg"
theme.titlebar_ontop_button_focus_inactive  = path.."default/titlebar/ontop.svg"
theme.titlebar_ontop_button_normal_active = path.."default/titlebar/ontop_active.svg"
theme.titlebar_ontop_button_focus_active  = path.."default/titlebar/ontop_active.svg"

theme.titlebar_sticky_button_normal_inactive = path.."default/titlebar/sticky.svg"
theme.titlebar_sticky_button_focus_inactive  = path.."default/titlebar/sticky.svg"
theme.titlebar_sticky_button_normal_active = path.."default/titlebar/sticky_active.svg"
theme.titlebar_sticky_button_focus_active  = path.."default/titlebar/sticky_active.svg"

theme.titlebar_floating_button_normal_inactive = path.."default/titlebar/floating.svg"
theme.titlebar_floating_button_focus_inactive  = path.."default/titlebar/floating.svg"
theme.titlebar_floating_button_normal_active = path.."default/titlebar/floating_active.svg"
theme.titlebar_floating_button_focus_active  = path.."default/titlebar/floating_active.svg"

theme.titlebar_maximized_button_normal_inactive = path.."default/titlebar/maximized.svg"
theme.titlebar_maximized_button_focus_inactive  = path.."default/titlebar/maximized.svg"
theme.titlebar_maximized_button_normal_active = path.."default/titlebar/maximized_active.svg"
theme.titlebar_maximized_button_focus_active  = path.."default/titlebar/maximized_active.svg"

theme.wallpaper = path.."default/background.png"
theme.wallpaper_alt = path.."default/black/jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = path.."default/layouts/fairhw.png"
theme.layout_fairv = path.."default/layouts/fairvw.png"
theme.layout_floating  = path.."default/layouts/floatingw.png"
theme.layout_magnifier = path.."default/layouts/magnifierw.png"
theme.layout_max = path.."default/layouts/maxw.png"
theme.layout_fullscreen = path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = path.."default/layouts/tileleftw.png"
theme.layout_tile = path.."default/layouts/tilew.png"
theme.layout_tiletop = path.."default/layouts/tiletopw.png"
theme.layout_spiral  = path.."default/layouts/spiralw.png"
theme.layout_dwindle = path.."default/layouts/dwindlew.png"
theme.layout_cornernw = path.."default/layouts/cornernww.png"
theme.layout_cornerne = path.."default/layouts/cornernew.png"
theme.layout_cornersw = path.."default/layouts/cornersww.png"
theme.layout_cornerse = path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = themeAssets.awesome_icon(
  theme.menu_height, theme.grey200.main, theme.grey600.main
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

