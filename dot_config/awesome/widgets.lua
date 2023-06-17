--------------------------------------------------------------------------------
--                                widgets.lua                                 --
--------------------------------------------------------------------------------
testing = false
----- [ Dependencies ] ---------------------------------------------------------
lain = require("lain")
json = require("lunajson")
markup = lain.util.markup
separators = lain.util.separators
require("vars")
require("dynamic_theme")

----- [ Font Awesome ] --------------------------------------------------------
-- Use to create a widget that's just a Font Awesome icon
local function faIcon( code )
  return wibox.widget{
    font   = theme_icon,
    markup = ' <span color="'.. beautiful.fg ..'">' .. code .. '</span> ',
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
  }
end

wifiIcon  = faIcon("")
blueIcon  = faIcon("")

function testNotify(message)
  if testing == true then
    naughty.notify(
      {
        title = "Debug notification",
        text = message
      })
  end
end
----- [ Per-screen widgets ] ---------------------------------------------------
function quake(s) -- Drop down terminal
  s.quake = lain.util.quake({
    app = "kitty",
    name = "Quake",
    argname = "--name Quake",
    border = beautiful.border_width
  })
end

function tagList(s) -- Current tags
  awful.tag(tagIcons, s, awful.layout.layouts[1])
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
    layout  = wibox.layout.flex.vertical() 
  }
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
      { "awesome", awesomeMenu, beautiful.awesome_icon }
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
   markup.color(beautiful.bg, beautiful.blue, timeFormat))

localDate = wibox.widget.textclock(
  markup.color(beautiful.bg, beautiful.purple, dateFormat))
----- [ Front info ] -----------------------------------------------------------
frontInfo = wibox.widget.textbox(markup.color(beautiful.bg, beautiful.pink, ""))

frontTimer = gears.timer {
  timeout   = frontTimeout,
  call_now  = true,
  autostart = true,
  callback  = function()
    awful.spawn.easy_async_with_shell(
      "bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/front.sh",
      function(out)
        if out ~= lastFront and out ~= "" then -- front changed
          testNotify("front changed")
          front = json.decode(out)
          lastFront = out
          if front.colour == nil then -- Fronter has no colour
            front.colour = "#ff79c6"
          else -- Fix formatting so we can use their colour
            front.colour = "#" .. front.colour
          end

          -- use member's theme, or default if not
          if fileExists(beautiful.dir .. "mimuki/members/".. front.id ..".lua") == true then 
            beautiful.init(beautiful.dir .. "mimuki/members/".. front.id ..".lua")
          else
            beautiful.init("~/.config/awesome/theme.lua")
          end
          
          markupColour(frontInfo, beautiful.front_fg, beautiful.front_bg, " " .. front.name .. " ")

          if front.avatar ~= nil then -- use members avatar for menu icon
          -- Only download it once
          -- TODO: some way of checking if the web version is a different image
            if fileExists(beautiful.dir .. "mimuki/icons/".. front.id ..".png") == false then 
              getImage(front.avatar, beautiful.dir .. "mimuki/icons/" .. front.id .. ".png")
            end
            beautiful.awesome_icon = beautiful.dir .. "mimuki/icons/" .. front.id .. ".png"
          end

          mainLauncher:set_image(beautiful.awesome_icon)

          if front.wallpaper ~= nil then --- Use member's wallpaper
          -- Only download it once
          -- TODO: some way of checking if the web version is a different image
            if fileExists(beautiful.dir .. "mimuki/wallpapers/".. front.id ..".png") == false then 
              getImage(front.wallpaper, beautiful.dir .. "mimuki/wallpapers/" .. front.id .. ".png")
            end
            beautiful.wallpaper = beautiful.dir .. "mimuki/wallpapers/" .. front.id .. ".png"
          end
          
          gears.wallpaper.maximized(beautiful.wallpaper, awful.screen.focused())

          refreshWibox()
          qutebrowserTheme()
          pyradioTheme()
          kittyTheme()
          rofiTheme()
        else -- if front didn't change
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
    -- markupColour(volIcon, beautiful.fg, beautiful.hilight, "  ")
    if volume_now.muted == "yes" then
      vlevel = volume_now.left .. "% "
      beautiful.vol_icon = "/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume_mute.png"
      volIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.vol_icon, beautiful.orange)))      
      markupColour(volInfo, beautiful.orange, "#b8bff222", vlevel)
    end

    if volume_now.muted == "no" then
      widget:set_markup(lain.util.markup(beautiful.fg, vlevel))
      markupColour(volInfo, beautiful.fg, "#b8bff222", vlevel)

      if volume_now.left <= "30" then 
      beautiful.vol_icon = "/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume_low.png"
      volIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.vol_icon, beautiful.fg)))      

      else
      beautiful.vol_icon = "/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume.png"
      volIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.vol_icon, beautiful.fg)))      

      end
    end
  end
})

