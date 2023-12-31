-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
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
      --awful.titlebar.widget.button(
      --  c, 
      --  "more", 
      --  function() return true end, 
      --  function()
      --    mytitlebarmenu:toggle() 
      --  end
      --),
      awful.titlebar.widget.floatingbutton (c),
      awful.titlebar.widget.closebutton    (c),
      -- awful.titlebar.widget.stickybutton   (c),
      -- awful.titlebar.widget.ontopbutton    (c),
      -- awful.titlebar.widget.maximizedbutton(c),
      -- awful.titlebar.widget.minimizebutton(c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

client.connect_signal("property::floating", function (c)
  awful.placement.centered(c)
  awful.placement.no_offscreen(c)
end)

client.connect_signal("focus", function(c) 
  c.border_color = beautiful.border_focus 
  
  -- If I'm watching videos, I need a brighter screen
  -- caveat: doesn't update when switching tabs, only when switching focus
  -- so it's good for switching between a fullscreen video and something else
  if string.find(c.name, "Invidious") then
    -- sometimes, especially when in fullscreen,  i get a brief flash of my
    -- background when switching- this waits until that's over before upping
    -- the brightness, because my background is bright :D 
    awful.spawn.with_shell("sleep 0.075;brightnessctl set +4%")
    increased = true
  else
    if increased == true then
      os.execute("brightnessctl set 4%-")
      increased = false
    end
  end
end)

client.connect_signal("unfocus", function(c) 
  c.border_color = beautiful.border_normal 
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", setWallpaper)
-- if maximized, don't
client.connect_signal("property::maximized", function(c)
	if c.maximized then
		c.maximized = false
	end
end)
