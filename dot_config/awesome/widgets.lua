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

wifiIcon  = faIcon("")
blueIcon  = faIcon("")
----- [ Per-screen widgets ] ---------------------------------------------------
function quake(s) -- Drop down terminal
  s.quake = lain.util.quake({
    app = "kitty",
    name = "Quake",
    argname = "--name Quake",
    border = theme_border_width
  })
end

function tagList(s) -- Current tags
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
    style   = {
      font = "linja lipamanka 18"
    } 
  }
end

-- Each screen has its own tag table.
function setTags(s)
  awful.tag({ "•", "•", "•", "•", "•" }, s, awful.layout.layouts[1])
end

taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end)
)

function layoutBox(s) -- Current tiling layout
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))
end
----- [ Menu ] -----------------------------------------------------------------
-- Create a launcher widget and a main menu
awesomeMenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "edit config", terminal .. " chezmoi edit " .. awesome.conffile },
   { "restart awesome", awesome.restart },
   { "quit", function() awesome.quit() end },
}

browserMenu = {
  { "qutebrowser", function() awful.util.spawn("qutebrowser") end },
  { "firefox",     function() awful.util.spawn("firefox") end },
}
funMenu = {
  { "youtube",     function() awful.util.spawn("freetube") end },
  { "minecraft",   function() awful.util.spawn("minecraft-launcher") end },
  { "steam",       function() awful.util.spawn("steam") end },
}

mainMenu = awful.menu(
  { items = { 
      { "browsers", browserMenu },
      { "fun", funMenu },
      { "terminal", terminal, beautiful.terminal_icon },
      { "search programs", function () awful.util.spawn("rofi -show drun") end, beautiful.list_icon },
      { "search windows",  function () awful.util.spawn("rofi -show window") end, beautiful.window_icon },
      { "search files",    function () awful.util.spawn("rofi -show filebrowser -theme-str '#listview {lines:6;}'") end, beautiful.folder_icon },
      { "awesome", awesomeMenu, beautiful.awesome_icon },

    }
  })

mainLauncher = awful.widget.button(
  { 
    image = beautiful.awesome_icon,
    menu = mainMenu,
  })

mainLauncher:buttons(gears.table.join(
    mainLauncher:buttons(),
    awful.button({}, 1, nil, 
      function() 
        mainMenu:toggle(
          {
            coords = {
              x = 0, 
              y = 0 
            }
          })
      end)
))
----- [ Time and date ] --------------------------------------------------------
timeFormat = " %I:%M %P "  -- 01:42 pm
dateFormat = " %A, %b %e " -- Tuesday, Apr 18

localTime = wibox.widget.textclock(
   markup.color(theme_bg, theme_blue, timeFormat))

localDate = wibox.widget.textclock(
  markup.color(theme_bg, theme_purple, dateFormat))
----- [ Front info ] -----------------------------------------------------------
frontInfo = wibox.widget.textbox(markup.color(theme_bg, theme_pink, ""))

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
            themeAccent(theme_green)
            themeAccentAlt(theme_pink)
            themeSelect(theme_select)
            themeBg(theme_bg)
            themeFg(theme_fg)

            awful.screen.focused().mytaglist._do_taglist_update()

            markupColour(frontInfo, grylt_widget_front_fg, grylt_widget_front_bg, out)
            formatColour(localDate, theme_bg, theme_blue, dateFormat)
            formatColour(localTime, theme_bg, theme_pink, timeFormat)
          
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
            themeSelect(theme_select)
            themeBg(theme_bg)
            themeFg(theme_fg)

            awful.screen.focused().mytaglist._do_taglist_update()
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
            themeSelect(theme_select)
            themeBg(theme_bg)
            themeFg(theme_fg)

            awful.screen.focused().mytaglist._do_taglist_update()

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
            themeSelect(theme_select)
            themeBg(theme_bg)
            themeFg(theme_fg)
            
            markupColour(frontInfo, theme_bg, theme_pink, out)
            formatColour(localDate, theme_bg, theme_purple, dateFormat)
            formatColour(localTime, theme_bg, theme_blue, timeFormat)
            awful.screen.focused().mytaglist._do_taglist_update()

          end
        
          volume.update() -- Volume widget colours

          -- Without this, taglist colours only change when focus changes
          -- awful.screen.focused().mytaglist._do_taglist_update()
          
          weatherTimer:emit_signal("timeout")
          cpuInfoTimer:emit_signal("timeout")
          ramInfoTimer:emit_signal("timeout")
          batInInfoTimer:emit_signal("timeout")
          batExInfoTimer:emit_signal("timeout")
          wattsTimer:emit_signal("timeout")

          -- Remove the current wibox and build a new one
          -- If i can find a way to update the bar's backgoround
          -- this might not be needed
          -- awful.screen.focused().mywibox.visible = false
          -- build_panel(awful.screen.focused())

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
volIcon = wibox.widget.imagebox("/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume.png"  )

