-- Create a launcher widget and a main menu
myawesomemenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editorCommand .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

mytitlebarmenu = awful.menu({
  items = {
  { "todo", terminal },

  { "todo", terminal }
  }
  })

mymainmenu = awful.menu({ 
  items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", terminal }
  }
})

mylauncher = awful.widget.launcher({ 
  image = beautiful.awesome_icon,
  menu = mymainmenu 
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
