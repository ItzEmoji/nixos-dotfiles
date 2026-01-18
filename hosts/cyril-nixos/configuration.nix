{ config,  lib,  pkgs, inputs,  ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../config/desktop/stylix/stylix-system.nix
    ./grub.nix
  ];
  programs.wayvnc.enable = true;
  # Networking
  services.tailscale.enable = true;

  networking.hostName = "cyril-nixos";
  networking.networkmanager.enable = true;
  # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Timezone
  time.timeZone = "Europe/Zurich";
  hardware.graphics = {
	enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };
  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "C.UTF-8/UTF-8" ];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de_CH-latin1";
  };
  programs.wireshark = {
    enable = true;
  };
  # Display Server
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    windowManager = {
      i3.enable = true;
    };
    autoRepeatInterval = 35;
    xkb.layout = "ch";
    videoDrivers = ["nvidia"];
  };
  services.desktopManager.plasma6.enable = true;
  programs.hyprland.enable = true;
  services.displayManager.ly = {
    enable = true;
    x11Support = true;
  };
  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
  
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
    extraGroups = [ "wheel" "wireguard" ];
    openssh.authorizedKeys.keys = 
    [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQ6mkR7siw01qo8FPru7N5AyP9qkr3B1VtiERugolDz"
    ];
    shell = pkgs.zsh;
  };
  
  programs.mango.enable = true;
  # System packages
  environment.systemPackages = with pkgs; [
    vim
    inputs.nix-alien.packages.${pkgs.system}.nix-alien
    swww
    wget
    git
    zsh
    waybar
    kitty
    file
    wireshark
    devbox
  ];
  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  system.stateVersion = "25.05";

}
