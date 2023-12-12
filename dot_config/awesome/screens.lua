awful.screen.connect_for_each_screen(function(s)
  -- setWallpaper(s)
    -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
-- Each screen has its own tag table.

  awful.tag.add("", {
    layout              = awful.layout.suit.tile,
    master_fill_policy  = "master_width_factor",
    master_width_factor = 0.8705,
    gap                 = 2,
    gap_single_client   = true,
    screen              = s,
    selected            = true,
})

awful.tag.add("", {
    layout             = awful.layout.suit.tile,
    screen             = s,
    gap                = 1.9,
    gap_single_client  = false,
})

awful.tag.add("", {
    layout             = awful.layout.suit.tile,
    screen             = s,
    gap                = 1.9,
    gap_single_client  = false,
})
  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))
  -- Create a taglist widget
  tagList(s)
  -- Create a tasklist widget
  taskList(s)

  -- Create the wibox
  s.mywibox = awful.wibar(
  { 
    position = "top", 
    screen = s,
    height = beautiful.get_font_height(beautiful.font)
  })

  statusBar(s)
end)
