{ ... }:
{
  flake.homeManagerModules.mango =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.file.".config/mango".source = ./mango/conf;
    };
}
