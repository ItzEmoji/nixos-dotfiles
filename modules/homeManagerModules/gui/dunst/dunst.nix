{ ... }:
{
  flake.homeManagerModules.dunst =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.file.".config/dunst".source = ./dunst/conf;
      home.packages = with pkgs; [
        dunst
      ];
    };
}
