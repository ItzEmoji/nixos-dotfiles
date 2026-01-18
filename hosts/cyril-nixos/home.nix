{ config, pkgs, inputs, ... }:

{
  home.username = "cyril";
  home.homeDirectory = "/home/cyril";
  home.stateVersion = "25.05";
  home.sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
  };
  home.file.".config/fastfetch".source = ../../config/cli/fastfetch;
  home.packages = with pkgs; [
    inputs.nvim.packages.${pkgs.system}.default
    btop
    tmux
    jq
    vivaldi
    ripgrep
    cmatrix
    bash
    cava
    pipes
    vesktop
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
  ];
}


