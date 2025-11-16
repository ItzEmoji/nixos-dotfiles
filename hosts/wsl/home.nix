{ config, pkgs, inputs, ... }:
{
  home.username = "cyril";
  home.stateVersion = "25.05";
  services.ssh-agent = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
