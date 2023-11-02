-- Functions
-- Switch between windows in both tmux and awesome with the same keybind
-- direction is either -1 or 1, as in awful.client.focus.byidx(direction)
function focusWindow(direction)
  if awful.screen.focused().selected_tag.index == 1 then 
    if direction == 1 then os.execute("tmux next-window") 
    else os.execute("tmux previous-window") end
    os.execute("sh ~/.tmux/plugins/rat_scripts/statusbar.sh")
  else awful.client.focus.byidx(direction) end
end
-- Move windows around in awesome, or panes in tmux
-- You'd think to try moving windows this way in tmux, but it doesn't feel 
-- right- you don't shuffle maximized windows like that, and moving windows 
-- between tags is a different keybind & conceptualized direction
function moveWindow(direction)
  if awful.screen.focused().selected_tag.index == 1 then 
    if direction == 1 then os.execute("tmux swap-pane -d -t +1") 
    else os.execute("tmux swap-pane -d -t -1") end
  else awful.client.swap.byidx(direction) end
end

-- Used for that "generate binds for each tag you have" thing
function viewTag(index)
  if awful.screen.focused().tags[index] then
    awful.screen.focused().tags[index]:view_only()
  end
end
function moveToTag(index)
  if client.focus then
    if client.focus.screen.tags[index] then 
      client.focus:move_to_tag(client.focus.screen.tags[index]) 
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
  { description = "Show help", group = "awesome" }),
awful.key(
  { modkey }, "m", function () mymainmenu:show() end,
  { description = "Show main menu", group = "awesome" }),
awful.key( 
  { modkey, "Control" }, "r", awesome.restart,
  { description = "Reload awesome", group = "awesome" }),
awful.key(
  { modkey, "Shift" }, "q", awesome.quit,
  { description = "Quit awesome", group = "awesome" }),

awful.key(
  { modkey }, "Up",   awful.tag.viewprev,
  { description = "or i View previous tag", group = "focus" }),
awful.key({ modkey }, "i",   awful.tag.viewprev),

awful.key(
  { modkey }, "Down",  awful.tag.viewnext,
  { description = "or e View next tag", group = "focus" }),
awful.key({ modkey }, "e",  awful.tag.viewnext),

awful.key(
  { modkey }, "Left", function () focusWindow(-1) end,
  { description = "or n Focus previous window", group = "focus" }),
awful.key({ modkey }, "n", function () focusWindow(-1) end),

awful.key(
  { modkey }, "Right", function () focusWindow(1) end,
  { description = "or o Focus next window", group = "focus" }),
awful.key({ modkey }, "o", function () focusWindow(1) end),

-- Layout manipulation

awful.key(
  { modkey, "Shift" }, "Right", function () moveWindow(1) end,
  { description = "or o Swap with next window by index", group = "window management" }),
awful.key({ modkey, "Shift" }, "o", function () awful.client.swap.byidx(  1) end),

awful.key(
  { modkey, "Shift" }, "Left", function () moveWindow(-1) end,
  { description = "or n Swap with previous window by index", group = "window management" }),
awful.key({ modkey, "Shift" }, "n", function () moveWindow(-1) end),

-- Standard program
awful.key(
  { modkey }, "Return", function () awful.spawn(terminal) end,
  { description = "Open a terminal", group = "programs" }),

awful.key(
  { modkey }, "space", function () awful.layout.inc( 1) end,
  { description = "Next layout", group = "layout" }),
awful.key(
  { modkey, "Shift" }, "space", function () awful.layout.inc(-1) end,
  { description = "Previous layout", group = "layout" }),

-- adjust brightness
awful.key(
  { }, "XF86MonBrightnessUp", function() os.execute("brightnessctl set 1%+") end),
awful.key(
  { }, "XF86MonBrightnessDown", function() os.execute("brightnessctl set 1%-") end),

-- Screenshot (the entire screen)
awful.key(
  { }, "Print", function () 
    awful.util.spawn([[scrot 'Pictures/Screenshots/%Y%m%d_%H%M%S.png' -e 'xclip -selection clipboard -t image/png -i $f']]) end,
  { description = "Screenshot", group = "awesome"}),

