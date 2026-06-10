{ ... }:
{
  flake.homeManagerModules.hypr =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.file.".config/hypr/hyprland.lua".source = ./hyprland/hyprland.lua;
      home.file.".config/hypr/hyprland".source = ./hyprland/conf;
    };
}
