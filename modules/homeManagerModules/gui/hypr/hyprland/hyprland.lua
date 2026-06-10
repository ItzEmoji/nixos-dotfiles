-- ~/.config/hypr/hyprland.lua
local conf_dir = os.getenv("HOME") .. "/.config/hypr/hyprland/"
package.path = conf_dir .. "?.lua;" .. package.path
require("variables")
require("monitors")
require("autostart")
require("general")
require("layouts")
require("window_rules")
require("graphical")
require("keybinds")
