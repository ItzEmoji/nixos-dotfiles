{ ... }:
{
  flake.homeManagerModules.carapace =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.carapace = {
        enable = true;
      };
    };
}
