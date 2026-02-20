{ ... }:
{
  flake.nixosModules.wsl-cyril =
    { self, inputs, ... }:
    {
      home-manager = {
        users.cyril.imports = [
          # Base
          self.homeManagerModules.home
          # Packages
          self.homeManagerModules.packages-wsl
          self.homeManagerModules.packages-global

          # CLI only (no desktop/programs for WSL)
          self.homeManagerModules.zsh
          inputs.nvim.homeManagerModules.nvim
          self.homeManagerModules.ssh-agent
          self.homeManagerModules.oh-my-posh
          self.homeManagerModules.fzf
          self.homeManagerModules.zoxide
          self.homeManagerModules.atuin
          self.homeManagerModules.fastfetch
        ];
      };
    };
}