volInfo = volume.widget -- needed because lain is weird and different

----- [ Current Weather ] -----------------------------------------------------------
weather, weatherTimer = awful.widget.watch(
  [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/weather.sh]], 3600, 
  function(widget, out)
    markupColour(weather, beautiful.fg, "#b8bff222", out)
  end)
-- moon    = awful.widget.watch([[
--   bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/moon.sh]], 3600,
--   function(widget, out)
--     markupColour(moon, beautiful.fg, beautiful.bg, out)
--   end)

----- [ Battery indicator ] ---------------------------------------------------------
batInIcon = wibox.widget.imagebox(gears.color.recolor_image(beautiful.bat_icon, beautiful.red))
batExIcon = wibox.widget.imagebox(gears.color.recolor_image(beautiful.bat_icon, beautiful.yellow))

gears.timer {
  timeout = 5, -- seconds
  call_now = true,
  autostart = true,
  callback = function() --reload-in=all Dynamic
    awful.spawn.easy_async("cat /sys/class/power_supply/BAT0/status",
      function(result)
        if string.match(result, "Discharging") then
          currentBattery = "internal"
          batInIcon.visible = true
          batExIcon.visible = false
          batInIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.bat_icon, beautiful.red)))
        end
        if string.match(result, "Not charging") then 
          currentBattery = "external"
          batInIcon.visible = false 
          batExIcon.visible = true
        end
        if string.match(result, "Charging") then
          currentBattery = "internal"
          batInIcon.visible = true
          batExIcon.visible = false
          batInIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.bat_charging_icon, beautiful.blue)))
        end
      end)
    awful.spawn.easy_async("cat /sys/class/power_supply/BAT1/status",
      function(result)
        if string.match(result, "Discharging") then
          currentBattery = "external"
          batInIcon.visible = false
          batExIcon.visible = true
          batExIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.bat_icon, beautiful.yellow)))
        end
        if string.match(result, "Not charging") then 
          if currentBattery == "internal" then
            batInIcon.visible = true
            batExIcon.visible = false
          else
            batInIcon.visible = false
            batExIcon.visible = true
          end
        end
        if string.match(result, "Charging") then 
          currentBattery = "external"
          batInIcon.visible = false
          batExIcon.visible = true
          batExIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.bat_charging_icon, beautiful.green)))
        end
      end)
    end
}
-- TODO: pad these to two digits, like the RAM and CPU widgets are
batInInfo, batInInfoTimer = awful.widget.watch([[awk '$0 { printf( $0 "% ") }' /sys/class/power_supply/BAT0/capacity]], 5, function(widget, out)
    if currentBattery == "internal" then
      batInInfo.markup = markup.fg.color(beautiful.fg, out .. "% ")
    else
      batIninfo.markup = markup.fg.color(beautiful.fg, "")
    end
  end)
batExInfo, batExInfoTimer = awful.widget.watch([[awk '$0 { printf( $0 "% ") }' /sys/class/power_supply/BAT1/capacity]], 5, function(widget, out)
    if currentBattery == "external" then
      batExInfo.markup = markup.fg.color(beautiful.fg, out .. "%" )
    else
      batExInfo.markup = markup.fg.color(beautiful.fg, "")
    end
  end)

-- Current wattage
watts, wattsTimer = awful.widget.watch([[
  bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/watts.sh
  ]], 5, function(widget, out)
    markupColour(watts, beautiful.fg, "#b8bff222", out)
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
            markupColour(wifiIcon, beautiful.fg, beautiful.bg, "") -- 
        end
        if string.match(result, "off") then
            markupColour(wifiIcon, beautiful.red, beautiful.bg, "  ")
        end
      end)
    awful.spawn.easy_async("bluetooth",
      function(result)
        if string.match(result, "on") then
            markupColour(blueIcon, beautiful.fg, beautiful.bg, "  ")
        end
        if string.match(result, "off") then 
            markupColour(blueIcon, beautiful.fg, beautiful.fg, "")
        end
      end)
    end
}
----- [ Stats ] -----------------------------------------------------------
cpuIcon = wibox.widget.imagebox(gears.color.recolor_image(beautiful.cpu_icon, beautiful.fg))
ramIcon = wibox.widget.imagebox(gears.color.recolor_image(beautiful.ram_icon, beautiful.fg))

cpuInfo, cpuInfoTimer = awful.widget.watch(
  [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/cpu.sh]], 2,
  function(widget, out)
    cpuInfo.markup = markup.fg.color(beautiful.fg, out)
  end)
ramInfo, ramInfoTimer = awful.widget.watch(
  [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/ram.sh]], 2,
  function(widget, out)
    markupColour(ramInfo, beautiful.fg, "#b8bff222", out)
  end)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

