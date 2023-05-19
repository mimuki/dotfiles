--------------------------------------------------------------------------------
--                                 hfsdt.lua                                  --
--------------------------------------------------------------------------------
-- v1.7
----- [ Dependencies ] ---------------------------------------------------------
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local theme = {}
----- [ Settings ] -------------------------------------------------------------
theme.font              = "Andika Rats 18" 
theme.notification_font = theme.font

theme.dir = "~/.config/awesome/themes/"

theme.wallpaper = theme.dir .. "dracula/goop_2.png"

theme.hotkeys_font             = "Fantasque Sans Mono 20"
theme.hotkeys_description_font = "Fantasque Sans Mono 20"
----- [ Colours ] --------------------------------------------------------------
theme.black   = "#0f3b3a"
theme.hilight = "#155352"
theme.lolight = "#21222C"
theme.white   = "#ffffff"
theme.red     = "#d74200"
theme.orange  = "#e99f10"
theme.yellow  = "#cfc041"
theme.green   = "#00c420"
theme.blue    = "#40a4b9"
theme.purple  = "#b154cf"
theme.pink    = "#da5bd6"
theme.special = "#b1c9c3"

theme.accent     = theme.yellow
theme.accent_alt = theme.blue

theme.error = theme.red 
theme.warn  = theme.orange

theme.bg = theme.black 
theme.fg = theme.white
----- [ Widgets ] --------------------------------------------------------------
theme.front_fg = theme.bg
theme.front_bg = theme.green
theme.date_fg  = theme.bg
theme.date_bg  = theme.accent_alt
theme.time_fg  = theme.yellow
theme.time_bg  = theme.bg
----- [ Background ] -----------------------------------------------------------
theme.bg_normal     = theme.black
theme.bg_focus      = theme.hilight
theme.bg_urgent     = theme.red
theme.bg_systray    = theme.black
theme.bg_minimize   = theme.hilight

theme.titlebar_bg_normal = theme.hilight
theme.titlebar_bg_focus  = theme.accent
theme.titlebar_bg_urgent = theme.red

theme.hotkeys_label_bg = theme.special

theme.taglist_bg_focus    = theme.black
theme.taglist_bg_occupied = theme.black
theme.taglist_bg_urgent   = theme.black
theme.taglist_bg_empty    = theme.black

theme.tooltip_bg = theme.black

theme.notifcation_bg = theme.black

theme.menu_bg_normal = theme.black
theme.menu_bg_focus  = theme.hilight
----- [ Foreground ] -----------------------------------------------------------
theme.fg_normal     = theme.white
theme.fg_focus      = theme.white
theme.fg_urgent     = theme.white
theme.fg_minimize   = theme.white

theme.titlebar_fg_normal = theme.black
theme.titlebar_fg_focus  = theme.black
theme.titlebar_fg_urgent = theme.black

theme.hotkeys_modifiers_fg = theme.white

theme.taglist_fg_focus    = theme.accent
theme.taglist_fg_occupied = theme.special
theme.taglist_fg_urgent   = theme.red
theme.taglist_fg_empty    = theme.hilight

theme.tooltip_fg = theme.white

theme.notifcation_fg = theme.white

theme.menu_fg_normal = theme.white
theme.menu_fg_focus  = theme.white
----- [ Borders & Gaps ] -------------------------------------------------------
theme.useless_gap       = dpi(0)
theme.gap_single_client = false

theme.border_width  = dpi(7)
theme.border_normal = theme.hilight
theme.border_focus  = theme.accent
theme.border_marked = theme.special

theme.hotkeys_border_width = theme.border_width
theme.hotkeys_border_color = theme.accent_alt
theme.hotkeys_group_margin = dpi(8)

theme.tooltip_border_width = dpi(2)
theme.tooltip_border_color = theme.accent_alt

theme.notification_border_color = theme.accent_alt
theme.notification_border_width = theme.border_width

theme.menu_border_color = theme.accent_alt
theme.menu_border_width = theme.border_width

theme.notification_width  = notificationWidth
-- theme.notification_height = 140
----- [ Other Stuff ] ----------------------------------------------------------
-- ran out of spoons lol
theme.notification_icon_size = 80
theme.menu_submenu_icon = theme.dir .."mimuki/icons/point-right.png"
theme.menu_height = dpi(35)
theme.menu_width  = dpi(250)
----- [ Titlebar Icons ] -------------------------------------------------------
theme.titlebar_close_button_normal = theme.dir .."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.dir .."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme.dir .."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme.dir .."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.dir .."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.dir .."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.dir .."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.dir .."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.dir .."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.dir .."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.dir .."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.dir .."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.dir .."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.dir .."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.dir .."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.dir .."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.dir .."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.dir .."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.dir .."default/titlebar/maximized_focus_active.png"
----- [ Layout Icons ] ---------------------------------------------------------
theme.layout_fairh       = theme.dir .."default/layouts/fairhw.png"
theme.layout_fairv       = theme.dir .."default/layouts/fairvw.png"
theme.layout_floating    = theme.dir .."default/layouts/floatingw.png"
theme.layout_magnifier   = theme.dir .."default/layouts/magnifierw.png"
theme.layout_max         = theme.dir .."mimuki/icons/maximize.png"
theme.layout_fullscreen  = theme.dir .."mimuki/icons/maximize.png"
theme.layout_tilebottom  = theme.dir .."default/layouts/tilebottomw.png"
theme.layout_tileleft    = theme.dir .."default/layouts/tileleftw.png"
theme.layout_tile        = theme.dir .."mimuki/icons/left-right.png"
theme.layout_tiletop     = theme.dir .."mimuki/icons/up-down.png"
theme.layout_spiral      = theme.dir .."default/layouts/spiralw.png"
theme.layout_dwindle     = theme.dir .."default/layouts/dwindlew.png"
theme.layout_cornernw    = theme.dir .."default/layouts/cornernww.png"
theme.layout_cornerne    = theme.dir .."default/layouts/cornernew.png"
theme.layout_cornersw    = theme.dir .."default/layouts/cornersww.png"
theme.layout_cornerse    = theme.dir .."default/layouts/cornersew.png"

theme.lain_icons         = os.getenv("HOME") ..
                           "/.config/awesome/lain/icons/layout/default/"
theme.layout_termfair    = theme.lain_icons .. "termfair.png"
theme.layout_centerfair  = theme.lain_icons .. "centerfair.png"  -- termfair.center
theme.layout_cascade     = theme.lain_icons .. "cascade.png"
theme.layout_cascadetile = theme.lain_icons .. "cascadetile.png" -- cascade.tile
theme.layout_centerwork  = theme.lain_icons .. "centerwork.png"
theme.layout_centerworkh = theme.lain_icons .. "centerworkh.png" -- centerwork.horizontal
----- [ Wibar Icons ] ----------------------------------------------------------
theme.awesome_icon  = theme.dir .."mimuki/icons/logo.png"
theme.terminal_icon = theme.dir .."mimuki/icons/terminal.png"
theme.folder_icon   = theme.dir .."mimuki/icons/folder.png"
theme.window_icon   = theme.dir .."mimuki/icons/windows.png"
theme.list_icon     = theme.dir .."mimuki/icons/list.png"
theme.cpu_icon      = theme.dir .."mimuki/icons/cpu.png"
theme.ram_icon      = theme.dir .."mimuki/icons/ram.png"
theme.vol_icon      = theme.dir .."mimuki/icons/volume.png"

theme.bat_icon          = theme.dir .."mimuki/icons/battery.png"
theme.bat_charging_icon = theme.dir .."mimuki/icons/battery_charging.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
