-- Hyprland config (Lua format). Managed by chezmoi.
-- Wiki: https://wiki.hypr.land/configuring/
--
-- Machine-specific settings (monitors, split workspaces, idle, browser) come from machine.lua,
-- which chezmoi generates from .chezmoidata/hosts.yaml. This file is shared by all hosts.

local machine = require("machine")


------------------
---- MONITORS ----
------------------

for _, m in ipairs(machine.monitors) do
    hl.monitor(m)
end


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"
local browser     = machine.browser


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    -- Hand the PAM-unlocked wallet to kwalletd. Arch ships it in /usr/lib; on NixOS
    -- home-manager links it into ~/.local/libexec (see hypr.nix in nixos-config).
    hl.exec_cmd([[for f in /usr/lib/pam_kwallet_init "$HOME/.local/libexec/pam_kwallet_init"; do [ -x "$f" ] && exec "$f"; done]])
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    if machine.idle then
        hl.exec_cmd("hypridle")
    end
    hl.exec_cmd("nextcloud")
    hl.exec_cmd("joplin-desktop")
    hl.exec_cmd("supersonic-desktop")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 1,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


-----------------
---- PLUGINS ----
-----------------

-- split-monitor-workspaces (Lua plugin, fetched by chezmoi via .chezmoiexternal.toml.tmpl)
local smw = nil
if machine.split_workspaces then
    package.path = package.path .. ";./?.lua;./?/init.lua"
    smw = require("plugins.split-monitor-workspaces")

    local priority = {}
    for _, m in ipairs(machine.monitors) do
        table.insert(priority, m.output)
    end

    smw.setup({
        workspace_count              = 5,
        monitor_priority             = priority, -- left-to-right, as listed in hosts.yaml
        keep_focused                 = false,
        enable_notifications         = false,
        enable_persistent_workspaces = true,
    })
end


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN",      hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",           hl.dsp.window.close())
hl.bind(mainMod .. " + CONTROL + Q", hl.dsp.exit())
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE",       hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",           hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + T",        hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + B",           hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + M",   hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Audio controls
hl.bind(mainMod .. " + F7",            hl.dsp.exec_cmd("supersonic-desktop -previous"))
hl.bind(mainMod .. " + F8",            hl.dsp.exec_cmd("supersonic-desktop -next"))
hl.bind(mainMod .. " + F9",            hl.dsp.exec_cmd("supersonic-desktop -play-pause"))
hl.bind(mainMod .. " + F10",           hl.dsp.exec_cmd("~/scripts/outs.py -n"))
hl.bind(mainMod .. " + CONTROL + F11", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ 0%"))
hl.bind(mainMod .. " + F11",           hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind(mainMod .. " + F12",           hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind(mainMod .. " + CONTROL + F12", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ 70%"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- With split workspaces, numbers are relative to the focused monitor.
if smw then
    for i = 1, smw.get_amount_of_workspaces() do
        local key = tostring(i % 10)
        hl.bind(mainMod .. " + " .. key,         smw.workspace(tostring(i)))
        hl.bind(mainMod .. " + SHIFT + " .. key, smw.move_to_workspace(tostring(i)))
    end
else
    for i = 1, 10 do
        local key = i % 10 -- workspace 10 is on key 0
        hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
        hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    end
end

-- Scratchpad special workspace
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
if smw then
    hl.bind(mainMod .. " + mouse_down", smw.cycle_workspaces("next"))
    hl.bind(mainMod .. " + mouse_up",   smw.cycle_workspaces("prev"))
else
    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys for volume and brightness (old bindel = locked + repeating)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),        { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"),                             { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"),                             { locked = true, repeating = true })

-- Media keys, requires playerctl (old bindl = locked)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Screenshots
hl.bind("PRINT",                       hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + PRINT",         hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))

-- Hypr utils
hl.bind(mainMod .. " + CONTROL + L",    hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + PERIOD",         hl.dsp.exec_cmd("hyprsunset"))
hl.bind(mainMod .. " + SHIFT + PERIOD", hl.dsp.exec_cmd("killall hyprsunset"))

-- System
hl.bind(mainMod .. " + CONTROL + S", hl.dsp.exec_cmd("shutdown now"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Ignore maximize requests from apps
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
-- (the old config had "^&" here, which looks like a typo for "^$")
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_initial_focus = true,
})

-- Special workspaces: Joplin (SUPER+N) and Supersonic (SUPER+M)
hl.window_rule({
    name  = "joplin-notes",
    match = { class = "^Joplin" },
    workspace = "special:notes",
})
hl.bind(mainMod .. " + N", hl.dsp.workspace.toggle_special("notes"))

hl.window_rule({
    name  = "supersonic-music",
    match = { class = "^Supersonic" },
    workspace = "special:music",
})
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("music"))

-- Game windows: fullscreen on the host's primary monitor (hosts.yaml), workspace 5
local steam_rule = {
    name  = "steam-games",
    match = { class = [[^steam_app_\d+$]] },
    fullscreen = true,
    workspace  = "5",
}
if machine.primary and machine.primary ~= "" then
    steam_rule.monitor = machine.primary
end
hl.window_rule(steam_rule)
hl.workspace_rule({ workspace = "5", no_border = true, no_rounding = true })
