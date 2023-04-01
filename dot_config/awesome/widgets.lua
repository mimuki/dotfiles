--------------------------------------------------------------------------------
--                                widgets.lua                                 --
--------------------------------------------------------------------------------

----- [ Dependencies ] ---------------------------------------------------------
local lain = require("lain")
local markup = lain.util.markup
local separators = lain.util.separators
require("vars")

----- [ Font Awesome ] --------------------------------------------------------
-- Use to create a widget that's just a Font Awesome icon
local function faIcon( code )
  return wibox.widget{
    font   = theme_icon,
    markup = ' <span color="'.. theme_fg ..'">' .. code .. '</span> ',
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
  }
end


cpuIcon   = faIcon("")
ramIcon   = faIcon("")
volIcon   = faIcon("")
wifiIcon  = faIcon("  ")
blueIcon  = faIcon("  ")
batInIcon = faIcon("  ")
batExIcon = faIcon("  ")

----- [ Time and date ] --------------------------------------------------------

localTime = wibox.widget.textclock(
  markup.fontfg(theme_font, theme_bg, " %I:%M %P ", 60))
localDate = wibox.widget.textclock(
  markup.fontfg(theme_font, theme_bg, " %A, %b %e ", 60))

----- [ Front info ] -----------------------------------------------------------
-- Placeholder text for initial load
frontInfo = wibox.widget.textbox(
  markup.fontfg(theme_font, theme_bg, " (loading) "))

gears.timer {
  timeout   = frontTimeout,
  call_now  = true,
  autostart = true,
  callback  = function()
    awful.spawn.easy_async_with_shell(
      "bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/front.sh",
      function(out)
        frontInfo.markup = markup.fontfg(theme_font, theme_bg, out)
      end
    )
  end
}

----- [ Volume indicator ] -----------------------------------------------------------

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

volInfo = volume.widget -- needed because lain is weird and different

----- [ Current Weather ] -----------------------------------------------------------
weather = awful.widget.watch([[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/weather.sh]], 3600)
moon    = awful.widget.watch([[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/moon.sh]], 3600)
----- [ Battery indicator ] ---------------------------------------------------------

gears.timer {
  timeout = 5, -- seconds
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async("cat /sys/class/power_supply/BAT0/status",
      function(result)
        if string.match(result, "Discharging") then
            batInIcon.markup = markup.fontfg(theme_icon, theme_red, "  ")
        end
        if string.match(result, "Not charging") then 
            batInIcon.markup = markup.fontfg(theme_icon, theme_fg, "")
        end
        if string.match(result, "Charging") then 
            batInIcon.markup = markup.fontfg(theme_icon, theme_blue, "  ")
        end
      end)
    awful.spawn.easy_async("cat /sys/class/power_supply/BAT1/status",
      function(result)
        if string.match(result, "Discharging") then
            batExIcon.markup = markup.fontfg(theme_icon, theme_yellow, "  ")
        end
        if string.match(result, "Not charging") then 
            batExIcon.markup = markup.fontfg(theme_icon, theme_fg, "")
        end
        if string.match(result, "Charging") then 
            batExIcon.markup = markup.fontfg(theme_icon, theme_green, "  ")
        end
      end)
    end
}

-- TODO: pad these to two digits, like the RAM and CPU widgets are
batInInfo = awful.widget.watch([[
  awk '$0 > 5 && $0 <= 85 { printf( $0  "% ") }' /sys/class/power_supply/BAT0/capacity
  ]])
batExInfo = awful.widget.watch([[
  awk '$0 > 5 && $0 <= 80 { printf( $0  "% ") }' /sys/class/power_supply/BAT1/capacity
  ]])

-- Current wattage
watts = awful.widget.watch([[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/watts.sh]])

----- [ Networking ] -----------------------------------------------------------

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
            blueIcon.markup = markup.fontfg(theme_icon, theme_fg, "  ")
        end
        if string.match(result, "off") then 
            blueIcon.markup = markup.fontfg(theme_icon, theme_fg, "")
        end
      end)
    end
}

----- [ Stats ] -----------------------------------------------------------

cpuInfo = awful.widget.watch([[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/cpu.sh]], 2)
ramInfo = awful.widget.watch([[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/ram.sh]], 2)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
