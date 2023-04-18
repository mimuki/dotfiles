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
  beautiful.bg_normal = colour
  beautiful.bg_systray = colour
  beautiful.titlebar_fg_focus = colour
  beautiful.titlebar_fg_urgent = colour
  beautiful.taglist_bg_focus = colour
  beautiful.taglist_bg_occupied = colour
  beautiful.taglist_bg_urgent = colour
  beautiful.taglist_bg_empty = colour
end

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
end

function themeSelect(colour)
  theme_select = colour
  beautiful.bg_focus = colour
  beautiful.border_normal = colour
  beautiful.titlebar_bg_normal = colour 
  beautiful.taglist_fg_empty = colour
end
