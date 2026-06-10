{ ... }:
{
  flake.nixosModules.packages-wsl =
    {
      pkgs,
      inputs,
      self,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        gnumake
        gcc
        ncurses
        fastfetch
        self.packages.${pkgs.stdenv.hostPlatform.system}.tmux
        self.packages.${pkgs.stdenv.hostPlatform.system}.bat
      ];
    };
  flake.homeManagerModules.packages-wsl =
    { pkgs, self, ... }:
    {
      home.packages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.tmux
        self.packages.${pkgs.stdenv.hostPlatform.system}.bat
      ];
    };
}
