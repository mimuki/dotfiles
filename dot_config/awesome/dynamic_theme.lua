require("themes.mimuki.members.main")


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

-- Changes Awesome's theme to a certain colour
function themeBg(colour)
  theme_bg = colour 
  awful.screen.focused().mywibox.bg = colour
  beautiful.bg_normal = colour
  beautiful.bg_systray = colour
  beautiful.titlebar_fg_focus = colour
  beautiful.titlebar_fg_urgent = colour
  beautiful.taglist_bg_focus = colour
  beautiful.taglist_bg_occupied = colour
  beautiful.taglist_bg_urgent = colour
  beautiful.taglist_bg_empty = colour
  beautiful.notifcation_bg = colour
  beautiful.menu_bg_normal = colour -- this doesnt work for some reason

end

function themeFg(colour)
  theme_fg = colour
  cpuIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.cpu_icon, colour)))
  ramIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.ram_icon, colour)))
  volIcon:set_image(gears.surface.load_uncached(gears.color.recolor_image(beautiful.vol_icon, colour))) 
  beautiful.menu_fg_normal = colour -- also broken
  beautiful.menu_fg_focus = colour
  beautiful.notifcation_fg = colour -- broken rn, oops. i think its the same issue 
end                                 -- as the notif border thing

function themeAccent(colour)
  theme_accent = colour
  beautiful.taglist_fg_focus = colour
  beautiful.border_focus = colour
  beautiful.titlebar_bg_focus = colour 

end

function themeAccentAlt(colour)
  theme_accent_alt = colour
  beautiful.hotkeys_border_color = colour  -- TODO: doesnt seem to update properly
  beautiful.tooltip_border_color = colour
  beautiful.notification_border_color = colour
  beautiful.menu_border_color = colour -- TODO: doesn't apply to the *main* menu, only submenus

end

function themeSelect(colour)
  theme_select = colour
  beautiful.bg_focus = colour
  beautiful.border_normal = colour
  beautiful.titlebar_bg_normal = colour 
  beautiful.taglist_fg_empty = colour
  beautiful.menu_bg_focus = colour

  -- ramIcon:set_bg(colour)
  -- volIcon:set_bg(colour)
end
