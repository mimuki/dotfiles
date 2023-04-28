
local bling = require("bling")


livecaptions = bling.module.scratchpad {
    command = "flatpak run net.sapples.LiveCaptions",
    rule = { instance = "livecaptions" }, 
    sticky = true, -- Stick to every tag
    autoclose = false, -- Don't hide when focus lost
    floating = true, 
    geometry = {x=600, y=800}, 
    reapply = false, -- "Remember" manual position changes
    dont_focus_before_close  = true,                 
}

pyradio = bling.module.scratchpad {
    command = "kitty --class pyradio -e pyradio",
    rule = { instance = "pyradio" }, 
    sticky = true, -- Stick to every tag
    autoclose = true, -- Don't hide when focus lost
    floating = true, 
    geometry = pyradioGeometry, 
    reapply = true, -- "Remember" manual position changes
    dont_focus_before_close  = true,                 
}