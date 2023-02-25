--------------------------------------------------------------------------------
--                              keybindings.lua                               --
--                                                                            --
-- Last edit: 18/01/23                        Made with love by kulupu Mimuki --
--------------------------------------------------------------------------------
-- TODO: Maybe only have todo files in the main rc.lua?                       --
--------------------------------------------------------------------------------

----- [ Dependencies ] ---------------------------------------------------------

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- Notification library
local hotkeys_popup = require("awful.hotkeys_popup")
-- Move window to next/previous tag
local gmath = require("gears.math")

local lain = require("lain")
local volume = lain.widget.pulsebar{
  notification_preset = {
    position = "top_middle",
    font = "Monospace 20"
  }
}

----- [ Variables ] ------------------------------------------------------------

modkey = "Mod4" -- GUI/Super/Meta/Windows etc
homeRow = {"a", "r", "s", "t", "g", "m", "n", "e", "i", "o", "semicolon" }
totalTags = 5 -- Change to increase or decrease number of tags generated

----- [ Keybindings ] ----------------------------------------------------------
globalkeys = gears.table.join(
----- [ Focus and Navigation ] -------------------------------------------------
-- For focusing a tag by number, see the end of the file.

awful.key({ modkey,           }, "n", awful.tag.viewprev,
          { description = "view previous tag", group = "tag" }),

awful.key({ modkey,           }, "Left", awful.tag.viewprev),

awful.key({ modkey,           }, "e",
            function () awful.client.focus.byidx(-1) end,
          { description = "focus previous window", group = "window" }),

awful.key({ modkey,           }, "Down",
            function () awful.client.focus.byidx(-1) end),

awful.key({ modkey,           }, "i",
            function () awful.client.focus.byidx( 1) end,
          { description = "focus next window", group = "window" }),


awful.key({ modkey,           }, "Up",
            function () awful.client.focus.byidx( 1) end),

awful.key({ modkey,           }, "o", awful.tag.viewnext,
          { description = "view next tag", group = "tag" }),

awful.key({ modkey,           }, "Right", awful.tag.viewnext),


awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
          { description = "jump to urgent window", group = "window" }),

awful.key({ modkey,           }, "Tab",
            function ()
                awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
                end
            end,
          { description = "go back", group = "window" }),


-- Only relevant when we get a second monitor. Pick a binding you like then.
--    awful.key({ modkey, "Control" }, "o",
--                function () awful.screen.focus_relative( 1) end,
--              { description = "focus next screen", group = "screen" }),
--    awful.key({ modkey, "Control" }, "n",
--                function () awful.screen.focus_relative(-1) end,
--              { description = "focus previous screen", group = "screen" }),

----- [ Layout Manipulation ] --------------------------------------------------

