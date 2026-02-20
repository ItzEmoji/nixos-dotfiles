{ ... }:
{
  flake.homeManagerModules.zoxide =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    };
}
