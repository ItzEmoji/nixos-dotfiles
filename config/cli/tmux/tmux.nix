{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];
  home.file.".config/tmux/tmux.conf".source = ./tmux.conf;
}

