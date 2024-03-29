homeDir = os.getenv("HOME")

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
  -- Set border colour
  c.border_color = beautiful.border_focus 
  
  -- Do silly numen things
  numenPath = "~/.config/numen/"
  phrasePath = numenPath .. "phrases/*"
  contextPath = numenPath .. "contexts/" .. c.class .. "/*"

  -- Numen politely writes the last thing it heard here
  -- disclaimer: no good for checking longer phrases, but perfect for sleep/wake
  local phrase = io.open(homeDir .. "/.local/state/numen/phrase", "r" )
  lastPhrase = phrase:read( "*all" )

  if lastPhrase ~= "newman sleep" then -- If numen isn't sleeping
    -- if this context doesn't exist, it'll still load the base phrases
    cmd = "echo load " .. phrasePath .. " " .. contextPath .. " | numenc"
    awful.spawn.with_shell(cmd)
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
