--------------------------------------------------------------------------------
--                                  rules.lua                                 --
--------------------------------------------------------------------------------

----- [ Rules ] ----------------------------------------------------------------
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {


------- [ All Clients ]
{ rule = { },
    properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen,
        -- we never maximize windows, so just disable it entirely
        maximized_horizontal = false,
        maximized_vertical = false,
        maximized = false
    }
},

------- [ Floating Clients ]
{ rule_any = {
    instance = {
        "DTA",  -- Firefox addon DownThemAll.
        "copyq",  -- Includes session name in class.
        "pinentry",
    },
    class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer"
      },

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
        "Event Tester",  -- xev.
    },
    role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "ConfigManager",  -- Thunderbird's about:config.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    }
}, properties = { floating = true }},

-- (don't) Add titlebars to normal clients and dialogs
{ rule_any = {type = { "normal", "dialog" }
    }, properties = { titlebars_enabled = false }
},

{ rule = { class = "livecaptions" },
    properties = { 
      floating = true,
      ontop = true,
      border_width = 0,
      placement = awful.placement.bottom
    }
},

{ rule = { class = "pyradio" },
    properties = { 
      floating = true,
      ontop = true,
      placement = awful.placement.top
    }
},

{ rule = { class = "URxvt" },
    properties = { size_hints_honor = false }
},



{ rule = { class = "feh" },
    properties = { 
      --floating = true,
      --ontop = true,
      placement = awful.placement.centered,
      maximized = true
    }
}
-- Set Firefox to always map on the tag named "2" on screen 1.
-- { rule = { class = "Firefox" },
--   properties = { screen = 1, tag = "2" } },
}
