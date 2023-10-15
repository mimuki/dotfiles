function taskList(s) 
  mytasklist = require("widgets/customtasklist")
  mytasklist = mytasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.focused
  }
  -- For reasons I don't understand, the margins are slightly off
  -- even though just using spaces is fine for the other widgets
  -- so... idk
  s.mytasklist = wibox.container.margin(mytasklist, 10, 10, 0, 0, beautiful.bg, false)
end
