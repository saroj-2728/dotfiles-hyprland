-- Refer to the wiki for more information.
-- https://wiki.hyprland.org/Configuring/



--------------------
--- Source files ---
--------------------
require("config/keyBindings")
require("config/animations")
require("config/general")
require("config/input")



----------------
--- Monitors ---
----------------
--- https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Monitor on the left of laptop screen
-- hl.monitor({
--     output = "eDP-1",
--     mode = "preferred",
--     position = "1920x0",
--     scale = 1.25,
-- })
--
-- hl.monitor({
--     output = "HDMI-A-1",
--     mode = "preferred",
--     position = "0x0",
--     scale = 1,
-- })

-- Mirror the laptop screen to the monitor
-- hl.monitor({
--     output = "HDMI-A-1",
--     mode = "preferred",
--     position = "0x0", -- Overridden by mirror
--     scale = 1,        -- Overridden by mirror
--     mirror = "eDP-1", -- Targets the source display
-- })

-- Monitor on the right of laptop screen
hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto",
    scale = 1.25,
})
hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

-- Unscale XWayland
hl.config({
    xwayland = {
        force_zero_scaling = true,
    }
})



-----------------
--- Autostart ---
-----------------
--- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    hl.exec_cmd("swaync & hypridle & nm-applet & blueman-applet & kwalletd5 & waybar")

    hl.exec_cmd("hyprpaper & eww daemon")

    hl.exec_cmd("sleep 2 && eww open desktop-clock")

    hl.exec_cmd("sleep 1 && ~/.config/hypr/scripts/random_wallpaper.sh")

    hl.exec_cmd("wlsunset -t 4000 -T 6500 -l 27.7 -L 85.3")

    hl.exec_cmd("rm -f ~/.cache/cliphist/db")

    hl.exec_cmd("wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store")

    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

    hl.exec_cmd("[workspace special:magic silent; fullscreen] kitty")

    hl.exec_cmd("[workspace special:discord silent] discord")
end)



---------------------
--- Env variables ---
---------------------
--- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("HYPRSHOT_DIR", "/home/sp/Pictures/Screenshots")
hl.env("WLR_DRM_NO_MODIFIERS", "1")
hl.env("WLR_DRM_NO_MODIFIERS", "1")
hl.env("LIBVA_DRIVER_NAME", "iHD")
hl.env("VDPAU_DRIVER", "va_gl")
hl.env("LIBVA_DRIVER_NAME", "iHD")
