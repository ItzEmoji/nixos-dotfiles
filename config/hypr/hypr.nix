{ config, pkgs, ... }:

{
  imports = [
    ../waybar/waybar.nix
    ../rofi/rofi.nix
    ../dunst/dunst.nix
  ];
  home.packages = with pkgs; [
    waybar
    dunst
    hyprpaper
    hyprlock
  ];
  services.hyprpaper = {
    enable = true;
  };

  home.file.".config/hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper/hyprpaper.conf;
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock/hyprlock.conf;
  home.file.".config/hypr/hyprland/conf".source = ./hyprland/conf;
  home.file.".config/hypr/hyprpaper/conf".source = ./hyprpaper/conf;
  home.file.".config/hypr/hyprlock/conf".source = ./hyprlock/conf;
}