------- [ Move Window ]
awful.key({ modkey, "Shift" }, "n", function ()
            local c = client.focus
            if not c then return end
            local t = c.screen.selected_tag
            local tags = c.screen.tags
            local idx = t.index
            local newtag = tags[gmath.cycle(#tags, idx - 1)]
            c:move_to_tag(newtag)
            end,
          { description = "move window to previous tag", group = "window" }),

awful.key({ modkey, "Shift"   }, "e",
            function () awful.client.swap.byidx( -1) end,
          { description = "swap with previous window",
            group = "window"  }),

awful.key({ modkey, "Shift"   }, "i",
            function () awful.client.swap.byidx(  1) end,
          { description = "swap with next window",
            group = "window"  }),

awful.key({ modkey, "Shift" }, "o", function ()
            local c = client.focus
            if not c then return end
            local t = c.screen.selected_tag
            local tags = c.screen.tags
            local idx = t.index
            local newtag = tags[gmath.cycle(#tags, idx + 1)]
            c:move_to_tag(newtag)
         end,
          { description = "move window to next tag", group = "window" }),

awful.key({ modkey,           }, "space",
            function () awful.layout.inc( 1) end,
          { description = "select next layout", group = "layout" }),

awful.key({ modkey, "Control" }, "space",
            function () awful.layout.inc(-1) end,
          { description = "select previous layout", group = "layout" }),



--awful.key({ modkey, "Mod1"  }, "n",     function () awful.tag.incnmaster( 1, nil, true) end,
--          {description = "increase the number of master clients", group = "layout"}),
--awful.key({ modkey, "Mod1"  }, "o",     function () awful.tag.incnmaster(-1, nil, true) end,
--          {description = "decrease the number of master clients", group = "layout"}),

----- [ Program Launchers ] ----------------------------------------------------

awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
          { description = "Terminal", group = "programs" }),

------- [ Rofi ]
-- TODO: maybe make it so that repeating these toggles rofi open/closed?
awful.key({ modkey            }, "p",
            function () awful.util.spawn("rofi -show drun") end,
          { description = "Search programs", group = "rofi" }),

awful.key({ modkey            }, "f",
            function () awful.util.spawn("rofi -show filebrowser -theme-str '#listview {lines:6;}'") end,
          { description = "Search files", group = "rofi" }),

awful.key({ modkey            }, "w",
            function () awful.util.spawn("rofi -show window") end,
          { description = "Search windows", group = "rofi" }),

awful.key({ modkey }, "y",  awful.client.floating.toggle,
          { description = "toggle floating", group = "client" }),
----- [ System Controls ] ------------------------------------------------------
-- Mute audio
awful.key({ modkey }, "m",
            function ()
              os.execute(string.format(
                "pactl set-sink-mute %s toggle",
                volume.device))
              volume.notify()
            end,
          { description = "mute audio", group = "audio" }),


awful.key({}, "XF86AudioMute",
            function ()
              os.execute(string.format(
                "pactl set-sink-mute %s toggle",
                volume.device))
              volume.notify()
            end),

-- Volume up
awful.key({ modkey }, "j",
            function ()
              os.execute(string.format(
                "pactl set-sink-volume %s +1%%",
                volume.device))
              volume.notify()
            end,
          { description = "increase audio", group = "audio" }),

awful.key({}, "XF86AudioRaiseVolume",
            function ()
              os.execute(string.format(
                "pactl set-sink-volume %s +1%%",
                volume.device))
              volume.notify()
            end),

-- Volume down
awful.key({ modkey }, "k",
            function ()
              os.execute(string.format(
                "pactl set-sink-volume %s -1%%",
                volume.device))
              volume.notify()
            end,
          { description = "decrease audio", group = "audio" }),

awful.key({}, "XF86AudioLowerVolume",
            function ()
              os.execute(string.format(
                "pactl set-sink-volume %s -1%%",
                volume.device))
              volume.notify()
            end),

-- toggle microphone 
awful.key({}, "XF86AudioMicMute",
              function() os.execute("amixer set Capture toggle") end),
-- toggle wifi
-- awful.key({}, "XF86WLAN",
--              function() os.execute("wifi toggle") end),
-- toggle bluetoth
awful.key({}, "XF86Bluetooth",
              function() os.execute("bluetooth toggle") end),
-- adjust brightness
awful.key({}, "XF86MonBrightnessUp",
              function() os.execute("xbacklight -inc 5") end),
awful.key({}, "XF86MonBrightnessDown",
              function() os.execute("xbacklight -dec 5") end),

----- [ AwesomeWM Meta Controls ] ----------------------------------------------

awful.key({ modkey,           }, "/",      hotkeys_popup.show_help,
          { description = "show help", group="awesome" }),
awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
          { description = "go back", group = "tag" }),
awful.key({ modkey, "Control" }, "r", awesome.restart,
          { description = "reload awesome", group = "awesome" })
)
----- [ Client Keys ] ----------------------------------------------------------
-- TODO: learn why this is seperate from globalkeys

clientkeys = gears.table.join(
    awful.key({ modkey,       }, "d", function (c) c:kill() end,
              { description = "close window", group = "window" }),

--    awful.key({ modkey,       }, "F11", function (c) awful.titlebar.toggle(c) end,
--              { description = "show/hide titlebars", group="client" }),

------- [ Layout Settings ]
-- Floating window: shrinks the focused window horizontally
--   Tiling window: shrinks the main window horizontally
awful.key({ modkey, "Control" }, "n", function (c)
            if c.floating then
              c:relative_move(10, 0, -20, 0)
            else
              awful.tag.incmwfact (-0.025) end
            end,
          { description = "Shrink window horizontally",
            group = "layout" }),
-- Floating window: grows the focused window vertically
--   Tiling window: grows the focused window if it's:
--                    - Not a main window
--                    - Has other secondary windows
awful.key({ modkey, "Control" }, "e", function (c)
            if c.floating then
              c:relative_move(0, -10, 0, 20)
            else
              awful.client.incwfact ( 0.025) end
            end,
          { description = "Grow window vertically",
            group = "layout" }),

-- Floating window: shrinks the focused window vertically
--   Tiling window: shrinks the focused window if it's:
--                    - Not a main window
--                    - Not the only secondary window
awful.key({ modkey, "Control" }, "i", function (c)
            if c.floating then
              c:relative_move(0, 10, 0, -20)
            else
              awful.client.incwfact (-0.025) end
            end,
          { description = "Shrink window vertically",
            group = "layout" }),

-- Floating window: grows the focused window horizontally
-- Tiling window: grows the main window
awful.key({ modkey, "Control" }, "o", function (c)
            if c.floating then
              c:relative_move(-10, 0, 20, 0)
            else
              awful.tag.incmwfact ( 0.025) end
            end,
          { description = "Grow horizontally to the right",
            group = "layout" }),

-- Shifted, faster variant

awful.key({ modkey, "Control", "Shift" }, "n", function (c) -- move left
            if c.floating then
              c:relative_move(40, 0, -80, 0)
            else
              awful.tag.incmwfact (-0.05) end
            end),
awful.key({ modkey, "Control", "Shift" }, "e", function (c) -- move down
            if c.floating then
              c:relative_move(0, -40, 0, 80)
            else
              awful.client.incwfact ( 0.1) end
            end),
awful.key({ modkey, "Control", "Shift" }, "i", function (c) -- move up
            if c.floating then
              c:relative_move(0, 40, 0, -80)
            else
              awful.client.incwfact (-0.1) end
            end),
awful.key({ modkey, "Control", "Shift" }, "o", function (c) -- move right
            if c.floating then
              c:relative_move(-40, 0, 80, 0)
            else
              awful.tag.incmwfact ( 0.05) end
            end),

-- Move floating window

awful.key({ modkey, "Mod1"   }, "n", function (c)
            c:relative_move(-25, 0, 0, 0) end,
          { description = "Move floating window left",
            group = "layout" }),

awful.key({ modkey, "Mod1"   }, "e", function (c)
            c:relative_move(  0, 25,  0,  0) end,
          { description = "Move floating window down",
            group = "layout" }),

awful.key({ modkey, "Mod1"   }, "i", function (c)
            c:relative_move(  0,-25,  0,  0) end,
          { description = "Move floating window up",
            group = "layout" }),

awful.key({ modkey, "Mod1"   }, "o", function (c)
            c:relative_move(25, 0, 0, 0) end,
          { description = "Move floating window right",
            group = "layout" }),

-- Shifted, faster variants

awful.key({ modkey, "Mod1", "Shift" }, "n", function (c) -- move left
            c:relative_move(-100,   0,   0,   0) end),
awful.key({ modkey, "Mod1", "Shift" }, "e", function (c) -- move down
            c:relative_move(   0, 100,   0,   0) end),
awful.key({ modkey, "Mod1", "Shift" }, "i", function (c) -- move up
            c:relative_move(   0,-100,   0,   0) end),
awful.key({ modkey, "Mod1", "Shift" }, "o", function (c) -- move right
            c:relative_move( 100,   0,   0,   0) end)
)

-- Create tag bindings automatically, and map them to my home row
for i = 1, totalTags do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey,         }, homeRow[i],
                    function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  { description = "view tag "..i, group = "tag" }),

        -- Move client to tag.
        awful.key({ modkey, "Shift" }, homeRow[i],
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  { description = "move focused window to tag "..i,
                    group = "tag" })
    )
end
