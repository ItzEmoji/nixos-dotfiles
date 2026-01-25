{ config, lib, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.nvim.packages.${pkgs.system}.default
    vim
    git
    gnumake
    gcc
    ncurses
    fastfetch
    zsh
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  wsl.docker-desktop.enable = true;
  programs.ssh.startAgent = true;
  programs.zsh.enable = true;
  users.users.cyril = {
    shell = pkgs.zsh;
  };
  wsl = {
    enable = true;
    defaultUser = "cyril";
  }; 
  system.stateVersion = "25.05"; 
}
