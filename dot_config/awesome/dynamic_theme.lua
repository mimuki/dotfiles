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

