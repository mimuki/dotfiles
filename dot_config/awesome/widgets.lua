--------------------------------------------------------------------------------
--                                widgets.lua                                 --
--                                                                            --
-- Last edit: 07/03/23                        Made with love by kulupu Mimuki --
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

----- [ Font Awesome ] --------------------------------------------------------

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

volumeIcon = faIcon("")

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
-- jan Tepo li wawa a
wattsExternal = awful.widget.watch([[awk '{printf(" %.1f W ", $1*10^-6)}' /sys/class/power_supply/BAT1/power_now]])
wattsInternal = awful.widget.watch([[awk '{printf(" %.1f W ", $1*10^-6)}' /sys/class/power_supply/BAT0/power_now]])
-- wattsInternal = awful.widget.watch([[awk '$1!=0{printf(" %.1f W ", $1*10^-6)}' /sys/class/power_supply/BAT0/power_now | head -1]])
-- wattsExternal = awful.widget.watch([[awk '$1!=0{printf(" %.1f W ", $1*10^-6)}' /sys/class/power_supply/BAT1/power_now | head -1]])


----- [ Current Weather ] -----------------------------------------------------------
-- TODO: remove the + somehow
weather = awful.widget.watch([[curl wttr.in/adelaide?format="%20%c%t%20\n"]], 3600)

----- [ Battery indicator ] ---------------------------------------------------------
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


internalBattery = battery_widget {
    ac = "AC",
    adapter = "BAT0",
    ac_prefix = satansBatteryAC,
    battery_prefix = satansBatteryBat,
    listen = true,
    timeout = 10,
    widget_text = "${AC_BAT}",
    widget_font = theme_font,
    tooltip_text = "Internal battery ${state}${time_est}\nCapacity: ${capacity_percent}%",
    alert_threshold = 5,
    alert_timeout = 0,
    alert_title = "Low battery !",
    alert_text = "${AC_BAT}${time_est}"
}

externalBattery = battery_widget {
    ac = "AC",
    adapter = "BAT1",
    ac_prefix = satansBatteryAC,
    battery_prefix = satansBatteryBat,
    listen = true,
    timeout = 10,
    widget_text = "${AC_BAT}",
    widget_font = theme_font,
    tooltip_text = "External battery ${state}${time_est}\nCapacity: ${capacity_percent}%",
    alert_threshold = 5,
    alert_timeout = 0,
    alert_title = "Low battery !",
    alert_text = "${AC_BAT}${time_est}"
}
----- [ Networking ] -----------------------------------------------------------

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
