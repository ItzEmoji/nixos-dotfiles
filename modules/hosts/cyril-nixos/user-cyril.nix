{ ... }:
{
  flake.nixosModules.cyril-nixos-user-cyril =
    {
      pkgs,
      self,
      inputs,
      ...
    }:
    {
      users.users.cyril = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "wireguard"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQ6mkR7siw01qo8FPru7N5AyP9qkr3B1VtiERugolDz"
        ];
        shell = pkgs.zsh;
      };
      home-manager.users.cyril.imports = [
        # Base
        self.homeManagerModules.home

        # CLI
        self.homeManagerModules.zsh
        self.homeManagerModules.oh-my-posh
        self.homeManagerModules.fzf
        self.homeManagerModules.zoxide
        self.homeManagerModules.atuin
        self.homeManagerModules.fastfetch
        self.homeManagerModules.carapace
        self.homeManagerModules.ssh-agent

        # Desktop
        self.homeManagerModules.dunst
        self.homeManagerModules.flameshot
        self.homeManagerModules.hypr
        self.homeManagerModules.noctalia
        self.homeManagerModules.rofi
        self.homeManagerModules.stylix-hm

        # Packages
        self.homeManagerModules.packages-global
        self.homeManagerModules.packages-cyril-nixos

        # External modules
        inputs.spicetify-nix.homeManagerModules.default
      ];
    };
}
