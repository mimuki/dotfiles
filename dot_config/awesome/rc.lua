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

-- Set theme
beautiful.init("~/.config/awesome/theme.lua")
----- [ External Config ] ------------------------------------------------------
require("vars")        -- Variables
require("keybindings") -- Default keybindings
require("rules")       -- Window Rules
require("signals")     -- "When this happens, do this" witchcraft
require("wibar")       -- Top bar
require("widgets")     -- Topbar widgets
require("utilities")   -- Bonus useful things
require("titlebars")   -- Titlebar config
require("wallpaper")   -- Set custom wallpaper
require("mouse")       -- Mouse specific features like right click menu
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

-- Each screen gets its own...
awful.screen.connect_for_each_screen(function(s)
  setWallpaper(s) -- ...wallpaper
  setTags(s)      -- ...tags
  quake(s)        -- ...quake-style terminal
  tagList(s)      -- ...taglist
  layoutBox(s)    -- ...layout box
  buildWibar(s)   -- ...wibar
end)

-- Set keys
root.keys(globalkeys)
