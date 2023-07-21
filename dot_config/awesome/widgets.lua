--------------------------------------------------------------------------------
--                                widgets.lua                                 --
--------------------------------------------------------------------------------
----- [ Dependencies ] ---------------------------------------------------------
lain = require("lain")
json = require("lunajson")
markup = lain.util.markup
separators = lain.util.separators
require("vars")
require("dynamic_theme")

function testNotify(message)
  if testing == true then
    naughty.notify(
    {
      title = "Debug notification",
      text = message
    })
  end
end

spacer = wibox.widget.textbox(" ")
----- [ Per-screen widgets ] ---------------------------------------------------
function quake(s) -- Drop down terminal
  s.quake = lain.util.quake({
    app = "urxvt",
    name = "Quake",
    height = 0.358,
    --argname = "-name Quake",
    border = beautiful.border_width
  })
end

function tagList(s) -- Current tags
  awful.tag(tagIcons, s, awful.layout.layouts[1])
  s.mytaglist = awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
      buttons = taglist_buttons,
      style = {
        font = "Monospace 9"
      },
      --layout  = wibox.layout.flex.vertical(),
    forced_height = 500,
    layout = wibox.layout.flex.vertical
  --  layout  = wibox.layout.flex.vertical({
--      forced_height = 200
--    }) 
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
  --awful.button({ }, 1, function () awful.layout.inc( 1) end), 
awful.button({}, 1, function() 
  mainMenu:toggle(
  {
    coords = {
      x = 0, 
      y = 0 
    }
  })
end),

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
timeFormat = "%I:%M %P"  -- 01:42 pm
dateFormat = " %A, %b %e " -- Tuesday, Apr 18

localTime = wibox.widget.textclock(
markup.color(beautiful.time_fg, beautiful.time_bg, timeFormat))

localDate = wibox.widget.textclock(
markup.color(beautiful.date_fg, beautiful.date_bg, dateFormat))
----- [ Front info ] -----------------------------------------------------------
-- This has a memory leak I haven't figured out yet
-- So it's disabled for the OCC
if oldComputerChallenge == false then
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
          -- qutebrowserTheme()
          pyradioTheme()
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
else
  -- During the challenge, just show static text :)
  frontInfo = wibox.widget.textbox(markup.color(beautiful.front_fg, beautiful.front_bg, " ilo Mimuki "))
end
----- [ Volume indicator ] -----------------------------------------------------------
--volIcon = wibox.widget.imagebox("/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume.png"  )
volIcon = wibox.widget.textbox("V:")

volume = lain.widget.pulse( {
  settings = function()
    vlevel = volume_now.left .. "%"
    -- markupColour(volIcon, beautiful.fg, beautiful.hilight, "  ")
    if volume_now.muted == "yes" then
      vlevel = volume_now.left .. "%"
      beautiful.vol_icon = "/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume_mute.png"

      markupColour(volInfo, beautiful.orange, "#b8bff222", vlevel)
    end

    if volume_now.muted == "no" then
      widget:set_markup(lain.util.markup(beautiful.fg, vlevel))
      markupColour(volInfo, beautiful.fg, "#b8bff222", vlevel)

      if volume_now.left <= "30" then 
        beautiful.vol_icon = "/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume_low.png"
      else
        beautiful.vol_icon = "/home/mimuki/.local/share/chezmoi/dot_config/awesome/themes/mimuki/icons/volume.png"
      end
    end
  end
})

volInfo = volume.widget -- needed because lain is weird and different

----- [ Current Weather ] -----------------------------------------------------------
if oldComputerChallenge == false then
  weather, weatherTimer = awful.widget.watch(
  [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/weather.sh]], 3600, 
  function(widget, out)
    markupColour(weather, beautiful.fg, "#b8bff222", out)
  end)
  moon    = awful.widget.watch([[
  bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/moon.sh]], 3600,
  function(widget, out)
    markupColour(moon, beautiful.fg, beautiful.bg, out)
  end)
end
----- [ Battery indicator ] ---------------------------------------------------------

batInfo = awful.widget.watch([[bash /home/mimuki/.config/awesome/scripts/bat.sh]], 5, function(widget, out)
      batBarInfo.value = tonumber(out)
      batNumber = math.floor((out/2))
      if batNumber >=100 then
        batText.text = "MAX"
      else
        batText.text = batNumber.."%"
      end
      -- If high usage, be kinda noticable
      if tonumber(out) <= 50 then
        batBarInfo.color = beautiful.warn
      else
        batBarInfo.color = beautiful.special
      end
    end)

