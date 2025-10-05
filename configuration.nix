{ config,  lib,  pkgs, inputs,  ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./config/stylix/stylix-system.nix
  ];
  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  networking.hostName = "cyril-nixos";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Europe/Zurich";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de_CH-latin1";
  };

  # Display Server
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    xkb.layout = "ch";
  };
  services.desktopManager.plasma6.enable = true;
  programs.hyprland.enable = true;
  services.displayManager.ly = {
    enable = true;
    x11Support = true;
  };
  programs.ssh.startAgent = true;
  
  programs.nix-ld.enable = true;
  # Miscellaneous
  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "~/dotfiles";
  };
  services.printing.enable = true;
  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
  programs.zsh = {
    enable =  true;
  };
  # User Account
  users.users.cyril = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    inputs.nix-alien.packages.${pkgs.system}.nix-alien
    wget
    git
    zsh
    waybar
    kitty
    file
  ];
  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  system.stateVersion = "25.05";

}
