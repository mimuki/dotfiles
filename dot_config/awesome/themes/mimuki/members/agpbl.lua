--------------------------------------------------------------------------------
--                                 theme.lua                                  --
--------------------------------------------------------------------------------
-- v1.8
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
theme.black   = "#000000"
theme.hilight = "#44475a"
theme.lolight = "#21222C"
theme.white   = "#ffffff" 
theme.red     = "#a00103"
theme.orange  = "#ffb86c"
theme.yellow  = "#ffdd00"
theme.green   = "#50fa7b"
theme.blue    = "#0021bc"
theme.purple  = "#bd93f9"
theme.pink    = "#ff79c6"
theme.special = "#6272a4"

theme.accent        = theme.yellow
theme.accent_fg     = theme.black 
theme.accent_alt    = theme.orange
theme.accent_alt_fg = theme.black

theme.error = theme.red 
theme.warn  = theme.orange

theme.bg = theme.black 
theme.fg = theme.white
----- [ Widgets ] --------------------------------------------------------------
theme.front_fg = theme.accent_fg
theme.front_bg = theme.accent 
theme.date_fg  = theme.white
theme.date_bg  = theme.red
theme.time_fg  = theme.white
theme.time_bg  = theme.blue
----- [ Background ] -----------------------------------------------------------
theme.bg_normal     = theme.bg
theme.bg_focus      = theme.hilight
theme.bg_urgent     = theme.red
theme.bg_systray    = theme.bg
theme.bg_minimize   = theme.hilight

theme.titlebar_bg_normal = theme.hilight
theme.titlebar_bg_focus  = theme.accent
theme.titlebar_bg_urgent = theme.red

theme.hotkeys_label_bg = theme.special

theme.taglist_bg_focus    = theme.accent
theme.taglist_bg_occupied = theme.special
theme.taglist_bg_urgent   = theme.red
theme.taglist_bg_empty    = theme.hilight

theme.tooltip_bg = theme.bg

theme.notifcation_bg = theme.bg

theme.menu_bg_normal = theme.bg
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

theme.tasklist_fg_focus = theme.accent_fg

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
-- task list
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
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
theme.layout_fairv       = theme.dir .."mimuki/layouts/fair_v.png"
theme.layout_fairh       = theme.dir .."mimuki/layouts/fair_h.png"

theme.layout_floating    = theme.dir .."mimuki/layouts/floating.png"

theme.layout_tile        = theme.dir .."mimuki/layouts/tile.png"
theme.layout_tileleft    = theme.dir .."mimuki/layouts/tile_left.png"
theme.layout_tilebottom  = theme.dir .."mimuki/layouts/tilebottom.png"
theme.layout_tiletop     = theme.dir .."mimuki/layouts/tiletop.png"

theme.layout_spiral      = theme.dir .."mimuki/layouts/spiral.png"
theme.layout_dwindle     = theme.dir .."mimuki/layouts/dwindle.png"
theme.layout_max         = theme.dir .."mimuki/layouts/max.png"
theme.layout_fullscreen  = theme.dir .."mimuki/layouts/max.png"

theme.layout_magnifier   = theme.dir .."mimuki/layouts/magnifier.png"

theme.layout_cornernw    = theme.dir .."mimuki/layouts/corner_nw.png"
theme.layout_cornerne    = theme.dir .."mimuki/layouts/corner_ne.png"
theme.layout_cornersw    = theme.dir .."mimuki/layouts/corner_sw.png"
theme.layout_cornerse    = theme.dir .."mimuki/layouts/corner_se.png"
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
