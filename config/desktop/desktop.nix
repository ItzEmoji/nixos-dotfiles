{ config, pkgs, ... }:
{
  imports = [
    ./hypr/hypr.nix
    ./rofi/rofi.nix
    ./waybar/waybar.nix
    ./dunst/dunst.nix
    ./flameshot/flameshot.nix
  ];
}