volume = lain.widget.pulse( {
  settings = function()
    vlevel = volume_now.left .. "% "
    -- markupColour(volIcon, theme_fg, theme_select, "  ")
    if volume_now.muted == "yes" then
      vlevel = volume_now.left .. "% "
      beautiful.vol_icon = "/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume_mute.png"
      volIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.vol_icon, theme_orange)))      
      markupColour(volInfo, theme_orange, "#b8bff222", vlevel)
    end

    if volume_now.muted == "no" then
      widget:set_markup(lain.util.markup(theme_fg, vlevel))
      markupColour(volInfo, theme_fg, "#b8bff222", vlevel)

      if volume_now.left <= "30" then 
      beautiful.vol_icon = "/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume_low.png"
      volIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.vol_icon, theme_fg)))      

      else
      beautiful.vol_icon = "/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume.png"
      volIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.vol_icon, theme_fg)))      

      end
    end
  end
})

volInfo = volume.widget -- needed because lain is weird and different

----- [ Current Weather ] -----------------------------------------------------------
weather, weatherTimer = awful.widget.watch(
  [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/weather.sh]], 3600, 
  function(widget, out)
    markupColour(weather, theme_fg, "#b8bff222", out)
  end)
-- moon    = awful.widget.watch([[
--   bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/moon.sh]], 3600,
--   function(widget, out)
--     markupColour(moon, theme_fg, theme_bg, out)
--   end)

----- [ Battery indicator ] ---------------------------------------------------------
batInIcon = wibox.widget.imagebox(gears.color.recolor_image(beautiful.bat_icon, theme_red))
batExIcon = wibox.widget.imagebox(gears.color.recolor_image(beautiful.bat_icon, theme_yellow))

gears.timer {
  timeout = 5, -- seconds
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async("cat /sys/class/power_supply/BAT0/status",
      function(result)
        if string.match(result, "Discharging") then
          batInIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.bat_icon, "#ff5555")))
        end
        if string.match(result, "Not charging") then 
          batInIcon.visible = false
        end
        if string.match(result, "Charging") then 
          batInIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.bat_charging_icon, "#8be9fd")))
        end
      end)
    awful.spawn.easy_async("cat /sys/class/power_supply/BAT1/status",
      function(result)
        if string.match(result, "Discharging") then
          batExIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.bat_icon, "#f1fa8c")))
        end
        if string.match(result, "Not charging") then 
          batExIcon.visible = false
        end
        if string.match(result, "Charging") then 
          batExIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.bat_charging_icon, "#50fa7b")))
        end
      end)
    end
}
-- TODO: pad these to two digits, like the RAM and CPU widgets are
batInInfo, batInInfoTimer = awful.widget.watch([[
  awk '$0 > 5 && $0 <= 85 { printf( $0  "% ") }' /sys/class/power_supply/BAT0/capacity
  ]], 5, function(widget, out)
    batInInfo.markup = markup.fg.color(theme_fg, out)
  end)
batExInfo, batExInfoTimer = awful.widget.watch([[
  awk '$0 > 5 && $0 <= 80 { printf( $0  "% ") }' /sys/class/power_supply/BAT1/capacity
  ]], 5, function(widget, out)
    batExInfo.markup = markup.fg.color(theme_fg, out)

  end
)

-- Current wattage
watts, wattsTimer = awful.widget.watch([[
  bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/watts.sh
  ]], 5, function(widget, out)
    markupColour(watts, theme_fg, "#b8bff222", out)
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
            markupColour(wifiIcon, theme_fg, theme_bg, "") -- 
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
cpuIcon = wibox.widget.imagebox(gears.color.recolor_image(beautiful.cpu_icon, theme_fg))
ramIcon = wibox.widget.imagebox(gears.color.recolor_image(beautiful.ram_icon, theme_fg))

cpuInfo, cpuInfoTimer = awful.widget.watch(
  [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/cpu.sh]], 2,
  function(widget, out)
    cpuInfo.markup = markup.fg.color(theme_fg, out)
  end)
ramInfo, ramInfoTimer = awful.widget.watch(
  [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/ram.sh]], 2,
  function(widget, out)
    markupColour(ramInfo, theme_fg, "#b8bff222", out)
  end)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

