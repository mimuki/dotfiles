-- Default modifier
-- Mod4 is the Windows/Super/etc key
modkey = "Mod4"

-- Layouts you want to use, and the order you want to switch between them
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.top,
  awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.floating,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}

-- Change the names (and amount of) tags you have.
tagNames = { "", "", "" }

terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
-- Used in the main menu- you can edit your config however you like,
-- but a fallback is nice for when you've accidentally broken stuff
editorCommand = terminal .. " -e " .. editor

