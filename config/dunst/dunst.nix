{ config, pkgs, ... }:
{
  home.file.".config/dunst".source = ./conf;
}
