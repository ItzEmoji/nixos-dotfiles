{ config, pkgs, ... }:
{
  imports = [
    ./spicetify/spicetify.nix
    ./foot/foot.nix
    ./kitty/kitty.nix
  ];
}
