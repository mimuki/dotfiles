--------------------------------------------------------------------------------
--                               wallpaper.lua                                --
--------------------------------------------------------------------------------
-- Sets wallpaper, and updates it when the screen changes.                    --
--------------------------------------------------------------------------------

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
