{ config, pkgs, ... }:
{
  imports = [
    ./zsh/zsh.nix
    ./oh-my-posh/oh-my-posh.nix
    ./fzf/fzf.nix
    ./zoxide/zoxide.nix
    ./atuin/atuin.nix
  ];
}
