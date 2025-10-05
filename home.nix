{ config, pkgs, inputs, ... }:

{
  imports = [
    ./config/zsh/zsh.nix
    ./config/hypr/hypr.nix
    ./config/stylix/stylix-home-manager.nix
    ./config/spicetify/spicetify.nix
    ./config/flameshot/flameshot.nix
  ];
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
#  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/oh-my-posh".source = ./config/oh-my-posh;
  home.file.".config/atuin".source = ./config/atuin;
  home.file.".config/tmux".source = ./config/tmux;
  home.file.".config/fastfetch".source = ./config/fastfetch;
  services.flameshot.enable = true;
  home.packages = with pkgs; [
    inputs.nvim.packages.${pkgs.system}.default
    btop
    tmux
    jq
    alacritty
    vivaldi
    ripgrep
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
    atuin
    oh-my-posh
    fzf
    direnv
    figlet
    bat
    gh
    lolcat
    zoxide
    zsh
    fastfetch
  ];
}
