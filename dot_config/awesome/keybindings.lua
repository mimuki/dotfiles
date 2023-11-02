-- Mouse bindings 
-- Only apply to the status bar, wallpaper, etc.
root.buttons(gears.table.join(
  awful.button({ }, 3, function () mymainmenu:toggle() end)))

-- Functions
-- Switch between windows in both tmux and awesome with the same keybind
-- direction is either -1 or 1, as in awful.client.focus.byidx(direction)
function windowFocus(direction)
  if awful.screen.focused().selected_tag.index == 1 then 
    if direction == 1 then os.execute("tmux next-window") 
    else os.execute("tmux previous-window") end
    os.execute("sh ~/.tmux/plugins/rat_scripts/statusbar.sh")
  else awful.client.focus.byidx(direction) end
end

function viewTag(i)
  if awful.screen.focused().tags[i] then
    awful.screen.focused().tags[i]:view_only()
  end
end

function moveToTag(i)
  if client.focus then
    if client.focus.screen.tags[i] then 
      client.focus:move_to_tag(client.focus.screen.tags[i]) 
    end
  end
end
-- Key bindings
-- These work everywhere; window specific things (like toggling floating) go 
-- under clientkeys.
globalkeys = gears.table.join(
---- [ Awesome ] ----
-- Meta client controls
awful.key(
  { modkey }, "/", hotkeys_popup.show_help,
  { description = "show help", group = "awesome" }),
awful.key(
  { modkey }, "m", function () mymainmenu:show() end,
  { description = "show main menu", group = "awesome" }),
awful.key( 
  { modkey, "Control" }, "r", awesome.restart,
  { description = "reload awesome", group = "awesome" }),
awful.key(
  { modkey, "Shift" }, "q", awesome.quit,
  { description = "quit awesome", group = "awesome" }),

awful.key({ modkey }, "Up",   awful.tag.viewprev),
awful.key(
  { modkey }, "i",   awful.tag.viewprev,
  { description = "view previous tag", group = "navigation" }),

awful.key({ modkey }, "Down",  awful.tag.viewnext),
awful.key(
  { modkey }, "e",  awful.tag.viewnext,
  { description = "view next tag", group = "navigation" }),

awful.key({ modkey }, "Left", function () windowFocus(-1) end),
awful.key(
  { modkey }, "n", function () windowFocus(-1) end,
  { description = "focus previous window", group = "navigation" }),

awful.key({ modkey }, "Right", function () windowFocus(1) end),
awful.key(
  { modkey }, "o", function () windowFocus(1) end,
  { description = "focus next window", group = "navigation" }),

-- Layout manipulation
awful.key(
  { modkey, "Shift"   }, "Right", function () awful.client.swap.byidx(  1) end,
  { description = "swap with next client by index", group = "client" }),
awful.key(
  { modkey, "Shift"   }, "Left", function () awful.client.swap.byidx( -1) end,
  { description = "swap with previous client by index", group = "client" }),


awful.key({ modkey, "Shift" }, "o", function () awful.client.swap.byidx(  1) end),
awful.key({ modkey, "Shift" }, "n", function () awful.client.swap.byidx( -1) end),

awful.key(
  { modkey,           }, "u", awful.client.urgent.jumpto,
  { description = "jump to urgent client", group = "client" }),

-- Standard program
awful.key(
  { modkey,           }, "Return", function () awful.spawn(terminal) end,
  { description = "open a terminal", group = "launcher" }),

awful.key(
  { modkey,           }, "space", function () awful.layout.inc( 1) end,
  { description = "select next", group = "layout" }),
awful.key(
  { modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end,
  { description = "select previous", group = "layout" }),

awful.key(
  { modkey, "Control" }, "n", function ()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal(
      "request::activate", "key.unminimize", {raise = true}
      )
    end
  end,
  { description = "restore minimized", group = "client" }),


  -- adjust brightness
awful.key({}, "XF86MonBrightnessUp",
              function() os.execute("brightnessctl set 1%+") end),
awful.key({}, "XF86MonBrightnessDown",
              function() os.execute("brightnessctl set 1%-") end),

              -- Screenshot (the entire screen)
awful.key({ }, "Print",
            function () awful.util.spawn([[scrot 'Pictures/Screenshots/%Y%m%d_%H%M%S.png' -e 'xclip -selection clipboard -t image/png -i $f']]) end,
          { description = "Screenshot", group = "awesome"}),

awful.key({ modkey }, "Print",
            function ()
              awful.util.spawn([[scrot 'Pictures/Screenshots/%Y%m%d_%H%M%S.png' -s -l width=4,color="]] .. beautiful.accents.secondary.main .. [[",opacity=100,mode=edge -e 'xclip -selection clipboard -t image/png -i $f']])
            end,
            { description = "Screenshot selection", group = "awesome"}),


awful.key({ modkey }, "h",
            function ()
              awful.util.spawn([[scrot 'Pictures/Screenshots/%Y%m%d_%H%M%S.png' -s -l width=4,color="]] .. beautiful.accents.secondary.main .. [[",opacity=100,mode=edge -e 'xclip -selection clipboard -t image/png -i $f']])
            end,
            { description = "Screenshot selection", group = "awesome"}),



awful.key(
  { modkey            }, "p", function () 
    awful.util.spawn("rofi -show drun") end,
  { description = "Search programs", group = "rofi" }),

awful.key(
  { modkey            }, "l", function () 
    awful.util.spawn("rofi -show filebrowser -theme-str '#listview {lines:6;}'") end,
  { description = "Search files", group = "rofi" }),

awful.key(
  { modkey            }, "w", function () 
    awful.util.spawn("rofi -show window") end,
  { description = "Search windows", group = "rofi" })

-- If you don't want to use rofi, uncomment this section
-- Prompt
-- awful.key(
--  { modkey,           }, "r", function () 
--    awful.screen.focused().mypromptbox:run() end,
--  { description = "run prompt", group = "launcher" }),
--
--awful.key(
--  { modkey,           }, "x", function ()
--    awful.prompt.run {
--      prompt       = "Run Lua code: ",
--      textbox      = awful.screen.focused().mypromptbox.widget,
--      exe_callback = awful.util.eval,
--      history_path = awful.util.get_cache_dir() .. "/history_eval"
--    }
--  end,
--  { description = "lua execute prompt", group = "awesome" }),
---- Menubar
--awful.key(
--  { modkey,           }, "p", function() menubar.show() end,
--  { description = "show the menubar", group = "launcher" })
)

clientkeys = gears.table.join(
awful.key(
  { modkey,           }, "b", function (c)
    awful.titlebar.toggle(c, "top") end,
  { description = "toggle titlebar on focused client", group = "client" }),

--awful.key(
--  { modkey,           }, "f", function (c)
--    c.fullscreen = not c.fullscreen
--    c:raise()
--  end,
--  { description = "toggle fullscreen", group = "client" }),

------- [ Layout Settings ]
-- Floating window: shrinks the focused window horizontally
--   Tiling window: shrinks the main window horizontally
awful.key(
  { modkey, "Control" }, "Left", function (c)
    if c.floating then
      c:relative_move(10, 0, -20, 0)
    else
      awful.tag.incmwfact (-0.025) end
    end,
  { description = "Shrink window horizontally", group = "layout" }),
-- Floating window: grows the focused window vertically
--   Tiling window: grows the focused window if it's:
--                    - Not a main window
--                    - Has other secondary windows
awful.key(
  { modkey, "Control" }, "Down", function (c)
    if c.floating then
      c:relative_move(0, -10, 0, 20)
    else
      awful.client.incwfact ( 0.025) end
    end,
  { description = "Grow window vertically", group = "layout" }),

-- Floating window: shrinks the focused window vertically
--   Tiling window: shrinks the focused window if it's:
--                    - Not a main window
--                    - Not the only secondary window
awful.key(
  { modkey, "Control" }, "Up", function (c)
    if c.floating then
      c:relative_move(0, 10, 0, -20)
    else
      awful.client.incwfact (-0.025) end
    end,
  { description = "Shrink window vertically", group = "layout" }),

-- Floating window: grows the focused window horizontally
-- Tiling window: grows the main window
awful.key(
  { modkey, "Control" }, "Right", function (c)
    if c.floating then
      c:relative_move(-10, 0, 20, 0)
    else
      awful.tag.incmwfact ( 0.025) end
    end,
  { description = "Grow horizontally to the right", group = "layout" }),

-- Shifted, slower variant
awful.key(
  { modkey, "Control", "Shift" }, "Left", function (c) -- move left
    if c.floating then
      c:relative_move(2, 0, -5, 0)
    else
      awful.tag.incmwfact (-0.002) end
    end),
awful.key(
  { modkey, "Control", "Shift" }, "Down", function (c) -- move down
    if c.floating then
      c:relative_move(0, -2, 0, 5)
    else
      awful.client.incwfact ( 0.002) end
    end),
awful.key(
  { modkey, "Control", "Shift" }, "Up", function (c) -- move up
    if c.floating then
      c:relative_move(0, 2, 0, -5)
    else
      awful.client.incwfact (-0.002) end
    end),
awful.key(
  { modkey, "Control", "Shift" }, "Right", function (c) -- move right
    if c.floating then
      c:relative_move(-2, 0, 5, 0)
    else
      awful.tag.incmwfact ( 0.002) end
    end),

-- Move floating window
awful.key(
  { modkey, "Mod1"   }, "Left",  function (c) c:relative_move(-25,  0,  0,  0) end,
  { description = "Move floating window left",  group = "layout" }),

awful.key(
  { modkey, "Mod1"   }, "Down",  function (c) c:relative_move(  0, 25,  0,  0) end,
  { description = "Move floating window down",  group = "layout" }),

awful.key(
  { modkey, "Mod1"   }, "Up",    function (c) c:relative_move(  0,-25,  0,  0) end,
  { description = "Move floating window up",    group = "layout" }),

awful.key(
  { modkey, "Mod1"   }, "Right", function (c) c:relative_move( 25,  0,  0,  0) end,
  { description = "Move floating window right", group = "layout" }),

-- Shifted, slower variants
awful.key(
  { modkey, "Mod1", "Shift" }, "Left",  function (c)
    c:relative_move(-5, 0, 0, 0) end),
awful.key(
  { modkey, "Mod1", "Shift" }, "Down",  function (c)
    c:relative_move( 0, 5, 0, 0) end),
awful.key(
  { modkey, "Mod1", "Shift" }, "Up",    function (c)
    c:relative_move( 0,-5, 0, 0) end),
awful.key(
  { modkey, "Mod1", "Shift" }, "Right", function (c)
    c:relative_move( 5, 0, 0, 0) end),

awful.key(
  { modkey,           }, "d", function (c) c:kill() end,
  { description = "close", group = "client" }),
awful.key(
  { modkey, "Control" }, "space",  awful.client.floating.toggle,
  { description = "toggle floating", group = "client" }),
awful.key(
  { modkey, "Control" }, "Return", function (c) 
    c:swap(awful.client.getmaster()) end,
  { description = "move to master", group = "client" }),
awful.key(
  { modkey,           }, "o", function (c) c:move_to_screen() end,
  { description = "move to screen", group = "client" })
--awful.key(
--  { modkey,           }, "t", function (c) c.ontop = not c.ontop end,
--  { description = "toggle keep on top", group = "client" }),
--awful.key(
--  { modkey,           }, "n", function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
--    c.minimized = true
--  end,
--  { description = "minimize", group = "client" }),
--awful.key(
--  { modkey,           }, "m", function (c)
--    c.maximized = not c.maximized
--    c:raise()
--  end,
--  { description = "(un)maximize", group = "client" }),
--awful.key(
--  { modkey, "Control" }, "m", function (c)
--    c.maximized_vertical = not c.maximized_vertical
--    c:raise()
--  end,
--  { description = "(un)maximize vertically", group = "client" }),
--awful.key(
--  { modkey, "Shift"   }, "m", function (c)
--    c.maximized_horizontal = not c.maximized_horizontal
--    c:raise()
--  end,
--  { description = "(un)maximize horizontally", group = "client" })
)

-- Create tag bindings automatically, and map them to my home row
for i = 1, totalTags do
globalkeys = gears.table.join(globalkeys,
  -- View tag only.
  awful.key({ modkey }, homeRow[i], function () viewTag(i) end),
  awful.key({ modkey }, i, function () viewTag(i) end,
  { description = "or ".. homeRow[i] .. " View tag "..i, group = "navigation" }),

    -- Move client to tag.
  awful.key({ modkey, "Shift" }, homeRow[i], function () moveToTag(i) end),
  awful.key({ modkey, "Shift" }, i, function () moveToTag(i) end,
  { description = "or " .. homeRow[i] .." Move focused window to tag "..i,
    group = "navigation" })
)
end

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

-- Set keys
root.keys(globalkeys)
-- }}}
