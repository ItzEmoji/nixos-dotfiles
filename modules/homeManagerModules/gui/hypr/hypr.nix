{ ... }:
{
  flake.homeManagerModules.hypr =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        hyprlock
      ];
      services.hyprpaper = {
        enable = true;
      };

      home.file.".config/hypr/hyprlock.conf".source = ./hyprlock/hyprlock.conf;
      home.file.".config/hypr/hyprlock/conf".source = ./hyprlock/conf;
      home.file.".config/hypr/hyprland.lua".source = ./hyprland/hyprland.lua;
      home.file.".config/hypr/hyprland".source = ./hyprland/conf;
    };
}
