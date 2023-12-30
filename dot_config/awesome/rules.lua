-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { 
    rule = { },
    properties = { 
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  { -- Make terminal use the entire space available, unless it's floating
    rule = { 
      class = "XTerm",
    },
    properties = { size_hints_honor = false }
  },


  -- Floating clients.
  { 
    rule_any = {
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
    }, 
    properties = { 
      floating = true 
    }
  },

  -- Add titlebars to normal clients and dialogs (or don't!)
  { 
    rule_any = {
      type = { 
        "normal", 
        "dialog" 
      }
    }, 
    properties = { 
      titlebars_enabled = false
    }
  },

  { 
    rule_any = { 
      class = {
        "Firefox",
        "Firefox-esr"
      }
    },
    properties = { 
      maximized = false,
    } 
  },

  { 
    rule = { class = "tmux" },
    properties = { 
      placement = awful.placement.centered,
      floating = true
    } 
  }
}
-- }}}
