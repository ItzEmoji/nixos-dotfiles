{ config, pkgs, ... }:
{
  home.file.".config/waybar".source = ./conf;
  home.packages = with pkgs; [
    waybar
  ];
}
