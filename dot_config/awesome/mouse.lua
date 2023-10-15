--------------------------------------------------------------------------------
--                                 mouse.lua                                  --
--------------------------------------------------------------------------------

clientbuttons = gears.table.join( -- broken??
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

root.buttons(gears.table.join(
    awful.button({ }, 3, function () mainMenu:toggle() end)
))
