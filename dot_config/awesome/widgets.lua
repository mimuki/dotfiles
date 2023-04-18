 --------------------------------------------------------------------------------
--                                widgets.lua                                 --
--------------------------------------------------------------------------------

----- [ Dependencies ] ---------------------------------------------------------
lain = require("lain")
markup = lain.util.markup
separators = lain.util.separators
require("vars")
require("dynamic_theme")

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
wifiIcon  = faIcon("")
blueIcon  = faIcon("")
batInIcon = faIcon("")
batExIcon = faIcon("")
----- [ Time and date ] --------------------------------------------------------
timeFormat = " %I:%M %P "
dateFormat = " %A, %b %e "

localTime = wibox.widget.textclock(
  markup.color(theme_bg, theme_blue, timeFormat))
localDate = wibox.widget.textclock(
  markup.color(theme_bg, theme_purple, dateFormat))
----- [ Front info ] -----------------------------------------------------------
-- Placeholder text for initial load
frontInfo = wibox.widget.textbox(
  markup.color(theme_bg, theme_pink, " (loading) ")
)
gears.timer {
  timeout   = frontTimeout,
  call_now  = true,
  autostart = true,
  callback  = function()
    awful.spawn.easy_async_with_shell(
      "bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/front.sh",
      function(out)
      -- Custom colours for specific headmates
        if out ~= lastFront then -- front changed
          lastFront = out
          -- naughty.notify(
          -- {
          --   title = "Front was different",
          --   text = "This should do a thing"
          -- })
          if string.match(out, "Jade") then
            -- Set new theme colours
            theme_red    = grylt_red
            theme_orange = grylt_orange
            theme_yellow = grylt_yellow
            theme_green  = grylt_green
            theme_blue   = grylt_blue
            theme_purple = grylt_purple
            theme_pink   = grylt_pink

            theme_bg     = grylt_bg
            theme_fg     = grylt_fg
            theme_select = grylt_select
            theme_special = grylt_special

            -- TODO: maybe just have theme accents above, since i wanna put these
            -- colours in their own files anyways it wouldn't change much i think
            themeAccent(theme_red)
            themeAccentAlt(theme_orange)

            markupColour(frontInfo, theme_bg, theme_accent, out)
            formatColour(localDate, theme_bg, grylt_accent_lowlight, dateFormat)
            formatColour(localTime, theme_bg, theme_yellow, timeFormat)
          elseif string.match(out, "kala") then

            theme_red    = "#ff5555"
            theme_orange = "#ffb86c"
            theme_yellow = "#f1fa8c"
            theme_green  = "#50fa7b"
            theme_blue   = "#5988FF"
            theme_purple = "#bd93f9"
            theme_pink   = "#ff79c6"

            theme_bg     = "#282a36"
            theme_fg     = "#f8f8f2"
            theme_select = "#44475a"
            theme_special = "#6272a4"

            themeAccent(theme_blue)
            themeAccentAlt(theme_green)

            markupColour(frontInfo, theme_bg, theme_accent, out)
            formatColour(localDate, theme_fg, theme_bg, dateFormat)
            formatColour(localTime, theme_accent, theme_bg, timeFormat)
          elseif string.match(out, "Nathan") then
            theme_red    = hajke_red
            theme_orange = hajke_orange
            theme_yellow = hajke_yellow
            theme_green  = hajke_green
            theme_blue   = hajke_blue
            theme_purple = hajke_purple
            theme_pink   = hajke_pink

            theme_bg     = hajke_bg
            theme_fg     = hajke_fg
            theme_select = hajke_select
            theme_special = hajke_special

            themeAccent(theme_purple)
            themeAccentAlt(theme_pink)

            markupColour(frontInfo, theme_bg, theme_accent_alt, out)
            formatColour(localDate, theme_bg, theme_accent, dateFormat)
            formatColour(localTime, theme_blue, theme_bg, timeFormat)
          else 
            theme_red    = "#ff5555"
            theme_orange = "#ffb86c"
            theme_yellow = "#f1fa8c"
            theme_green  = "#50fa7b"
            theme_blue   = "#8be9fd"
            theme_purple = "#bd93f9"
            theme_pink   = "#ff79c6"

            theme_bg     = "#282a36"
            theme_fg     = "#f8f8f2"
            theme_select = "#44475a"
            theme_special = "#6272a4"

            themeAccent(theme_purple)
            themeAccentAlt(theme_pink)

            markupColour(frontInfo, theme_bg, theme_pink, out)
            formatColour(localDate, theme_bg, theme_purple, dateFormat)
            formatColour(localTime, theme_bg, theme_blue, timeFormat)
            themeAccent(theme_purple)
          end
          themeBg(theme_bg)
          themeSelect(theme_select)

          volume.update() -- Volume widget colours
          -- Without this, taglist colours only change when focus changes
          awful.screen.focused().mytaglist._do_taglist_update()
          
          weatherTimer:emit_signal("timeout")
          batInInfoTimer:emit_signal("timeout")
          batExInfoTimer:emit_signal("timeout")
          ramInfoTimer:emit_signal("timeout")
          cpuInfoTimer:emit_signal("timeout")
          wattsTimer:emit_signal("timeout")

          -- Remove the current wibox and build a new one
          -- If i can find a way to update the bar's backgoround
          -- this might not be needed
          awful.screen.focused().mywibox.visible = false
          build_panel(awful.screen.focused())

        -- else -- if front didn't change
        --   naughty.notify(
        --     {
        --       title = "Front was the same",
        --       text = "This should do a thing"
        --     })
        end
        end
    )
  end
}
----- [ Volume indicator ] -----------------------------------------------------------
volume = lain.widget.pulse( {
  settings = function()
    vlevel = volume_now.left .. "% "
    markupColour(volIcon, theme_fg, theme_select, "  ")
    if volume_now.muted == "yes" then
      -- widget:set_markup(lain.util.markup(theme_special, vlevel))
      markupColour(volInfo, theme_special, theme_select, vlevel)
    end

    if volume_now.muted == "no" then
      widget:set_markup(lain.util.markup(theme_fg, vlevel))
      markupColour(volInfo, theme_fg, theme_select, vlevel)
    end
  end
})

