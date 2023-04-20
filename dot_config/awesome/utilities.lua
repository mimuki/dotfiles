
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