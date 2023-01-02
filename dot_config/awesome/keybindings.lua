--------------------------------------------------------------------------------
--                              keybindings.lua                               --
--                                                                            --
-- Last edit: 01/01/23                        Made with love by kulupu Mimuki --
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

----- [ Variables ] ------------------------------------------------------------

modkey = "Mod4" -- GUI/Super/Meta/Windows etc
homeRow = {"a", "r", "s", "t", "g", "m", "n", "e", "i", "o", "semicolon" }
totalTags = 5

----- [ Keybindings ] ----------------------------------------------------------
globalkeys = gears.table.join(
----- [ Focus and Navigation ] -------------------------------------------------
-- For focusing a tag by number, see the end of the file.

awful.key({ modkey,           }, "n", awful.tag.viewprev,
          { description = "view previous tag", group = "tag" }),
awful.key({ modkey,           }, "o", awful.tag.viewnext,
          { description = "view next tag", group = "tag" }),

awful.key({ modkey,           }, "i",
            function () awful.client.focus.byidx( 1) end,
          { description = "focus next window", group = "window" }),
awful.key({ modkey,           }, "e",
            function () awful.client.focus.byidx(-1) end,
          { description = "focus previous window", group = "window" }),

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
awful.key({ modkey, "Shift"   }, "i",
            function () awful.client.swap.byidx(  1) end,
          { description = "swap with next window",
            group = "window"  }),
awful.key({ modkey, "Shift"   }, "e",
            function () awful.client.swap.byidx( -1) end,
          { description = "swap with previous window",
            group = "window"  }),

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

------- [ Layout Settings ]
awful.key({ modkey, "Alt"     }, "o",
            function () awful.tag.incmwfact( 0.05) end,
          { description = "increase master width factor",
            group = "layout"  }),

awful.key({ modkey, "Alt"     }, "n",
            function () awful.tag.incmwfact(-0.05) end,
          { description = "decrease master width factor",
            group = "layout"  }),

awful.key({ modkey, "Control" }, "n",
            function () awful.tag.incncol( 1, nil, true) end,
          { description = "increase the number of columns",
            group = "layout"  }),

awful.key({ modkey, "Control" }, "o",
            function () awful.tag.incncol(-1, nil, true) end,
          { description = "decrease the number of columns",
            group = "layout"  }),

awful.key({ modkey,           }, "space",
            function () awful.layout.inc( 1) end,
          { description = "select next layout", group = "layout" }),

awful.key({ modkey, "Control" }, "space",
            function () awful.layout.inc(-1) end,
          { description = "select previous layout", group = "layout" }),

--awful.key({ modkey, "Alt"     }, "n",     function () awful.tag.incnmaster( 1, nil, true) end,
--          {description = "increase the number of master clients", group = "layout"}),
--awful.key({ modkey, "Alt"   }, "o",     function () awful.tag.incnmaster(-1, nil, true) end,
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
            function () awful.util.spawn("rofi -show filebrowser -theme-str '#listview {lines:8;}'") end,
          { description = "Search files", group = "rofi" }),

awful.key({ modkey            }, "w",
            function () awful.util.spawn("rofi -show window") end,
          { description = "Search windows", group = "rofi" }),


----- [ AwesomeWM Meta Controls ] ----------------------------------------------

awful.key({ modkey,           }, "/",      hotkeys_popup.show_help,
          { description = "show help", group="awesome" }),
awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
          { description = "go back", group = "tag" }),
awful.key({ modkey, "Control" }, "r", awesome.restart,
          { description = "reload awesome", group = "awesome" }),
awful.key({ modkey, "Shift"   }, "q", awesome.quit,
          { description = "quit awesome", group = "awesome" })
)
----- [ Client Keys ] ----------------------------------------------------------
-- TODO: learn why this is seperate

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "d", function (c) c:kill() end,
              { description = "close window", group = "window" }),

    awful.key({ modkey,           }, "F11", function (c) awful.titlebar.toggle(c)         end,
              {description = "Show/Hide Titlebars", group="client"})
)

for i = 1, totalTags do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey,           }, homeRow[i],
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

        -- Toggle tag display.
--        awful.key({ modkey, "Control" }, homeRow[i],
--                  function ()
--                      local screen = awful.screen.focused()
--                      local tag = screen.tags[i]
--                      if tag then
--                         awful.tag.viewtoggle(tag)
--                      end
--                  end,
--                  { description = "toggle tag " .. i, group = "tag" }),
--        -- Toggle tag on focused client.
--        awful.key({ modkey, "Control", "Shift" }, homeRow[i]
--                  function ()
--                      if client.focus then
--                          local tag = client.focus.screen.tags[i]
--                          if tag then
--                              client.focus:toggle_tag(tag)
--                          end
--                      end
--                  end,
--                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end
