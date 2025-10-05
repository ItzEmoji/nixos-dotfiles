{ config, pkgs, ... }:
{
  home.file.".config/waybar".source = ./conf;
}
