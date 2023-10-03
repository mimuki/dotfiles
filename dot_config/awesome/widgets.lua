--------------------------------------------------------------------------------
--                                widgets.lua                                 --
--------------------------------------------------------------------------------
----- [ Dependencies ] ---------------------------------------------------------
json = require("lunajson")
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
function tagList(s) -- Current tags
  layouts = awful.layout.layouts

  tags = {
    settings = {
      { 
        names  = { "1", "2", "3" },
        -- Start at layout[n] on each tag
        layout = { layouts[3], layouts[1], layouts[2] }
  }}}

  tags[s] = awful.tag(tags.settings[s.index].names, s, tags.settings[s.index].layout)

  -- awful.tag(tagIcons, s, awful.layout.layouts[1])
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
    style = {
      font = "Monospace 9"
    },
    forced_height = 500,
    layout = wibox.layout.flex.vertical
  }
end

function taskList(s) 
  mytasklist = require("customtasklist")
  s.mytasklist = mytasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.focused
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
-- Make the widgets
localTime = wibox.widget.textclock()
localDate = wibox.widget.textclock()
-- Set their colours
formatColour(localTime, beautiful.time_fg, beautiful.time_bg, "%I:%M %P")
formatColour(localDate, beautiful.date_fg, beautiful.date_bg, " %A, %b %e ")
----- [ Volume indicator ] -----------------------------------------------------------
--todo
----- [ Current Weather ] -----------------------------------------------------------
--todo
-- if oldComputerChallenge == false then
--   weather, weatherTimer = awful.widget.watch(
--   [[bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/weather.sh]], 3600, 
--   function(widget, out)
--     --markupColour(weather, beautiful.fg, "#b8bff222", out)
--   end)
--   moon    = awful.widget.watch([[
--   bash /home/mimuki/.local/share/chezmoi/dot_config/awesome/scripts/moon.sh]], 3600,
--   function(widget, out)
--     --markupColour(moon, beautiful.fg, beautiful.bg, out)
--   end)
-- end
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
    batBarInfo.color = beautiful.hilight
  end
end)

batBarInfo =  wibox.widget{
  max_value     = 160,
  value = batNumber,
  forced_height = 10,
  direction = 'east',
  color = beautiful.fg,
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
  -- you're probably charging
  if tonumber(wattNumber) >= 20 then
    watts.markup = ""
  elseif tonumber(wattNumber) >= 15 then
    watts.markup = "<span foreground='"..beautiful.bg.."' background='"..beautiful.red.."'>"..out.."</span>"
  elseif tonumber(wattNumber) >= 7 then
    watts.markup = "<span foreground='"..beautiful.bg.."' background='"..beautiful.warn.."'>"..out.."</span>"
  else
    watts.markup = "<span foreground='"..beautiful.fg.."'>"..out.."</span>"
  end
end)
----- [ Networking ] -----------------------------------------------------------
--todo
----- [ Stats ] -----------------------------------------------------------
-- The actual progress bar
cpuBarInfo =  wibox.widget{
  max_value     = 100,
  value = cpuNumber,
  forced_height = 10,
  direction = 'east',
  color = beautiful.bg,
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
  color = beautiful.bg,
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

