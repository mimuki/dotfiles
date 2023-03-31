--------------------------------------------------------------------------------
--                                  vars.lua                                  --
--------------------------------------------------------------------------------
-- Sets wallpaper, and updates it when the screen changes.                    --
--------------------------------------------------------------------------------

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")

function setWallpaper(s)
-- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", setWallpaper)
