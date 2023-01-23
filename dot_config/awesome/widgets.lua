--------------------------------------------------------------------------------
--                                widgets.lua                                 --
--                                                                            --
-- Last edit: 22/01/23                        Made with love by kulupu Mimuki --
--------------------------------------------------------------------------------

----- [ Dependencies ] ---------------------------------------------------------
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local wibox = require("wibox")

local lain = require("lain")
local markup = lain.util.markup
local separators = lain.util.separators
require("vars")
----- [ Separators ] -----------------------------------------------------------

arrow_bg_select   = separators.arrow_right(theme_bg,     theme_select)
arrow_select_bg   = separators.arrow_right(theme_select, theme_bg)
arrow_bg_blue     = separators.arrow_right(theme_bg,     theme_blue)
arrow_select_blue = separators.arrow_right(theme_select, theme_blue)
arrow_blue_purple = separators.arrow_right(theme_blue,   theme_purple)
arrow_purple_pink = separators.arrow_right(theme_purple, theme_pink)
arrow_pink_bg     = separators.arrow_right(theme_pink,   theme_bg)


----- [ Time and Date ] --------------------------------------------------------

localTime = wibox.widget.textclock(
                markup.fontfg("sans 16", theme_bg, " %I:%M %P ", 60))
localDate = wibox.widget.textclock(
                markup.fontfg("sans 16", theme_bg, " %A, %b %e ", 60))

----- [ Front Info ] -----------------------------------------------------------

frontInfo = wibox.widget.textbox(" (loading) ") -- placeholder text

gears.timer {
  timeout = 5, -- seconds
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async("less /home/mimuki/Documents/Projects/pk-rpc/front.txt",
      function(out)
        frontInfo.markup = markup.fontfg("sans 16", theme_bg, out)
      end
      )
  end
}