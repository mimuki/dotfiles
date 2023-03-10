--------------------------------------------------------------------------------
--                                   rc.lua                                   --
--                                                                            --
-- Last edit: 08/03/23                        Made with love by kulupu Mimuki --
--------------------------------------------------------------------------------
-- TODO: Rewrite theme                                                        --
--       Continue making things pretty                                        --
--       Move top bar to its own file                                         --
--       Make the last edit indicator automated?                              --
--------------------------------------------------------------------------------

----- [ Dependencies ] ---------------------------------------------------------
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Theme
beautiful.init("~/.config/awesome/theme.lua")
----- [ External Config ] ------------------------------------------------------
require("keybindings")    -- My default keybindings
require("rules")          -- Window Rules
require("vars")           -- Variables
-- Disable when using smart_borders for a perfomance boost:
require("titlebars")      -- Titlebar config
-- Enable for smart_borders
-- note: you will need to do some DIY because i removed the module ol
-- require("smart_borders")  -- Border config (technically made of titlebars)
require("widgets")        -- Topbar widgets
-- Lain
local lain = require("lain")
local separators = lain.util.separators
local markup = lain.util.markup

----- [ Variables ] ------------------------------------------------------------
-- This is used later as the default terminal and editor to run.
-- terminal = "x-terminal-emulator"
terminal = "kitty"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4" -- GUI/Super/Meta/Windows etc

-- Enabled layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.top,
}


----- [ Error Handling ] -------------------------------------------------------
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}


----- [ Menu ] -----------------------------------------------------------------
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end)
                )

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
    end),
    awful.button({ }, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1)
    end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    
    -- Quake application
    s.quake = lain.util.quake({
        app = "kitty",
        name = "Quake",
        argname = "--name Quake",
        border = theme_border_width
    })

    -- Each screen has its own tag table.
    awful.tag({ "kijetesantakalu", "toki", "musi", "nasa", "ilo" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
      awful.button({ }, 1, function () awful.layout.inc( 1) end),
      awful.button({ }, 3, function () awful.layout.inc(-1) end),
      awful.button({ }, 4, function () awful.layout.inc( 1) end),
      awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style   = {
            font = "linja lipamanka 18"
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.background(s.mytaglist, theme_bg),

            wibox.container.background(spacer, theme_pink),
            wibox.container.background(frontInfo, theme_pink),
            wibox.container.background(spacer, theme_pink),
            wibox.container.background(localDate, theme_purple),
            wibox.container.background(weather, theme_select),

        },
	dummy, -- Only needed when there are no middle widgets
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            wibox.container.background(bluetoothIcon, theme_select),
            wibox.container.background(wifiIcon, theme_select),
            
            wibox.container.background(volumeIcon, theme_bg),
            wibox.container.background(volume.widget, theme_bg),

            wibox.container.background(watts, theme_select),
            batteryIcon,
            wibox.container.background(internalBattery, theme_select),
            wibox.container.background(externalBattery, theme_bg),
            wibox.container.background(localTime, theme_blue),
        },
    }
 end)
-- }}}


----- [ Mouse Support ] --------------------------------------------------------

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
