{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprlock
  ];
  services.hyprpaper = {
    enable = true;
  };

  home.file.".config/hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock/hyprlock.conf;
  home.file.".config/hypr/hyprland/conf".source = ./hyprland/conf;
  home.file.".config/hypr/hyprlock/conf".source = ./hyprlock/conf;
}
