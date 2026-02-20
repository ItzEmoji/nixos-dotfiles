{ ... }:
{
  flake.nixosModules.packages-wsl =
    {
      pkgs,
      inputs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        gnumake
        gcc
        ncurses
        fastfetch
      ];
    };
  flake.homeManagerModules.packages-wsl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
      ];
    };
}
