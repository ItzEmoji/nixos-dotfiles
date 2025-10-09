{ config, pkgs, ... }:
{
  stylix = {
    enable = true;
    
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"; 
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    targets = {
      rofi.enable = false;
      waybar.enable = false;
      spicetify.enable = false;
      nixcord.enable = false;
    };
  };
}
