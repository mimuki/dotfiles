-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  local topTitlebar = awful.titlebar(c, 
    { size = beautiful.get_font_height(beautiful.font) })

  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 2, function()
      awful.menu(titlebarMenu):show() 
     end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.resize(c)
    end)
  )

  topTitlebar : setup {
    { -- Left
      -- wibox.container.margin makes it look nicer with other icons
      wibox.container.margin(awful.titlebar.widget.iconwidget(c),5,5,5,5),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
     awful.titlebar.widget.button(
        c, 
        "more", 
        function() return true end, 
        function() 
   --     awesome.restart
           mytitlebarmenu:toggle() 
        end
        ),
      awful.titlebar.widget.floatingbutton (c),
      -- awful.titlebar.widget.stickybutton   (c),
      -- awful.titlebar.widget.ontopbutton    (c),
      -- awful.titlebar.widget.maximizedbutton(c),
      -- awful.titlebar.widget.minimizebutton(c),
      awful.titlebar.widget.closebutton    (c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) 
  if c.floating then
    c.border_color = beautiful.accents.secondary.main
  else
    c.border_color = beautiful.border_focus 
  end
end)

client.connect_signal("property::floating", function (c)
  awful.placement.centered(c)
  awful.placement.no_offscreen(c)
end)

client.connect_signal("unfocus", function(c) 
  c.border_color = beautiful.border_normal 
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 2
        else -- Thin borders for live captions
          if c.class == "livecaptions" then
            c.border_width = 1
            c.ontop = true
            c.sticky = true
          else -- Normal borders for everything else
            c.border_width = beautiful.border_width 
          
            if c.floating then
              c.border_color = beautiful.accents.secondary.main
            else
              c.border_color = beautiful.border_focus 
            end
          end
        end
    end
end)
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", setWallpaper)
