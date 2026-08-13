-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 1.6

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- PC: external LG.
hl.monitor({ output = "DP-2", mode = "3840x2160@60", position = "auto", scale = omarchy_monitor_scale })

-- Slimbook: built-in display below and external LG above/right.
hl.monitor({ output = "eDP-1", mode = "2880x1800@120", position = "0x180", scale = omarchy_monitor_scale })
hl.monitor({ output = "DP-1", mode = "3840x2160@60", position = "1440x0", scale = omarchy_monitor_scale })

-- Fallback for any other monitor.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- On Slimbook, workspaces 1–5 default to the external LG; 6 defaults to the built-in display.
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
hl.workspace_rule({ workspace = "6", monitor = "eDP-1", default = true })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
