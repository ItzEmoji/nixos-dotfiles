{ inputs, self, ... }:
{
  flake.nixosConfigurations.cyril-nixos = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [
      ./_hardware-configuration.nix

      # System
      self.nixosModules.base-system
      self.nixosModules.ssh-server
      self.nixosModules.tailscale
      self.nixosModules.bluetooth
      self.nixosModules.virtualisation
      self.nixosModules.fonts
      self.nixosModules.nh
      self.nixosModules.kmscon

      # Services
      self.nixosModules.audio
      self.nixosModules.printing
      self.nixosModules.flatpak

      # Boot
      self.nixosModules.grub

      # Desktop
      self.nixosModules.nvidia
      self.nixosModules.base-videoDrivers
      self.nixosModules.xserver
      self.nixosModules.xkb
      self.nixosModules.hyprland
      self.nixosModules.plasma
      self.nixosModules.ly

      # Packages
      self.nixosModules.packages-global
      self.nixosModules.packages-cyril-nixos
      inputs.nvim.nixosModules.nvim

      # Theming
      self.nixosModules.stylix

      # Home Manager
      self.nixosModules.home-manager
      self.nixosModules.cyril-nixos-user-cyril
      {
        networking.hostName = "cyril-nixos";
      }
    ];
  };
}
