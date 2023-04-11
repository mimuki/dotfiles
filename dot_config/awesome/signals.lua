--------------------------------------------------------------------------------
--                                signals.lua                                 --
--------------------------------------------------------------------------------

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

client.connect_signal("focus", function(c) 
  if c.floating then
    c.border_color = theme_accent_alt
  else
    c.border_color = beautiful.border_focus
  end
end)

client.connect_signal("unfocus", function(c) 
  c.border_color = beautiful.border_normal 
end)

-- New floating windows are centered by default (and shouldn't overlap)
client.connect_signal("request::manage", function(client, context)
  if client.floating and context == "new" then
    client.placement = awful.placement.centered + awful.placement.no_overlap
  end
end)

-- if a client is minimized, no you don't
-- (solves bug of games disappearing when unfocused)
client.connect_signal("property::minimized", function(c)
    c.minimized = false
end)