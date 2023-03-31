--------------------------------------------------------------------------------
--                             smart_borders.lua                              --
--------------------------------------------------------------------------------

----- [ Dependencies ] ---------------------------------------------------------
-- Theme handling library
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

require('modules/smart_borders'){
----- [ Settings ] -------------------------------------------------------------
	show_button_tooltips = true,
	buttons = { "floating", "close" },
	layout = "ratio",
	button_ratio = 1,
	color_normal = "#44475a",  				-- grey
	color_floating = "#ff79c6",  				-- grey
	color_maximized = "#282a36",  				-- grey
	color_focus  = "#bd93f9", 				-- purple
	color_floating_hover = "#8be9fd", -- cyan
	color_close_hover = "#ff5555",		-- red
	stealth = true,
	border_width = dpi(7)
}
