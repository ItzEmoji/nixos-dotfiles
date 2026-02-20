{ ... }:
{
  flake.nixosModules.packages-cyril-nixos =
    {
      pkgs,
      inputs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        inputs.nix-alien.packages.${pkgs.system}.nix-alien
        swww
        wireshark
      ];
      programs = {
        wireshark.enable = true;
        wayvnc.enable = true;
      };
    };
  flake.homeManagerModules.packages-cyril-nixos =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        devbox
        cachix
        obs-studio
        vesktop
        vivaldi
      ];
      programs = {
      };
    };
}
