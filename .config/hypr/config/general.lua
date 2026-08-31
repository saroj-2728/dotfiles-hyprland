-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/


---------------------
--- Look and feel ---
---------------------

hl.config({
    general = {
        gaps_in = 0,     -- 4
        gaps_out = 0,    -- 5

        border_size = 0, -- 3

        col = {
            active_border = {
                colors = {
                    "rgba(0,153,255,0.93)",
                    "rgba(0,156,156,0.93)",
                    "rgba(0,255,48,0.93)",
                    "rgba(0,255,0,1)"
                },
                angle = 45,
            },

            inactive_border = {
                colors = {
                    "rgba(0,153,255,0.3)",
                    "rgba(0,156,156,0.3)",
                    "rgba(0,255,48,0.3)",
                    "rgba(0,255,0,0.3)"
                },
                angle = 45,
            },
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps (why isn't this working....)
        resize_on_border = true,

        hover_icon_on_border = true, -- Show resize cursor when hovering over borders and gaps

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 0,       -- 4
        rounding_power = 0, -- 2

        -- Change transparency of focused and unfocused windows
        active_opacity = 1,
        inactive_opacity = 1,

        shadow = {
            enabled = false, -- true
            range = 4,
            render_power = 3,
            color = "rgba(0,50,100,0.55)"
        },

        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            new_optimizations = true,
            vibrancy = 0.1696,
        },
    },
})



--------------------
--- Layer Rules ----
--------------------
--- https://wiki.hypr.land/Configuring/Basics/Window-Rules/#layer-rules

hl.layer_rule({
    match = {
        namespace = "rofi"
    },
    blur = true,
    dim_around = true,
    ignore_alpha = 0.1
})

hl.layer_rule({
    match = {
        namespace = "swaync-control-center"
    },
    blur = true,
    dim_around = true,
    ignore_alpha = 0.1
})

hl.layer_rule({
    match = {
        namespace = "eww-control-center"
    },
    blur = true,
    dim_around = true,
    ignore_alpha = 0.1
})



---------------------
--- Window Rules ----
---------------------
--- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
hl.window_rule({
    name = "translucent-discord-background",
    match = {
        class = "discord",
    },
    opacity = "1.0 override 0.1 override",
})

hl.window_rule({
    name = "discord-in-sp-workspace",
    match = {
        class = "discord",
    },
    -- move = {
    workspace = "special:discord silent",
    -- },
    fullscreen = 1,
})

hl.window_rule({
    name = "code-in-fullscreen",
    match = {
        class = "code",
    },
    fullscreen = true,
})

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name = "supress-maximize-events",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})


--- Dwindle layout
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,  -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- If true disables the random hyprland logo/anime girl background
        disable_splash_rendering = true,

        on_focus_under_fullscreen = 1,         -- Allow focus change under fullscreen windows, set to 0 to disable (WARNING: DO NOT EDIT THIS)
        exit_window_retains_fullscreen = true, -- If true, when a fullscreen window is closed, the next focused window will be fullscreen as well
    }
})
