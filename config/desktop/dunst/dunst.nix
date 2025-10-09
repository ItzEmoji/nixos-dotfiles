{ config, pkgs, ... }:
{
  home.file.".config/dunst".source = ./conf;
  home.packages = with pkgs; [
    dunst
  ];
}
