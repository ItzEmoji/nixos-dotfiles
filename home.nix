{ config, pkgs, inputs, ... }:

{
  home.username = "cyril";
  home.homeDirectory = "/home/cyril";
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      c = "clear";
      nrs = "sudo nixos-rebuild switch --flake /home/cyril/dotfiles#cyril-nixos";
    };
  };
  home.sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
  };
#  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/kitty".source = ./config/programs/kitty;
  home.file.".config/oh-my-posh".source = ./config/cli/oh-my-posh;
  home.file.".config/atuin".source = ./config/cli/atuin;
  home.file.".config/tmux".source = ./config/cli/tmux;
  home.file.".config/fastfetch".source = ./config/cli/fastfetch;
  home.packages = with pkgs; [
    inputs.nvim.packages.${pkgs.system}.default
    btop
    tmux
    jq
    vivaldi
    ripgrep
    cmatrix
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
