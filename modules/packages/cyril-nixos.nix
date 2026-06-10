{ ... }:
{
  flake.nixosModules.packages-cyril-nixos =
    {
      pkgs,
      self,
      inputs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}.nix-alien
        self.packages.${pkgs.stdenv.hostPlatform.system}.rio
        wireshark
      ];
      programs = {
        wireshark.enable = true;
        wayvnc.enable = true;
      };
    };
  flake.homeManagerModules.packages-cyril-nixos =
    { pkgs, self, ... }:
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
