{ ... }:
{
  flake.nixosModules.packages-global =
    { pkgs, inputs, ... }:
    {
      environment.systemPackages = with pkgs; [
        inputs.nix-alien.packages.${pkgs.system}.nix-alien
        vim
        git
        wget
        file
        zsh
      ];
      programs = {
        zsh.enable = true;
        nix-ld.enable = true;
      };
    };

  flake.homeManagerModules.packages-global =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        btop
        jq
        ripgrep
        cmatrix
        bash
        cava
        pipes
        nil
        nixfmt
        nodejs
        eza
        gcc
        git
        gnumake
        nixd
        lua-language-server
        gh
        opencode
        gemini-cli
      ];
      programs = {
      };
    };
}
