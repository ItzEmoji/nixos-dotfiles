{ ... }:
{
  flake.nixosModules.packages-global =
    {
      pkgs,
      inputs,
      self,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}.nix-alien

        vim
        self.packages.${pkgs.stdenv.hostPlatform.system}.tmux
        self.packages.${pkgs.stdenv.hostPlatform.system}.bat
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
    { pkgs, self, ... }:
    {
      home.packages = with pkgs; [
        btop
        self.packages.${pkgs.stdenv.hostPlatform.system}.tmux
        self.packages.${pkgs.stdenv.hostPlatform.system}.bat
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
