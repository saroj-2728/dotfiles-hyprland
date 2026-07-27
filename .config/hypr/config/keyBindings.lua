--- https://wiki.hypr.land/Configuring/Basics/Binds/

-------------------
--- My Programs ---
-------------------

local terminal = "kitty"
local fileManager = "nautilus"
local menu = "rofi -show drun"
local windowMenu = "rofi -show window"
local commandMenu = "rofi -show run"
local browser = "firefox"

local mainMod = "SUPER"
local superShift = "SUPER + SHIFT"


-------------------------
--- Inputs to browser ---
-------------------------
local firefoxInput = [[sh -c '
input=$(rofi -dmenu -p "Firefox")
[ -z "$input" ] && exit

case "$input" in
    *.*|*://*)
        firefox --new-tab "$input"
        ;;
    *)
        firefox --new-tab "https://www.google.com/search?q=$(printf "%s" "$input" | sed "s/ /+/g")"
        ;;
esac
']]

local zenInput = [[sh -c '
input=$(rofi -dmenu -p "Zen")
[ -z "$input" ] && exit

case "$input" in
    *.*|*://*)
        zen-browser --new-tab "$input"
        ;;
    *)
        zen-browser --new-tab "https://www.google.com/search?q=$(printf "%s" "$input" | sed "s/ /+/g")"
        ;;
esac
']]

---------------------
---- KEYBINDINGS ----
---------------------


--- Submaps ----
hl.bind(superShift .. " + slash", hl.dsp.submap("lock_mode"))

-- Start a submap called "lock_mode".
hl.define_submap("lock_mode", function()
    hl.bind(superShift .. " + L", hl.dsp.exec_cmd("hyprlock"))

    hl.bind(superShift .. " + slash", hl.dsp.submap("reset"))
end)


-- Close focused window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())


-- Exit Hyprland
-- hl.bind(mainMod .. " + M", hl.dsp.exit())


-- Do some actions with windows
hl.bind(mainMod .. " + R", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + Y", hl.dsp.layout("rotatesplit")) -- dwindle layout only


-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end


-- Special workspaces (scratchpads)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
-- Discord on special workspace, opens in full screen by default
hl.bind(mainMod .. " + D", hl.dsp.workspace.toggle_special("discord"))
-- Special workspace with nothing (to freeze)
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.workspace.toggle_special("freeze"))


-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))


-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- Resize windows with mainMod + arrow keys
hl.bind(mainMod .. " + LEFT",
    hl.dsp.window.resize({
        x = -60, y = 0, relative = true,
    }),
    { repeating = true }
)
hl.bind(mainMod .. " + RIGHT",
    hl.dsp.window.resize({
        x = 60, y = 0, relative = true
    }),
    { repeating = true }
)
hl.bind(mainMod .. " + UP",
    hl.dsp.window.resize({
        x = 0, y = -60, relative = true
    }),
    { repeating = true }
)
hl.bind(mainMod .. " + DOWN",
    hl.dsp.window.resize({
        x = 0, y = 60, relative = true
    }),
    { repeating = true }
)


-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
-- { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.local/bin/mic-toggle.sh"), { locked = true })
hl.bind("XF86WebCam", hl.dsp.exec_cmd("~/.local/bin/camera-toggle.sh"), { locked = true })


-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


-- Open programs
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("code"))


-- Open menus
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind("CONTROL + " .. mainMod .. " + SPACE", hl.dsp.exec_cmd(commandMenu))
hl.bind(superShift .. " + SPACE", hl.dsp.exec_cmd(windowMenu))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(superShift .. " + I", hl.dsp.exec_cmd(firefoxInput))
hl.bind(superShift .. " + Z", hl.dsp.exec_cmd(zenInput))

-- Utilities
-- Screenshot
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- Lock screen
hl.bind(superShift .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Toggle fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))     -- Toggle fullscreen (maximize)
hl.bind(superShift .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) -- Toggle fullscreen (fullscreen)

-- Toggle waybar
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill waybar || waybar"))

-- Window switcher
hl.bind("ALT + Tab", hl.dsp.window.cycle_next()) -- For allowing focus to change under fullscreen windows set on_focus_under_fullscreen = 1 in misc settings in general.lua

-- Workspace switcher
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))

-- Clipboard manager
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/hypr/scripts/clipboard-paste.sh"))
