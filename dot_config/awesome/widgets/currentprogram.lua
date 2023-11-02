function taskList(s) 
  programName = require("widgets/customtasklist") {
    screen  = s,
    filter  = awful.widget.tasklist.filter.focused,
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
      { -- margin between widgets
        { -- background colour
          { -- icon+text margin
            { -- icon margin
              { -- icon
                id     = "icon_role",
                widget = wibox.widget.imagebox,
              },
              margins = 4,
              widget  = wibox.container.margin,
            },
            { -- text
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
      left = 3,
      widget = wibox.container.margin
    }
  }
  -- Just a little bit of extra padding
  --s.currentProgram = wibox.container.margin(programName, 4, 0, 0, 0, beautiful.bg, false)
  s.currentProgram = programName
end
