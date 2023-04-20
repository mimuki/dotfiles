--------------------------------------------------------------------------------
--                                   rc.lua                                   --
--------------------------------------------------------------------------------
-- TODO: Rewrite theme                                                        --
--       Move top bar to its own file                                         --
--------------------------------------------------------------------------------

----- [ Dependencies ] ---------------------------------------------------------
-- Standard awesome library
gears = require("gears")
awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Theme
beautiful.init("~/.config/awesome/theme.lua")

----- [ External Config ] ------------------------------------------------------
require("keybindings")    -- My default keybindings
require("rules")          -- Window Rules
require("vars")           -- Variables
-- Disable when using smart_borders for a perfomance boost:
require("titlebars")      -- Titlebar config
-- Enable for smart_borders
-- note: you will need to do some DIY because i removed the module ol
-- require("smart_borders")  -- Border config (technically made of titlebars)
require("widgets")        -- Topbar widgets
require("signals")
require("tags") 
require("wallpaper") -- Set custom wallpaper
require("mouse")
require("utilities") 
require("wibar")
-- Lain
local lain = require("lain")
local separators = lain.util.separators
local markup = lain.util.markup
-- Bling
----- [ Variables ] ------------------------------------------------------------

-- Enabled layouts
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.top,
  awful.layout.suit.max.fullscreen,
}

----- [ Error Handling ] -------------------------------------------------------
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify(
    { 
      preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors 
    }
  )
end

-- Handle runtime errors after startup
do
  local in_error = false
    awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
      if in_error then return end
        in_error = true
        naughty.notify(
          { 
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err) 
          })
        in_error = false
    end)
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

-- Each screen gets its own...
awful.screen.connect_for_each_screen(function(s)
  setWallpaper(s) -- ...wallpaper
  setTags(s)      -- ...tags
  quake(s)        -- ...quake-style terminal
  tagList(s)      -- ...taglist
  layoutBox(s)    -- ...layout box
  buildWibar(s)   -- ...wibar
end)

root.buttons(gears.table.join(
    awful.button({ }, 3, function () mainMenu:toggle() end)
))

-- Set keys
root.keys(globalkeys)
