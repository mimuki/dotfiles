function statusBar(s)
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    -- ensures the middle widgets are centered
    expand = "none",
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.currentProgram,
      s.mypromptbox,
    },
      subtitles,
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      mytextclock,
      s.mylayoutbox,
    },
  }
end
