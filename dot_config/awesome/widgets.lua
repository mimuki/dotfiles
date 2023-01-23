--------------------------------------------------------------------------------
--                                widgets.lua                                 --
--                                                                            --
-- Last edit: 23/01/23                        Made with love by kulupu Mimuki --
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
ilo_dynamic_focus = "#0000ff"
arrow_dynamic     = separators.arrow_right(ilo_dynamic_focus, theme_pink)

arrow_bg_select   = separators.arrow_right(theme_bg,     theme_select)
arrow_bg_pink     = separators.arrow_right(theme_bg,     theme_pink)
arrow_bg_blue     = separators.arrow_right(theme_bg,     theme_blue)
arrow_pink_purple = separators.arrow_right(theme_pink, theme_purple)
arrow_pink_bg     = separators.arrow_right(theme_pink,   theme_bg)
arrow_purple_blue = separators.arrow_right(theme_purple, theme_blue)
arrow_purple_pink = separators.arrow_right(theme_purple, theme_pink)
arrow_blue_purple = separators.arrow_right(theme_blue,   theme_purple)
arrow_blue_bg     = separators.arrow_right(theme_blue,   theme_bg)
arrow_select_bg   = separators.arrow_right(theme_select, theme_bg)
arrow_select_blue = separators.arrow_right(theme_select, theme_blue)

----- [ Time and date ] --------------------------------------------------------

localTime = wibox.widget.textclock(
                markup.fontfg(theme_font, theme_bg, " %I:%M %P ", 60))
localDate = wibox.widget.textclock(
                markup.fontfg(theme_font, theme_bg, " %A, %b %e ", 60))

----- [ Front info ] -----------------------------------------------------------

-- Placeholder text
frontInfo=wibox.widget.textbox(markup.fontfg(theme_font,theme_bg," (loading) "))

gears.timer {
  timeout = 5, -- seconds
  call_now = true,
  autostart = true,
  callback = function()
    awful.spawn.easy_async("less /home/mimuki/Documents/Projects/pk-rpc/front.txt",
      function(out)
        frontInfo.markup = markup.fontfg(theme_font, theme_bg, out)
      end)
  end
}

----- [ Volume indicator ] -----------------------------------------------------------

volume = lain.widget.pulse( {
    settings = function()
        vlevel = volume_now.left .. "%"
        if volume_now.muted == "yes" then
            widget:set_markup(lain.util.markup(theme_special, vlevel))
        end

        if volume_now.muted == "no" then
            widget:set_markup(lain.util.markup(theme_fg, vlevel))
        end
    end
})
