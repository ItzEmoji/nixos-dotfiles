{ config, pkgs, ... }:
{
  programs.foot = {
    enable = true;
    server.enable = true;
  };
  home.file.".config/foot".source = ./conf;
}
