--------------------------------------------------------------------------------
--                                shortcuts.lua                               --
--------------------------------------------------------------------------------
require("vars")           -- Variables

--- Widget to add to the wibar
shortcutButton = wibox.widget {
  {
    image = '/home/mimuki/.local/share/chezmoi/dot_config/awesome/images/mimuki.png',
    resize = true,
    widget = wibox.widget.imagebox,
  },
  margins = 4,
  layout = wibox.container.margin
}

local menu_items = {
  { 
    name = 'todo', 
    icon_name = 'a.svg', 
    url = 'https://mimuki.net/' 
  }
}


local popup = awful.popup {
  ontop = true,
  visible = false,
  shape = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, 0)
  end,
  border_width = theme_border_width,
  border_color = theme_pink,
  maximum_width = 400,
  offset = { x = -4, y = 0 },
  widget = {}
}
local rows = { layout = wibox.layout.fixed.vertical }

for _, item in ipairs(menu_items) do

  local row = wibox.widget {
    {
      {
        {
          image = '/home/mimuki/.local/share/chezmoi/dot_config/awesome/images/mimuki.png',
          forced_width = 32,
          forced_height = 32,
          widget = wibox.widget.imagebox
        },
        {
          text = item.name,
          widget = wibox.widget.textbox
        },
        spacing = 12,
        layout = wibox.layout.fixed.horizontal
      },
      margins = 8,
      widget = wibox.container.margin
    },
    bg = beautiful.bg_normal,
    widget = wibox.container.background
  }

  -- Change item background on mouse hover
  row:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)
  row:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_focus) end)

  -- Change cursor on mouse hover
  local old_cursor, old_wibox
  row:connect_signal("mouse::enter", function()
  local wb = mouse.current_wibox
  old_cursor, old_wibox = wb.cursor, wb
  wb.cursor = "hand1"
  end)
  row:connect_signal("mouse::leave", function()
  if old_wibox then
    old_wibox.cursor = old_cursor
    old_wibox = nil
  end
  end)

  -- Mouse click handler
  row:buttons(
  awful.util.table.join(
  awful.button({}, 1, function()
  popup.visible = not popup.visible
  awful.spawn.with_shell('xdg-open ' .. item.url)
  end)
  )
  )

  -- Insert created row in the list of rows
  table.insert(rows, row)
end

-- Add rows to the popup
popup:setup(rows)

-- Mouse click handler
shortcutButton:buttons(
awful.util.table.join(
awful.button({}, 1, function()
if popup.visible then
  popup.visible = not popup.visible
else
  popup:move_next_to(mouse.current_widget_geometry)
end
end))
)