{ config, pkgs, ... }:
{
  home.file.".config/mango".source = ./conf;
}
