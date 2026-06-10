-------------------
---- GENERAL ------
-------------------

local config = hl.config
config({
	input = {
		kb_layout = "ch",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
		},
	},
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

local gesture = hl.gesture
gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

local device = hl.device
device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
