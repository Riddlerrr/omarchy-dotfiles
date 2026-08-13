-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Personal keybindings migrated from Omarchy 3.8.

-- AI button sends ALT+SHIFT+F23 after altwin:swap_alt_win.
o.bind("ALT + SHIFT + F23", "AI Button", "omarchy-menu toggle root")

-- Application overrides.
hl.unbind("SUPER + SHIFT + G") -- was: Signal
o.bind(
	"SUPER + SHIFT + G",
	"Lazy Git",
	[=[omarchy-launch-tui lazygit -p "$(grep -A 1 "recentrepos:" ~/.local/state/lazygit/state.yml | tail -1 | sed 's/^[[:space:]]*-[[:space:]]*//')"]=]
)

hl.unbind("SUPER + SHIFT + W") -- was: Omawrite
o.bind("SUPER + SHIFT + W", "Typora", { launch = "typora" })

-- Menus and window management.
hl.unbind("SUPER + SPACE") -- was: Omarchy menu
o.bind("SUPER + SPACE", "Switch keyboard layout", "~/.local/bin/notify-layout.sh")
o.bind("ALT + SPACE", "Launch apps", "omarchy-menu toggle apps")

hl.unbind("SUPER + ALT + SPACE") -- was: Apps menu
o.bind("SUPER + GRAVE", "Omarchy menu", "omarchy-menu toggle root")

hl.unbind("SUPER + W") -- was: Close window
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

o.bind("SUPER + E", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
hl.unbind("SUPER + ALT + S") -- was: Move window to scratchpad
o.bind(
	"SUPER + ALT + E",
	"Move window to scratchpad",
	hl.dsp.window.move({ workspace = "special:scratchpad", follow = false })
)

-- Notes scratchpad.
o.bind("SUPER + N", "Toggle notes", "~/.local/bin/omarchy-toggle-notes")
o.bind("SUPER + ALT + N", "Move window to notes", hl.dsp.window.move({ workspace = "special:notes", follow = false }))

-- Map Command-style shortcuts to their Control equivalents by physical key.
local function ctrl_shortcut(key)
	return hl.dsp.send_shortcut({ mods = "CTRL", key = key, window = "activewindow" })
end

hl.unbind("SUPER + S") -- was: Toggle scratchpad
hl.unbind("SUPER + F") -- was: Full screen
hl.unbind("SUPER + BACKSPACE") -- was: Toggle window transparency
hl.unbind("SUPER + SLASH") -- was: Monitor scaling up

o.bind("SUPER + S", "Universal save", ctrl_shortcut("code:39"))
o.bind("SUPER + Z", "Universal undo", ctrl_shortcut("code:52"))
o.bind("SUPER + A", "Universal select all", ctrl_shortcut("code:38"))
o.bind("SUPER + F", "Universal search", ctrl_shortcut("code:41"))
o.bind("SUPER + code:61", "Universal comment", ctrl_shortcut("code:61"))
o.bind("SUPER + CTRL + code:61", "Monitor scaling up", "omarchy-hyprland-monitor-scaling up")

-- Disabled defaults.
hl.unbind("SUPER + SHIFT + SPACE") -- was: Toggle top bar
hl.unbind("SUPER + CTRL + F") -- was: Tiled full screen
hl.unbind("SUPER + ALT + F") -- was: Full width

-- Fullscreen rebindings.
o.bind("F11", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("ALT + F11", "Full width", hl.dsp.window.fullscreen({ mode = "maximized" }))
o.bind("CTRL + F11", "Tiled full screen", "omarchy-hyprland-window-tiled-fullscreen-toggle")