awful.key(
  { modkey }, "Print", function ()
    awful.util.spawn([[scrot 'Pictures/Screenshots/%Y%m%d_%H%M%S.png' -s -l width=4,color="]] .. beautiful.accents.secondary.main .. [[",opacity=100,mode=edge -e 'xclip -selection clipboard -t image/png -i $f']])
    end,
  { description = "Screenshot selection", group = "awesome"}),


awful.key(
  { modkey }, "h", function ()
    awful.util.spawn([[scrot 'Pictures/Screenshots/%Y%m%d_%H%M%S.png' -s -l width=4,color="]] .. beautiful.accents.secondary.main .. [[",opacity=100,mode=edge -e 'xclip -selection clipboard -t image/png -i $f']])
    end,
  { description = "Screenshot selection", group = "awesome"}),

awful.key(
  { modkey }, "p", function () 
    awful.util.spawn("rofi -show drun") end,
  { description = "Search programs", group = "rofi" }),

awful.key(
  { modkey }, "l", function () 
    awful.util.spawn("rofi -show filebrowser -theme-str '#listview {lines:6;}'") end,
  { description = "Search files", group = "rofi" }),

awful.key(
  { modkey }, "w", function () 
    awful.util.spawn("rofi -show window") end,
  { description = "Search windows", group = "rofi" })
)

clientkeys = gears.table.join(
awful.key(
  { modkey }, "b", function (c)
    awful.titlebar.toggle(c, "top") end,
  { description = "toggle titlebar on focused client", group = "window management" }),

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
  { description = "Shrink window horizontally", group = "window management" }),

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
  { description = "Grow window vertically", group = "window management" }),

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
  { description = "Shrink window vertically", group = "window management" }),

-- Floating window: grows the focused window horizontally
-- Tiling window: grows the main window
awful.key(
  { modkey, "Control" }, "Right", function (c)
    if c.floating then
      c:relative_move(-10, 0, 20, 0)
    else
      awful.tag.incmwfact ( 0.025) end
    end,
  { description = "Grow horizontally to the right", group = "window management" }),

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
  { description = "Move floating window left",  group = "floating windows" }),

awful.key(
  { modkey, "Mod1"   }, "Down",  function (c) c:relative_move(  0, 25,  0,  0) end,
  { description = "Move floating window down",  group = "floating windows" }),

awful.key(
  { modkey, "Mod1"   }, "Up",    function (c) c:relative_move(  0,-25,  0,  0) end,
  { description = "Move floating window up",    group = "floating windows" }),

awful.key(
  { modkey, "Mod1"   }, "Right", function (c) c:relative_move( 25,  0,  0,  0) end,
  { description = "Move floating window right", group = "floating windows" }),

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
  { modkey }, "d", function (c) c:kill() end,
  { description = "close", group = "window management" }),
awful.key(
  { modkey, "Control" }, "space",  awful.client.floating.toggle,
  { description = "toggle floating", group = "floating windows" }),
awful.key(
  { modkey }, "o", function (c) c:move_to_screen() end,
  { description = "move to screen", group = "window management" })
)

-- Create tag bindings automatically, and map them to my home row
for i = 1, totalTags do
globalkeys = gears.table.join(globalkeys,
  -- View tag only.
  awful.key({ modkey }, homeRow[i], function () viewTag(i) end),
  awful.key({ modkey }, i, function () viewTag(i) end,
  { description = "or ".. homeRow[i] .. " View tag "..i, group = "focus" }),

    -- Move client to tag.
  awful.key({ modkey, "Shift" }, homeRow[i], function () moveToTag(i) end),
  awful.key({ modkey, "Shift" }, i, function () moveToTag(i) end,
  { description = "or " .. homeRow[i] .." Move focused window to tag "..i,
    group = "window management" })
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

-- Mouse bindings 
-- Only apply to the status bar, wallpaper, etc.
root.buttons(gears.table.join(
  awful.button({ }, 3, function () mymainmenu:toggle() end)))

-- Set keys
root.keys(globalkeys)
-- }}}
