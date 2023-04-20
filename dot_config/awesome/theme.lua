--------------------------------------------------------------------------------
--                                 theme.lua                                  --
--------------------------------------------------------------------------------

----- [ Dependencies ] ---------------------------------------------------------
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
require("vars")
----- [ Settings ] -------------------------------------------------------------
local theme = {}
theme.font              = theme_font 
theme.notification_font = theme_font

theme.hotkeys_font             = "Fantasque Sans Mono 20"
theme.hotkeys_description_font = "Fantasque Sans Mono 20"
----- [ Background ] ----------------------------------------------------------
theme.bg_normal     = theme_bg
theme.bg_focus      = theme_select
theme.bg_urgent     = theme_red
theme.bg_systray    = theme_bg
theme.bg_minimize   = theme_select

theme.titlebar_bg_normal = theme_select
theme.titlebar_bg_focus  = theme_accent
theme.titlebar_bg_urgent = theme_red

theme.hotkeys_label_bg = theme_special

theme.taglist_bg_focus    = theme_bg
theme.taglist_bg_occupied = theme_bg
theme.taglist_bg_urgent   = theme_bg
theme.taglist_bg_empty    = theme_bg

theme.tooltip_bg = theme_bg

theme.notifcation_bg = theme_bg

theme.menu_bg_normal = theme_bg
theme.menu_bg_focus  = theme_select
----- [ Foreground ] ------------------------------------------------------------
theme.fg_normal     = theme_fg
theme.fg_focus      = theme_fg
theme.fg_urgent     = theme_fg
theme.fg_minimize   = theme_fg

theme.titlebar_fg_normal = theme_bg
theme.titlebar_fg_focus  = theme_bg
theme.titlebar_fg_urgent = theme_bg

theme.hotkeys_modifiers_fg = theme_fg

theme.taglist_fg_focus    = theme_purple
theme.taglist_fg_occupied = theme_special
theme.taglist_fg_urgent   = theme_red
theme.taglist_fg_empty    = theme_select

theme.tooltip_fg = theme_fg

theme.notifcation_fg = theme_fg

theme.menu_fg_normal = theme_fg
theme.menu_fg_focus  = theme_fg
----- [ Borders & Gaps ] -------------------------------------------------------
theme.useless_gap       = theme_useless_gap 
theme.gap_single_client = false

theme.border_width  = theme_border_width
theme.border_normal = theme_select
theme.border_focus  = theme_accent
theme.border_marked = theme_special

theme.hotkeys_border_width = theme_border_width
theme.hotkeys_border_color = theme_accent_alt
theme.hotkeys_group_margin = dpi(8)

theme.tooltip_border_width = dpi(2)
theme.tooltip_border_color = theme_accent_alt

theme.notification_border_color = theme_accent_alt
theme.notification_border_width = theme_border_width

theme.menu_border_color = theme_accent_alt
theme.menu_border_width = theme_border_width

theme.notification_width  = 560
theme.notification_height = 140
----- [ Other Stuff ] ----------------------------------------------------------
-- ran out of spoons lol
theme.menu_submenu_icon = themePath.."mimuki/icons/point-right.png"
theme.menu_height = dpi(35)
theme.menu_width  = dpi(250)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themePath.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themePath.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themePath.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themePath.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themePath.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themePath.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themePath.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themePath.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themePath.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themePath.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themePath.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themePath.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themePath.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themePath.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themePath.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themePath.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themePath.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themePath.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themePath.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themePath.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = themePath.."dracula/goop_2.png"

-- You can use your own layout icons like this:
theme.layout_fairh       = themePath.."default/layouts/fairhw.png"
theme.layout_fairv       = themePath.."default/layouts/fairvw.png"
theme.layout_floating    = themePath.."default/layouts/floatingw.png"
theme.layout_magnifier   = themePath.."default/layouts/magnifierw.png"
theme.layout_max         = themePath.."mimuki/icons/maximize.png"
theme.layout_fullscreen  = themePath.."mimuki/icons/maximize.png"
theme.layout_tilebottom  = themePath.."default/layouts/tilebottomw.png"
theme.layout_tileleft    = themePath.."default/layouts/tileleftw.png"
theme.layout_tile        = themePath.."mimuki/icons/left-right.png"
theme.layout_tiletop     = themePath.."mimuki/icons/up-down.png"
theme.layout_spiral      = themePath.."default/layouts/spiralw.png"
theme.layout_dwindle     = themePath.."default/layouts/dwindlew.png"
theme.layout_cornernw    = themePath.."default/layouts/cornernww.png"
theme.layout_cornerne    = themePath.."default/layouts/cornernew.png"
theme.layout_cornersw    = themePath.."default/layouts/cornersww.png"
theme.layout_cornerse    = themePath.."default/layouts/cornersew.png"

theme.lain_icons         = os.getenv("HOME") ..
                           "/.config/awesome/lain/icons/layout/default/"
theme.layout_termfair    = theme.lain_icons .. "termfair.png"
theme.layout_centerfair  = theme.lain_icons .. "centerfair.png"  -- termfair.center
theme.layout_cascade     = theme.lain_icons .. "cascade.png"
theme.layout_cascadetile = theme.lain_icons .. "cascadetile.png" -- cascade.tile
theme.layout_centerwork  = theme.lain_icons .. "centerwork.png"
theme.layout_centerworkh = theme.lain_icons .. "centerworkh.png" -- centerwork.horizontal

theme.awesome_icon = themePath.."mimuki/icons/logo.png"
theme.terminal_icon = themePath.."mimuki/icons/terminal.png"
theme.folder_icon = themePath.."mimuki/icons/folder.png"
theme.window_icon = themePath.."mimuki/icons/windows.png"
theme.list_icon = themePath.."mimuki/icons/list.png"
theme.cpu_icon = themePath.."mimuki/icons/cpu.png"
theme.ram_icon = themePath.."mimuki/icons/ram.png"
theme.bat_icon = themePath.."mimuki/icons/battery.png"
theme.bat_charging_icon = themePath.."mimuki/icons/battery_charging.png"
theme.vol_icon = themePath.."mimuki/icons/logo.png"


-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme