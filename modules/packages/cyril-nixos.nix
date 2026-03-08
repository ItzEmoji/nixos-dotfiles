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
        self.packages.${pkgs.system}.tmux
        self.packages.${pkgs.system}.bat
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
        self.packages.${pkgs.system}.tmux
        self.packages.${pkgs.system}.bat
      ];
      programs = {
      };
    };
}
