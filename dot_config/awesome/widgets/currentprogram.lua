function taskList(s) 
  mytasklist = require("widgets/customtasklist")
  mytasklist = mytasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.focused,
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
      {
        {
          {
            {
              id     = "icon_role",
              widget = wibox.widget.imagebox,
            },
            margins = 8,
            widget  = wibox.container.margin,
          },
          {
            id     = "text_role",
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left  = 2, -- visually, the icon's padding does the rest
        right = 10,
        widget = wibox.container.margin
      },
      id     = "background_role",
      widget = wibox.container.background,
    },
  }
  -- Just a little bit of extra padding
  s.currentProgram = wibox.container.margin(mytasklist, 4, 0, 0, 0, beautiful.bg, false)
end
