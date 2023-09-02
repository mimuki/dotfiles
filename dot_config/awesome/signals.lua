--------------------------------------------------------------------------------
--                                signals.lua                                 --
--------------------------------------------------------------------------------
require("wallpaper")
----- [ Signals ] --------------------------------------------------------------
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- TODO: understand what this does enough to rephrase it, the whole
  --       master/slave phrasing is weird
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- Different focus colours for floating & tiled windows
client.connect_signal("focus", function(c) 
  if c.border_width == 1 then
    c.border_color = beautiful.border_normal
  else
    if c.floating then
      c.border_color = beautiful.accent_alt
    else
      c.border_color = beautiful.border_focus
    end
  end
end)

client.connect_signal("unfocus", function(c) 
  c.border_color = beautiful.border_normal 
end)

client.connect_signal("property::floating", function(c)
  c.border_color = beautiful.accent_alt
end)

-- if a client is minimized, no you don't
-- (solves bug of games disappearing when unfocused)
client.connect_signal("property::minimized", function(c)
    c.minimized = false
end)

-- Extra thin borders when rearranging only 1 non-floating or maximized client
-- Eventually i could update this to change colours based on...stuff
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 1
            c.border_color = beautiful.border_normal
        else -- Thin borders for live captions
          if c.class == "livecaptions" then
            c.border_width = 1
            c.ontop = true
            c.sticky = true
          else -- Normal borders for everything else
            c.border_width = beautiful.border_width 
          end
        end
    end
end)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", setWallpaper)
-- make titles short a, usually
client.connect_signal("property::name", function(c)
  if c.class == "Firefox" then
    if c.name ~= "Mozilla Firefox" then
      c.name = "Mozilla Firefox"
    end
  end
end)
