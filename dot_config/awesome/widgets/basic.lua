subtitles = wibox.widget{
  markup = '',
  align  = 'center',
  valign = 'center',
  widget = wibox.widget.textbox
}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

function tagList(s)
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
    layout  = wibox.layout.flex.vertical(),
    widget_template = {
      { -- margin between widgets
        { -- background colour
          { -- ext margin
            { -- text
              id     = "text_role",
              widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal,
          },
          left  = 10, 
          widget = wibox.container.margin
        },
        id     = "background_role",
        widget = wibox.container.background,
      },
      left = 3,
      widget = wibox.container.margin
    }
  }
end

-- Create a wibox for each screen and add it
taglist_buttons = gears.table.join(
	awful.button({ }, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
	  if client.focus then
	    client.focus:move_to_tag(t)
	  end
	end),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
	  if client.focus then
	    client.focus:toggle_tag(t)
	  end
	end),
	awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

