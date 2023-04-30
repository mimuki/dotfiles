----- [ Colours ] --------------------------------------------------------------
-- Change the foreground and background colour of a widget
-- For widgets with custom formats (i.e. textclocks), not textboxes
function formatColour(widget, fg, bg, text)
  widget.format = "<span foreground='" .. fg .. "' background='" .. bg .. "'>" .. text .. "</span>"
end
-- Change the foreground and background colour of a widget
-- For widgets with custom markup (i.e. text boxes)
function markupColour(widget, fg, bg, text)
  widget.markup = markup.color(fg, bg, text)
end

function refreshWibox()
  formatColour(localDate, beautiful.date_fg, beautiful.date_bg, dateFormat)
  formatColour(localTime, beautiful.time_fg, beautiful.time_bg, timeFormat)
  awful.screen.focused().mywibox.bg = beautiful.bg -- Update wibox
  cpuIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.cpu_icon, beautiful.fg)))
  ramIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.ram_icon, beautiful.fg)))
  volIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.vol_icon, beautiful.fg))) 
  weatherTimer:emit_signal("timeout")
  cpuInfoTimer:emit_signal("timeout")
  ramInfoTimer:emit_signal("timeout")
  batInInfoTimer:emit_signal("timeout")
  batExInfoTimer:emit_signal("timeout")
  wattsTimer:emit_signal("timeout")
  volume.update() -- Volume widget colours
  awful.screen.focused().mytaglist._do_taglist_update()
end

function fileExists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function getImage(url, dir)
  local https = require "ssl.https" 
  local body, code = https.request(url) 
  if not body then error(code) end 
  local f = assert(io.open(dir, 'wb')) -- open in "binary" mode 
  f:write(body) 
  f:close()
end

function kittyTheme()
  kitTheme = "# Generated automatically, will be overwritten\n" .. 
  "foreground          " .. beautiful.fg .. "\n"..
  "background          " .. beautiful.bg .. "\n"
  local f =  assert(io.open("/home/mimuki/.config/kitty/themes/dynamic.conf", 'w'))
  f:write(kitTheme)
  f:close()
  awful.spawn.easy_async("kitty +kitten themes --reload-in=all Dynamic", 
    function(result)
      -- might be worth catching errors here some day
    end)
end
function pyradioTheme()
  pyTheme = "# Generated automatically, will be overwritten\n" ..
  "# Main foreground and background\n" ..
  "Stations            " .. beautiful.fg .. " " .. beautiful.bg .. "\n\n" ..
  "# Playing station text color\n" ..
  "# (background color will come from Stations)\n" ..
  "Active Station      " .. beautiful.accent .. "\n\n" ..
  "# Status bar foreground and background\n" ..
  "Status Bar          " .. beautiful.accent_alt .. " " .. beautiful.bg .. "\n\n" ..
  "# Normal cursor foreground and background\n" ..
  "Normal Cursor       " .. beautiful.bg .. " " .. beautiful.accent .. "\n\n" ..
  "# Cursor foreground and background\n" ..
  "# when cursor on playing station\n" ..
  "Active Cursor       " .. beautiful.bg .. " " .. beautiful.accent_alt .."\n\n" ..
  "# Cursor foreground and background\n" ..
  "# This is the Line Editor cursor\n" ..
  "Edit Cursor         " .. beautiful.bg .. " " .. beautiful.fg .. "\n\n" ..
  "# Text color for extra function indication\n" ..
  "# and jump numbers within the status bar\n" ..
  "# (background color will come from Stations)\n" ..
  "Extra Func          " .. beautiful.red .. "\n\n" ..
  "# Text color for URL\n" ..
  "# (background color will come from Stations)\n" ..
  "PyRadio URL         " .. beautiful.l_black .. "\n\n" ..
  "# Message window border foreground and background.\n" ..
  "# The background color can be left unset.\n" ..
  "# Please refer to the following link for more info\n" ..
  "# https://github.com/coderholic/pyradio#secondary-windows-background\n" ..
  "Messages Border     " .. beautiful.accent_alt .. "\n\n" ..
  "# Border color for the Main Window\n" ..
  "# (background color will come from Stations)\n" ..
  "Border              " .. beautiful.grey .. "\n\n" ..
  "# Theme Transparency\n" ..
  "# Values are:\n" ..
  "#   0: No transparency (default)\n" ..
  "#   1: Theme is transparent\n" ..
  "#   2: Obey config setting\n" ..
  "transparency        0\n"
  local f =  assert(io.open("/home/mimuki/.config/pyradio/themes/dynamic.pyradio-theme", 'w'))
  f:write(pyTheme)
  f:close()
end
