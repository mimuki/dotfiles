 --------------------------------------------------------------------------------
--                                widgets.lua                                 --
--------------------------------------------------------------------------------

----- [ Dependencies ] ---------------------------------------------------------
local lain = require("lain")
local markup = lain.util.markup
local separators = lain.util.separators
require("vars")
----- [ Colours ] --------------------------------------------------------------
-- Change the foreground and background colour of a widget
-- For widgets with custom formats (i.e. textclocks), not textboxes
function formatColour(widget, fg, bg, text)
  widget.format = "<span foreground='" .. fg .. "' background='" .. bg .. "'>" .. text .. "</span>"
end
-- Change the foreground and background colour of a widget
-- For widgets with custom markup (i.e. text boxes)
function markupColour(widget, fg, bg, text)
  widget.markup = markup.color(fg, bg, text)
end

-- Changes Awesome's theme to a certain colour
function themeBg(colour)
  theme_bg = colour 
  beautiful.bg_normal = colour
  beautiful.bg_systray = colour
  beautiful.titlebar_fg_focus = colour
  beautiful.titlebar_fg_urgent = colour
  beautiful.taglist_bg_focus = colour
  beautiful.taglist_bg_occupied = colour
  beautiful.taglist_bg_urgent = colour
  beautiful.taglist_bg_empty = colour
end

function themeAccent(colour)
  theme_accent = colour
  beautiful.taglist_fg_focus = colour
  beautiful.border_focus = colour
  beautiful.titlebar_bg_focus = colour 

end

function themeAccentAlt(colour)
  theme_accent_alt = colour
  beautiful.hotkeys_border_color = colour  -- TODO: doesnt seem to update properly
  beautiful.tooltip_border_color = colour
  beautiful.notification_border_color = colour
end
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
            theme_red    = "#B23636" -- 
            theme_orange = "#F2854A" --
            theme_yellow = "#664233"
            theme_green  = "#A6E3A1"
            theme_blue   = "#89B4FA"
            theme_purple = "#bd93f9"
            theme_pink   = "#992E2E"

            theme_bg     = "#F0DBD1" --
            theme_fg     = "#4C3226" --
            theme_select = "#BF9986"
            theme_special = "#A6ADC8"

            -- TODO: maybe just have theme accents above, since i wanna put these
            -- colours in their own files anyways it wouldn't change much i think
            themeAccent(theme_red)
            themeAccentAlt(theme_orange)
            themeBg(theme_bg)

            markupColour(frontInfo, theme_bg, theme_accent, out)
            formatColour(localDate, theme_bg, theme_pink, dateFormat)
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
            themeBg(theme_bg)

            markupColour(frontInfo, theme_bg, theme_accent, out)
            formatColour(localDate, theme_fg, theme_bg, dateFormat)
            formatColour(localTime, theme_accent, theme_bg, timeFormat)
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
            themeBg(theme_bg)

            markupColour(frontInfo, theme_bg, theme_pink, out)
            formatColour(localDate, theme_bg, theme_purple, dateFormat)
            formatColour(localTime, theme_bg, theme_blue, timeFormat)
            themeAccent(theme_purple)
          end

          volume.update() -- Volume widget colours
          -- Without this, taglist colours only change when focus changes
          awful.screen.focused().mytaglist._do_taglist_update()

          -- Remove the current wibox and build a new one
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
            -- batInIcon.markup = markup.fontfg(theme_icon, theme_red, "  ")
            markupColour(batInIcon, theme_red, theme_bg, "  ")
        end
        if string.match(result, "Not charging") then 
            -- batInIcon.markup = markup.fontfg(theme_icon, theme_fg, "")
            markupColour(batInIcon, theme_fg, theme_fg, "")

        end
        if string.match(result, "Charging") then 
            markupColour(batInIcon, theme_blue, theme_bg, "  ")
            -- batInIcon.markup = markup.fontfg(theme_icon, theme_blue, "  ")
        end
      end)
    awful.spawn.easy_async("cat /sys/class/power_supply/BAT1/status",
      function(result)
        if string.match(result, "Discharging") then
            markupColour(batExIcon, theme_orange, theme_bg, "  ")
            -- batExIcon.markup = markup.fontfg(theme_icon, theme_yellow, "  ")
        end
        if string.match(result, "Not charging") then 
            markupColour(batInIcon, theme_fg, theme_fg, "")
            -- batExIcon.markup = markup.fontfg(theme_icon, theme_fg, "")
        end
        if string.match(result, "Charging") then 
            markupColour(batInIcon, theme_green, theme_bg, "  ")
            -- batExIcon.markup = markup.fontfg(theme_icon, theme_green, "  ")
        end
      end)
    end
}

-- TODO: pad these to two digits, like the RAM and CPU widgets are
batInInfo = awful.widget.watch([[
  awk '$0 > 5 && $0 <= 85 { printf( $0  "% ") }' /sys/class/power_supply/BAT0/capacity
  ]], 5, function(widget, out)
    markupColour(batInInfo, theme_fg, theme_bg, out)
  end)
batExInfo = awful.widget.watch([[
  awk '$0 > 5 && $0 <= 80 { printf( $0  "% ") }' /sys/class/power_supply/BAT1/capacity
  ]], 5, function(widget, out)
    markupColour(batExInfo, theme_fg, theme_bg, out)
  end
)

-- Current wattage
watts = awful.widget.watch([[
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
cpuInfo = awful.widget.watch([[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/cpu.sh]], 2)
ramInfo = awful.widget.watch([[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/ram.sh]], 2)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
