{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    theme = ./themes/rounded.rasi;
  };
}
