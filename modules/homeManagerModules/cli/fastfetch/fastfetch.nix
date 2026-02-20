{ ... }:
{
  flake.homeManagerModules.fastfetch =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.file.".config/fastfetch/config.jsonc".source = ./config.jsonc;
      home.packages = with pkgs; [
        fastfetch
      ];
    };
}
