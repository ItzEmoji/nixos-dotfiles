-------------------
---- KEYBINDS -----
-------------------
local bind = hl.bind
local exec_cmd = hl.dsp.exec_cmd
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
bind(mainMod .. " + RETURN", exec_cmd(terminal))
local closeWindowBind = bind(mainMod .. " + Q", hl.dsp.window.close())
bind(
	mainMod .. " + SHIFT + Q",
	exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
bind(mainMod .. " + F", exec_cmd(fileManager))
bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
bind(mainMod .. " + SPACE", exec_cmd(ipc .. "launcher toggle"))
bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("[float; size 1200 800; center] " .. terminal))
bind(mainMod .. " + W", exec_cmd(ipc .. "wallpaper toggle"))
bind(mainMod .. " + B", exec_cmd(browser))

-- Move focus with mainMod + arrow keys
bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
bind(
	"XF86AudioRaiseVolume",
	exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
bind("XF86AudioLowerVolume", exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
bind("XF86AudioMute", exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
bind("XF86AudioMicMute", exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
bind("XF86MonBrightnessUp", exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
bind("XF86MonBrightnessDown", exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
bind("XF86AudioNext", exec_cmd("playerctl next"), { locked = true })
bind("XF86AudioPause", exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86AudioPlay", exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86AudioPrev", exec_cmd("playerctl previous"), { locked = true })
