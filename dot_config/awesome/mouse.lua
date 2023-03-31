--------------------------------------------------------------------------------
--                                 mouse.lua                                  --
--------------------------------------------------------------------------------
-- Handles mouse stuff                                                        -- 
-- TODO: actually i think this hasn't worked for a while                      --
--------------------------------------------------------------------------------

clientbuttons = gears.table.join(
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