batBarInfo =  wibox.widget{
  max_value     = 160,
  value = batNumber,
  forced_height = 10,
  direction = 'east',
  color = beautiful.special,
  background_color = gears.color.transparent,
  widget        = wibox.widget.progressbar,
}
-- but its rotatified, to be vertical
batBar = wibox.container.rotate(batBarInfo, 'east')
batText = wibox.widget.textbox("") -- still deciding if i want this
-- combined for fruity goodness
batStack = wibox.widget {
  batBar,
  batText,
  layout = wibox.layout.stack
}

-- Current wattage
watts, wattsTimer = awful.widget.watch([[
bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/watts.sh
]], 5, function(widget, out)
  wattNumber = out:match("(%d+.%d)")
  -- Avoid an error if that fails
  if wattNumber == nil then
    wattNumber = 0
  end
  -- If high usage, be very noticable
  if tonumber(wattNumber) >= 15 then
    markupColour(watts, beautiful.bg, beautiful.red, out)
  elseif tonumber(wattNumber) >= 7 then
    markupColour(watts, beautiful.bg, beautiful.warn, out)
  else
    markupColour(watts, beautiful.fg, "#b8bff201", out)
  end
end)
----- [ Networking ] -----------------------------------------------------------
--gears.timer {
--  timeout = 5, -- seconds
--  call_now = true,
--  autostart = true,
--  callback = function()
--    awful.spawn.easy_async("wifi",
--    function(result)
--      if string.match(result, "on") then
--        markupColour(wifiIcon, beautiful.fg, beautiful.bg, "") -- 
--      end
--      if string.match(result, "off") then
--        markupColour(wifiIcon, beautiful.red, beautiful.bg, "  ")
--      end
--    end)
--  end
--}
----- [ Stats ] -----------------------------------------------------------
--cpuIcon = wibox.widget.imagebox(gears.color.recolor_image(beautiful.cpu_icon, beautiful.fg))
--ramIcon = wibox.widget.imagebox(gears.color.recolor_image(beautiful.ram_icon, beautiful.fg))

-- The actual progress bar
cpuBarInfo =  wibox.widget{
  max_value     = 100,
  value = cpuNumber,
  forced_height = 10,
  direction = 'east',
  color = beautiful.special,
  background_color = gears.color.transparent,
  widget        = wibox.widget.progressbar,
}
-- but its rotatified, to be vertical
cpuBar = wibox.container.rotate(cpuBarInfo, 'east')
cpuText = wibox.widget.textbox("") -- is set later
-- combined for fruity goodness
cpuStack = wibox.widget {
  cpuBar,
  cpuText,
  layout = wibox.layout.stack
}

cpuInfo, cpuInfoTimer = awful.widget.watch(
[[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/cpu.sh]], 2,
function(widget, out)
  cpuNumber =  out:match("(%d+)")
  cpuBarInfo.value = tonumber(cpuNumber)
  -- Hide when usage is low
  if tonumber(cpuNumber) < 25 then
    cpuText.text = ""
    cpuBar.visible = false
  else
    cpuText.text = "CPU"
    cpuBar.visible = true
  end
end)

ramBarInfo =  wibox.widget{
  max_value     = 100,
  value = ramNumber,
  forced_height = 10,
  direction = 'east',
  color = beautiful.special,
  background_color = gears.color.transparent,
  widget        = wibox.widget.progressbar,
}
-- but its rotatified, to be vertical
ramBar = wibox.container.rotate(ramBarInfo, 'east')
ramText = wibox.widget.textbox("RAM")
-- combined for fruity goodness
ramStack = wibox.widget {
  ramBar,
  ramText,
  layout = wibox.layout.stack
}

ramInfo, ramInfoTimer = awful.widget.watch(
[[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/ram.sh]], 2,
function(widget, out)
  ramBarInfo.value = tonumber(out)
  -- Hide when usage is low
  if tonumber(out) < 25 then
    ramText.visible = false
    ramBar.visible = false
  else
    ramStack.visible = true
    ramBar.visible = true
  end
end)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

