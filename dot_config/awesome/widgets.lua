--------------------------------------------------------------------------------
--                                widgets.lua                                 --
--                                                                            --
-- Last edit: 26/01/23                        Made with love by kulupu Mimuki --
--------------------------------------------------------------------------------

----- [ Dependencies ] ---------------------------------------------------------
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local wibox = require("wibox")

local lain = require("lain")
local markup = lain.util.markup
local separators = lain.util.separators

battery_widget = require("battery-widget")
require("vars")
----- [ Separators ] -----------------------------------------------------------
blank_pink=wibox.widget.textbox(" ")

arrow_bg_select   = separators.arrow_right(theme_bg,     theme_select)
arrow_bg_pink     = separators.arrow_right(theme_bg,     theme_pink)
arrow_bg_blue     = separators.arrow_right(theme_bg,     theme_blue)
arrow_pink_purple = separators.arrow_right(theme_pink,   theme_purple)
arrow_pink_bg     = separators.arrow_right(theme_pink,   theme_bg)
arrow_purple_blue = separators.arrow_right(theme_purple, theme_blue)
arrow_purple_pink = separators.arrow_right(theme_purple, theme_pink)
arrow_blue_purple = separators.arrow_right(theme_blue,   theme_purple)
arrow_blue_bg     = separators.arrow_right(theme_blue,   theme_bg)
arrow_select_bg   = separators.arrow_right(theme_select, theme_bg)
arrow_select_blue = separators.arrow_right(theme_select, theme_blue)

----- [ Font Awesome ] --------------------------------------------------------
-- FontAwesome
local function faIcon( code )
  return wibox.widget{
    font = theme_icon,
    markup = ' <span color="'.. theme_fg ..'">' .. code .. '</span> ',
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
  }
end

----- [ Time and date ] --------------------------------------------------------

localTime = wibox.widget.textclock(
                markup.fontfg(theme_font, theme_bg, " %I:%M %P ", 60))
localDate = wibox.widget.textclock(
                markup.fontfg(theme_font, theme_bg, " %A, %b %e ", 60))

----- [ Front info ] -----------------------------------------------------------
-- Placeholder text
frontInfo=wibox.widget.textbox(markup.fontfg(theme_font, theme_bg," (loading) "))

gears.timer {
  timeout = 5, -- seconds
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async("less /home/mimuki/Documents/Projects/pk-rpc/front.txt",
      function(out)
        frontInfo.markup = markup.fontfg(theme_font, theme_bg, out)
      end)
  end
}

----- [ Volume indicator ] -----------------------------------------------------------

volumeIcon = faIcon("  ")

volume = lain.widget.pulse( {
    settings = function()
        vlevel = volume_now.left .. "% "
        if volume_now.muted == "yes" then
            widget:set_markup(lain.util.markup(theme_special, vlevel))
        end

        if volume_now.muted == "no" then
            widget:set_markup(lain.util.markup(theme_fg, vlevel))
        end
    end
})
----- [ Current Wattage ] -----------------------------------------------------------

watts = awful.widget.watch([[awk '{print " " $1*10^-6 " W "}' /sys/class/power_supply/BAT1/power_now]], 5)

----- [ Battery indicator ] -----------------------------------------------------------
batteryIcon = battery_widget {
    ac = "AC",
    adapter = "BAT0",
    ac_prefix = "  ",
    battery_prefix = "  ",
    listen = true,
    timeout = 10,
    widget_text = "${AC_BAT}",
    widget_font = theme_icon,
    tooltip_text = "Internal battery ${state}${time_est}\nCapacity: ${capacity_percent}%",
    alert_threshold = 5,
    alert_timeout = 0,
    alert_title = "Low battery !",
    alert_text = "${AC_BAT}${time_est}"
}

batteryText = battery_widget {
    ac = "AC",
    adapter = "BAT1",
    ac_prefix = "",
    battery_prefix = "",
    percent_colors = {
        { 25,  theme_red    },
        { 50,  theme_orange },
        { 999, theme_green  },
    },
      listen = true,
    timeout = 10,
    widget_text = "${AC_BAT}${color_on}${percent}%${color_off} ",
    widget_font = theme_font,
    tooltip_text = "External battery ${state}${time_est}\nCapacity: ${capacity_percent}%",
    alert_threshold = 5,
    alert_timeout = 0,
    alert_title = "Low battery !",
    alert_text = "${AC_BAT}${time_est}"
}

-- wifi

-- Placeholder text
wifiIcon = wibox.widget.textbox(markup.fontfg(theme_icon, theme_fg,"  "))
bluetoothIcon = wibox.widget.textbox(markup.fontfg(theme_icon, theme_fg,"  "))

gears.timer {
  timeout = 5, -- seconds
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async("wifi",
      function(result)
        if string.match(result, "on") then
            wifiIcon.markup = markup.fontfg(theme_icon, theme_fg, "  ")
        end
        if string.match(result, "off") then 
            wifiIcon.markup = markup.fontfg(theme_icon, theme_fg, "  ")
        end
      end)
    awful.spawn.easy_async("bluetooth",
      function(result)
        if string.match(result, "on") then
            bluetoothIcon.markup = markup.fontfg(theme_icon, theme_fg, "  ")
        end
        if string.match(result, "off") then 
            bluetoothIcon.markup = markup.fontfg(theme_icon, theme_fg, "")
        end
      end)
end
}