volInfo = volume.widget -- needed because lain is weird and different
----- [ Current Weather ] -----------------------------------------------------------
weather, weatherTimer = awful.widget.watch(
  [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/weather.sh]], 3600, 
  function(widget, out)
    markupColour(weather, theme_fg, theme_select, out)
  end)
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
            markupColour(batInIcon, theme_red, theme_bg, "  ")
        end
        if string.match(result, "Not charging") then 
            markupColour(batInIcon, theme_fg, theme_fg, "")

        end
        if string.match(result, "Charging") then 
            markupColour(batInIcon, theme_blue, theme_bg, "  ")
        end
      end)
    awful.spawn.easy_async("cat /sys/class/power_supply/BAT1/status",
      function(result)
        if string.match(result, "Discharging") then
            markupColour(batExIcon, theme_orange, theme_bg, "  ")
        end
        if string.match(result, "Not charging") then 
            markupColour(batExIcon, theme_fg, theme_fg, "")
        end
        if string.match(result, "Charging") then 
            markupColour(batExIcon, theme_green, theme_bg, "  ")
        end
      end)
    end
}

-- TODO: pad these to two digits, like the RAM and CPU widgets are
batInInfo, batInInfoTimer = awful.widget.watch([[
  awk '$0 > 5 && $0 <= 85 { printf( $0  "% ") }' /sys/class/power_supply/BAT0/capacity
  ]], 5, function(widget, out)
    markupColour(batInInfo, theme_fg, theme_bg, out)
  end)
batExInfo, batExInfoTimer = awful.widget.watch([[
  awk '$0 > 5 && $0 <= 80 { printf( $0  "% ") }' /sys/class/power_supply/BAT1/capacity
  ]], 5, function(widget, out)
    markupColour(batExInfo, theme_fg, theme_bg, out)
  end
)

-- Current wattage
watts, wattsTimer = awful.widget.watch([[
  bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/watts.sh
  ]], 5, function(widget, out)
    markupColour(watts, theme_fg, theme_select, out)
  end)
----- [ Networking ] -----------------------------------------------------------
gears.timer {
  timeout = 5, -- seconds
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async("wifi",
      function(result)
        if string.match(result, "on") then
            markupColour(wifiIcon, theme_fg, theme_bg, "  ")
        end
        if string.match(result, "off") then
            markupColour(wifiIcon, theme_red, theme_bg, "  ")
        end
      end)
    awful.spawn.easy_async("bluetooth",
      function(result)
        if string.match(result, "on") then
            markupColour(blueIcon, theme_fg, theme_bg, "  ")
        end
        if string.match(result, "off") then 
            markupColour(blueIcon, theme_fg, theme_fg, "")
        end
      end)
    end
}
----- [ Stats ] -----------------------------------------------------------
cpuInfo, cpuInfoTimer = awful.widget.watch(
  [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/cpu.sh]], 2,
  function(widget, out)
    markupColour(cpuInfo, theme_fg, theme_bg, out)
    markupColour(cpuIcon, theme_fg, theme_bg, "  ")
  end)
ramInfo, ramInfoTimer = awful.widget.watch(
  [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/ram.sh]], 2,
  function(widget, out)
    markupColour(ramInfo, theme_fg, theme_select, out)
    markupColour(ramIcon, theme_fg, theme_select, "  ")
  end)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
